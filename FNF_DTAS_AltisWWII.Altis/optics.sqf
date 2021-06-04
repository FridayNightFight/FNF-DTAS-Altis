
params ["_addorremove"];

phx_selector_optics = ["optic_Holosight_blk_F", "rhsusf_acc_eotech_xps3", "rhsusf_acc_compm4", "rhsusf_acc_T1_high", "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_ekp8_02", "rhs_acc_okp7_dovetail", "rhs_acc_pkas"];


if (_addorremove == "add") then {
  //Create base actions
  _action = ["Gear_Selector","Gear Selector","",{}, {true}] call ace_interact_menu_fnc_createAction;
  [(typeOf player), 1, ["ACE_SelfActions"],_action] call ace_interact_menu_fnc_addActionToClass;

  _action = ["Optic_Selector","Optic","",{},{true}] call ace_interact_menu_fnc_createAction;
  [(typeOf player), 1, ["ACE_SelfActions", "Gear_Selector"],_action] call ace_interact_menu_fnc_addActionToClass;

  {
    _action = ["Optic_Selector",getText (configFile >> "cfgWeapons" >> _x >> "displayName"),"",{
      _optic = _this select 2;
      player addPrimaryWeaponItem _optic;
      player setVariable ["chosenOptic", _optic];
    },{(_this select 2) in ([primaryWeapon player, "optic"] call CBA_fnc_compatibleItems)}, {}, _x] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions","Gear_Selector","Optic_Selector"], _action] call ace_interact_menu_fnc_addActionToClass;
  } forEach phx_selector_optics;
};

if (_addorremove == "remove") then {
  [(typeOf player), 1, ["ACE_SelfActions","Gear_Selector", "Optic_Selector"]] call ace_interact_menu_fnc_removeActionFromClass;
  [(typeOf player), 1, ["ACE_SelfActions","Gear_Selector"]] call ace_interact_menu_fnc_removeActionFromClass;
};