params ["_pos"];
_grp = createGroup [civilian , false];
_unit = _grp createUnit [(["CIV", "Inf"] call TR_fnc_getUnits), _pos, [], 50, "NONE"];
[_grp, (_pos) , 50, 1, false, true, true] call CBAEXT_fnc_taskDefend;
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
hostages pushBack [_unit,[]];
publicVariable "hostages";
[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
if((nearestBuilding _unit) distance _unit > 50) then
{
	_objs = [getpos _unit, random 360, (call COMP_fnc_camp), 0.1] call BIS_fnc_objectsMapper;
	[_objs] remoteExec ["TR_fnc_addToAllCurators", 2];
	_tent = nearestObject [getpos _unit, "Land_Tents_Refugee_lxWS"];
	_tent animate ['Door_1_Hide',1];
	_tent animate ['Door_Wrapped',1];
};
