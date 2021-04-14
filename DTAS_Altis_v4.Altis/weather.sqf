private ["_rain", "_date"];

0 setFog (fogParam / 10);
0 setOvercast (overcastParam / 10);
//_rain = (rainParam / 10);
//0 setRain _rain;

sleep 5;
skipTime 1;
sleep 5;
_date = date;
_date set [3, (_date select 3) - 1];
setDate _date;

while {true} do
{
	//0 setRain _rain;
	0 setFog (fogParam / 10);
	0 setOvercast (overcastParam / 10);
	sleep 1;
};