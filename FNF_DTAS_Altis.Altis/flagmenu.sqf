//Adds all the scrollmenu stuff to the yellow crate/cement thing

private ["_obj"];

waitUntil {!isNil "preInitDone"};

_obj = _this select 0;
_obj allowDamage false;
_obj enableSimulation false;

//Code that executes when someone clicks the map to mark insertion point
aPosHandler =
{
	private ["_pos"];
	_pos = _this select 0;
	if (([_pos, objPos] call fnc_airDistance) < minDist * (minDistFactors select requestedInsertionType)) then
	{
		hint (localize "STR_InvalidPosition");
	}
	else
	{
		if (((surfaceIsWater _pos)) && requestedInsertionType == 0) then
		{
			hint localize "STR_InvalidPositionWater";
		}
		else
		{
			if ((!(surfaceIsWater _pos)) && (requestedInsertionType == 1 || requestedInsertionType == 2)) then
			{
				hint localize "STR_InvalidPositionLand";
			}
			else
			{
				if (((surfaceIsWater _pos)) && requestedInsertionType == 3) then
				{
					hint localize "STR_InvalidPositionHeloBug";
				}
				else
				{
					(group player) setVariable ["insertionType", requestedInsertionType, true];
					(group player) setVariable ["insertionPos", _pos, true];
					(group player) setVariable ["insertionPosPicked", true, true];
					["DTASChooseAPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
					"mrkAZone" setMarkerAlphaLocal 0;
		
					hint format ["%1 %2", localize "STR_InsertionPositionUpdated", format [localize "STR_InsertingWith", localize format ["STR_InsertionVehicle%1s", requestedInsertionType]]];
				};
			};
		};
	};
	
	false
};

if (isServer) then
{
	waitUntil {!isNil "adminObjPosHandler"};
};

//Code that executes when an admin sets the objective position
adminObjPosClickHandler =
{
	private ["_pos"];
	_pos = _this select 0;
	if (surfaceIsWater _pos) then
	{
		hint localize "STR_CannotPlaceObjectiveOnWater";
	}
	else
	{
		adminObjPos = _pos;
		publicVariable "adminObjPos";
		if (isServer) then
		{
			[] call adminObjPosHandler;
		};
		["DTASChooseObjPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	};
};

//Insertion types
{
	_obj addAction [format ["<t color='#ffe400'>%1</t>", (_x select 0)], "pickspawnaction.sqf", [_x select 1], (_x select 2), false, true, "", "canChangeClass && (!roundInProgress) && (attackerSide == sidePlayer) && ([player] call fnc_isLeaderWithGroup)"];
} forEach [[localize "STR_JeepInsertion", 0, 14]/*, [localize "STR_BoatInsertion", 1, 13], [localize "STR_SubmarineInsertion", 2, 12],[localize "STR_LittlebirdInsertion", 3, 11]*/];

// _obj addAction [format ["<t color='#32cd32'>%1</t>", localize "STR_Ready"], "readyaction.sqf", [], 5, false, true, "", "(!roundInProgress) && (!((group player) getVariable ['groupReady', false])) && ([player] call fnc_isLeaderWithGroup)"];

//Launch spectator
_obj addAction ["Spectate", "[] call fnc_nextSpectateUnit", [], 0, false, false, ""];

//TFAR Channels
// choosingTFRChannel = false;
// _obj addAction [format ["<t color='#AAB43A'>%1</t>", localize "STR_ChooseTFRChannel"], "choosetfrchannelmenu.sqf", [_obj], 2, false, true, "", "(!choosingTFRChannel)"];
// _obj addAction [format ["<t color='#AAB43A'>%1</t>", localize "STR_EnableCommandChannel"], "enablecommandchannel.sqf", [true], 1, false, true, "", "!commandChannelEnabled"];
// _obj addAction [format ["<t color='#AAB43A'>%1</t>", localize "STR_DisableCommandChannel"], "enablecommandchannel.sqf", [false], 1, false, true, "", "commandChannelEnabled"];

//Driving
_obj addAction [format ["<t color='#a0a0a0'>%1</t>", localize "STR_PreferDriving"], "preferdriving.sqf", [true], 3, false, true, "", "!preferDriver"];
_obj addAction [format ["<t color='#c0c0c0'>%1</t>", localize "STR_PreferNotDriving"], "preferdriving.sqf", [false], 3, false, true, "", "preferDriver"];
	
//Admin shit
_obj addAction [format ["<t color='#CA2E2E'>%1</t>", localize "STR_ForceRoundStart"], "adminactions\forceroundstart.sqf", [], 0, false, false, "", "([] call fnc_isAdmin) && !roundInProgress"];
_obj addAction [format ["<t color='#CA2E2E'>%1</t>", localize "STR_PauseRoundStart"], "adminactions\pauseroundstart.sqf", [], 0, false, false, "", "([] call fnc_isAdmin) && !adminPaused"];
_obj addAction [format ["<t color='#CA2E2E'>%1</t>", localize "STR_UnpauseRoundStart"], "adminactions\unpauseroundstart.sqf", [], 0, false, false, "", "([] call fnc_isAdmin) && adminPaused"];
_obj addAction [format ["<t color='#CA2E2E'>%1</t>", localize "STR_ReLocateObjectivePosition"], "adminactions\relocateobjective.sqf", [], 0, false, false, "", "([] call fnc_isAdmin) && !roundInProgress"];