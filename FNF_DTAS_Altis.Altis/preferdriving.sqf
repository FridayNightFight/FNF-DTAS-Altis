private ["_params", "_preference"];

_params = _this select 3;
_preference = _params select 0;

preferDriver = _preference;
player setVariable ["preferDriver", preferDriver, true];