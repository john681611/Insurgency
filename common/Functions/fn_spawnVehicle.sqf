	params ["_AOMarker", "_AORad", "_vehType", "_defend" , ["_side", east]];

private _AOpos = nil; 
if(typeName _AOMarker == "ARRAY") then {
	_AOpos = _AOMarker
} else {
	_AOpos = getMarkerPos _AOMarker;
};

private _randomPos = [];
if(_defend) then {
	_randomPos = [_AOpos, 0, _AORad, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
} else {
	_randomPos = [_AOpos, _AORad + 100, _AORad + 300 , 0, 0, 0.4, 0, []] call BIS_fnc_findSafePos;
};
private _veh = createVehicle [_vehType, _randomPos, [], 5, "NONE"];
private _grp = createGroup _side;
createVehicleCrew _veh;
(crew _veh) joinSilent _grp;
_veh allowCrewInImmobile true;

_grp enableDynamicSimulation true;
_veh enableDynamicSimulation true;
[[_veh] + (units _grp)] remoteExec ["TR_fnc_addToAllCurators", 2];
_veh;