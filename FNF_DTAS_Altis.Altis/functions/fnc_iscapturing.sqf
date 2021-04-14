private ["_unit", "_triggerList", "_inTrigger"];

_unit = _this select 0;

if (isServer) then
{
	_triggerList = list trgObj;
}
else
{
	_triggerList = list trgCapMsg;
};

_inTrigger = false;
if (!isNil "_triggerList") then
{
	_inTrigger = (_unit in _triggerList);
};

(
	(alive _unit)
	&&
	(_unit isKindOf "MAN")
	&&
	(vehicle _unit == _unit)
	&&
	((((getPos _unit) select 2) > 0) ||(!(surfaceIsWater (getPos _unit))))
	&&
	_inTrigger
	&&
	side _unit == attackerSide
)