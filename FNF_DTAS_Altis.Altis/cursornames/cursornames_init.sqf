// Get a list of turret paths up to 2 levels deep.
fnc_getTurretPaths =
{
	private ["_veh", "_resultsArr", "_turrets", "_i", "_j"];
	
	_veh = _this select 0;
	
	_resultsArr = [];
	_turrets = configFile / "CfgVehicles" / typeOf _veh / "Turrets";
	for "_i" from 0 to ((count _turrets) - 1) do
	{
		_resultsArr set [count _resultsArr, [_i]];
		for "_j" from 0 to (count (_turrets / configName (_turrets select _i) / "Turrets") - 1) do
		{
			_resultsArr set [count _resultsArr, [_i, _j]];
		};
	};
	
	_resultsArr
};

// Get the list of crew members and empty seats.
fnc_getVehicleCrewText =
{
	private ["_vehicle", "_string", "_nameVehicle", "_picture", "_driver", "_commander", "_emptyPosCount", "_gunnerIndex", "_turretPaths", "_turretPath", "_gunner", "_cargoCrew", "_isCargo", "_gunnerRoleName", "_driverRoleName", "_unit"];
	
	_vehicle = _this select 0;
	
	_nameVehicle = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
	_picture = getText (configFile >> "cfgVehicles" >> (typeOf _vehicle) >> "picture");
	_driver = if (alive (driver _vehicle)) then {name (driver _vehicle)} else {if ((_vehicle emptyPositions "Driver") > 0) then {localize "STR_Empty"} else {""}};
	
	_commander  = if (alive (commander _vehicle)) then {name (commander _vehicle)} else {if ((_vehicle emptyPositions "Commander") > 0) then {localize "STR_Empty"} else {""}};
	_emptyPosCount = (_vehicle) emptyPositions "cargo";
	
	_string = format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748' underline='true'>%1 </t><img align='left' size='0.45' image='%2'/><br/>", _nameVehicle, _picture];
	
	if (_commander != "") then
	{
		_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1: %2 </t><br/>", localize "STR_Commander", _commander];
	};
	
	_driverRoleName = localize "STR_Driver";
	_gunnerRoleName = localize "STR_Gunner";
	if (_vehicle isKindOf "Air") then
	{
		_gunnerRoleName = localize "STR_CoPilot";
		_driverRoleName = localize "STR_Pilot";
	};
	
	if (_driver != "") then
	{
		_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1: %2 </t><br/>", _driverRoleName, _driver];
	};
	
	// Handle multiple gunners in turrets.
	// Assume first turret of air vehicles is copilot, otherwise gunner.
	_gunnerIndex = 0;
	_turretPaths = [_vehicle] call fnc_getTurretPaths;
	if ((count _turretPaths) > 1) then
	{
		{
			_turretPath = _x;
			_unit = _vehicle turretUnit _turretPath;
			if (_unit != commander _vehicle) then
			{
				_gunner = if (alive _unit) then {name _unit} else {localize "STR_Empty"};
				if (_gunnerIndex == 0) then
				{
					_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1: %2 </t><br/>", _gunnerRoleName, _gunner];				
				}
				else
				{
					_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1 %2: %3 </t><br/>", localize "STR_Turret", _gunnerIndex, _gunner];
				};
				_gunnerIndex = _gunnerIndex + 1;
			};
		} forEach _turretPaths;
	}
	else
	{
		if ((count _turretPaths) > 0) then
		{
			// Only one gunner, so just display him.
			_turretPath = _turretPaths select 0;
			_gunner = if (alive (_vehicle turretUnit _turretPath)) then {name (_vehicle turretUnit _turretPath)} else {localize "STR_Empty"};
			_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1: %2 </t><br/>", _gunnerRoleName, _gunner];
		};
	};
	
	_cargoCrew = (crew _vehicle) - [driver _vehicle, gunner _vehicle, commander _vehicle];
	_isCargo = false;
	{
		if (alive _x) then
		{
			if (!_isCargo) then
			{
				_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1:</t><br/>", localize "STR_Cargo"];
			};
			_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1</t><br/>", name _x];
			_isCargo = true;
		};
	} forEach _cargoCrew;
	
	if ((_emptyPosCount > 0) || ((count _cargoCrew) > 0)) then
	{
		_string = _string + format ["<t font='puristaMedium' size='0.4' align='left' color='#a8e748'>%1: %2 </t><br/>", localize "STR_EmptyCargoSeats", _emptyPosCount];
	};
	
	_string
};

fnc_handleCursorNames = compile preprocessFileLineNumbers "cursornames\cursornames_main.sqf";

while {true} do
{
	sleep 0.01;
	[] call fnc_handleCursorNames;
}