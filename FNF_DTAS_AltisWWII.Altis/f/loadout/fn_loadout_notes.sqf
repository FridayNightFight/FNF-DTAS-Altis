// F3 - Loadout Notes
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS
if (!hasInterface) exitWith {};

params ["_unit"];

private ["_text","_weps","_items","_fnc_wepMags","_wepMags","_magArr","_s","_mags","_icon"];

// Local function to set the proper magazine count.
_fnc_wepMags = {
    private ["_magarr"];
    params["_w"];

    //Get possible magazines for weapon
    _wepMags = getArray (configFile >> "CfgWeapons" >> _w >> "magazines");

    // Compare weapon magazines with _unit magazines
    _magArr = [];
    {
        // findInPairs returns the first index that matches the checked for magazine
        _s = [_mags,_x] call BIS_fnc_findInPairs;

        //If we have a match
        if (_s != -1) then {
            // Add the number of magazines to the list
            _numMags = ([_mags,[_s, 1]] call BIS_fnc_returnNestedElement);
            _magArr pushBack _numMags;
            // Remove the entry
            _mags = [_mags, _s] call BIS_fnc_removeIndex;

        };
    } forEach _wepMags;

    if (count _magArr > 0) then {
        _text = _text + " [";

        {
            _text = _text + format ["x%1 magazines",_x];
            if (count _magarr > (_forEachIndex + 1)) then {_text = _text + "+";}
        } forEach _magArr;

        _text = _text + "]";
    };
};

// ====================================================================================
// SET UP KEY VARIABLES

_text = "<br/>";

// All weapons minus the field glasses
_weps = weapons _unit - ["Rangefinder","Binocular","Laserdesignator", "ACE_VectorDay"];

// Get a nested array containing all attached weapon items
_wepItems = weaponsItems _unit;

// Get a nested array containing all unique magazines and their count
_mags = (magazines _unit + primaryWeaponMagazine _unit + secondaryWeaponMagazine _unit + handgunMagazine _unit) call BIS_fnc_consolidateArray;

// Get a nested array containing all non-equipped items and their count
_items = (items _unit) call BIS_fnc_consolidateArray;

_visText = "";

// ====================================================================================
// Do this before _mags is deleted from.
_magVisText = "";
{
    _pic = getText(configFile >> "CfgMagazines" >> (_x select 0) >> "picture");
    _name = getText(configFile >> "CfgMagazines" >> (_x select 0) >> "displayName");
    _count = _x select 1;
    if (_pic find ".paa" isEqualTo -1) then { _pic = _pic + ".paa"};
    // _magVisText = _magVisText + "<img image='" + _icon + "' height=32 />";
    // if ((_x select 1) > 1) then {
        // _magVisText = _magVisText + format[" x%1",(_x select 1)];
    // };
    if (_pic == "") then {
       _magVisText = _magVisText + format["<font color='#ffffff' size='12' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>%3 x%2 </execute></font>", _pic, _count, _name];
    } else {
        _magVisText = _magVisText + format["<img height='40' image='%1'/><font color='#ffffff' size='10' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>x%2 </execute></font>", _pic, _count, _name];
    };
    if ((_forEachIndex + 1) mod 5 == 0) then {_magVisText = _magVisText + "<br/>"};
} forEach _mags;
_magVisText = _magVisText + "<br/>";
_magVisText = _magVisText + "<br/>";

// WEAPONS
// Add lines for all carried weapons and corresponding magazines

if (count _weps > 0) then {
    _text = _text + "<font size='14' color='#e1701a' face='PuristaBold'>WEAPONS:</font>";
    {
        _text = _text + format["<br/>%1",getText (configFile >> "CfgWeapons" >> _x >> "displayname")];

        //Add magazines for weapon
          [_x] call _fnc_wepMags;

          // Check if weapon has an underslung grenade launcher
        if ({_x in ["GL_3GL_F","EGLM","UGL_F"]} count (getArray (configFile >> "CfgWeapons" >> _x >> "muzzles")) > 0) then {
            _text = _text + "<br/> |- UGL";
            ["UGL_F"] call _fnc_wepMags;
        };
        _pic = getText(configFile >> "CfgWeapons" >> _x >> "picture");
        if (_pic find ".paa" isEqualTo -1) then { _pic = _pic + ".paa"};
        // _visText = _visText + "<img image='" + _pic + "' height=32 />";
        _name = getText (configFile >> "CfgWeapons" >> _x >> "displayname");
        _count = 1;

        if (_pic == "") then {
				_visText = _visText +  format["<font color='#ffffff' size='12' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>%3 x%2 </execute></font>", _pic, _count, _name];
			} else {
				_visText = _visText + format["<img height='70' image='%1'/><font color='#ffffff' size='10' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>x%2 </execute></font>", _pic, _count, _name];
			};
        if ((_forEachIndex + 1) mod 3 == 0) then {_visText = _visText + "<br/>"};
        // _visText = _visText + "<br/>";
        
        // List weapon attachments
        // Get attached items
        _attachments = _wepItems select (([_wepItems,_x] call BIS_fnc_findNestedElement) select 0);
        _attachments deleteAt 0; // Remove the first element as it points to the weapon itself

        {
            if (typeName _x != typeName [] && {_x != ""}) then {
                _icon = getText(configFile >> "CfgWeapons" >> _x >> "picture");
                if (_icon find ".paa" isEqualTo -1) then { _icon = _icon + ".paa"};
                _text = _text + format["<br/> |- %1",getText (configFile >> "CfgWeapons" >> _x >> "displayname")];
                _visText = _visText + "<img image='" + _icon + "' height=32 />";
            };
        } forEach _attachments;
        _visText = _visText;
    } forEach _weps;
    _visText = _visText + "<br/>";
    _visText = _visText + "<br/>";
    _text = _text + "<br/>";
};

// ====================================================================================
// OTHER MAGAZINES
// Add lines for all magazines not tied to any carried weapon (grenades etc.)

if (count _mags > 0) then {
    _text = _text + "<br/><font size='14' color='#e1701a' face='PuristaBold'>OTHER:</font><br/>";

    {
        _text = _text + format["%1 [x%2]<br/>",getText (configFile >> "CfgMagazines" >> (_x select 0) >> "displayname"),_x select 1];
    } forEach _mags;
};

_visText = _visText + _magVisText;

// ====================================================================================
// BACKPACK
// Add lines for all other items

if !(backpack _unit isEqualTo "") then {
    _text = _text + "<br/><font size='14' color='#e1701a' face='PuristaBold'>BACKPACK:</font><br/>";
    _text = _text + format["%1 [%2",getText (configFile >> "CfgVehicles" >> (backpack _unit) >> "displayname"), 100*loadBackpack _unit]+"% full]<br/>";
};

// ====================================================================================
// ITEMS
// Add lines for all other items

if (count _items > 0) then {
    _text = _text + "<br/><font size='14' color='#e1701a' face='PuristaBold'>ITEMS:</font><br/>";

    {
        // _text = _text + format["%1 [x%2]<br/>",getText (configFile >> "CfgWeapons" >> _x select 0 >> "displayname"),_x select 1];
        // _visText = _visText + "<img image='" + getText(configFile >> "CfgWeapons" >> _x select 0  >> "picture") + "' height=32 />";
        // if ((_x select 1) > 1) then {
        //     _visText = _visText + format[" x%1",(_x select 1)];
        // };

        _pic = getText(configFile >> "CfgWeapons" >> (_x select 0)  >> "picture");
        _name = getText (configFile >> "CfgWeapons" >> (_x select 0) >> "displayname");
        _count = _x select 1;

        if (_pic == "") then {
				_visText = _visText + format["<font color='#ffffff' size='12' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>%3 x%2 </execute></font>", _pic, _count, _name];
			} else {
				_visText = _visText + format["<img height='30' image='%1'/><font color='#ffffff' size='10' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>x%2 </execute></font>", _pic, _count, _name];
			};
        if ((_forEachIndex + 1) mod 6 == 0) then {_visText = _visText + "<br/>"};
    } forEach _items;
    _visText = _visText + "<br/>";
    _visText = _visText + "<br/>";

    {
        _text = _text + format["*%1<br/>",getText (configFile >> "CfgWeapons" >> _x >> "displayname")];
        // _visText = _visText + "<img image='" + getText(configFile >> "CfgWeapons" >> _x >> "picture") + "' height=32 />";
        _pic = getText(configFile >> "CfgWeapons" >> _x >> "picture");
        _name = getText (configFile >> "CfgWeapons" >> _x >> "displayname");
        _count = 1;

        if (_pic == "") then {
				_visText = _visText + format["<font color='#ffffff' size='12' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>%3 x%2 </execute></font>", _pic, _count, _name];
			} else {
				_visText = _visText + format["<img height='30' image='%1'/><font color='#ffffff' size='10' face='EtelkaMonospacePro'><execute expression='systemChat ""%3"";'>x%2 </execute></font>", _pic, _count, _name];
			};
        if ((_forEachIndex + 1) mod 6 == 0) then {_visText = _visText + "<br/>"};
    } forEach assignedItems _unit;
    _visText = _visText + "<br/>";
    _visText = _visText + "<br/>";

    _text = _text + "<br/>*Indicates an equipped item.";
};

// ====================================================================================
// ADD DIARY SECTION
// Wait for the briefing script to finish, then add the created text




if (!isNil "PHX_Diary") then {

    if (_unit == player) then {
        playerLoadoutNotes = player createDiaryRecord ["PHX_Diary", [name player, "NOTE: The loadout shown below updates at round start and kit change.<br/>"+ _visText + _text],
            taskNull,
			"?",
			true
        ];
    } else {
        player createDiaryRecord ["PHX_Diary", [name _unit, "<font face='PuristaLight'>NOTE: The loadout shown below updates every two minutes.<br/>"+ _visText + _text + "</font>"],
            taskNull,
			"?",
			true
        ];
    };

};

/* 
[{
    params ["_args", "_handle"];
    _args params ["_visText", "_text"];
    
    if (!isNil "PHX_Diary") then {
        // [_handle] call CBA_fnc_removePerFrameHandler;

        player removeDiaryRecord ["PHX_Diary", loadoutDiary];
    
        loadoutDiary = player createDiaryRecord ["PHX_Diary", ["Loadout", "NOTE: The loadout shown below is only accurate at mission start.<br/>"+ _visText + _text]];
    };
}, 15, [_visText, _text]] call CBA_fnc_addPerFrameHandler;
 */
