private ["_veh"];

waitUntil {!isNil "preInitDone"};

_this execVM "classmenu.sqf";

_veh = _this select 0;

if (isServer) then
{
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	clearBackPackCargoGlobal _veh;
	
	all_crates = all_crates + [_veh];
};