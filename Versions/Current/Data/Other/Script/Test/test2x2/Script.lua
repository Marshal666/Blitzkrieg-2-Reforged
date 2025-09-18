GenCarsId = 1;

function Cars_Start_Movement()
	
	local i = 1;
	CmdMultiple( ACT_MOVE, GenCarsId, GetScriptAreaParams( "A" .. i ) );
	for i = 2, 12 do
		QCmdMultiple( ACT_MOVE, GenCarsId, GetScriptAreaParams( "A" .. i ) );
	end;
end;

Cars_Start_Movement();

--StartThread( )