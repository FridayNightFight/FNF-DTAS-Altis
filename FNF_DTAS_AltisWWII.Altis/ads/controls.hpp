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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans - Season 2</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://challonge.com/Titansv2NA/module'>NA Roster</a><br/><a href='https://challonge.com/Titansv2EU/module'>EU Roster</a><br/><br/></t><t size='1.3' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='1'>    * Events will run every Saturday<br/>    * NA's final match is tomorrow, June 12th at 6PM EDT / 10PM UTC<br/>    * EU's final match is June 19th at 3PM EDT / 7PM UTC</t><br/><br/><t size='0.8'>    Titans V2 - NA is heading into the play-offs! The top 4 teams consist of Pepega Pirates, 2nd MRB, AA/CSC, and Centaur. Kicking off with PP vs. Centaur and 2nd vs. AA/CSC for a spot in the final and a chance to win the NA segment. A 3rd.-4th. placement match will be played as well. The two teams making it into the finals will fight against the 2 best teams from the EU segment.</t></t> "; //--- ToDo: Localize;
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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF WWII</t><br/><t align='center'>World War II Month has arrived!<br/><br/></t><t size='1.5' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='0.8'>    * First WWII event will take place on Friday, June 4th in place of the normal event<br/>    * Start Times for each segment will not change<br/>    * A new modset (Steam Collection) is present in our #servers-and-mods channel<br/>    * The ORBAT will accurately reflect company compositions of each respective nation from that era<br/><br/>    It's HERE! If you're reading this, you have your mods sorted and should be good to play for our first WWII event today. Enjoy trying out some of the weaponry you'll see at today's event!</t></t> "; //--- ToDo: Localize;
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