/* 
   SESC: Super ESCalar simulator
   Copyright (C) 2004 University of Illinois.

   Contributed by Jose Renau

This file is part of SESC.

SESC is free software; you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation;
either version 2, or (at your option) any later version.

SESC is    distributed in the  hope that  it will  be  useful, but  WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should  have received a copy of  the GNU General  Public License along with
SESC; see the file COPYING.  If not, write to the  Free Software Foundation, 59
Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

#include "SescConf.h"
#include "MemorySystem.h"
#include "AddressPrefetcher.h"
#include "ThreadContext.h"


// NOTE: This class is not finished. Most of the code is there, but it
// still does not work.


AddressPrefetcher::AddressPrefetcher(MemorySystem* current
				     ,const char *section
				     ,const char *name)
  : MemObj(section, name)
  ,bsize(SescConf->getInt(section, "bsize"))
  ,gms(current)
{
  MemObj *lower_level = NULL;

  SescConf->isInt(section, "numPorts");
  SescConf->isInt(section, "portOccp");

  SescConf->isInt(section, "bsize");

  NumUnits_t  num = SescConf->getInt(section, "numPorts");
  TimeDelta_t occ = SescConf->getInt(section, "portOccp");

  cachePort = PortGeneric::create(name, num, occ);

  const char *cacheSection = SescConf->getCharPtr(section, "cache");
  cache = CacheType::create(cacheSection, "", name);

  SescConf->isInt(cacheSection, "hitDelay");
  hitDelay = SescConf->getInt(cacheSection, "hitDelay");

  SescConf->isInt(cacheSection, "missDelay");
  missDelay = SescConf->getInt(cacheSection, "missDelay");

  I(current);
  lower_level = current->declareMemoryObj(section, k_lowerLevel);   
  if (lower_level != NULL)
    addLowerLevel(lower_level);
}

void AddressPrefetcher::tryPrefetch(MemRequest *mreq)
{
}

void AddressPrefetcher::access(MemRequest *mreq)
{
  Time_t when = cachePort->nextSlot();
  Line *l = cache->readLine(mreq->getPAddr());

  if (l) {
    MSG("test[0x%x] op[%d]", (unsigned int) mreq->getPAddr(), mreq->getMemOperation());
    if (mreq->getMemOperation() == MemRead) {
      MSG("hit[0x%x", (unsigned int) mreq->getPAddr());
      mreq->goUpAbs(when);
      return;
    }
    // on displacements, invalidate the line
    l->invalidate();
  }

  mreq->goDown(0, lowerLevel[0]);
}

void AddressPrefetcher::returnAccess(MemRequest *mreq)
{
  if(!mreq->isPrefetch())
    tryPrefetch(mreq);

  mreq->goUp(0);
}

bool AddressPrefetcher::canAcceptStore(PAddr addr)
{
  return true;
}

void AddressPrefetcher::invalidate(PAddr addr,ushort size,MemObj *oc)
{ 
  // Invalidate the local cache
  while (size) {
    cachePort->nextSlot();
    Line *l = cache->readLine(addr);
    if(l)
      l->invalidate();

    addr += cache->getLineSize();
    size -= cache->getLineSize();
  }

  invUpperLevel(addr,size,oc); 
}

Time_t AddressPrefetcher::getNextFreeCycle() const
{ 
  return cachePort->calcNextSlot();
}
