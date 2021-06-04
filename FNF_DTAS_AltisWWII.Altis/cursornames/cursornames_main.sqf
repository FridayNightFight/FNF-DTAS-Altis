private ["_target", "_emptyPosCount"];

_target = cursorTarget;

// Check for valid cursor target.
if ((_target != player) && (side _target == sidePlayer) && (player distance _target) < nameTagMaxDistance) then
{
	// Handle "Man" cursor target.
	if (_target isKindOf "Man") then
	{
		_string = format ["<t font='puristaMedium' size='0.4' color='#a8e748'>%1</t>", name _target];
		[_string, 0, 0.4, 0.1, 0, 0, 3] spawn BIS_fnc_dynamicText;
	}
	else
	{
		// Handle vehicle cursor target if it isn't empty.
		if (({alive _x} count (crew _target)) > 0) then
		{
			_string = [_target] call fnc_getVehicleCrewText;
			[_string, 0, 0.35, 0.1, 0, 0, 3] spawn BIS_fnc_dynamicText;
		};
	};
};

// Show names of current player's vehicle crew members.
if (player != vehicle player) then	
{
	_string = [vehicle player] call fnc_getVehicleCrewText;
	
	//[_string,1.2 ,0.8 ,0.1, 0, 0, 4] spawn BIS_fnc_dynamicText;
	[_string,1.2 ,0.6 ,0.1, 0, 0, 4] spawn BIS_fnc_dynamicText;
};

