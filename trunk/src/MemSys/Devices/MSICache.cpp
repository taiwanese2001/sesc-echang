#include "MSICache.h"
#include "../Messages/AllMessageTypes.h"
#include "../EventManager.h"
#include "../Connection.h"
#include "../Debug.h"
#include "../Configuration.h"
#include <cstdlib>
#include <algorithm>
#include "to_string.h"

namespace Memory
{
	int MSICache::RandomEvictionPolicy::Evict(Memory::MSICache::BlockState *set, int setSize)
	{
		DebugAssert(setSize > 0);
		int validCount = 0;
		for(int i = 0; i < setSize; i++)
		{
			if(set[i].valid && set[i].state != bs_Invalid && !set[i].locked)
			{
				validCount++;
			}
		}
		if(validCount == 0)
		{
			return InvalidBlock;
		}
		int index = rand() % setSize;
		for(int i = 0; i < setSize; i++)
		{
			if(set[i].valid && set[i].state != bs_Invalid && !set[i].locked)
			{
				if(index == 0)
				{
					return i;
				}
				index--;
			}
		}
		DebugFail("Strange indexing problem in Random Eviction [MSI]");
		return InvalidBlock;
	}
	int MSICache::LRUEvictionPolicy::Evict(Memory::MSICache::BlockState *set, int setSize)
	{
		DebugAssert(setSize > 0);
		DebugAssert(set);
		TickTime useTime = (TickTime)-1;
		int index = InvalidBlock;
		int validCount = 0;
		for(int i = 0; i < setSize; i++)
		{
			if(set[i].valid && set[i].state != bs_Invalid && !set[i].locked)
			{
				TickTime t = std::max(set[i].lastWrite,set[i].lastRead);
				if(useTime > t)
				{
					index = i;
					useTime = t;
				}
				validCount++;
			}
		}
		if(validCount == 0)
		{
			return InvalidBlock;
		}
		DebugAssert(index != InvalidBlock);
		return index;
	}
	MSICache::BlockState* MSICache::GetSet(int i)
	{
		DebugAssert(i >= 0 && i < setCount);
      BlockState *myBlockState = &(cacheContents[i * associativity]);
      return myBlockState;
	}
	unsigned int MSICache::getReadHits()
	{
		return readHits;
	}
	unsigned int MSICache::getReadMisses()
	{
		return readMisses;
	}
	unsigned int MSICache::getWriteHits()
	{
		return writeHits;
	}
	unsigned int MSICache::getWriteMisses()
	{
		return writeMisses;
	}
	void MSICache::InvalidateBlock(MSICache::BlockState& block)
	{
		DebugAssert(waitingOnBlockUnlock.find(block.tag) == waitingOnBlockUnlock.end());
		block.tag = 0;
		block.lastRead = 0;
		block.lastWrite = 0;
		block.state = bs_Invalid;
		block.valid = false;
		block.locked = false;
	}
	MSICache::AddrTag MSICache::CalcTag(Address addr)
	{
		return (AddrTag)(addr / lineSize);
	}
	Address MSICache::CalcAddr(MSICache::AddrTag tag)
	{
		return (Address)(tag * lineSize);
	}
	int MSICache::CalcSetFromAddr(Address addr)
	{
		return CalcSetFromTag(CalcTag(addr));
	}
	int MSICache::CalcSetFromTag(MSICache::AddrTag tag)
	{
		return (int)(tag % setCount);
	}
	MSICache::BlockState* MSICache::Lookup(MSICache::AddrTag tag)
	{
      int setIndex = CalcSetFromTag(tag);
		BlockState* set = GetSet(setIndex);
		DebugAssert(set);
		for(int i = 0; i < associativity; i++)
		{
			if(set[i].valid)
			{
				if(set[i].tag == tag)
				{
					return &(set[i]);
				}
			}
		}
		return NULL;
	}

	/**
	 * can be called as the result of a block not being found in cache
	 * during a read from the CPU side (OnLocalRead)
	 */
	bool MSICache::AllocateBlock(MSICache::AddrTag tag)
	{
		BlockState* set = GetSet(CalcSetFromTag(tag));
		DebugAssert(set);
		for(int i = 0; i < associativity; i++)
		{
			if(set[i].valid == false)
			{
				PrepareFreshBlock(CalcSetFromTag(tag),i,tag);
				return true;
			}
		}
		int eviction = evictionPolicy->Evict(set,associativity);
		if(eviction == InvalidBlock)
		{
			return false;
		}
		else  // eviction indexes a valid block
		{
         if(topCache)
         {
            EvictBlock(set[eviction].tag);
            PrepareFreshBlock(CalcSetFromTag(tag),eviction,tag);
         }
         else
         {
   #ifdef MEMORY_MSI_CACHE_DEBUG_PENDING_EVICTION
            printDebugInfo("AllocateBlock",set[eviction].tag,"pendingEviction.insert");
   #endif
            DebugAssert(pendingEviction.find(set[eviction].tag) == pendingEviction.end());
            pendingEviction[set[eviction].tag] = set[eviction];

            if(pendingInvalidate.find(tag) == pendingInvalidate.end())
            {
               InvalidateMsg* im = EM().CreateInvalidateMsg(getDeviceID(),0);
               im->addr = CalcAddr(set[eviction].tag);
               im->size = lineSize;
               localConnection->SendMsg(im,invalidateTime);
            }

            // PrepareFreshBlock can sometimes
            // prepare the block that we just inserted into pendingEviction
            PrepareFreshBlock(CalcSetFromTag(tag),eviction,tag);
         }
         return true;
		}
	}
	void MSICache::RetryMsg(const BaseMsg* m, int connectionID)
	{
		RecvMsg(m,connectionID);
	}
	void MSICache::PrepareFreshBlock(int setNumber, int index, AddrTag tag)
	{
		BlockState* mySet = GetSet(setNumber);
		DebugAssert(mySet[index].locked == false);
		if(pendingEviction.find(tag) == pendingEviction.end())
		{
			mySet[index].valid = true;
			mySet[index].tag = tag;
			mySet[index].lastWrite = 0;
			mySet[index].lastRead = 0;
			mySet[index].state = bs_Invalid;
		}
		else
		{  // cancel pendingEviction
         // need to tell OnLocalInvalidResponse that BlockEviction was canceled
		   canceledBlockEviction.insert(tag);
			mySet[index] = pendingEviction[tag];
#ifdef MEMORY_MSI_CACHE_DEBUG_PENDING_EVICTION
			printDebugInfo("PrepareFreshBlock",tag,"pendingEviction.erase");
#endif
			pendingEviction.erase(tag);
			DebugAssert(mySet[index].state != bs_Invalid);
		}
		DebugAssert(mySet[index].locked == false);
	}
	void MSICache::EvictBlock(MSICache::AddrTag tag)
	{
		BlockState* b = Lookup(tag);
		DebugAssert(b != NULL);
		DebugAssert(pendingEviction.find(tag) == pendingEviction.end());
		DebugAssert(b->valid);
		DebugAssert(!b->locked);
		DebugAssert(b->state != bs_Invalid);
		EvictionMsg* m = EM().CreateEvictionMsg(getDeviceID(),0);
		DebugAssert(m);
		m->addr = CalcAddr(b->tag);
		m->size = lineSize;
		m->blockAttached = (b->lastWrite != 0);
		DebugAssert(remoteConnection);
		remoteConnection->SendMsg(m,evictionTime);
	}
	void MSICache::RespondInvalidate(MSICache::AddrTag tag)
	{
		DebugAssert(pendingInvalidate.find(tag) != pendingInvalidate.end())
		BlockState* b = Lookup(tag);
		InvalidateResponseMsg* res = EM().CreateInvalidateResponseMsg(getDeviceID(),0);
		res->addr = CalcAddr(tag);
		res->size = lineSize;
		res->solicitingMessage = pendingInvalidate[tag]->MsgID();
		if(b && (b->state == bs_Modified))
		{
			res->blockAttached = true;
		}
      /*
		else if (b && (b->state == bs_Owned))
		{
		   res->blockAttached = true;
		}
      */
		else if(b == NULL && pendingEviction.find(tag) != pendingEviction.end())
		{
			res->blockAttached = (pendingEviction[tag].state == bs_Modified);
#ifdef MEMORY_MSI_CACHE_DEBUG_PENDING_EVICTION
			printDebugInfo("RespondInvalidate",tag,"pendingEviction.erase");
#endif
			pendingEviction.erase(tag);
		}
		else
		{
			res->blockAttached = false;
		}
		remoteConnection->SendMsg(res,invalidateTime);
		if(waitingOnBlockUnlock.find(tag) != waitingOnBlockUnlock.end())
		{
			DebugAssert(b);
			DebugAssert(b->locked);
			b->state = bs_Invalid;
			ReadMsg* forward = EM().CreateReadMsg(getDeviceID(),pendingInvalidate[tag]->GeneratingPC());
			forward->addr = pendingInvalidate[tag]->addr;
			forward->size = lineSize;
			forward->alreadyHasBlock = false;
			forward->onCompletedCallback = NULL;
			forward->requestingExclusive = false;
			remoteConnection->SendMsg(forward,invalidateTime);
		}
		else if (b)
		{
			InvalidateBlock(*b);
		}
		EM().DisposeMsg(pendingInvalidate[tag]);
#ifdef MEMORY_MSI_CACHE_DEBUG_PENDING_INVALIDATE
		printDebugInfo("RespondInvalidate",tag,"pendingInvalidate.erase");
#endif
		pendingInvalidate.erase(tag);
	}
void MSICache::LockBlock(MSICache::AddrTag tag)
	{
		BlockState* b = Lookup(tag);
		DebugAssert(b);
		DebugAssert(b->valid);
		DebugAssert(!b->locked);
		DebugAssert(waitingOnBlockUnlock.find(tag) == waitingOnBlockUnlock.end());
		b->locked = true;
	}
void MSICache::UnlockBlock(MSICache::AddrTag tag)
	{
		BlockState* b = Lookup(tag);
		DebugAssert(b);
		DebugAssert(b->valid);
		DebugAssert(b->locked);
		DebugAssert(waitingOnBlockUnlock.find(tag) != waitingOnBlockUnlock.end());
		b->locked = false;
		StoredFunctionBase* f = waitingOnBlockUnlock[tag];
		waitingOnBlockUnlock.erase(tag);
		DebugAssert(f);
		f->Call();
		if(!b->locked)
		{
			int setIndex = CalcSetFromTag(tag);
			f = waitingOnSetUnlock[setIndex];
			if(f)
			{
				waitingOnSetUnlock[setIndex] = NULL;
				f->Call();
			}
		}
	}
void MSICache::WaitOnBlockUnlock(MSICache::AddrTag tag, StoredFunctionBase* f)
	{
		DebugAssert(f);
		if(waitingOnBlockUnlock.find(tag) != waitingOnBlockUnlock.end())
		{
			CompositPool::FunctionType* c = compositPool.Create();
			c->Initialize(waitingOnBlockUnlock[tag],f);
			f = c;
		}
		waitingOnBlockUnlock[tag] = f;
	}
void MSICache::WaitOnRemoteReadResponse(MSICache::AddrTag tag, StoredFunctionBase* f)
	{
		DebugAssert(f);
		if(waitingOnRemoteReads.find(tag) != waitingOnRemoteReads.end())
		{
			CompositPool::FunctionType* c = compositPool.Create();
			c->Initialize(waitingOnRemoteReads[tag],f);
			f = c;
		}
		waitingOnRemoteReads[tag] = f;
	}
void MSICache::WaitOnSetUnlock(int s, StoredFunctionBase* f)
	{
		DebugAssert(f);
		if(waitingOnSetUnlock[s])
		{
			CompositPool::FunctionType* c = compositPool.Create();
			c->Initialize(waitingOnSetUnlock[s],f);
			f = c;
		}
		waitingOnSetUnlock[s] = f;
	}
void MSICache::PerformRead(const ReadMsg* m)
	{		
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);
		DebugAssertWithMessageID(b,m->MsgID());
		if(b->state == bs_Invalid || (m->requestingExclusive && (b->state == bs_Shared)))
		{//miss
			if(!b->locked)
			{
				LockBlock(tag);
				readMisses++;
				ReadMsg* forward = EM().CreateReadMsg(getDeviceID(),m->GeneratingPC());
				forward->addr = CalcAddr(tag);
				forward->size = lineSize;
				forward->alreadyHasBlock = (b->state != bs_Invalid);
				forward->onCompletedCallback = NULL;
				forward->requestingExclusive = m->requestingExclusive;
				remoteConnection->SendMsg(forward, missTime);
			}
			CBPerformRead::FunctionType* f = cbPerformRead.Create();
			f->Initialize(this,m);
			WaitOnBlockUnlock(tag,f);
		}
		else
		{  //hit
		   readHits++;
			ReadResponseMsg* res = EM().CreateReadResponseMsg(getDeviceID(),m->GeneratingPC());
			m->SignalComplete();
			res->addr = m->addr;
			res->size = m->size;
			res->blockAttached = !m->alreadyHasBlock;
			res->exclusiveOwnership = (b->state == bs_Modified);
			res->satisfied = true;
			res->solicitingMessage = m->MsgID();
			localConnection->SendMsg(res,hitTime);
			EM().DisposeMsg(m);
		}
		b->lastRead = EM().CurrentTick();
	}
	void MSICache::PerformRemoteRead(const ReadMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);
		ReadResponseMsg* res = EM().CreateReadResponseMsg(getDeviceID(),m->GeneratingPC());
		res->addr = m->addr;
		res->size = m->size;
		m->SignalComplete();
		res->solicitingMessage = m->MsgID();
		if(b == NULL || b->state == bs_Invalid)
		{
			res->exclusiveOwnership = false;
			res->satisfied = false;
			res->blockAttached = false;
		}
		else if(m->requestingExclusive)
		{
			res->blockAttached = !m->alreadyHasBlock;
			res->exclusiveOwnership = true;
			res->satisfied = true;
			if(waitingOnBlockUnlock.find(tag) != waitingOnBlockUnlock.end())
			{
				DebugAssertWithMessageID(b->locked,m->MsgID());
				b->state = bs_Invalid;
			}
			else
			{
				DebugAssertWithMessageID(!b->locked,m->MsgID());
				InvalidateBlock(*b);
			}
		}
		else
		{
			if(b->state == bs_Modified)
			{
				b->state = bs_Shared;
			}
         /*
			else if(b->state == bs_Exclusive)
			{
				b->state = bs_Shared;
			}
         */
			res->exclusiveOwnership = false;
			res->blockAttached = true;
			res->satisfied = true;
		}
		remoteConnection->SendMsg(res,hitTime);
		EM().DisposeMsg(m);
	}
	void MSICache::PerformWrite(const WriteMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);
		DebugAssertWithMessageID(b,m->MsgID());
		if(b->state == bs_Invalid || b->state == bs_Shared)
		{
			if(!b->locked)
			{
				LockBlock(tag);
				writeMisses++;
				ReadMsg* forward = EM().CreateReadMsg(getDeviceID(),m->GeneratingPC());
				forward->addr = CalcAddr(tag);
				forward->size = lineSize;
				forward->alreadyHasBlock = (b->state != bs_Invalid);
				forward->onCompletedCallback = NULL;
				forward->requestingExclusive = true;
				remoteConnection->SendMsg(forward, missTime);
			}
			CBPerformWrite::FunctionType* f = cbPerformWrite.Create();
			f->Initialize(this,m);
			WaitOnBlockUnlock(tag,f);
		}
		else
		{
		   writeHits++;
			b->state = bs_Modified;
			WriteResponseMsg* res = EM().CreateWriteResponseMsg(getDeviceID(),m->GeneratingPC());
			res->addr = m->addr;
			res->size = m->size;
			res->solicitingMessage = m->MsgID();
			m->SignalComplete();
			localConnection->SendMsg(res,hitTime);
			EM().DisposeMsg(m);
		}
		b->lastWrite = EM().CurrentTick();
		return;
	}
							void MSICache::OnLocalRead(const ReadMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);
		if(b)
		{//block found
			PerformRead(m);
		}
		else
		{//block not found at all
		   bool allocateBlockResult = AllocateBlock(tag);
			if(!allocateBlockResult)
			{
				CBRetryMsg::FunctionType* retry = cbRetryMsg.Create();
				retry->Initialize(this,m,localConnectionID);
				WaitOnSetUnlock(CalcSetFromTag(tag),retry);
			}
			else
			{
				PerformRead(m);
			}
		}
	}
	void MSICache::OnRemoteRead(const ReadMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);
		if(b)
		{//block found
			if(topCache || b->state == bs_Invalid || (!m->requestingExclusive && (b->state == bs_Shared)))
			{//satisfy here
				PerformRemoteRead(m);
			}
			else
			{
				ReadMsg* forward = EM().CreateReadMsg(getDeviceID(),m->GeneratingPC());
				forward->addr = m->addr;
				forward->alreadyHasBlock = true;
				forward->onCompletedCallback = NULL;
				forward->requestingExclusive = m->requestingExclusive;
				forward->size = m->size;
				localConnection->SendMsg(forward, hitTime);
				CBPerformRemoteRead::FunctionType* f = cbPerformRemoteRead.Create();
				f->Initialize(this,m);
				WaitOnRemoteReadResponse(tag,f);
			}
		}
		else
		{//cache is inclusive, and thus cannot be satisfied
			PerformRemoteRead(m);
		}
	}
	void MSICache::OnLocalWrite(const WriteMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);
		if(b)
		{//block found
			PerformWrite(m);
		}
		else
		{//block not found at all
			if(!AllocateBlock(tag))
			{
				CBRetryMsg::FunctionType* retry = cbRetryMsg.Create();
				retry->Initialize(this,m,localConnectionID);
				WaitOnSetUnlock(CalcSetFromTag(tag),retry);
			}
			else
			{
				PerformWrite(m);
			}
		}
	}
	void MSICache::OnRemoteWrite(const WriteMsg* m)
	{
		WriteResponseMsg* res = EM().CreateWriteResponseMsg(getDeviceID(),m->GeneratingPC());
		res->addr = m->addr;
		res->size = m->size;
		res->solicitingMessage = m->MsgID();
		m->SignalComplete();
		remoteConnection->SendMsg(res,satisfyRequestTime);
		EM().DisposeMsg(m);
	}
	void MSICache::OnLocalInvalidate(const InvalidateMsg* m)
	{
		EM().DisposeMsg(m);
		DebugFail("Local Invalidates illegal in this cache");
	}
	void MSICache::OnRemoteInvalidate(const InvalidateMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		if(pendingInvalidate.find(tag) != pendingInvalidate.end())
		{
			EM().DisposeMsg(m);
			return;
		}
		else
		{
#ifdef MEMORY_MSI_CACHE_DEBUG_PENDING_INVALIDATE
		   printDebugInfo("OnRemoteInvalidate",*m,
		         ("pendingInvalidate.insert(" + to_string<AddrTag>(tag)+")").c_str());
#endif
		   pendingInvalidate[tag] = m;
		}
		if(topCache)
		{
			RespondInvalidate(tag);
			return;
		}
		BlockState* b = Lookup(tag);
		if(b)
		{
			localConnection->SendMsg(EM().ReplicateMsg(m),0);
		}
		else
		{
			RespondInvalidate(tag);
		}
	}
	void MSICache::OnLocalEviction(const EvictionMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);

		if(b && m->blockAttached)
		{
			//DebugAssertWithMessageID(b->state==bs_Modified,m->MsgID());
			//if(b->state == bs_Exclusive)
			{
				b->state = bs_Modified;
			}
		}

		EvictionResponseMsg* res = EM().CreateEvictionResponseMsg(getDeviceID(),m->GeneratingPC());
		res->addr = m->addr;
		res->size = m->size;
		res->solicitingMessage = m->MsgID();
		localConnection->SendMsg(res,hitTime);
		EM().DisposeMsg(m);
	}
	void MSICache::OnRemoteEviction(const EvictionMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		EvictionResponseMsg* res = EM().CreateEvictionResponseMsg(getDeviceID(),m->GeneratingPC());
		res->addr = m->addr;
		res->size = m->size;
		res->solicitingMessage = m->MsgID();
		remoteConnection->SendMsg(res,hitTime);
		EM().DisposeMsg(m);
	}
	void MSICache::OnLocalReadResponse(const ReadResponseMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		if(waitingOnRemoteReads.find(tag) != waitingOnRemoteReads.end())
		{
			StoredFunctionBase* f = waitingOnRemoteReads[tag];
			waitingOnRemoteReads.erase(tag);
			f->Call();
		}
		EM().DisposeMsg(m);
	}
	void MSICache::OnRemoteReadResponse(const ReadResponseMsg* m)
	{
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		BlockState* b = Lookup(tag);
      /*
      if (b==NULL)
      {
         // there is apparently a reason why we don't send another message back to evict the directory,
            // but I'm not sure what it is
         BlockState &bs = pendingEviction[m->addr];
         // send eviction message because this block is not found in the cache
         EvictionMsg *forward = EM().CreateEvictionMsg(getDeviceID());
         forward->addr = m->addr;
         DebugAssertWithMessageID(m->blockAttached,m->MsgID());
         forward->blockAttached = m->blockAttached;
         forward->size = m->size;
         forward->isBlockNotFound = true;
         DebugAssertWithMessageID(pendingEviction.find(tag)==pendingEviction.end(),m->MsgID());
         remoteConnection->SendMsg(forward,evictionTime);
      }
   */
		if(b == NULL || !b->locked)
		{
			EM().DisposeMsg(m);
			return;
		}
		if(m->exclusiveOwnership)
		{
			//b->state = bs_Exclusive;
			b->state = bs_Modified;
		}
		else
		{
			b->state = bs_Shared;
		}
		UnlockBlock(tag);
		EM().DisposeMsg(m);
	}
	void MSICache::OnLocalWriteResponse(const WriteResponseMsg* m)
	{
		EM().DisposeMsg(m);
		DebugFail("A Write should never have been emitted");
	}
	void MSICache::OnRemoteWriteResponse(const WriteResponseMsg* m)
	{
		EM().DisposeMsg(m);
	}
	void MSICache::OnLocalInvalidateResponse(const InvalidateResponseMsg* m)
	{
#ifdef MEMORY_MSI_CACHE_DEBUG_COMMON
   #ifdef _WIN32
         waitingOnBlockUnlock;
         waitingOnSetUnlock;
         waitingOnRemoteReads;
         pendingEviction;
         pendingInvalidate;
   #else
         #define MEMORY_MSI_CACHE_ARRAY_SIZE 200
         StoredFunctionBase* waitingOnBlockUnlockArray[MEMORY_MSI_CACHE_ARRAY_SIZE];
         StoredFunctionBase* waitingOnSetUnlockArray[MEMORY_MSI_CACHE_ARRAY_SIZE];
         StoredFunctionBase* waitingOnRemoteReadsArray[MEMORY_MSI_CACHE_ARRAY_SIZE];
         BlockState pendingEvictionArray[MEMORY_MSI_CACHE_ARRAY_SIZE];
         const InvalidateMsg* pendingInvalidateArray[MEMORY_MSI_CACHE_ARRAY_SIZE];

         waitingOnBlockUnlock.convertToArray(waitingOnBlockUnlockArray,MEMORY_MSI_CACHE_ARRAY_SIZE);
         convertVectorToArray<StoredFunctionBase*>(waitingOnSetUnlock,waitingOnSetUnlockArray,MEMORY_MSI_CACHE_ARRAY_SIZE);
         waitingOnRemoteReads.convertToArray(waitingOnRemoteReadsArray,MEMORY_MSI_CACHE_ARRAY_SIZE);
         pendingEviction.convertToArray(pendingEvictionArray,MEMORY_MSI_CACHE_ARRAY_SIZE);
         pendingInvalidate.convertToArray(pendingInvalidateArray,MEMORY_MSI_CACHE_ARRAY_SIZE);
   #endif
#endif
		DebugAssertWithMessageID(m,m->MsgID());
		AddrTag tag = CalcTag(m->addr);
		DebugAssertWithMessageID(pendingEviction.find(tag) != pendingEviction.end()
		      || pendingInvalidate.find(tag) != pendingInvalidate.end()
		      || canceledBlockEviction.find(tag) != canceledBlockEviction.end()
		      ,m->MsgID());
		// if a block eviction was canceled by PrepareFreshBlock()
		if (canceledBlockEviction.find(tag) != canceledBlockEviction.end())
		{
		   // if the block was canceled eviction, it shouldn't be found
		   // in pendingEviction or pendingInvalidate
		   DebugAssertWithMessageID(pendingEviction.find(tag) == pendingEviction.end(),m->MsgID());
		   DebugAssertWithMessageID(pendingInvalidate.find(tag)==pendingInvalidate.end(),m->MsgID());
		   canceledBlockEviction.erase(tag);
		   EM().DisposeMsg(m);
		   return;
		}
		else //(canceledBlockEviction.find(tag) == canceledBlockEviction.end())
		{
         if(m->blockAttached)
         {
            BlockState* b = NULL;
            if(pendingEviction.find(tag) != pendingEviction.end())
            {
               b = &(pendingEviction[tag]);
            }
            else if(pendingInvalidate.find(tag) != pendingInvalidate.end())
            {
               b = Lookup(tag);
            }
            // if blockState is still NULL, don't do
            // anything to it, otherwise, it would cause an error
            if (b)
            {
               //if(b->state == bs_Exclusive)
               {
						DebugAssertWithMessageID(b->state==bs_Modified,m->MsgID());
                  b->state = bs_Modified;
               }
               /*
               else if(b->state == bs_Shared)
               {
                  b->state = bs_Owned;
               }
               */
            }
         }
         if(pendingInvalidate.find(tag) != pendingInvalidate.end())
         {
            RespondInvalidate(tag);
         }
         if(pendingEviction.find(tag) != pendingEviction.end())
         {
            EvictionMsg* forward = EM().CreateEvictionMsg(getDeviceID(),m->GeneratingPC());
            forward->addr = CalcAddr(CalcTag(m->addr));
            forward->size = lineSize;
            forward->blockAttached = pendingEviction[tag].state == bs_Modified;
   #ifdef MEMORY_MSI_CACHE_DEBUG_PENDING_EVICTION
            printDebugInfo("OnLocalInvalidateResponse",tag,"pendingEviction.erase");
   #endif
            pendingEviction.erase(tag);
            remoteConnection->SendMsg(forward,evictionTime);
         }
         EM().DisposeMsg(m);
		} // else (canceledBlockEviction.find(tag) == canceledBlockEviction.end())
	}
	void MSICache::OnRemoteInvalidateResponse(const InvalidateResponseMsg* m)
	{
		EM().DisposeMsg(m);
	}
	void MSICache::OnLocalEvictionResponse(const EvictionResponseMsg* m)
	{
		EM().DisposeMsg(m);
		DebugFail("An Eviction should never have been emitted");
	}
	void MSICache::OnRemoteEvictionResponse(const EvictionResponseMsg* m)
	{
		EM().DisposeMsg(m);
	}
	MSICache::~MSICache()
	{
		if(evictionPolicy)
		{
			delete evictionPolicy;
		}
	}
	void MSICache::Initialize(EventManager* em, const RootConfigNode& config, const std::vector<Connection*>& connectionSet)
	{
		BaseMemDevice::Initialize(em,config,connectionSet);
		localConnection = NULL;
		remoteConnection = NULL;
		for(size_t i = 0; i < connectionSet.size(); i++)
		{
			if(connectionSet[i]->Name() == "LocalConnection")
			{
				DebugAssert(localConnection == NULL);
				localConnection = connectionSet[i];
				localConnectionID = (int)i;
			}
			else if(connectionSet[i]->Name() == "RemoteConnection")
			{
				DebugAssert(remoteConnection == NULL);
				remoteConnection = connectionSet[i];
				remoteConnectionID = (int)i;
			}
		}
		DebugAssert(localConnection);
		DebugAssert(remoteConnection);
		if(config.ContainsSubNode("HitTime") && config.SubNode("HitTime").IsA<IntConfigNode>())
		{
			hitTime = (TimeDelta)((const IntConfigNode&)config.SubNode("HitTime")).Value();
		}
		else
		{
			hitTime = 1;
		}
		if(config.ContainsSubNode("MissTime") && config.SubNode("MissTime").IsA<IntConfigNode>())
		{
			missTime = (TimeDelta)((const IntConfigNode&)config.SubNode("MissTime")).Value();
		}
		else
		{
			missTime = 1;
		}
		if(config.ContainsSubNode("EvictionTime") && config.SubNode("EvictionTime").IsA<IntConfigNode>())
		{
			evictionTime = (TimeDelta)((const IntConfigNode&)config.SubNode("EvictionTime")).Value();
		}
		else
		{
			evictionTime = 1;
		}
		if(config.ContainsSubNode("InvalidateTime") && config.SubNode("InvalidateTime").IsA<IntConfigNode>())
		{
			invalidateTime = (TimeDelta)((const IntConfigNode&)config.SubNode("InvalidateTime")).Value();
		}
		else
		{
			invalidateTime = 1;
		}
		if(config.ContainsSubNode("CheckAndFailTime") && config.SubNode("CheckAndFailTime").IsA<IntConfigNode>())
		{
			checkAndFailTime = (TimeDelta)((const IntConfigNode&)config.SubNode("CheckAndFailTime")).Value();
		}
		else
		{
			checkAndFailTime = 1;
		}
		if(config.ContainsSubNode("SatisfyRequestTime") && config.SubNode("SatisfyRequestTime").IsA<IntConfigNode>())
		{
			satisfyRequestTime = (TimeDelta)((const IntConfigNode&)config.SubNode("SatisfyRequestTime")).Value();
		}
		else
		{
			satisfyRequestTime = 1;
		}
		DebugAssert(config.ContainsSubNode("Associativity") && config.SubNode("Associativity").IsA<IntConfigNode>());
		DebugAssert(config.ContainsSubNode("SetCount") && config.SubNode("SetCount").IsA<IntConfigNode>());
		DebugAssert(config.ContainsSubNode("TopCache") && config.SubNode("TopCache").IsA<IntConfigNode>());
		DebugAssert(config.ContainsSubNode("LineSize") && config.SubNode("LineSize").IsA<IntConfigNode>());
		associativity = (int)((const IntConfigNode&)config.SubNode("Associativity")).Value();
		setCount = (int)((const IntConfigNode&)config.SubNode("SetCount")).Value();
		topCache = ((const IntConfigNode&)config.SubNode("TopCache")).Value() != 0;
		lineSize = (Address)((const IntConfigNode&)config.SubNode("LineSize")).Value();
		cacheContents.resize(setCount * associativity);
		waitingOnSetUnlock.resize(setCount);
		for(size_t i = 0; i < cacheContents.size(); i++)
		{
			cacheContents[i].valid = false;
			cacheContents[i].tag = 0;
			cacheContents[i].lastRead = cacheContents[i].lastWrite = false;
			cacheContents[i].locked = false;
		}
		for(size_t i = 0; i < waitingOnSetUnlock.size(); i++)
		{
			waitingOnSetUnlock[i] = NULL;
		}
		DebugAssert(config.ContainsSubNode("EvictionPolicy") && config.SubNode("EvictionPolicy").IsA<StringConfigNode>());
		const std::string& evictName= ((const StringConfigNode&)config.SubNode("EvictionPolicy")).Value();
		evictionPolicy = NULL;
		if(evictName == "Random")
		{
			evictionPolicy = new RandomEvictionPolicy();
		}
		else if(evictName == "LRU")
		{
			evictionPolicy = new LRUEvictionPolicy();
		}
		else
		{
			DebugFail("Bad eviction policy specified");
		}

      messagesReceived = readHits = readMisses = writeHits = writeMisses = 0;
	}
	void MSICache::DumpRunningState(RootConfigNode& node){}
	void MSICache::DumpStats(std::ostream& out)
	{
	   out << "messagesReceived:" << messagesReceived << std::endl;
	   out << "readHits:" << readHits << std::endl;
	   out << "readMisses:" << readMisses << std::endl;
	   out << "writeHits:" << writeHits << std::endl;
	   out << "writeMisses:" << writeMisses << std::endl;
	}
	void MSICache::RecvMsg(const BaseMsg* msg, int connectionID)
	{
	   messagesReceived++;
      ReadMsg* debugReadMsg = (ReadMsg*)msg;

		if(connectionID == localConnectionID)
		{
			switch(msg->Type())
			{
			case(mt_Read):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalRead", *msg, "RecvMsg");
         #endif
				OnLocalRead((const ReadMsg*)msg);
				break;
			case(mt_Write):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalWrite", *msg, "RecvMsg");
         #endif
				OnLocalWrite((const WriteMsg*)msg);
				break;
			case(mt_Invalidate):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalInvalidate", *msg, "RecvMsg");
         #endif
				OnLocalInvalidate((const InvalidateMsg*)msg);
				break;
			case(mt_Eviction):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalEviction", *msg, "RecvMsg");
         #endif
				OnLocalEviction((const EvictionMsg*)msg);
				break;
			case(mt_ReadResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalReadResponse", *msg, "RecvMsg");
         #endif
				OnLocalReadResponse((const ReadResponseMsg*)msg);
				break;
			case(mt_WriteResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalWriteResponse", *msg, "RecvMsg");
         #endif
				OnLocalWriteResponse((const WriteResponseMsg*)msg);
				break;
			case(mt_InvalidateResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalInvalidateResponse", *msg, "RecvMsg");
         #endif
				OnLocalInvalidateResponse((const InvalidateResponseMsg*)msg);
				break;
			case(mt_EvictionResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnLocalEvictionResponse", *msg, "RecvMsg");
         #endif
				OnLocalEvictionResponse((const EvictionResponseMsg*)msg);
				break;
			default:
				DebugFail("MSICache::Bad msg Type");
			}
		}
		else if(connectionID == remoteConnectionID)
		{
			switch(msg->Type())
			{
			case(mt_Read):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteRead", *msg, "RecvMsg");
         #endif
				OnRemoteRead((const ReadMsg*)msg);
				break;
			case(mt_Write):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteWrite", *msg, "RecvMsg");
         #endif
				OnRemoteWrite((const WriteMsg*)msg);
				break;
			case(mt_Invalidate):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteInvalidate", *msg, "RecvMsg");
         #endif
				OnRemoteInvalidate((const InvalidateMsg*)msg);
				break;
			case(mt_Eviction):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteEviction", *msg, "RecvMsg");
         #endif
				OnRemoteEviction((const EvictionMsg*)msg);
				break;
			case(mt_ReadResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteReadResponse", *msg, "RecvMsg");
         #endif
				OnRemoteReadResponse((const ReadResponseMsg*)msg);
				break;
			case(mt_WriteResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteWriteResponse", *msg, "RecvMsg");
         #endif
				OnRemoteWriteResponse((const WriteResponseMsg*)msg);
				break;
			case(mt_InvalidateResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteInvalidateResponse", *msg, "RecvMsg");
         #endif
				OnRemoteInvalidateResponse((const InvalidateResponseMsg*)msg);
				break;
			case(mt_EvictionResponse):
         #ifdef MEMORY_MSI_CACHE_DEBUG_VERBOSE
            printDebugInfo("OnRemoteEvictionResponse", *msg, "RecvMsg");
         #endif
				OnRemoteEvictionResponse((const EvictionResponseMsg*)msg);
				break;
			default:
				DebugFail("Bad msg Type");
			}
		}
		else
		{
			DebugFail("Connection not a valid ID");
		}
	} // MSICache::RecvMsg

   void MSICache::printDebugInfo(const char* fromMethod, const BaseMsg &myMessage, const char* operation)
   {
      printBaseMemDeviceDebugInfo("MSICache", fromMethod, myMessage, operation);
   }

   void MSICache::printDebugInfo(const char* fromMethod,const AddrTag tag,const char* operation)
   {
      cout << setw(17) << " "
            << " dst=" << setw(2) << getDeviceID()
            << " MSICache::" << fromMethod
            << " " << operation << "(" << tag << ")"
            << endl;
   }
}
