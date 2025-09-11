---------------------------------------------

function FlagReinf103()
	if ( GetNUnitsInScriptGroup(903, 0) > 0) then
		LandReinforcement(103);
		Suicide();
	end;
end;

function FlagReinf104()
	if ( GetNUnitsInScriptGroup(904, 0) > 0) then
		LandReinforcement(104);
		Suicide();
	end;
end;

function FlagReinf105()
	if ( GetNUnitsInScriptGroup(905, 0) > 0) then
		LandReinforcement(105);
		Suicide();
	end;
end;

function FlagReinf203()
	if ( GetNUnitsInScriptGroup(903, 1) > 0) then
		LandReinforcement(203);
		Suicide();
	end;
end;

function FlagReinf207()
	if ( GetNUnitsInScriptGroup(907, 1) > 0) then
		LandReinforcement(207);
		Suicide();
	end;
end;

function FlagReinf206()
	if ( GetNUnitsInScriptGroup(906, 1) > 0) then
		LandReinforcement(206);
		Suicide();
	end;
end;

function FlagReinf902()
	if ( GetNUnitsInScriptGroup(902, 0) > 0) then
		EnableAviation(0, 4);
		Suicide();
	end;
end;

function FlagReinf902i()
	if ( GetNUnitsInScriptGroup(902, 1) > 0) then
		EnableAviation(1, 4);
		Suicide();
	end;
end;

function FlagReinf901()
	if ( GetNUnitsInScriptGroup(901, 0) > 0) then
		EnableAviation(0, 4);
		EnableAviation(0, 2);
		Suicide();
	end;
end;

function FlagReinf901i()
	if ( GetNUnitsInScriptGroup(901, 1) > 0) then
		EnableAviation(1, 4);
		EnableAviation(1, 2);
		Suicide();
	end;
end;

function Presets()
	DisableAviation(0, -1);
	DisableAviation(1, -1);
	Suicide();
end;

function Init()
	RunScript( "Presets", 0);
	RunScript( "FlagReinf103", 2000);
	RunScript( "FlagReinf104", 2000);
	RunScript( "FlagReinf105", 2000);
	RunScript( "FlagReinf203", 2000);
	RunScript( "FlagReinf207", 2000);
	RunScript( "FlagReinf206", 2000);
	RunScript( "FlagReinf902", 2000);
	RunScript( "FlagReinf902i", 2000);
	RunScript( "FlagReinf901", 2000);
	RunScript( "FlagReinf901i", 2000);
end;
