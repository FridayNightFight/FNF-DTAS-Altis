private ["_missionText", "_ui", "_timeText", "_isCapturing", "_cap"];

_timeText = _this select 0;

_isCapturing = [player] call fnc_isCapturing;

disableSerialization;

_ui = uiNamespace getVariable "DTASHUD";

(_ui displayCtrl 1001) ctrlSetText _timeText;
if (!isSpectating) then
{
	_cap = round (capPercentage * 100);
	if (_cap > 100) then
	{
		_cap = 100;
	};
	_missionText = format [localize "STR_Attacking", _cap, "%"];
	if (_isCapturing) then
	{
		_missionText = format [localize "STR_Capturing", _cap, "%"];
	};
	if (sidePlayer != attackerSide) then
	{
		_missionText = localize "STR_Defending";
		if (_isCapturing) then
		{
			_missionText = localize "STR_Holding";
		};
	};
	if (!roundInProgress) then
	{
		_missionText = localize "STR_Planning";
	};
	if (roundInProgress && (!isPlaying)) then
	{
		_missionText = localize "STR_Waiting";
	};
};
if (!isNil "_missionText") then 
{ 
	(_ui displayCtrl 1002) ctrlSetText _missionText;
};
(_ui displayCtrl 1101) ctrlSetText str scoreW;
(_ui displayCtrl 1102) ctrlSetText str scoreE;