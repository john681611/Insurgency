params ["_mkr", ["_IsTrail", false]];

if(_mkr in subObjectives) exitWith {};


if(count hostages < 5) exitWith {
	[getMarkerPos _mkr] call TR_fnc_createHostage;
};

if(count ammoCaches < 10) exitWith {
	_veh = [_mkr, 50,(["VC", "Supply"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	_veh addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		"Bo_GBU12_LGB" createVehicle (getpos _unit);
		ammoCaches deleteAt (ammoCaches find _unit);
		publicVariable "ammoCaches";
		call TR_fnc_updateCacheTask;
	}];
	ammoCaches pushBack [_veh,[]];
	[(getMarkerPos _mkr), 50, [_veh]] call TR_fnc_hideInBuilding;
	publicVariable "ammoCaches";
};

private _subObjMkr = createMarker [format ["%1-subObj", _mkr], getMarkerPos _mkr];
_subObjMkr setMarkerColorLocal "colorOPFOR";
_subObjMkr setMarkerAlphaLocal 1;

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_antiair";
	_veh = [_mkr, 50,(["VC", "AA"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};


if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_armor";
	_veh = [_mkr, 50,(["VC", "MBT"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_art";
	_veh = [_mkr, 50,(["VC", "Arty"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};
