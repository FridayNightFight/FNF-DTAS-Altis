private ["_TFRChannel", "_radio", "_activeSWRadio"];

_radio = "TFAR_anprc152";
if (sidePlayer == east) then
{
	_radio = "TFAR_fadak";
};
player linkItem _radio;

// Wait for the new radio with ID to be added.
waitUntil {call TFAR_fnc_haveSWRadio;};

// Wait for server to assign squad channel if it isn't assigned.
_TFRChannel = -1;
waitUntil
{
	_TFRChannel = (group player) getVariable ["TFRChannel", -1];
	_TFRChannel != -1
};

[_TFRChannel] spawn {
	private _TFRChannel = _this select 0;

	sleep 2;
	_activeSWRadio = call TFAR_fnc_activeSwRadio;
	// Set the short range channel to the squad channel.
	[_activeSWRadio, _TFRChannel - 1] call TFAR_fnc_setSwChannel;
	[_activeSWRadio, 1] call TFAR_fnc_setSwStereo;

	// Set the additional channel to command channel (8).
	if (commandChannelEnabled) then
	{
		[_activeSWRadio, 7] call TFAR_fnc_setAdditionalSwChannel;
		[_activeSWRadio, 2] call TFAR_fnc_setAdditionalSwStereo;
	};
};