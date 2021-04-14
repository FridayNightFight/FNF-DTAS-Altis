private ["_ui", "_timer", "_mission", "_scoreW", "_scoreE"];

disableSerialization;
cutRsc ["DTASHUD","PLAIN"];
_ui = uiNamespace getVariable "DTASHUD";

_timer = _ui displayCtrl 1001;
_mission = _ui displayCtrl 1002;
_scoreW = _ui displayCtrl 1101;
_scoreE = _ui displayCtrl 1102;

{_x ctrlShow true} foreach [_timer, _mission, _scoreW, _scoreE];

_mission ctrlSetBackgroundColor [if (sidePlayer == WEST) then {0} else {1}, 0, if (sidePlayer == WEST) then {1} else {0}, 0.3];