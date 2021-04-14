private ["_allRoads", "_road", "_sqrDist", "_newSqrDist", "_pos", "_minSqrDist"];

_allRoads = [objPos select 0, objPos select 1] nearRoads 2500;
_truckOnRoad=false;
_tankOnRoad=false;

if (count _allRoads > 0) then
{

	_road = _allRoads select 0;
	_sqrDist = (2 * minDist) * (2 * minDist);
	_minSqrDist = minDist * minDist;
	
	{
		if ([getPos _x, objPos] call fnc_getSqrDist > _minSqrDist) then
		{
			_newSqrDist = [getPos _x, objPos] call fnc_getSqrDist;
			if (_newSqrDist < _sqrDist) then
			{
				_sqrDist = _newSqrDist;
				_road = _x;
			};
		};
	} forEach _allRoads;

	_pos = [(getPos _road) select 0, (getPos _road) select 1];
}
else
{
	_pos = [objPos, minDist, minDist * 1.25, 6, 0.5, 0, [], [markerPos "mrkDefaultPos", markerPos "mrkDefaultPos"]] call bis_fnc_findSafePos;
};

_pos