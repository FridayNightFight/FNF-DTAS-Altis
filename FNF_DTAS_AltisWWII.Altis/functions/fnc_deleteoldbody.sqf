// Description
// Deletes old body after switching to a new one with selectPlayer.

private["_oldUnit", "_alive"];

_oldUnit = _this select 0;

_alive = alive _oldUnit;

if (_oldUnit != (vehicle _oldUnit)) then
{
	unassignVehicle _oldUnit;
	_oldUnit action ["EJECT", vehicle _oldUnit];
};

_oldUnit setDamage 1;

if (!_alive) then
{
	waitUntil {!roundInProgres};
};


_oldUnit setPos markerPos "mrkRemote";

waitUntil {sleep 1; (!(isPlayer _oldUnit))};
deleteVehicle _oldUnit;