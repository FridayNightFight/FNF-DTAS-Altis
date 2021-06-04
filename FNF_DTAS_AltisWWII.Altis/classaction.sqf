private ["_class", "_side"];
_class = (_this select 3) select 0;
_side = (_this select 3) select 1;

if (_side == WEST) then
{
	currentAClass = _class;
}
else
{
	currentDClass = _class;
};

[false] call fnc_assignGear;