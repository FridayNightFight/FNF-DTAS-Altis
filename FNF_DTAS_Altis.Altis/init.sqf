#include "islandspecific.hpp"

//No clue what this island specific shit is supposed to do
call compile preprocessFile "islandspecific.sqf";

player allowDamage false;

// minimum and maximum capturing times - Maximum for when only 1 more attackers than defenders, minimum when infinitely more attackers than defenders
minCapTime = 20;
maxCapTime = 60;
s_loadout_radio = 0;
s_loadout_map = 0;
// Multipliers for minimum spawn distance of each insertion type.
minDistFactors = [1, 0.7, 0.55, 1];

// The variable this is waiting on is launched by a module...why is it done this way? I have no idea.
waitUntil {!isNil "preInitDone"};

enableSaving [false, false];
enableSentences false;

// fix for marker position desync for JIP
[] spawn
{
	waitUntil {!isNil "objPos"};
	"mrkObj" setMarkerPosLocal objPos;
	"mrkObj1" setMarkerPosLocal objPos;
};

//launch function definition script
[] execVM "functions.sqf";

//launch capture monitor script
[] execVM "capture.sqf";

//execute this shit if this script is running on the server
if (isServer) then
{
	["Initialize"] call BIS_fnc_dynamicGroups;

	// Make sure teamkillers don't go on side enemy
	[] spawn
	{
		while {true} do
		{
			waitUntil {sideEnemy countSide allUnits > 0};
			{
				if (side _X == sideEnemy) then
				{
					_X addRating (-(rating _X));
				};
			} forEach allUnits;
		};
	};

	execVM "roundserver.sqf";
};

//Setup event handlers that watch for mission end and display appropriate crap
execVM "endhandler.sqf";

//Launches a script that checks once per second to see if the player should be vulnerable or not and enforces it
//execVM "spawnprotection.sqf";

//Set the weather ... don't even know if this works
execVM "weather.sqf";

//Execute this stuff if this computer isn't a dedicated server meaning if a player is hosting the mission, they can run this script too
if (!isDedicated) then
{
	waitUntil {!isNull player};

	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

	sidePlayer = playerSide;
	isJoining = false;
	player setVariable ["ready", false, true];

	execVM "briefing.sqf";
	execVM "QS_icons.sqf";

	call compile preprocessFileLineNumbers "f\loadout\defineclasses.sqf";

	[
		0, // free cam
		objNull, // no focus
		-2, // normal vision mode
		[0,0,150], // position
		0 // facing north
	] call ace_spectator_fnc_setCameraAttributes;

	sleep .01;

	execVM "roundclient.sqf";
};
