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

fnc_nextSpectateUnit =
{
	spectateUnit = objNull;
	[] call fnc_switchCamera;
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
	if (!alive player) then
	{
		waitUntil {alive player};
		[] call fnc_addActions;
	};
	player setVariable ["preferDriver", preferDriver, true];
	player setVariable ["vehicleRole", [objNull, false]];
	player setVariable ["playerAllowDamage", false, true];
	[_bGiveWeapons] call fnc_assignGear;
	player setFatigue 0;
	
	if(roundInProgress && !isPlaying) then {
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

fnc_switchCamera =
{
	if (isNull spectateUnit) then
	{
		isSpectating = true;
		[player,player,true,true,true] call F_fnc_CamInit;
	}
	else 
	{
		if (spectateUnit == player) then
		{
			isSpectating = false;
			[] call F_fnc_ForceExit;
			[player, false] call TFAR_fnc_forceSpectator;
		} 
		else 
		{
			isSpectating = true;
			[player,player,true,true,true] call F_fnc_CamInit;
		};	
	};
};