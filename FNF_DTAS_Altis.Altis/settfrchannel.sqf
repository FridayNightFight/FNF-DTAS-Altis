private ["_params", "_channel"];

_params = _this select 3;
_channel = _params select 0;

if ([player] call fnc_isLeaderWithGroup) then
{
	(group player) setVariable ["TFRManualChannel", true, true];
	(group player) setVariable ["TFRChannel", _channel, true];
};

tfrChannelMenuClose = true;