#pragma once
#include "BaseMsg.h"
#include "../MSTypes.h"

namespace Memory
{
	class WriteResponseMsg : public BaseMsg
	{
	public:
		Address addr;
		size_t size;
		MessageID solicitingMessage;

		virtual bool IsResponse() const { return true; }
		virtual size_t MsgSize() const { return 1 + sizeof(Address); }
		virtual MsgType Type() const { return mt_WriteResponse; }
		//virtual void print() const {print(0)};
      virtual void print(DeviceID destinationDeviceID) const
		{
		   BaseMsg::print(destinationDeviceID);
		   cout << " adr=" << addr
		         << " solicitingMessage=" << solicitingMessage
		   ;
		}

	};
}
