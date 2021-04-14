private ["_dir", "_radius", "_maxRadius", "_pos", "_originalPos", "_isWater", "_bCont", "_veh", "_modifieMinDist"];

unstuck_enabled = false;

_veh = vehicle player;

_originalPos = objPos;
if (vehicle player != player) then
{
	_originalPos = (group player) getVariable ["insertionPos", defaultInsertionPos];
};

_isWater = (vehicle player) isKindOf "Ship";
_maxRadius = 10;
if (vehicle player == player) then
{
	_maxRadius = 30;
};
_insertionType = 0;
if ((toUpper (typeOf (vehicle player))) == "B_SDV_01_F") then
{
	_insertionType = 2;
}
else
{
	if (_isWater) then
	{
		_insertionType = 1;
	};
};
_modifieMinDist = minDist * (minDistFactors select _insertionType);
_bCont = true;
while {_bCont} do
{
	_dir = random 360;
	_radius = _maxRadius * sqrt (random 1);
	_maxRadius = _maxRadius * 1.5;
	_pos = [(_originalPos select 0) + _radius * (cos _dir), (_originalPos select 1) + _radius * (sin _dir)];
	_pos = [_pos] call fnc_findFlatEmpty;
	
	_bCont =
	(
		(((surfaceIsWater _pos) && (!_isWater)) || ((!(surfaceIsWater _pos)) && _isWater))
	    ||
		((_veh != player) && (([_pos, objPos] call fnc_airDistance) < _modifieMinDist))
	);
};

// Teleport
_veh setPos _pos;
// Repair/heal
_veh setDammage 0;
player setDammage 0;
// Unflip
_veh setVectorUp [0, 0, 1];
_veh setPos [(getPos _veh) select 0, (getPos _veh) select 1, 0];

sleep 5;
unstuck_enabled = true;