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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans - Season 2</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://challonge.com/Titansv2NA/module'>NA Roster</a><br/><a href='https://challonge.com/Titansv2EU/module'>EU Roster</a><br/><br/></t><t size='1.3' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='1'>    * 2nd MRB has won their placement match against SOF and moves on to the Grand Final<br/>    * 2MRB will face Gluesniffers to fight for the title of FNF TITAN<br/></t><br/><br/><t size='0.8'>    On Saturday, July 24th at 3PM EDT / 7PM UTC / 9PM CEST, 2nd MRB and Gluesniffers will play in the Grand Final! This is a heated match between two incredible opponents, representing our NA and EU communities! Look forward to more details emerging soon!</t></t> "; //--- ToDo: Localize;
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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans - Season 2</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://challonge.com/Titansv2NA/module'>NA Roster</a><br/><a href='https://challonge.com/Titansv2EU/module'>EU Roster</a><br/><br/></t><t size='1.3' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='1'>    * 2nd MRB has won their placement match against SOF and moves on to the Grand Final<br/>    * 2MRB will face Gluesniffers to fight for the title of FNF TITAN<br/></t><br/><br/><t size='0.8'>    On Saturday, July 24th at 3PM EDT / 7PM UTC / 9PM CEST, 2nd MRB and Gluesniffers will play in the Grand Final! This is a heated match between two incredible opponents, representing our NA and EU communities! Look forward to more details emerging soon!</t></t> "; //--- ToDo: Localize;
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