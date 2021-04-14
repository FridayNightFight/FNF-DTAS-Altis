if (!isDedicated) then
{
	winnerSidePVHandler =
	{
		if (dialog) then
		{
			closeDialog 0;
		};
		if (sidePlayer == winnerSide) then
		{
			["END1", sidePlayer == winnerSide, 1] spawn BIS_fnc_endMission;
		}
		else
		{
			["END2", sidePlayer == winnerSide, 1] spawn BIS_fnc_endMission;
		};
	};
	"winnerSide" addPublicVariableEventHandler winnerSidePVHandler;
	if (!(isNil "winnerSide")) then
	{
		[] call winnerSidePVHandler;
	};
};

if (isServer) then
{
	waitUntil {!(isNil "scoreW")};
	waitUntil {!(isNil "scoreE")};
	waitUntil {((scoreW >= maxScore) && (scoreW > (scoreE + 1))) || ((scoreE >= maxScore) && (scoreE > (scoreW + 1)))};
	if (scoreW > scoreE) then
	{
		winnerSide = West;
	}
	else
	{
		winnerSide = East;
	};
	publicVariable "winnerSide";
	if (dialog) then
	{
		closeDialog 0;
	};
	sleep 5;
	if (!isDedicated) then
	{
		[] call winnerSidePVHandler;
	}
	else
	{
		endMission "END1";
	};
};