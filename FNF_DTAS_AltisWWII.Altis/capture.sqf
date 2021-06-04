private ["_i", "_count", "_r", "_nextTick", "_fnc_extraAttackersInZone"];

_fnc_extraAttackersInZone =
{
	private ["_count", "_units", "_defenderSide"];
	_count = 0;
	_units = list trgObj;
	_defenderSide = EAST;
	if (attackerSide == EAST) then
	{
		_defenderSide = WEST;
	};
	{
		if ([_x] call fnc_isCapturing) then
		{
			if (side _x == attackerSide) then
			{
				_count = _count + 1;
			};
			if (side _x == _defenderSide) then
			{
				//_count = _count - 1;
			};
		};
	} forEach _units;
	_count
};

waitUntil {!isNil "roundInProgress"};

_r = ln (1 - minCapTime/maxCapTime);

_nextTick = time;

while {true} do
{
	waitUntil {!roundInProgress};
	waitUntil {roundInProgress};
	
	_nextTick = time;
	_i = 0;
	capPercentage = 0;
	
	while {roundInProgress && capPercentage < 1} do
	{
		waitUntil {time > _nextTick};
		_nextTick  = _nextTick + 0.5;
		_count = ([] call _fnc_extraAttackersInZone);
		if (_count > 0) then
		{
			capPercentage = capPercentage + ((1 - exp (_r*_count))/minCapTime)/2;
			if (isServer) then
			{
				// Synchronize capture timer every 5 seconds.
				if (_i == 10) then
				{
					_i = 0;
					publicVariable "capPercentage";
				};
				_i = _i + 1;
			};
		};
	};
	if (capPercentage >= 1 && roundInProgress) then
	{
		if (attackerSide == WEST) then
		{
			bObjW=true;
		}
		else
		{
			bObjE=true;
		};
	};
};