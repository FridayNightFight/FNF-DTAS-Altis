private ["_pos", "_minDist", "_startDist", "_factor", "_foundPos", "_unitType"];

_pos = _this select 0;
_startDist = 10;
_factor = 2;
_minDist = 0;
if (!isDedicated) then
{
	_unitType = typeOf (vehicle player);
}
else
{
	_unitType = typeOf (allUnits select 0);
};
if (count _this > 1) then
{
	_startDist = _this select 1;
};
if (count _this > 2) then
{
	_factor = _this select 2;
};
if (count _this > 3) then
{
	_unitType = _this select 3;
};
if (count _this > 4) then
{
	_minDist = _this select 4;
};

_foundPos = [];

while {count _foundPos < 1} do
{
	_foundPos = _pos findEmptyPosition [0, _startDist, _unitType];
	_startDist = _startDist * 2;
};

_foundPos