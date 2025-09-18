triggers = {};
maxTriggerIndex = 0;
STOPTHISTRIGGER = -65536;
--
function KillTrigger( specifiedtrigger )
	if ( specifiedtrigger ~= nil ) then
		triggers[ specifiedtrigger ] = nil;
	end;
end;
--
function Trigger( trigger, handler, cycled, latency )
	if ( trigger == nil ) then
		Trace( "Trigger: No trigger specified" );
		return -1;
	end;
	if ( handler == nil ) then
		Trace( "Trigger: No handler specified" );
		return -1;
	end;	
	maxTriggerIndex = maxTriggerIndex + 1;
	triggers[maxTriggerIndex] = {};
	triggers[maxTriggerIndex].trigger = trigger;
	triggers[maxTriggerIndex].handler = handler;
	if latency == nil then
		triggers[maxTriggerIndex].latency = 20;
	else
		triggers[maxTriggerIndex].latency = latency;
	end
	triggers[maxTriggerIndex].curLatency = 0;
	triggers[maxTriggerIndex].cycled = cycled;
	return maxTriggerIndex;
end
--
function TriggersManager()
	Trace( "Triggers manager was started" );
	while 1 
	do
		for index, handler in triggers
		do
			if ( index ~= nil ) and ( handler ~= nil ) then
				if handler.curLatency >= handler.latency then
					local handlerresult = handler.trigger();
					if handlerresult ~= nil then
						if handlerresult ~= STOPTHISTRIGGER then
							StartThread( handler.handler );
						end;
						if ( handler.cycled == nil ) or ( handlerresult == STOPTHISTRIGGER ) then
							triggers[index] = nil;
							break;
						end	
					end
					if triggers[index] ~= nil then
						handler.curLatency = 0;
					end
				end
				handler.curLatency = handler.curLatency + 10;
			end
		end
		Sleep( 10 );
	end
end
--
TriggersManager();
--