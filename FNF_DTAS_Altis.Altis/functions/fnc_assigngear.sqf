private ["_bGiveWeapons", "_aClassSide", "_currentClass", "_i", "_magCount", "_tempBackpackItems", "_backpack", "_chosenOptic"];

//Set the 'finished' flag to false
gearAssigned = false;

#include "..\f\loadout\cfgLoadouts.hpp"

//Get the give weapons param value
_bGiveWeapons = _this select 0;

//Figure out what class/side the player is going to be for the next round
_aClassSide = nextAttackerSide;
if (_bGiveWeapons) then
{
	_aClassSide = attackerSide;
};
_currentClass = currentDClass;
pUniform = ["phx_loadout_opfor_uniform",16] call BIS_fnc_getParamValue;
pWeapons = ["phx_loadout_opfor_weapons",4] call BIS_fnc_getParamValue;
if (_aClassSide == sidePlayer) then
{
	pUniform = ["phx_loadout_blufor_uniform",3] call BIS_fnc_getParamValue;
	pWeapons = ["phx_loadout_blufor_weapons",0] call BIS_fnc_getParamValue;
	_currentClass = currentAClass;
};

pRole = _currentClass select 1;
phx_loadout_unitLevel = 2;
phx_loadout_radio = ["phx_loadout_radio",0] call BIS_fnc_getParamValue;
phx_loadout_map = ["phx_loadout_map",0] call BIS_fnc_getParamValue;
phx_loadout_gps = ["phx_loadout_gps",0] call BIS_fnc_getParamValue;
phx_loadout_watch = ["phx_loadout_watch",0] call BIS_fnc_getParamValue;
phx_loadout_compass = ["phx_loadout_compass",0] call BIS_fnc_getParamValue;
phx_loadout_aid = "FirstAidKit:2";
phx_loadout_smoke = "SmokeShell:4";
phx_loadout_grenade = "HandGrenade:2";
phx_loadout_cuffs = "ACE_CableTie:2";
phx_loadout_explosives = "DemoCharge_Remote_Mag:4";
phx_loadout_defusalkit = "ACE_DefusalKit";
phx_loadout_trigger = "ACE_Clacker";
phx_loadout_PAK = "ACE_personalAidKit";
phx_loadout_bandage = "ACE_fieldDressing:32";
phx_loadout_morphine = "ACE_morphine:16";
phx_loadout_epinephrine = "ACE_epinephrine:8";
phx_loadout_blood = "ACE_bloodIV:2";
phx_loadout_maptools = "ACE_MapTools";
phx_loadout_entrenching = "ACE_EntrenchingTool";
[] call compile preprocessFileLineNumbers format["f\loadout\fn_loadout_uniforms.sqf"];
[] call compile preprocessFileLineNumbers format["f\loadout\fn_loadout_weapons.sqf"];

removeAllWeapons player;
removeGoggles player;

//Determine whether or not to give the player weapons
if (_bGiveWeapons) then {
	// [] call fnc_addRadio;
} else {
	phx_loadout_rifle_mag_tracer = "";
	phx_loadout_rifle_mag = "";
	phx_loadout_sidearm_mag = "";
	phx_loadout_rifle_gl_he = "";
	phx_loadout_rifle_gl_smoke = "";
	phx_loadout_rifle_gl_flare = "";
	phx_loadout_automaticrifle_mag = "";
	phx_loadout_mmg_mag = "";
	phx_loadout_antitank_weapon = "";
	phx_loadout_antitank_mag = "";
	phx_loadout_antitank_mag_1 = "";
	phx_loadout_mediumantitank_mag = "";
	phx_loadout_mediumantitank_mag_1 = "";
	phx_loadout_flare = "";
	phx_loadout_grenade = "";
	phx_loadout_explosives = "";
	phx_loadout_entrenching = "";
	phx_loadout_smoke = "";
	phx_loadout_cuffs = "";
};

[] call compile preprocessFileLineNumbers format[ROLE_SQF_FILENAME select pRole];

if (_bGiveWeapons) then {if (needReload player == 1) then {reload player}};

_chosenOptic = player getVariable ["chosenOptic", nil];
if (!isNil "_chosenOptic") then {
	player addPrimaryWeaponItem _chosenOptic; 
};

if (!isNil "loadoutNotes") then {[loadoutNotes] call CBA_fnc_removePerFrameHandler};

loadoutNotes = [{
	[_x] spawn {
		player removeDiarySubject "PHX_Diary";
		PHX_Diary = player createDiarySubject ["PHX_Diary", "Loadout", "\a3\UI_F_Orange\Data\CfgMarkers\b_Ordnance_ca.paa"];
		{
			[_x] call phx_fnc_loadout_notes;
		} forEach ((units group player));
	};
}, 120] call CBA_fnc_addPerFrameHandler;

if (!_bGiveWeapons) then {
	[] spawn {
		waitUntil {missionNamespace getVariable ["bKeepPlayerInBox", false]};
		while {bKeepPlayerInBox} do {
			{player removeMagazine _x} forEach (magazines player);
			sleep 2;
		};
	};
};


//Set the 'finished' flag to true
gearAssigned = true;
