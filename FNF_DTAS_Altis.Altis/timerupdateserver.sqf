private ["_nextUpdateTime"];

if (!isDedicated) then
{
	waitUntil {!(isNil "timeleftpvhandler")};
};

waitUntil {!isNil "roundStartTime"};

while {true} do
{
	_nextUpdateTime = time + 10;
	
	waitUntil {updateTime || time > _nextUpdateTime};
	
	updateTime = false;
	
	if (roundInProgress) then
	{
		timeLeft = roundEndTime - time;
	}
	else
	{
		timeLeft = roundStartTime - time;
	};
	publicVariable "timeLeft";
	if (!isDedicated) then
	{
		[timeLeft] call timeLeftPVHandler;
	};
};