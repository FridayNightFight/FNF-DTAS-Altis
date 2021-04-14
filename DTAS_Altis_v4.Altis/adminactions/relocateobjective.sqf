["DTASChooseAPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
"mrkAZone" setMarkerAlphaLocal 0;
["DTASChooseObjPos", "onMapSingleClick", {[_pos] call adminObjPosClickHandler}, []] call BIS_fnc_addStackedEventHandler;
hint localize "STR_ClickMapToPlaceObjective";