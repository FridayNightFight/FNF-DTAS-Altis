fnc_addRadio = compile preprocessFileLineNumbers "functions\fnc_addradio.sqf";
fnc_assigngear = compile preprocessFileLineNumbers "functions\fnc_assigngear.sqf";
fnc_cleanName = compile preprocessFileLineNumbers "functions\fnc_cleanname.sqf";
fnc_DeleteOldBody = compile preprocessFileLineNumbers "functions\fnc_deleteoldbody.sqf";
fnc_findFlatEmpty = compile preprocessFileLineNumbers "functions\fnc_findflatempty.sqf";
fnc_getSqrDist = compile preprocessFileLineNumbers "functions\fnc_getsqrdist.sqf";
fnc_handleGroupsServer = compile preprocessFileLineNumbers "functions\fnc_handlegroups.sqf";
fnc_HUDUpdate = compile preprocessFileLineNumbers "hud_update.sqf";
fnc_isCapturing = compile preprocessFileLineNumbers "functions\fnc_iscapturing.sqf";
fnc_roundEndMessage = compile preprocessFileLineNumbers "roundendmsg.sqf";
fnc_startPos = compile preprocessFileLineNumbers "functions\fnc_startpos.sqf";

fnc_addActions =
{
	player addAction [localize "STR_UnStuck", "unstuck.sqf", [], 0, false, true, "",
	"
		unstuck_enabled
		&&
		isPlaying && ((time + timeLimit - endTime) > 5)
		&&
		(
			(sidePlayer != attackerSide) && ((time + timeLimit - endTime) < 45) && (([getPos player, objPos] call fnc_getSqrDist) < 10000)
			||
			((vehicle player != player) && (player == driver (vehicle player)) && ([getPos player, ((group player) getVariable ['insertionPos', [0, 0, 0]])] call fnc_getSqrDist) < 5625)
		)
	"];
};

fnc_allGroupsReady =
{
	private ["_ready", "_minGroupSize", "_group", "_atLeastOneGroup"];
	_ready = true;
	_atLeastOneGroup = false;
	_minGroupSize = [] call fnc_minGroupSize;
	{
		_group = _x;
		//if ((side _group == attackerSide) && (count (units _group)) >= _minGroupSize) then
		if ((count (units _group)) >= _minGroupSize) then
		{
			_atLeastOneGroup = true;
			if (!(_group getVariable ["groupReady", false])) then
			{
				_ready = false;
			};
		};
	} forEach allGroups;
	
	(_ready && _atLeastOneGroup)
};

fnc_airDistance =
{
	sqrt (_this call fnc_getSqrDist)
};

fnc_cleanUpVehicles =
{
	{
		if (!(isNull _x)) then
		{
			deleteVehicle _x;
		};
	} forEach vehArr;
	
	{
		if (_x isKindOf "AIR") then
		{
			deleteVehicle _x;
		};
	} forEach vehicles;
};

fnc_hasPlayers =
{
	private ["_aCount", "_dCount"];
	
	_aCount = 0;
	_dCount = 0;
	
	{
		_unit = _x;
		if (_unit getVariable ["ready", false]) then
		{
			if ((side _unit) == attackerSide) then
			{
				_aCount = _aCount + 1;
			}
			else
			{
				_dCount = _dCount + 1;
			};
		};
	} forEach allUnits;
	
	((_aCount > 0) && (_dCount > 0))
};

fnc_isAdmin =
{
	serverCommandAvailable '#kick'
};

fnc_isLeaderWithGroup =
{
	_unit = _this select 0;
	_minGroupSize = [] call fnc_minGroupSize;
	
	(
		(player == leader player)
		&&
		((count (units (group player))) >= _minGroupSize)
	)
};

// function to init spectator
fnc_nextSpectateUnit =
{
	spectateUnit = objNull;
	// [] call fnc_switchCamera;

	private _relPos = (markerPos "mrkObj") getPos [200, 180];
	_relPos set [2, 150];
	if (roundInProgress) then {
		[
			0, // free cam
			objNull, // random player around objective selectRandom((markerPos "mrkObj") nearEntities ["Man", 1000])
			-2, // normal vision mode
			_relPos, // position south of objective
			0 // facing north
		] call ace_spectator_fnc_setCameraAttributes;
	} else {

		[
			0, // free cam
			objNull, // no focus
			-2, // normal vision mode
			_relPos, // position south of objective
			0 // facing north
		] call ace_spectator_fnc_setCameraAttributes;
	};


	[allPlayers] call ace_spectator_fnc_updateUnits;


	// * Possible camera modes are:
	// *   - 0: Free
	// *   - 1: First person
	// *   - 2: Follow
	[[0,1,2]] call ace_spectator_fnc_updateCameraModes;


	// * Possible vision modes are:
	// *   - -2: Normal
	// *   - -1: Night vision
	// *   -  0: White hot
	// *   -  1: Black hot
	// *   -  2: Light Green Hot / Darker Green cold
	// *   -  3: Black Hot / Darker Green cold
	// *   -  4: Light Red Hot / Darker Red Cold
	// *   -  5: Black Hot / Darker Red Cold
	// *   -  6: White Hot / Darker Red Cold
	// *   -  7: Thermal (Shade of Red and Green, Bodies are white)
	[[-2,1], [-1,0,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes;


	// * Arguments:
	// * 0: Spectator state of local client <BOOL> (default: true)
	// * 1: Force interface <BOOL> (default: true)
	// * 2: Hide player (if alive) <BOOL> (default: true)
	[true, false, false] call ace_spectator_fnc_setSpectator;
	[player, true] call TFAR_fnc_forceSpectator;



	//Draw 3d icons
	phx_drawObjective = [{
		_objMark = "mrkObj";
		if (markerType _objMark isEqualTo "" || !ace_spectator_isset) then {
			[_handle] call CBA_fnc_removePerFrameHandler;
		} else {
			drawIcon3D ["a3\ui_f\data\map\Markers\Military\objective_CA.paa", [1,0,0,0.8], markerPos _objMark, 0.6, 0.6, 45];
		};
	} , 0] call CBA_fnc_addPerFrameHandler;

	phx_drawInsertion = [{
		_insertionMark = "mrkDefaultInsertion";
		if (markerType _insertionMark isEqualTo "" || !ace_spectator_isset || playerSide != attackerSide) then {
			[_handle] call CBA_fnc_removePerFrameHandler;
		} else {
			drawIcon3D ["\A3\ui_f\data\map\markers\handdrawn\start_CA.paa", [0,0.8,0,0.8], markerPos _insertionMark, 0.6, 0.6, 0];
		};
	} , 0] call CBA_fnc_addPerFrameHandler;
};

// function to exit spectator
fnc_switchCamera =
{
	[false] call ace_spectator_fnc_setSpectator;
	[player, false] call TFAR_fnc_forceSpectator;
};

fnc_vehicleAllowDamage =
{
	{
		_x allowDamage false;
	} forEach vehArr;
	
	[] spawn
	{
		private ["_endTime", "_oldVehArr"];
		_oldVehArr = vehArr + [];
		_endTime = time + 30;
		waitUntil {time > _endTime};
		{
			if (!(isNull _x)) then
			{
				_x allowDamage true;
			};
		} forEach _oldVehArr;
	};
};

fnc_minGroupSize =
{
	private ["_minGroupSize"];
	_minGroupSize = (playersNumber (attackerSide)) / 3;
	if (_minGroupSize > 3) then
	{
		_minGroupSize = 3;
	};
	
	_minGroupSize
};

fnc_respawn =
{
	private ["_bGiveWeapons"];
	_bGiveWeapons = _this select 0;
	if (!alive player || !(player isKindOf "CAManBase")) then
	{
		waitUntil {alive player && player isKindOf "CAManBase"};
		[] call fnc_addActions;
	};
	if (!isNil "preferDriver") then {
		player setVariable ["preferDriver", preferDriver, true];
	};
	player setVariable ["vehicleRole", [objNull, false]];
	player setVariable ["playerAllowDamage", false, true];

	[_bGiveWeapons] call fnc_assignGear;
	
	if (_bGiveWeapons) then {
		// Remove optics selection
		["remove"] execVM "optics.sqf";
	} else {
		// Add optics selection
		["add"] execVM "optics.sqf";
	};

	player setFatigue 0;
	
	if (roundInProgress && !isPlaying) then {
		[] call fnc_nextSpectateUnit;
		//hint "Round in Progress and Player is not playing";
	} else {
		spectateUnit = player;
		[] call fnc_switchCamera;
		//hint "Round not in Progress or player is playing";
	};
};

fnc_reveal =
{
	{(group player) reveal _x;} forEach ((getPos player) nearObjects ["B_SupplyCrate_F", 50]);
	if (sidePlayer == WEST) then
	{
		(group player) reveal westMenuFlag;
	}
	else
	{
		(group player) reveal eastMenuFlag;
	};
};

fnc_setupObjPos =
{
	private ["_group"];
	defaultInsertionPos = [] call fnc_startPos;
	publicVariable "defaultInsertionPos";
	if (!isDedicated) then
	{
		[] call defaultInsertionPosHandler;
	};
	
	{
		_group = _x;
		if (side _group == attackerSide) then
		{
			_group setVariable ["insertionType", 0, true];
			_group setVariable ["insertionPos", defaultInsertionPos, true];
			_group setVariable ["insertionPosPicked", false, true];
		};
		_group setVariable ["groupReady", false, true];
	} forEach allGroups;
	
	trgObj setPos objPos;
	"mrkObj" setMarkerPos objPos;
	"mrkObj1" setMarkerPos objPos;
	
	if (currentSetupTime == -2) then
	{
		currentSetupTime = setupTime * 2;
	};
	roundStartTime = time + currentSetupTime;
	
	updateTime = true;
	aStartPosPicked = false;
	canChangeObjPos = true;
	forceRoundStart = false;
	
	publicVariable "aStartPosPicked";
};