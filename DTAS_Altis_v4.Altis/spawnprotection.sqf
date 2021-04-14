// Make players invulnerable in base
	
while {true} do
{
	sleep 1;
	{
		_x allowDamage (_x getVariable ["playerAllowDamage", false]);
	} forEach allUnits;
};