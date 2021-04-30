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
			text = "<t valign='middle' font='TahomaB'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>FNF Titans - Season 2</t><br/><t align='center'>A 7v7 Team vs Team Tournament!<br/><a href='https://discord.com/channels/106475368495484928/812707811141484564/837040970020421712'>Tournament Roster</a><br/><br/></t><t size='1.5' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/>    * Signups are now closed<br/>    * Events will run every Saturday<br/>    * EU will fight May 8th, May 22nd, and June 5th at 3PM EDT / 7PM UTC<br/>    * NA will fight May 15th, May 29th, and June 12th at 6PM EDT / 10PM UTC<br/><br/>With 10 teams for EU and 5 teams for NA, we have a solid tournament lined up! Remember that the first match of the series starts on May 8th at 3PM EDT / 7PM UTC and will be streamed by FNF Staff. Hope to see you there!</t> "; //--- ToDo: Localize;
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
			text = "<t valign='middle' font='TahomaB'><t font='PuristaBold' size='2.0' align='center' color='#FF0000'>Tuesday Night Tanks</t><br/><t align='center'>Two tank companies slug it out in three 1-life rounds in explosive battles!<br/><a href='https://discord.com/channels/106475368495484928/823585368598380544/834452658998870076'>Original Discord Announcement</a><br/><br/></t><t size='1.5' color='#4CFF00' font='PuristaBold'>What you need to know:</t><br/><br/>    * RSVPs close Sunday, May 2nd at 5PM EST / 9PM UTC<br/>    * TNT will be held on Tuesday, May 4th at 5PM EST / 9PM UTC<br/><br/>The event will feature three one life rounds where two tank companies face off against one another in explosive battles. Supporting the tank companies will be a light armored reconnaissance section, a ground reconnaissance team, and a logistical section.<br/><br/>There have been several changes since the first event, the LAR section and ground recon team will be a little more potent this time around. New assets will be featured as well while we continue to refine the heavy armor event.</t> "; //--- ToDo: Localize;
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