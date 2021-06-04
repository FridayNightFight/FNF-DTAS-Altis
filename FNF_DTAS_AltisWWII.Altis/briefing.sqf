private ["_strSide", "_strSpectGear"];

waitUntil {!isNull player};

player createDiaryRecord ["Diary", [localize "STR_Credits", format ["%1<br/><br/>%2<br/><br/>%3<br/><br/><img image='images\dtaslogo.jpg' width='350' height='175'/>", localize "STR_Credits1", localize "STR_Credits2", localize "STR_Credits3"]]];

player createDiaryRecord ["Diary", [localize "STR_Spectating", format ["%1<br/><br/>%2<br/><br/>%3<br/><br/>%4", localize "STR_Spectating1", localize "STR_Spectating2", localize "STR_Spectating3", localize "STR_Spectating4"]]];

player createDiaryRecord ["Diary", [localize "STR_Equipment", format ["%1<br/><br/>%2", localize "STR_Equipment1", localize "STR_Equipment2"]]];

player createDiaryRecord ["Diary", [localize "STR_LastPlayersCountdown", format [localize "STR_LastPlayersCountdown1", lastPlayersCountdown]]];

player createDiaryRecord ["Diary", [localize "STR_RoundSystem", format [localize "STR_RoundSystem1", timelimit/60]]];

player createDiaryRecord ["Diary", [localize "STR_Squads", format ["%1<br/><br/>%2<br/><br/>%3", localize "STR_Squads1", localize "STR_Squads2", localize "STR_Squads3"]]];

player createDiaryRecord ["Diary", [localize "STR_CaptureSystem", localize "STR_CaptureSystem1"]];

player createDiaryRecord ["Diary", [localize "STR_Insertion", format ["%1<br/><br/>%2<br/><br/>%3<br/><br/>%4", format [localize "STR_Insertion1", minDist], localize "STR_Insertion2", format [localize "STR_Insertion3", setupTime], localize "STR_Insertion4"]]];

player createDiaryRecord ["Diary", [localize "STR_Mission", format [format ["%1 <marker name='mrkObj'>%2</marker> %3", localize "STR_Mission1", localize "STR_Mission2", localize "STR_Mission3"], timeLimit/60, maxScore, 2*maxScore-1]]]