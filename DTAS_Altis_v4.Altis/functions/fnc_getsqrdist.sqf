private ["_pos1", "_pos2", "_dx", "_dy"];
_pos1 = _this select 0;
_pos2 = _this select 1;
_dx = (_pos1 select 0) - (_pos2 select 0);
_dy = (_pos1 select 1) - (_pos2 select 1);

_dx * _dx + _dy * _dy;