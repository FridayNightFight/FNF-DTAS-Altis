private ["_deleteTypes", "_i", "_j", "_changeAttackerSide", "_dUnitArr", "_aUnitArr", "_dUnitCount", "_aUnitCount", "_minX", "_maxX", "_minY", "_maxY", "_vehType", "_vehCount", "_slotCount", "_veh", "_pos", "_aStartDir", "_zoneMarker", "_area", "_posFound", "_driverArray", "_driverArrayCount", "_passengerArray", "_passengerArrayCount", "_endTime", "_group", "_groups", "_groupIndex", "_maxGroupIndex", "_minGroupSize", "_unitsWithoutGroup", "_units", "_vehicleIndex", "_moreGroupsToSpawn", "_shouldSpawnThisGroup", "_spawnMode", "_toDelete", "_crate", "_dx", "_dy", "_jeepType", "_jeepCrewCount"];

//Define private vars
_changeAttackerSide = true;
_deleteTypes = ["GroundWeaponHolder", "WeaponHolderSimulated", "Default"];
_jeepType = {
	selectRandomWeighted [
		"rhsusf_m1025_d", 0.7,
		"rhsusf_m1043_d", 0.7,
		"rhs_usf_m998_d_2dr_fulltop", 0.7,
		"rhsusf_m998_d_4dr_fulltop", 0.7,
		"rhsusf_m998_d_2dr_halftop", 0.7,
		"rhsusf_M1239_socom_d", 0.5,
		"rhsusf_M1238A1_socom_d", 0.5,
		"rhsusf_m1151_m240_v1_usarmy_d", 0.25,
		"rhsusf_m113d_usarmy_M240", 0.25
	]
};
_jeepCrewCount = 4;

//Define public vars
scoreW = 0;
scoreE = 0;
bObjW = false;
bObjE = false;
attackerSide = WEST;
nextAttackerSide = WEST;
roundInProgress = false;
canChangeClass = true;
currentSetupTime = FirstRoundSetupTime;
adminPaused = false;
updateTime = false;
trainingRound = ["trainingRound",0] call BIS_fnc_getParamValue;
if (DefaultAdminPaused > 0) then
{
	adminPaused = true;
};

//Distribute public var values to the clients
publicVariable "scoreE";
publicVariable "scoreW";
publicVariable "attackerSide";
publicVariable "nextAttackerSide";
publicVariable "roundInProgress";
publicVariable "canChangeClass";
publicVariable "adminPaused";

//Start the initial stuff
"mrkObj" setMarkerSize [capRad, capRad];
trgObj setTriggerArea [capRad, capRad, 0, false];

if (!isDedicated) then
{
	waitUntil {!isNil "objPosHandlerClient"};
	waitUntil {!isNil "defaultInsertionPosHandler"};
	waitUntil {!isNil "vehArrHandler"};
	waitUntil {!isNil "currentVehHandler"};
};

// Should be obsolete
aStartPosHandlerServer =
{
	private ["_dx", "_dy"];
	if (!roundInProgress) then
	{
		insertionType = requestedInsertionType;
		publicVariable "insertionType";

		aStartPos = aStartPosRequest;
		publicVariable "aStartPos";
		if (!isDedicated) then
		{
			[] call aStartPosHandlerClient;
		};
		aStartPosPicked=true;
		publicVariable "aStartPosPicked";
	};
};
"aStartPosRequest" addPublicVariableEventHandler aStartPosHandlerServer;

execVM "timerupdateserver.sqf";

adminObjPosHandler =
{
	// This condition is almost the same as roundInProgress, but safe for updating objective position.
	if (canChangeObjPos) then
	{
		objPos = adminObjPos;
		publicVariable "objPos";
		if (!isDedicated) then
		{
			[] call objPosHandlerClient;
		};
		[] call fnc_setupObjPos;
	};
};
"adminObjPos" addPublicVariableEventHandler adminObjPosHandler;

vehArr = [];
markerAreaArray = [];
totalMarkerArea = 0;
_j = 0;
_markerPrefix = "mrkZone";
{
	if ([_markerPrefix, _x] call BIS_fnc_inString) then {
		_area = ((markerSize _x) select 0) * ((markerSize _x) select 1);
		totalMarkerArea = totalMarkerArea + _area;
		markerAreaArray set [_j, [_x, _area]];
		_j = _j + 1;
	};
} forEach allMapMarkers;

//Continuously check groups
[] spawn
{
	while {true} do
	{
		sleep 1;
		[] call fnc_handleGroupsServer;
	};
};

while {true} do
{
	//Start players in boxes, round not running
	roundInProgress=false;
	bLastPlayersCountdown = false;
	fakeExtraDefenderTime = 0;

	//Publish the variables values
	publicVariable "roundInProgress";
	publicVariable "bLastPlayersCountdown";
	publicVariable "fakeExtraDefenderTime";

	if (_changeAttackerSide) then
	{
		// Set the objective area
		_posFound = false;
		while {!_posFound} do
		{
			_randomAreaSelector = random totalMarkerArea;
			_i = 0;
			_totalCheckedArea = (markerAreaArray select _i) select 1;
			_zoneMarker = (markerAreaArray select _i) select 0;
			while {_totalCheckedArea < _randomAreaSelector} do
			{
				_i = _i + 1;
				_totalCheckedArea = _totalCheckedArea + ((markerAreaArray select _i) select 1);
				_zoneMarker = (markerAreaArray select _i) select 0;
			};

			_minX = (markerPos _zoneMarker select 0) - (markerSize _zoneMarker select 0);
			_maxX = (markerPos _zoneMarker select 0) + (markerSize _zoneMarker select 0);
			_minY = (markerPos _zoneMarker select 1) - (markerSize _zoneMarker select 1);
			_maxY = (markerPos _zoneMarker select 1) + (markerSize _zoneMarker select 1);

			objPos = [_minX + random (_maxX - _minX), _minY + random (_maxY - _minY)];

			_nearBuildings = nearestObjects [objPos, ["House_F"], 75, true] select {!(_x isKindOf "PowerLines_base_F" || _x isKindOf "PowerLines_Small_Base_F" || _x isKindOf "House_Small_F")};

			if
			(
				(!(surfaceIsWater objPos))
				&&
				(!(([objPos, (markerPos "respawn_west")] call fnc_airDistance) < (minDist + 50)))
				&&
				(!(([objPos, (markerPos "respawn_east")] call fnc_airDistance) < (minDist + 50)))
				&&
				count _nearBuildings > 2 && count _nearBuildings < 7
			) then
			{
				_posFound = true;
			};
		};

		// Publish the objective
		publicVariable "objPos";
		if (!isDedicated) then
		{
			[] call objPosHandlerClient;
		};
	};

	// Update objective markers
	[] call fnc_setupObjPos;

	if (currentSetupTime > 0 && !forceRoundStart) then
	{
		waitUntil
		{
			if (!([] call fnc_hasPlayers)) then
			{
				roundStartTime = time + currentSetupTime;
				//roundStart = false;
			};
			forceRoundStart || (time > roundStartTime) && ([] call fnc_hasPlayers)
		};
	}
	else
	{
		waitUntil {forceRoundStart || [] call fnc_hasPlayers};
	};

	// Don't start until admin un-paused the round start.
	waitUntil {!adminPaused || forceRoundStart};

	if (adminPaused && DefaultAdminPaused > 1) then
	{
		adminPaused = false;
		publicVariable "adminPaused";
	};

	canChangeObjPos = false;

	currentSetupTime = setupTime;

	// Clean up vehicles that somehow weren't cleaned at end of round
	[] call fnc_cleanUpVehicles;

	// Clean up dead bodies
	{
		if (!isNull _x) then
		{
			if (_x isKindOf "MAN") then
			{
				if (!isPlayer _x) then
				{
					deleteVehicle _x;
				}
				else
				{
					[_x] spawn fnc_DeleteOldBody;
				};
			};
		};
	} forEach allDead;

	// Clean up other objects near previous objective and spawns
	_toDelete = nearestObjects [markerPos "mrkObj1", _deleteTypes, deleteRadius];
	_toDelete = _toDelete + ((markerPos "mrkObj1") nearObjects ["Default", deleteRadius]); // fix for bug with detecting satchels
	_toDelete = _toDelete + nearestObjects [getPos westMenuFlag, _deleteTypes, 100];
	_toDelete = _toDelete + nearestObjects [getPos eastMenuFlag, _deleteTypes, 100];
	for "_i" from 0 to ((count _toDelete) - 1) do
	{
		deleteVehicle (_toDelete select _i);
	};

	bObjW = false;
	bObjE = false;


	// Create list of participating players
	_dUnitArr = [];
	_aUnitArr = [];
	_dUnitCount = 0;
	_aUnitCount = 0;


	{
		if ((isPlayer _x) && (alive _x)) then
		{
			if (side _x == attackerSide) then
			{
				_aUnitArr set [_aUnitCount, _x];
				_aUnitCount = _aUnitCount + 1;
			}
			else
			{
				_dUnitArr set [_dUnitCount, _x];
				_dUnitCount = _dUnitCount + 1;
			};
			_x setVariable ["ready", true, true];
			_x setVariable ["isPlaying", true, true];
		};
	} forEach allUnits;




	// special lastPlayersCountdown variable when less than 5 participating players
	ulastPlayersCountdown = 0;
	if (_dUnitcount + _aUnitCount <= 5) then {
		ulastPlayersCountdown = 300;
	} else {
		ulastPlayersCountdown = lastPlayersCountdown;
	};

	canChangeClass = false;
	publicVariable "canChangeClass";

	if (_changeAttackerSide) then
	{
		if (attackerSide == WEST) then
		{
			nextAttackerSide = EAST;
		}
		else
		{
			nextAttackerSide = WEST;
		};
		publicVariable "nextAttackerSide";
	};

	//Handle vehicle spawning and assignment
	vehArr = [];
	private _units = [];
	private _minGroupSize = [] call fnc_minGroupSize;
	private _unitsWithoutGroup = [] + _aUnitArr;
	private _groups = allGroups select {side _x == attackerSide};
	private _groupIndex = 0;
	private _maxGroupIndex = count _groups;
	private _moreGroupsToSpawn = true;
	private _shouldSpawnThisGroup = false;

	while {_moreGroupsToSpawn} do
	{
		if (_groupIndex < _maxGroupIndex) then
		{
			_group = _groups select _groupIndex;
			_groupIndex = _groupIndex + 1;
			_units = units _group;
			if (((side _group) isEqualTo attackerSide)/*  && ((count _units) >= _minGroupSize) */) then {
				_shouldSpawnThisGroup = true;
				_unitsWithoutGroup = _unitsWithoutGroup - _units;
				_slotCount = 0;
				switch (_group getVariable ["insertionType", 0]) do {
					// Jeep
					case 0:
					{
						_vehType = call _jeepType;
						_slotCount = ([_vehType, true] call BIS_fnc_crewCount) max 2;
					};
					// Boat
					case 1:
					{
						_vehType = "B_Boat_Transport_01_F";
						_slotCount = 5;
					};
					// Submarine
					case 2:
					{
						_vehType = "B_SDV_01_F";
						_slotCount = 4;
					};
					// Littlebird
					case 3:
					{
						_vehType = "B_Heli_Light_01_F";
						_slotCount = 6;
					};
				};
			};
		} else {
			_units = _unitsWithoutGroup;
			_moreGroupsToSpawn = false;
			_shouldSpawnThisGroup = (count _units > 0);

			_vehType = call _jeepType;
			_slotCount = ([_vehType, true] call BIS_fnc_crewCount) max 2;
		};

		if (_shouldSpawnThisGroup) then {
			// how many vehicles to spawn for this group
			_vehCount = ceil ((count _units) / (_slotCount));
			private _veh = objNull;
			private ["_pos", "_dir"];
			_pos = defaultInsertionPos;
			_roads = _pos nearRoads 300;
			if (count _roads > 0) then {
				_thisGroupRoad = _roads select (random((count _roads) - 1));
				(getRoadInfo _thisGroupRoad) params [
					"_mapType",
					"_width",
					"_isPedestrian",
					"_texture",
					"_textureEnd",
					"_material",
					"_begPos",
					"_endPos",
					"_isBridge"
				];
				
				_pos = getPosATL _thisGroupRoad;
				_dir = _begPos getDir _endPos;
			} else {
				_dir = (_pos getDir objPos);
			};

			if (_moreGroupsToSpawn) then {
				// if spawning a group, check if the leader has chosen a custom position
				_pos = _group getVariable ["insertionPos", defaultInsertionPos];
			};

			_vehicleIndex = count vehArr;

			for "_i" from 0 to (_vehCount - 1) do {
				_pos = _pos findEmptyPosition [5, 100, _vehType];
				if (count _pos isEqualTo 0) then {
					// failed, just check isFlatEmpty
					_pos = _pos isFlatEmpty [50,250,-1,-1,1,0,false];
				};
				// _pos = [_pos, 0, 250, 6, 0, 60, 0] call BIS_fnc_findSafePos;
				_spawnMode = "NONE";
				// If position is on water, spawn flying.
				if (surfaceIsWater _pos) then { _spawnMode = "FLY" };
				_veh = createVehicle [_vehType, _pos, [], 0, _spawnMode];
				_veh setDir _dir;

				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearItemCargoGlobal _veh;
				clearBackpackCargoGlobal _veh;
				vehArr set [count vehArr, _veh];

				// // _wantsToDrive = selectRandom (_units select {_x getVariable ["preferDriver", false]});
				// if (isNil "_wantsToDrive") then {
				// 	// currentVeh pushBack objNull;
				// 	{
				// 		// (owner _x) publicVariableClient "currentVeh";
				// 		[_x, _veh] remoteExecCall ["moveInAny", _x];
				// 	} forEach _units;
				// } else {
				// 	// currentVeh pushBack _wantsToDrive;
					
				// 	// (owner _wantsToDrive) publicVariableClient "currentVeh";
				// 	[_wantsToDrive, _vehcurrentVeh] remoteExecCall ["moveInDriver", _wantsToDrive];

				// 	sleep 0.1;

				// 	// (owner _x) publicVariableClient "currentVeh";
				// 	{
				// 		[_x, _veh] remoteExecCall ["moveInAny", _x];
				// 	} forEach (_units select {!(_x isEqualTo _wantsToDrive)});
				// };
			};



			

			_driverArray = [];
			_driverArrayCount = 0;
			_passengerArray = [];
			_passengerArrayCount = 0;
			{
				if (_x getVariable ["preferDriver", false]) then {
					_driverArray set [_driverArrayCount, _x];
					_driverArrayCount = _driverArrayCount + 1;
				} else {
					_passengerArray set [_passengerArrayCount, _x];
					_passengerArrayCount = _passengerArrayCount + 1;
				};
			} forEach _units;

			for "_i" from 0 to (_vehCount - 1 - _driverArrayCount) do {
				_driverArray set [_driverArrayCount, _passengerArray select _i];
				_driverArrayCount = _driverArrayCount + 1;
			};

			_passengerArray = _passengerArray - _driverArray;
			_passengerArrayCount = count _passengerArray;

			for "_i" from _vehCount to (_driverArrayCount - 1) do {
				_passengerArray set [_passengerArrayCount, _driverArray select _i];
				_passengerArrayCount = _passengerArrayCount + 1;
			};

			for "_i" from 0 to (_vehCount - 1) do {
				currentVeh = [vehArr select _vehicleIndex + _i, 0];
				(owner (_driverArray select _i)) publicVariableClient "currentVeh";
				if (!isDedicated) then {
					if (player == (_driverArray select _i)) then {
						//[currentVeh] call currentVehHandler;
					};
				};

				for "_j" from 0 to (_slotCount - 2) do {
					if (((_i * (_slotCount - 1)) + _j) < _passengerArrayCount) then {
						currentVeh set [1, _j + 1];
						(owner (_passengerArray select ((_i * (_slotCount - 1)) + _j))) publicVariableClient "currentVeh";
						if (!isDedicated) then {
							if (player == (_passengerArray select ((_i * (_slotCount - 1)) + _j))) then {
								[currentVeh] call currentVehHandler;
							};
						};
					};
				};
			};
		};
	};

	[] spawn {
		sleep 1;
		canChangeClass = true;
		publicVariable "canChangeClass";
	};

	// Tell clients to run generic vehicle initialization scripts
	publicVariable "vehArr";
	if (!isDedicated) then {
		//Make sure scripts run on host
		[] call vehArrHandler;
	} else {
		// Run invulnerability script on server too (already runs on host and clients from vehArrHandler)
		[] call fnc_vehicleAllowDamage;
	};

	sleep 1.5;

	roundEnd = 0;
	publicVariable "roundEnd";
	roundEndTime = time + timeLimit;
	updateTime = true;
	roundInProgress = true;
	publicVariable "roundInProgress";

	// If parameter was chosen, pause the next round start timer.
	if (DefaultAdminPaused > 1) then {
		adminPaused = true;
		publicVariable "adminPaused";
	};



	sleep 2;
	atkHasMat = _aUnitArr select {_x hasWeapon "rhs_weap_maaws"};
	defHasMat = _dUnitArr select {_x hasWeapon "launch_RPG32_green_F"};
	fnc_limitMATCount = {
		params ["_units", "_numberPer10Players", "_aOrD"];
		while {count _units > (count _units / (10/_numberPer10Players))} do {
			_removeMAT = selectRandom _units;
			_units deleteAt (_units find _removeMAT);
			switch (_aOrD) do {
				case "A": {
					{
						currentAClass = (selectRandom aClasses);
						[true] call fnc_respawn;
					} remoteExec ["call", _removeMAT];
				};
				case "D": {
					{
						currentDClass = (selectRandom dClasses);
						[true] call fnc_respawn;
					} remoteExec ["call", _removeMAT];
				};
			};
		};
	};
	// limit MAT on each side to maximum 2 per 10 players
	[defHasMat, 2, "D"] call fnc_limitMATCount;
	[atkHasMat, 2, "A"] call fnc_limitMATCount;

	sleep 2;


	waitUntil
	{
		if (trainingRound == 0) then {

			noPlayersLeft = {alive _x} count _dUnitArr == 0 || {alive _x} count _aUnitArr == 1 || {alive _x} count _aUnitArr <= 0.1 * _aUnitCount;
		} else {
			noPlayersLeft = {alive _x} count _dUnitArr == 0 && {alive _x} count _aUnitArr == 0;
		};

		// if all defenders die, or only 1 attacker left, or less than 10% of attackers left
		noPlayersLeft
		||
		(bObjW && attackerSide == WEST) || (bObjE && attackerSide == EAST)
		||
		time > roundEndTime
	};

	while {roundEnd == 0} do
	{
		if (time > roundEndTime) then
		{
			roundEnd=4;
			publicVariable "roundEnd";
		}
		else
		{
			if ((bObjW && attackerSide == WEST) || (bObjE && attackerSide == EAST)) then
			{
				roundEnd=3;
				publicVariable "roundEnd";
			}
			else
			{
				if ({alive _x} count _dUnitArr == 0) then
				{
					roundEnd=2;
					publicVariable "roundEnd";
				}
				else
				{
					if ({alive _x} count _aUnitArr == 0) then
					{
						roundEnd=1;
						publicVariable "roundEnd";
					}
					else
					{
						if ((time + ulastPlayersCountdown) < roundEndTime) then
						{
							fakeExtraDefenderTime = roundEndTime - time - ulastPlayersCountdown;
							publicVariable "fakeExtraDefenderTime";

							roundEndTime = time + ulastPlayersCountdown;
							bLastPlayersCountdown = true;
							publicVariable "bLastPlayersCountdown";
							updateTime = true;
						};
						waitUntil
						{
							if (trainingRound == 0) then {
								noPlayersLeft = {alive _x} count _dUnitArr == 0 || {alive _x} count _aUnitArr == 0;
							} else {
								noPlayersLeft = {alive _x} count _dUnitArr == 0 && {alive _x} count _aUnitArr == 0;
							};

							noPlayersLeft
							||
							((bObjW && attackerSide == WEST) || (bObjE && attackerSide == EAST))
							||
							time > roundEndTime
						};
					};
				};
			};
		};
	};

	if (((roundEnd == 2 || roundEnd == 3) && attackerSide == WEST) || ((roundEnd == 1 || roundEnd == 4) && attackerSide == EAST))then
	{
		scoreW = scoreW + 1;
		publicVariable "scoreW";
	}
	else
	{
		scoreE = scoreE + 1;
		publicVariable "scoreE";
	};

	sleep 1.5;

	// Clean up vehicles
	[] call fnc_cleanUpVehicles;

	// Empty base crates
	{
		_crate = _x;
		clearWeaponCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearItemCargoGlobal _crate;
	} forEach all_crates;

	_changeAttackerSide = !_changeAttackerSide;
	attackerSide = nextAttackerSide;
	publicVariable "attackerSide";
};
