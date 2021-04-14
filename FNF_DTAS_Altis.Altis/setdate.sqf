nightWeapons = 1;
nightVision = nightVisionParam;
switch (nightOrDay) do
{
	case 0:
	{
		if (isServer) then
		{
			setDate [1985, 8, 30, 9, 0];
		};
		nightWeapons = 0;
		nightVision = -1;
	};
	case 1:
	{
		if (isServer) then
		{
			setDate [1985, 12, 13, 4, 40];
		};
	};
	case 2:
	{
		//setDate [1985, 7, 12, 2, 0];
	};
	case 3:
	{
		if (isServer) then
		{
			setDate [1985, 10, 8, 2, 0];
		};
	};
	case 4:
	{
		if (isServer) then
		{
			setDate [1985, 1, 1, 0, 0];
		};
	};
};