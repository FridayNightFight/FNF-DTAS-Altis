private ["_mhq", "_openers", "_closers", "_openersCount", "_skipChars", "_sideColor", "_groupColor", "_cmdColor", "_playerColor", "_infMarkers", "_textMarkers", "_currentMarker", "_insertionMarkers", "_currentUnit", "_i", "_group", "_currentInsertionMarker", "_leader", "_pos", "_dir", "_inTransportCargo", "_nameStartIndex", "_i", "_j"];

if (isDedicated) exitWith {};
waitUntil {!(isNull player)};
waitUntil {!(isNil "attackerSide")};
waitUntil {!(isNil "nextAttackerSide")};

_openers = toArray "[({<";
_closers = toArray "])}>";
_openersCount = count _openers;
_skipChars = toArray "`~!@#$%^&*()-_=+;:,./?()[]{} 1234567890";

// Minimum damage to show as faded
_injuredDamage = 0.1;

// Define color for each role
_sideColor="ColorBlue";
_groupColor="ColorGreen";
_cmdColor="ColorOrange";
_playerColor="ColorRed";

// Create enough markers for max possible player count
_infMarkers = [];
_textMarkers = [];
_insertionMarkers = [];
for "_i" from 0 to 62 do
{
	_currentMarker = createMarkerLocal [format ["mrki%1", _i], [1, 1]];
	_currentMarker setMarkerShapeLocal "ICON";
	_currentMarker setMarkerTypeLocal "mil_triangle";
	_currentMarker setMarkerSizeLocal [0.5,1];
	_infMarkers set [_i, _currentMarker];
	
	_currentMarker = createMarkerLocal [format ["mrki%1text", _i], [1, 1]];
	_currentMarker setMarkerShapeLocal "ICON";
	_currentMarker setMarkerTypeLocal "mil_triangle";
	_currentMarker setMarkerSizeLocal [0.6,0];
	_textMarkers set [_i, _currentMarker];
	
	_currentMarker = createMarkerLocal [format ["mrkInsertion%1", _i], [1, 1]];
	_currentMarker setMarkerShapeLocal "ICON";
	_currentMarker setMarkerTypeLocal "mil_start";
	_currentMarker setMarkerColorLocal "COLORGREEN";
	_currentMarker setMarkerSizeLocal [1.1,1.1];
	_insertionMarkers set [_i, _currentMarker];
};

while {true} do
{
	_i = 0;
	{
		_currentUnit = _x;
		_leader = leader _currentUnit;
		if ((_currentUnit isKindOf "Man") && ((side _currentUnit) == sidePlayer)) then
		{
			_currentMarker = _infMarkers select _i;
			_currentTextMarker = _textMarkers select _i;
			
			if (_currentUnit == _leader) then
			{
				(group _currentUnit) setGroupID [name _currentUnit];
				if ((leader (group _currentUnit)) != _currentUnit) then
				{
					(group _currentUnit) selectLeader _currentUnit;
				};
			};
			
			if ((group _currentUnit) == (group player)) then
			{
				if (_currentUnit == _leader) then
				{
					_currentMarker setMarkerColorLocal _cmdColor;
					_currentTextMarker setMarkerColorLocal _cmdColor;
					
					if ((!isJoining) && (player == _leader)) then
					{
						isGroupLeader = true;
					};
				}
				else
				{
					if (_currentUnit == player) then
					{
						_currentMarker setMarkerColorLocal _playerColor;
						_currentTextMarker setMarkerColorLocal _playerColor;
					}
					else
					{
						_currentMarker setMarkerColorLocal _groupColor;
						_currentTextMarker setMarkerColorLocal _groupColor;
					};
				};
			}
			else
			{
				_currentMarker setMarkerColorLocal _sideColor;
				_currentTextMarker setMarkerColorLocal _sideColor;
			};
		
			if ((alive _currentUnit) && (isPlayer _currentUnit)) then
			{
				_inTransportCargo = false;
				if ((vehicle _currentUnit) != _currentUnit) then
				{
					if (_currentUnit != (driver vehicle _currentUnit)) then
					{
						_currentMarker setMarkerAlphaLocal 0.3;
						_currentTextMarker setMarkerAlphaLocal 0.3;
						_inTransportCargo = true;
					};
				};
				if (!_inTransportCargo) then
				{
					if (getDammage _currentUnit > _injuredDamage) then
					{
						_currentMarker setMarkerAlphaLocal 0.6;
						_currentTextMarker setMarkerAlphaLocal 0.6;
					}
					else
					{
						_currentMarker setMarkerAlphaLocal 1;
						_currentTextMarker setMarkerAlphaLocal 1;
					};
				};
				
				_currentMarker setMarkerPosLocal
				[
					(getPos _currentUnit select 0)
					,(getPos _currentUnit select 1)
				];
			
				_currentMarker setMarkerDirLocal (direction vehicle _currentUnit);
				
				_shortName = _currentUnit getVariable ["shortName", "-"];
			
				if (_shortName == "-") then
				{
					_shortNameArr = [];
					_shortNameArrCount = 0;
					_stack = [];
					_stackIndex = 0;
					_nameArr = toArray (name _currentUnit);					
					_nameArrLength = count _nameArr;
					_index = 0;
					_nameStartIndex = 0;
					while {_shortNameArrCount < nameLength && _shortNameArrCount < _nameArrLength && _index < _nameArrLength} do
					{
						_char = _nameArr select _index;
						_openerIndex = -1;
						_closerIndex = -1;
						_nameStartIndex = 0;
						_j = 0;
						while {(_openerIndex < 0) && (_closerIndex < 0) && (_j < _openersCount)} do
						{
							if ((_openers select _j) == _char) then
							{
								_openerIndex = _j;
								_nameStartIndex = _j + 1;
							};
							if ((_closers select _j) == _char) then
							{
								_closerIndex = _j;
								_nameStartIndex = _j + 1;
							};
							_j = _j + 1;
						};
						if (_openerIndex >= 0) then
						{
							_stack set [_stackIndex, _openerIndex];
							_stackIndex = _stackIndex + 1;
						};
						
						if (_stackIndex == 0 && (!(_char in _skipChars))) then
						{
							_shortNameArr set [_shortNameArrCount, _char];
							_shortNameArrCount = _shortNameArrCount + 1;
						};
					
						if (_stackIndex > 0 && _closerIndex >= 0) then
						{
							if (_closerIndex == (_stack select (_stackIndex - 1))) then
							{
								_stackIndex = _stackIndex - 1;
							};
						};
				
						_index = _index + 1;
					};
					
					if (_shortNameArrCount == 0) then
					{
						_index = _nameStartIndex;
						while {_shortNameArrCount < nameLength && _shortNameArrCount < _nameArrLength && _index < _nameArrLength} do
						{
							_char = _nameArr select _index;
							if (!(_char in _skipChars)) then
							{
								_shortNameArr set [_shortNameArrCount, _char];
								_shortNameArrCount = _shortNameArrCount + 1;	
							};
							_index = _index + 1;
						};
					};
				
					_shortName = toString _shortNameArr;
					_currentUnit setVariable ["shortName", _shortName];
					
				};
				_currentTextMarker setMarkerPosLocal markerPos _currentMarker;
				_currentTextMarker setMarkerTextLocal _shortName;

			}
			else
			{
				_currentMarker setMarkerAlphaLocal 0;
				_currentTextMarker setMarkerAlphaLocal 0;
			};
			
			_i = _i + 1;
		};
	} forEach allUnits;
	
	while {_i<63} do
	{
		_currentMarker = _infMarkers select _i;
		_currentMarker setMarkerAlphaLocal 0;
		_currentTextMarker = _textMarkers select _i;
		_currentTextMarker setMarkerAlphaLocal 0;
		_i = _i + 1;
	};
	
	_i = 0;
	{
		_group = _x;
		_leader = leader _group;
		if
		(
			(!(isNull _group))
			&&
			(!(isNull _leader))
			&&
			((side _group) == sidePlayer)
			&&
			(
				(((side _group) == attackerSide)  && roundInProgress)
				||
				(((side _group) == nextAttackerSide) && (!roundInProgress))
			)
			&&
			(_group getVariable ["insertionPosPicked", false])
		) then
		{
			_currentMarker = _insertionMarkers select _i;
			_pos = _group getVariable "insertionPos";
			
			_dx = (objPos select 0) - (_pos select 0);
			_dy = (objPos select 1) - (_pos select 1);
			_dir = atan (_dy/_dx);
			if (_dx<0) then
			{
				_dir = _dir + 180;
			};
			if (_dx==0) then
			{
				if (_dy>0) then
				{
					_dir = 90;
				}
				else
				{
					_dir = -90;
				};
			};
			_dir = 90 - _dir;

			_currentMarker setMarkerDirLocal _dir;
			_currentMarker setMarkerPosLocal _pos;
			_currentMarker setMarkerTextLocal format ["%1 (%2)", name _leader, localize format ["STR_InsertionVehicle%1s", _group getVariable "insertionType"]];
			_currentMarker setMarkerAlphaLocal 1;			

			_i = _i + 1;
		};
	} forEach allGroups;
	
	while {_i<63} do
	{
		_currentMarker = _insertionMarkers select _i;
		_currentMarker setMarkerAlphaLocal 0;
		_i = _i + 1;
	};
	
	sleep 1;
};