#include "TestMemory.h"
#include "../Configuration.h"
#include "../Messages/AllMessageTypes.h"
#include "../Debug.h"
#include "../EventManager.h"
#include "../Connection.h"

namespace Memory
{
	void TestMemory::Initialize(EventManager* em, const RootConfigNode& config, const std::vector<Connection*>& connectionSet)
	{
		BaseMemDevice::Initialize(em,config,connectionSet);
		DebugAssert(connectionSet.size() == 1);
		DebugAssert(config.ContainsSubNode("ReadLatency"));
		DebugAssert(config.SubNode("ReadLatency").IsA<IntConfigNode>());
		readTime = (TimeDelta)((const IntConfigNode&)config.SubNode("ReadLatency")).Value();
		DebugAssert(config.ContainsSubNode("WriteLatency"));
		DebugAssert(config.SubNode("WriteLatency").IsA<IntConfigNode>());
		writeTime = (TimeDelta)((const IntConfigNode&)config.SubNode("WriteLatency")).Value();
		evictionsReceived = 0;
		readsReceived = 0;
		writesReceived = 0;
	}

	void TestMemory::DumpRunningState(RootConfigNode& node){}

	void TestMemory::DumpStats(std::ostream& out)
	{
		out << DeviceName() << ":EvictionsReceived:" << evictionsReceived << endl;
		out << DeviceName() << ":ReadsReceived:" << readsReceived << endl;
		out << DeviceName() << ":WritessReceived:" << writesReceived << endl;
	}

	void TestMemory::RecvMsg(const BaseMsg* msg, int connectionID)
	{
		DebugAssert(msg);
		TimeDelta replyTime = 0;
		BaseMsg* reply = NULL;

		switch(msg->Type())
		{
		case(mt_Read):
			{
				readsReceived++;
				ReadMsg* rm = (ReadMsg*)msg;
				replyTime = readTime;
				ReadResponseMsg* m = EM().CreateReadResponseMsg(GetDeviceID(),msg->GeneratingPC());
				m->addr = rm->addr;
				m->size = rm->size;
				m->blockAttached = true;
				m->directoryLookup = rm->directoryLookup;
				m->exclusiveOwnership = true;
				m->satisfied = true;
				m->solicitingMessage = rm->MsgID();
				rm->SignalComplete();

				reply = m;
				break;
			}
		case(mt_Write):
			{
				writesReceived++;
				WriteMsg* wm = (WriteMsg*)msg;
				replyTime = writeTime;
				WriteResponseMsg* m = EM().CreateWriteResponseMsg(GetDeviceID(),msg->GeneratingPC());
				m->addr = wm->addr;
				m->size = wm->size;
				m->solicitingMessage = wm->MsgID();
				wm->SignalComplete();
				reply = m;
				break;
			}
		case(mt_Eviction):
			{
				evictionsReceived++;
				EvictionMsg* em = (EvictionMsg*)msg;
				EvictionResponseMsg* m = EM().CreateEvictionResponseMsg(GetDeviceID(),msg->GeneratingPC());
				m->addr = em->addr;
				m->size = em->size;
				m->solicitingMessage = em->MsgID();
				reply = m;
				break;
			}
		case(mt_Invalidate):
         {
			   DebugFail("TestMemory::RecvMsg: Main memory being told to invalidate");
			   break;
         }
      case(mt_EvictionResponse):
         {
            DebugFail("TestMemory::RecvMsg: Main memory received eviction response message");
            break;
         }
      case(mt_InvalidateResponse):
         {
            DebugFail("TestMemory::RecvMsg: Main memory received invalidate response message");
            break;
         }
      case(mt_Network):
         {
            DebugFail("TestMemory::RecvMsg: Main memory received network message");
            break;
         }
      case(mt_ReadResponse):
         {
            DebugFail("TestMemory::RecvMsg: Main memory received read response message");
            break;
         }
      case(mt_WriteResponse):
         {
            DebugFail("TestMemory::RecvMsg: Main memory received write response message");
            break;
         }
      default:
         {
            DebugFail("TestMemory::RecvMsg: Main memory received message with unknown message type");
            break;
         }
		}
		// end switch(msg->Type())
		if(reply)
		{
			DebugAssert(reply->IsResponse());
			GetConnection(connectionID).SendMsg(reply,replyTime);
		}
		EM().DisposeMsg(msg);
	}
}
