class RscAdDisplay1
{
	idd = 1514;
	class Controls
	{
		class adFrame: RscFrame
		{
			idc = 1800;
			x = 0.295812 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.408375 * safezoneW;
			h = 0.55 * safezoneH;
			colorText[] = {0,0,0,0.7};
			colorBackground[] = {0,0,0,0.85};
		};
		class textBox: RscStructuredText
		{
			idc = 1100;
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans - Season 2</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://challonge.com/Titansv2NA/module'>NA Roster</a><br/><a href='https://challonge.com/Titansv2EU/module'>EU Roster</a><br/><br/></t><t size='1.5' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='0.8'>    * Events will run every Saturday<br/>    * NA's remaining matches take place May 29th and June 12th at 6PM EDT / 10PM UTC<br/>    * EU will fight tomorrow (May 22nd), June 5th, and June 19th at 3PM EDT / 7PM UTC<br/><br/>    With 10 teams for EU and 5 teams for NA, we have a solid tournament underway! All events will be streamed. Check out our <a href='https://discord.gg/QkaFhHjUeu'>#fnf-media</a> channel at event time. Hope to see you there!</t></t> "; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.396 * safezoneW;
			h = 0.473 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.85};
			sizeEx = 0.9 * GUI_GRID_H;
		};
		class buttonClose: RscButton
		{
			idc = 1600;
			text = "Close"; //--- ToDo: Localize;
			x = 0.462875 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.07425 * safezoneW;
			h = 0.044 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.85};
			size = 0.9 * GUI_GRID_H;
			action = "closeDialog 1;";
		};
	};
};

class RscAdDisplay2
{
	idd = 1514;
	class Controls
	{
		class adFrame: RscFrame
		{
			idc = 1800;
			x = 0.295812 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.408375 * safezoneW;
			h = 0.55 * safezoneH;
			colorText[] = {0,0,0,0.7};
			colorBackground[] = {0,0,0,0.85};
		};
		class textBox: RscStructuredText
		{
			idc = 1100;
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF WWII</t><br/><t align='center'>World War II Month is almost upon us!<br/><br/></t><t size='1.5' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='0.8'>    * First WWII event will take place on Friday, June 4th in place of the normal event<br/>    * Start Times for each segment will not change<br/>    * A new modset (Steam Collection) will be posted at least a few days prior<br/>    * The ORBAT will accurately reflect company compositions of each respective nation from that era<br/><br/>    The wait is almost over! Our annual WWII theme month will begin in two weeks, on June 4th. During June, FNF events will be themed for WWII and use the WWII modset. Missions will be predominantly created by Staff with limited selections contributed by our community Mission Makers. Expect to see combined arms, limited-radio, era-accurate gameplay!</t></t> "; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.396 * safezoneW;
			h = 0.473 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.85};
			sizeEx = 0.9 * GUI_GRID_H;
		};
		class buttonClose: RscButton
		{
			idc = 1600;
			text = "Close"; //--- ToDo: Localize;
			x = 0.462875 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.07425 * safezoneW;
			h = 0.044 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.85};
			size = 0.9 * GUI_GRID_H;
			action = "closeDialog 1;";
		};
	};
};