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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans - Season 2</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://challonge.com/Titansv2NA/module'>NA Roster</a><br/><a href='https://challonge.com/Titansv2EU/module'>EU Roster</a><br/><br/></t><t size='1.3' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='1'>    * Tomorrow July 3rd is the semifinal match between 2MRB and SOF<br/>    * The winner will go on to face Gluesniffers in the Grand Final<br/></t><br/><br/><t size='0.8'>    Geeeeeet ready for the finaaaaaals! Tomorrow, on July 3rd at 3PM EDT / 7PM UTC / 8PM BST, 2nd MRB and SOF will have their last matches of the series. The winner of that game will go on to play in the Grand Final against Gluesniffers to fight for the title FNF Titan!</t></t> "; //--- ToDo: Localize;
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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans - Season 2</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://challonge.com/Titansv2NA/module'>NA Roster</a><br/><a href='https://challonge.com/Titansv2EU/module'>EU Roster</a><br/><br/></t><t size='1.3' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='1'>    * Tomorrow July 3rd is the semifinal match between 2MRB and SOF<br/>    * The winner will go on to face Gluesniffers in the Grand Final<br/></t><br/><br/><t size='0.8'>    Geeeeeet ready for the finaaaaaals! Tomorrow, on July 3rd at 3PM EDT / 7PM UTC / 8PM BST, 2nd MRB and SOF will have their last matches of the series. The winner of that game will go on to play in the Grand Final against Gluesniffers to fight for the title FNF Titan!</t></t> "; //--- ToDo: Localize;
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