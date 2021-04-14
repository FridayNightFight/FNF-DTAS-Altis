private ["_params", "_actualMinDist"];

_params = _this select 3;
requestedInsertionType = _params select 0;

if (sidePlayer == attackerSide) then
{
	["DTASChooseObjPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	["DTASChooseAPos", "onMapSingleClick", {[_pos] call aPosHandler}, []] call BIS_fnc_addStackedEventHandler;
	hint (format [localize "STR_ClickMapForInsertion", localize (format ["STR_%1", requestedInsertionType])]);
	"mrkAZone" setMarkerPosLocal objPos;
	_actualMinDist = minDist * (minDistFactors select requestedInsertionType);
	"mrkAZone" setMarkerSizeLocal [_actualMinDist, _actualMinDist];
	"mrkAZone" setMarkerAlphaLocal 1;
};