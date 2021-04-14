#define CT_STATIC         0
#define ST_LEFT           0x00
#define ST_CENTER         0x02

	class DTASHUD
	{
      	idd = 1000;
     	movingEnable=0;
      	duration=1e+011;
      	name = "DTASHUD_name";
      	onLoad = "uiNamespace setVariable ['DTASHUD', _this select 0];";
		onUnLoad = "uiNamespace setVariable ['DTASHUD', nil]";
      	controlsBackground[] = {};
      	objects[] = {};
      	class controls
		{
			class TimerDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1001;
				text = "";
				x = 0.4625 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.075 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {0.05,0.05,0.05,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};
			
			class MissionDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1002;
				text = "";
				x = 0.55 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.1 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {0.05,0.05,0.05,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};
			
			class ScoreWDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1101;
				text = "";
				x = 0.679 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {0,0,1,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};

			class ScoreEDisplay
			{
				type = CT_STATIC;
				style = ST_CENTER;
				idc = 1102;
				text = "";
				x = 0.71 * safezoneW + safezoneX;
				y = 0.02 * safezoneH + safezoneY;
				w = 0.03 * safezoneW;
				h = 0.04 * safezoneH;
				font = "PuristaMedium";
				colorBackground[] = {1,0,0,0.3};
				colorText[] = {1,1,1,1};
				sizeEx = 0.05;
			};

		};
	};

