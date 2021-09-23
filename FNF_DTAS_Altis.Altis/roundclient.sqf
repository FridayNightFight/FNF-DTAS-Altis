Private ["_defaultInsertionMarker", "_aRadiusMarker", "_xOffset", "_yOffset", "_pos", "_taskMessageTitle", "_taskMessageText", "_endTime"];

//default player class selection - correlates to loadout\defineclasses.sqf
currentClass = ["", ""];
currentAClass = aClasses select 10;
currentDClass = dClasses select 10;

//vars
basePos = getPos player;
capPercentage = 0;
commandChannelEnabled = true;
isPlaying = false;
isGroupLeader = false;
isSpectating = false;
nameTagMaxDistance = 60;
preferDriver = false;
spectateUnit = player;
unstuck_enabled = true;

//Get offset from respawn marker position ... this is used later for spreading defenders out at the objective ... cheap trick, but effective
_xOffset = (basePos select 0) - (markerPos "respawn_west" select 0);
_yOffset = (basePos select 1) - (markerPos "respawn_west" select 1);
if (sidePlayer == EAST) then
{
	_xOffset = (basePos select 0) - (markerPos "respawn_east" select 0);
	_yOffset = (basePos select 1) - (markerPos "respawn_east" select 1);
};

//Set player vars
player setVariable ["shortName", "-", true];
player setVariable ["preferDriver", preferDriver, true];
player setVariable ["vehicleRole", [objNull, false]];

//Launch startup scripts
execVM "capturetriggermsg.sqf";
execVM "afkkiller.sqf";
// execVM "cursornames\cursornames_init.sqf";

// Run key press handler (disable spacebar scanning, group joining)
disableSerialization;

// Setup the capture trigger (locally)
trgCapMsg setTriggerArea [capRad, capRad, 0, false];

// Setup the initial insertion marker (locally)
_defaultInsertionMarker = createMarkerLocal ["mrkDefaultInsertion", [1, 1]];
_defaultInsertionMarker setMarkerShapeLocal "ICON";
_defaultInsertionMarker setMarkerTypeLocal "mil_start";
_defaultInsertionMarker setMarkerTextLocal format [localize "STR_DefaultInsertion", localize "STR_InsertionVehicle0s"];
_defaultInsertionMarker setMarkerColorLocal "COLORGREEN";
_defaultInsertionMarker setMarkerSizeLocal [1.1, 1.1];
_defaultInsertionMarker setMarkerAlphaLocal 0;

// Setup the initial objective marker (locally)
_aRadiusMarker = createMarkerLocal ["mrkAZone", [1, 1]];
_aRadiusMarker setMarkerShapeLocal "ELLIPSE";
_aRadiusMarker setMarkerBrushLocal "SolidBorder";
_aRadiusMarker setMarkerColorLocal "COLORRED";
_aRadiusMarker setMarkerSizeLocal [minDist, minDist];
_aRadiusMarker setMarkerAlphaLocal 0;

// Setup a handler that runs when the player is killed
player addEventHandler ["Killed",
{
	private ["_killer"];
	_killer = _this select 1;

	if (sidePlayer == side _killer) then
	{
		TKer = _killer;
		publicVariable "TKer";
		[TKer] call TKerPVHandler;
	};

	isPlaying = false;
}];

// Setup a handler that announces when a guy on your team was tk'd
TKerPVHandler =
{
	private ["_killer"];

	_killer = _this select 0;

	if (side _killer == sidePlayer) then
	{
		systemChat format [localize "STR_TKMessage", name _killer];
	};
};
"TKer" addPublicVariableEventHandler
{
	[_this select 1] call TKerPVHandler;
};

// Setup a handler for when the objective is moved
objPosHandlerClient =
{
	trgCapMsg setPos objPos;
	if ((!roundInProgress) && (attackerSide == sidePlayer) && ([player] call fnc_isLeaderWithGroup)) then
	{
		hint (localize "STR_SelectInsertionMethod");
	};
};
"objPos" addPublicVariableEventHandler objPosHandlerClient;

// Setup a handler for when the default insertion position is updated
defaultInsertionPosHandler =
{
	private ["_dx", "_dy", "_dir"];
	if (sidePlayer == attackerSide) then
	{
		_dx = (objPos select 0) - (defaultInsertionPos select 0);
		_dy = (objPos select 1) - (defaultInsertionPos select 1);
		_dir = atan (_dy/_dx);
		if (_dx<0) then
		{
			_dir = _dir + 180;
		};
		if (_dx==0) then
		{
			if (_dy>0) then
			{
				_dir = 90;
			}
			else
			{
				_dir = -90;
			};
		};
		_dir = 90 - _dir;

		"mrkDefaultInsertion" setMarkerPosLocal defaultInsertionPos;
		"mrkDefaultInsertion" setMarkerDirLocal _dir;
		"mrkDefaultInsertion" setMarkerAlphaLocal 1;
	};
};
"defaultInsertionPos" addPublicVariableEventHandler defaultInsertionPosHandler;

// Setup a handler for when vehicles are spawned
vehArrHandler =
{
	{player reveal _x} forEach vehArr;
	[] call fnc_vehicleAllowDamage;
};
"vehArr" addPublicVariableEventHandler vehArrHandler;

// Setup a handler for when the player is assigned to a vehicle
currentVehHandler =
{
	private ["_veh", "_roleIndex", "_slotIndex"];

	_veh = (_this select 0) select 0;
	_roleIndex = (_this select 0) select 1;

	bKeepPlayerInBox = false;

	// Place the player near the vehicle, just in case getting the the vehicle gets messed up.
	player setPos ([getPos _veh, 3] call fnc_findFlatEmpty);
	// player setPos ((position _veh) findEmptyPosition [2, 20]);
	

	// Get in the vehicle.
	if (_roleIndex == 0) then
	{
		player moveInDriver _veh;
	}
	else
	{
		_slotIndex = _roleIndex - 1;
		if (((toLower (typeOf _veh)) == (toLower "B_Heli_Light_01_F")) || ((toLower (typeOf _veh)) == (toLower "B_SDV_01_F"))) then
		{
			_slotIndex = _slotIndex - 1;
		};
		if (_slotIndex < 0) then
		{
			player moveInTurret [_veh, [0]];
		}
		else
		{
			player moveInCargo [_veh, _slotIndex];
		};
	};

	// bKeepPlayerInBox = false;

	// params ["_vehicle", "_driver"];

	// if (!isNull _driver) then {
	// 	if (player isEqualTo _driver) then {
	// 		player moveInDriver _vehicle;
	// 	} else {
	// 		player moveInAny _vehicle;
	// 	};
	// } else {
		// player moveInAny _vehicle;
	// };
};
"currentVeh" addPublicVariableEventHandler {
	[_this # 1] call currentVehHandler;
};

// Wait until we have an objective and then call the handler manually (initial run)
waitUntil {!(isNil "objPos")};
[] call objPosHandlerClient;

// Wait until we have an insertion position and then call the handler manually (initial run)
waitUntil {!(isNil "defaultInsertionPos")};
[] call defaultInsertionPosHandler;

// Wait until the player is alive and we know who is attacking (initial run)
waitUntil {alive player && (!isNil "nextAttackerSide")};
[] call objPosHandlerClient;

// Ok, setup the DTAS Hude
[] call compile preprocessFileLineNumbers "hud_create.sqf";

// Run the time left script
execVM "timerupdateclient.sqf";

// Strip the player of their default stuff (initial run)
[false] call fnc_respawn;

// Keep the player in the box cause they're not included in whatever round may be running
bKeepPlayerInBox = true;

// Well, this is just starting so ... obviously the guy is alive but ... add the action to 'unstuck' a car
if (alive player) then
{
	[] call fnc_addActions;
};

// Variables for restriction checking.
// Set enableRestrictionChecking to false and wait for restrictionCheckingEnabled to become false.
// To re-enable, set restrictionCheckingEnabled and enableRestrictionChecking to true (in that order).
enableRestrictionChecking = true;
restrictionCheckingEnabled = true;

//So...this is bit of code is spawned in a separate non-blocking thread
//It appears to move the player back into the box at spawn and constantly check to see if they've left
[] spawn
{
	private ["_xPos", "_yPos", "_sight", "_FAKCount", "_maxFAKCount"];
	_xPos = (markerPos "respawn_east") select 0;
	_yPos = (markerPos "respawn_east") select 1;
	if (sidePlayer == WEST) then
	{
		_xPos = (markerPos "respawn_west") select 0;
		_yPos = (markerPos "respawn_west") select 1;
	};

	while {true} do
	{
		/* Temporarily disable restriction checking while initializing round. */
		if (!enableRestrictionChecking) then
		{
			restrictionCheckingEnabled = false;
			waitUntil {enableRestrictionChecking};
		};

		if (bKeepPlayerInBox) then
		{
			if ((alive player) && (((abs((getPos player select 0) - _xPos)) > 14) || ((abs ((getPos player select 1) - _yPos)) > 10))) then
			{
				player setPos [_xPos, _yPos];
				player setVelocity [0, 0, 0];
			};
		};

		sleep .01;
	};
};

//This seems like 'wtf gotcha compensation code' ... so basically, if we don't know if a round is in progress, wait until we do or until the player dies and if they die, move them back to their spawn
while {isNil "roundInProgress"} do
{
	waitUntil {!isNil "roundInProgress" || !alive player};
	if (!alive player) then
	{
		[false] call fnc_respawn;
	};
};

//Ok, so we're still on our initial run, and now we're checking to see if a round is in progress
if (roundInProgress) then
{
	// Tell the player they're waiting until the next round
	hintC localize "STR_WaitNextRound";

	// and while the round is in progress
	while {roundInProgress} do
	{
		// wait until the round is over or the player dies and if they died, move them back to spawn
		waitUntil {!roundInProgress || !alive player};
		if (!alive player) then
		{
			[false] call fnc_respawn;
		};
	};
};

//Ok, so at this point, we joined and if a round was running when we joined, it's now over so this player is going to continue to execute the following code until the mission is over
while {true} do
{
	//Set the camera to be from the players perspective
	spectateUnit = player;
	[] call fnc_switchCamera;

	//Set the vars
	player setVariable ["isPlaying", false];
	// player setVariable ["ready", true, true];

	//This is some weird code...but I'm pretty sure it stops the script until the round starts
	while {(!roundInProgress) || (!(player getVariable ["isPlaying", false]))} do
	{
		// Wait til the round starts and the player is ready OR until the player dies
		waitUntil {(roundInProgress && (player getVariable ["isPlaying", false])) || !alive player};

		// If the player died (for whatever reason), move them back to spawn and set their ready status
		if (!alive player) then
		{
			[false] call fnc_respawn;
			// player setVariable ["ready", true, true];
		};
	};

	//Round has started, stop the player from choosing their insertionPos
	["DTASChooseAPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	["DTASChooseObjPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	"mrkAZone" setMarkerAlphaLocal 0;

	lastAttackerSide = attackerSide;

	// Stop restriction checking to allow "thread-safe" round initialization.
	enableRestrictionChecking = false;
	waitUntil {!restrictionCheckingEnabled};

	//Stop player's existing movement
	player setVelocity [0,0,0];
	if (sidePlayer == attackerSide) then
	{
		bKeepPlayerInBox = false;
		//put in assigned vehicle (attackers)
		if ((vehicle player == player) && (isNil "currentVeh")) then
		{
			waitUntil {!isNil "currentVeh"};
			if (vehicle player == player) then
			{
				[currentVeh] call currentVehHandler;
			};
		};
	}
	else
	{
		//move to flat area (defenders)
		_pos = [(objPos select 0) + _xOffset, (objPos select 1) + _yOffset];
		_pos = [_pos, 3] call fnc_findFlatEmpty;
		bKeepPlayerInBox = false;
		player setPos _pos;
	};

	//Reset players health
	player setDamage 0;
	[player] call ace_medical_treatment_fnc_fullHealLocal;

	//Set the isPlaying flag
	isPlaying = true;

	//Give them their weapons
	[true] call fnc_respawn;
	
	
	player allowDamage true;

	// Re-enable restriction checking.
	restrictionCheckingEnabled = true;
	enableRestrictionChecking = true;

	//Set conditions for allowing player damage (30 second wait or the player dies or the round ends)
	[] spawn
	{
		private ["_endTime"];
		_endTime = time + 30;
		waitUntil {(!(alive player)) || (!roundInProgress) || (time > _endTime)};
		if ((time > _endTime) && (alive player) && roundInProgress) then
		{
			player setVariable ["playerAllowDamage", true, true];
		};
	};

	//Display "capture the zone" or "defend the zone" message
	if (sidePlayer == attackerSide) then
	{
		_taskMessageTitle = "STR_CaptureTheZone";
		_taskMessageText = "STR_CaptureTheZoneLong";
		["DTASNotificationAttackStart", [localize _taskMessageTitle, localize _taskMessageText]] spawn BIS_fnc_showNotification;
	}
	else
	{
		_taskMessageTitle = "STR_DefendTheZone";
		_taskMessageText = "STR_DefendTheZoneLong";
		["DTASNotificationDefenseStart", [localize _taskMessageTitle, localize _taskMessageText]] spawn BIS_fnc_showNotification;
	};


	if (player isEqualTo (leader (group player))) then {
		_radio = call TFAR_fnc_activeSwRadio;
		player setVariable ["groupRadio", _radio, true];
		sleep 1;
	} else {
		sleep 1;
		_groupRadio = (leader (group player)) getVariable ["groupRadio", ""];
		if !(_groupRadio isEqualTo "") then {
			[_groupRadio, (call TFAR_fnc_activeSwRadio)] call TFAR_fnc_CopySettings;
		};
	};



	

	//Wait until the round ends or the player dies
	waitUntil {!(alive player) || !roundInProgress};

	//Set their isPlaying flag
	isPlaying = false;
	player setVariable ["isPlaying", false];

	//Set the flag to keep them in the box
	bKeepPlayerInBox = true;

	//Strip 'em
	[false] call fnc_respawn;

	//Is the round still going?
	if (roundInProgress) then
	{
		//Yep, launch spectator
		//[] call fnc_nextSpectateUnit;
		// [["You can enter spectator at any time"], ["using the yellow box at spawn."], [getText(configfile >> "CfgVehicles" >> "Land_CinderBlocks_F" >> "EditorPreview"), 3]] call CBA_fnc_notify;
	}
	else
	{
		//Nope, reset the player back to the spawn
		if (vehicle player != player) then
		{
			player action ["Eject", vehicle player];
		};
		player setPos basePos;
		player setVelocity [0,0,0];
		player setDamage 0;
		[player] call ace_medical_treatment_fnc_fullHealLocal;
		player allowDamage false;
	};

	waitUntil {!roundInProgress};

	//Some crap I don't care about that happens after the round ends
	// (group player) setVariable ["groupReady", false];
	"mrkDefaultInsertion" setMarkerAlphaLocal 0;
	[] call fnc_reveal;
	[] call fnc_roundEndMessage;
};
