private ["_i", "_maxi", "_markerCharArray", "_markerPrefixCharArray", "_equal", "_currentMarker"];

_markerPrefixCharArray = toArray "mrkZone";
_maxi = count _markerPrefixCharArray;
{
	_markerCharArray = toArray _x;
	_equal = (count _markerCharArray) >= _maxi;
	_i = 0;
	while {_equal && _i < _maxi} do
	{
		if ((_markerCharArray select _i) != (_markerPrefixCharArray select _i)) then
		{
			_equal = false;
		};
		_i = _i + 1;
	};
	if (_equal) then
	{
		_x setMarkerAlpha 0;
	};
} forEach allMapMarkers;

// Workaround for bug 24051
[] execVM "preinit2.sqf";