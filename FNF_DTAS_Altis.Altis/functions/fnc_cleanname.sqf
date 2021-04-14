private ["_originalName", "_skipChars", "_nameArr", "_cleanNameArr", "_i", "_char"];

_originalName = _this select 0;

_skipChars = toArray "<>";

_nameArr = toArray _originalName;
_cleanNameArr = [];
for "_i" from 0 to ((count _nameArr) - 1) do
{
	_char = _nameArr select _i;
	// replace < or > with space (32)
	if (_char in _skipChars) then
	{
		_cleanNameArr set [_i, 32];
	}
	else
	{
		_cleanNameArr set [_i, _char];
	};
};

(toString _cleanNameArr)