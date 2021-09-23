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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans v3</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://docs.google.com/document/d/1Qv9ZGX7iJXYVVZjdqNLkwYdBT6Hvv70UfoDD55tfyEE/'>Info Doc</a><br/><br/></t><t size='1.3' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='1'>    * Brand new framework tailored to Titans gameplay<br/>    * Group stage followed by a single-elimination tournament<br/>    * Game mode will be a mix of team deathmatch and connection</t><br/><br/><t size='0.8'>    Major changes and updates has been made to the framework and the teams can now look forward to auto respawns, switching of sides, in-game point system and much more. We wish to invite up to 2x12 teams to fight in for the EU and NA segmen. Titans V3 will be held as a group stage (2 groups of 6) followed by a single-elimination bracket Tournament with the best 4 teams from each group for both segments. Further details can be found at the Info Doc link at the top of this page.</t></t> "; //--- ToDo: Localize;
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
			text = "<t font='PuristaMedium'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans v3</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://docs.google.com/document/d/1Qv9ZGX7iJXYVVZjdqNLkwYdBT6Hvv70UfoDD55tfyEE/'>Info Doc</a><br/><br/></t><t size='1.3' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/><t size='1'>    * Brand new framework tailored to Titans gameplay<br/>    * Group stage followed by a single-elimination tournament<br/>    * Game mode will be a mix of team deathmatch and connection</t><br/><br/><t size='0.8'>    Major changes and updates has been made to the framework and the teams can now look forward to auto respawns, switching of sides, in-game point system and much more. We wish to invite up to 2x12 teams to fight in for the EU and NA segmen. Titans V3 will be held as a group stage (2 groups of 6) followed by a single-elimination bracket Tournament with the best 4 teams from each group for both segments. Further details can be found at the Info Doc link at the top of this page.</t></t> "; //--- ToDo: Localize;
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