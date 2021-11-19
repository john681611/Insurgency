params ["_mkr", ["_IsTrail", false]];

if(_mkr in subObjectives) exitWith {};

private _subObjMkr = createMarker [format ["%1-subObj", _mkr], getMarkerPos _mkr];
_subObjMkr setMarkerColorLocal "colorOPFOR";
_subObjMkr setMarkerAlphaLocal 0;

if(count hostages < 5) exitWith {
	_grp = createGroup [civilian , false];
	_unit = _grp createUnit [(["CIV", "Inf"] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
	[_grp, (getMarkerPos _mkr) , 50, 1, false, true, true] call CBAEXT_fnc_taskDefend;
	private _waypoints = waypoints _grp;
	{
		deleteWaypoint [_grp, 0];
	} forEach _waypoints;
	_unit setCaptive true;
	_unit switchMove "Acts_AidlPsitMstpSsurWnonDnon01";
	_unit spawn TR_fnc_free_add_action;
	_unit addEventHandler ["Killed", {
		call TR_fnc_update_hostage_task;
	}];
	hostages pushBack _unit;
	subObjectives set [_mkr, [[_unit], _subObjMkr]];
	[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
	if((nearestBuilding _unit) distance _unit > 50) then
	{
		_objs = [getpos _unit, random 360, (call COMP_fnc_camp), 0.1] call BIS_fnc_objectsMapper;
		[_objs] remoteExec ["TR_fnc_addToAllCurators", 2];
		_tent = nearestObject [getpos _unit, "Land_Tents_Refugee_lxWS"];
		_tent animate ['Door_1_Hide',1];
		_tent animate ['Door_Wrapped',1];
	};
};

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

if(random 100 < 20) exitWith {
	_subObjMkr setMarkerType "o_Ordnance";
	_veh = [_mkr, 50,(["VC", "Supply"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	_veh addEventHandler ["Killed", {
		"Bo_GBU12_LGB" createVehicle (getpos _unit);
	}];
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
};
