while {true} do
{
	waitUntil {[player] call fnc_isCapturing};
	if (roundInProgress) then
	{
		if (attackerSide == sidePlayer) then
		{
			hint localize "STR_CapMsg";
		}
		else
		{
			hint localize "STR_DefendMsg";
		};
	};
	waitUntil {!([player] call fnc_isCapturing)};
	if (roundInProgress) then
	{
		if (attackerSide == sidePlayer) then
		{
			hint localize "STR_StopCapMsg";
		}
		else
		{
			hint localize "STR_StopDefendMsg";
		};
	};
};