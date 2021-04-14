private ["_strASide", "_strDSide", "_str1", "_str2", "_bYouWin", "_notification"];

_strASide="Red";
_strDSide="Blue";
if (lastAttackerSide==WEST) then
{
	_strASide="Blue";
	_strDSide="Red";
};

switch (roundEnd) do
{
	case 1:
	{
		if (sidePlayer != lastAttackerSide) then
		{
			_bYouWin = true;
			_str2 = localize "STR_EnemyTeamHasBeenEliminated";
			_notification = "DTASNotificationEnemyTeamDead";
		}
		else
		{
			_bYouWin = false;
			_str2 = localize "STR_YourTeamHasBeenEliminated";
			_notification = "DTASNotificationYourTeamDead";
		};
	};
	
	case 2:
	{
		if (sidePlayer == lastAttackerSide) then
		{
			_bYouWin = true;
			_str2 = localize "STR_EnemyTeamHasBeenEliminated";
			_notification = "DTASNotificationEnemyTeamDead";
		}
		else
		{
			_bYouWin = false;
			_str2 = localize "STR_YourTeamHasBeenEliminated";
			_notification = "DTASNotificationYourTeamDead";
		};
	};

	case 3:
	{
		if (sidePlayer == lastAttackerSide) then
		{
			_bYouWin = true;
			_str2 = localize "STR_YourTeamCapturedTheZone";
			_notification = "DTASNotificationCaptureWin";
		}
		else
		{
			_bYouWin = false;
			_str2 = localize "STR_EnemyTeamCapturedTheZone";
			_notification = "DTASNotificationCaptureLose";
		};
	};
	
	case 4:
	{
		if (sidePlayer != lastAttackerSide) then
		{
			_bYouWin = true;
			_str2 = localize "STR_EnemyTeamRanOutOfTime";
			_notification = "DTASNotificationTimeOutWin";
		}
		else
		{
			_bYouWin = false;
			_str2 = localize "STR_YourTeamRanOutOfTime";
			_notification = "DTASNotificationTimeOutLose";
		};
	};
};

if (_bYouWin) then
{
	_str1 = localize "STR_YourTeamWon";
	//_notification = "DTASNotificationSuccess";
}
else
{
	_str1 = localize "STR_YourTeamLost";
	//_notification = "DTASNotificationFail";
};

[_notification, [_str1, _str2]] spawn BIS_fnc_showNotification;