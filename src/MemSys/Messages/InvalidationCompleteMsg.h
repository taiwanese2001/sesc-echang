#pragma once
#include "BaseMsg.h"

namespace Memory
{
	class InvalidationCompleteMsg : public BaseMsg
	{
	public:
		Address addr;
      MessageID solicitingMessage;

		virtual bool IsResponse() const { return true; }
		virtual size_t MsgSize() const { return 1 + sizeof(Address); }
		virtual MsgType Type() const { return mt_InvalidationComplete; }
      virtual void print(DeviceID destinationDeviceID) const
		{
		   BaseMsg::print(destinationDeviceID);
		   cout << " adr=" << addr
            << " sMsg=" << solicitingMessage
		   ;
		}
	};
}
