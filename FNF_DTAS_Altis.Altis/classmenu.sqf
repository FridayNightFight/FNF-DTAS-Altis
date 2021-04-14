private ["_veh", "_cond"];
waitUntil {!isNull player};

_veh = _this select 0;

_veh allowDammage false;

waitUntil {!(isNil "aClasses")};
waitUntil {!(isNil "dClasses")};

{
	_cond = "(nextAttackerSide==sidePlayer) && canChangeClass";
	_veh addAction [_x select 0, "classaction.sqf", [_x, WEST], 4, false, true, "", _cond];
} forEach aClasses;

{
	_cond = "(nextAttackerSide!=sidePlayer) && canChangeClass";
	_veh addAction [_x select 0, "classaction.sqf", [_x, EAST], 4, false, true, "", _cond];
} forEach dClasses;