private ["_obj", "_params", "_channelUsers", "_radioActions", "_channel", "_channelIndex", "_i", "_actionString", "_usersString", "_action", "_cancelAction"];

_params = _this select 3;
_obj = _params select 0;

choosingTFRChannel = true;
tfrChannelMenuClose = false;

_radioActions = [];

_channelUsers = [localize "STR_Public", "", "", "", "", "", "", localize "STR_Command"];

{
	_group = _x;
	if (side _group == sidePlayer) then
	{
		if ((count (units _group)) >= ([] call fnc_minGroupSize)) then
		{
			_channel = _group getVariable ["TFRChannel", 1];
			if ((_channel != 1) || (_group getVariable ["TFRManualChannel", false])) then
			{
				_channelIndex = _channel - 1;
				
				_usersString = _channelUsers select _channelIndex;
				if (_usersString != "") then
				{
					_usersString = _usersString + ", ";
				};
				_usersString = _usersString + ([(name (leader _group))] call fnc_cleanName);
								
				_channelUsers set [_channelIndex, _usersString];
			};
		};
	};
} forEach allGroups;

for "_i" from 1 to 8 do
{
	_usersString = _channelUsers select (_i - 1);
	_actionString = format [localize "STR_TFRChannel", _i];
	if (_usersString != "") then
	{
		_actionString = format [localize "STR_TFRChannelUsers", _i, _usersString];
	};

	_action = _obj addAction [format ["<t color='#AAB43A'>%1</t>", _actionString], "settfrchannel.sqf", [_i], 4, false, true, "", "true"];
	_radioActions set [_i - 1, _action];
};

_cancelAction = _obj addAction [format ["<t color='#AAB43A'>%1</t>", localize "STR_CancelTFRChannelMenu"], "canceltfrchannelmenu.sqf", [], 4, false, true, "", "true"];

waitUntil {tfrChannelMenuClose || (!([player] call fnc_isLeaderWithGroup))};
{
	_obj removeAction _x;
} forEach _radioActions;

_obj removeAction _cancelAction;

choosingTFRChannel = false;