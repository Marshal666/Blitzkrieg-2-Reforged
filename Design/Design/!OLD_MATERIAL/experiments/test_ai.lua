function Reinf1()
	LandReinforcement(2 * RandomInt(3) + 1);
	RunScript( "Reinf1I", 1000);
	Suicide();
end;

function Reinf2()
	LandReinforcement(2 * (RandomInt(3) + 1));
	RunScript( "Reinf2I", 1000);
	Suicide();
end;

function Reinf1I()
local time = 49000 + GetIGlobalVar( "temp.1", 0) + RandomInt(5000);
	RunScript( "Reinf", time);
	RunScript( "Reinf1", time + 1000);
	Suicide();
end;

function Reinf2I()
local time = 49000 + GetIGlobalVar( "temp.2", 0) + RandomInt(5000);
	RunScript( "Reinf", time);
	RunScript( "Reinf2", time + 1000);
	Suicide();
end;

function Reinf()
local delta_time = {0};
local num1 = GetNUnitsInScriptGroup(1) + GetNUnitsInScriptGroup(11) + GetNUnitsInScriptGroup(12);
local num2 = GetNUnitsInScriptGroup(2) + GetNUnitsInScriptGroup(21) + GetNUnitsInScriptGroup(22);
local k1 = 1;
local k2 = 0.1;

--	if ( num1 >= 10) then
--		d1 = 90000;
--	end;
--
--	if ( num2 >= 10) then
--		d2 = 90000;
--	end;

	if ( num1 > num2) then
		if ( num2 == 0) then
			factor = num1 / (num2 + 1);
		else
			factor = num1 / num2;
		end;
		diff = num1 - num2;
		a = 1;
	else
		if ( num1 == 0) then
			factor = num2 / (num1 + 1);
		else
			factor = num2 / num1;
		end;
		diff = num2 - num1;
		a = 2;
	end;
	delta_time[1] = 0;
	delta_time[2] = 0;

	local df = diff * factor;

	if ( df > 1 ) then
		thrust1 = k1 * sqrt( df );
		thrust2 = k2 * df;

		delta_time[a] = thrust1 * 10000; -- slow factor
		delta_time[3 - a] = - thrust1 * 6000; -- immediate factor
	end;

	if ( delta_time[1] < -45000) then
		delta_time[1] = -45000;
	end;
	if ( delta_time[2] < -45000) then
		delta_time[2] = -45000;
	end;

	Trace("Delta1 = %g, Delta2 = %g, Thrust = %g", delta_time[1], delta_time[2], thrust1*(3 - 2*a));

	SetIGlobalVar( "temp.1", delta_time[1]);
	SetIGlobalVar( "temp.2", delta_time[2]);
	Suicide();
end;

function max(aa, bb)
	if ( aa > bb) then
		return aa;
	else
		return bb;
	end;
end;

----------------------------
function sqrt( x)
local ITNUM = 4;
local sp = 0
local i = ITNUM;
local inv = 0;
local a, b;
	if ( x <= 0) then return 0; end;

	if ( x < 1) then
		x = 1 / x;
		inv = 1;
	end;

	while ( x > 16) do
		sp = sp + 1;
		x = x / 16;
	end;

	a = 2;
-- Newtonian algorithm
	while (i > 0) do
		b = x / a;
		a = a + b;
		a = a * 0.5;
		i = i - 1;
	end;
--
	while ( sp > 0) do
		sp = sp - 1;
		a = a * 4;
	end;

	if ( inv == 1) then
		a = 1 / a;
	end;
	return a;
end;
----------------------------

function Init()
	RunScript( "Reinf1", 1000);
	RunScript( "Reinf2", 1000);
--	RunScript( "Reinf", 2000);
end;
