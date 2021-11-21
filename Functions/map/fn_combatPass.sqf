//THIS WILL LIKELY WORK FOR MOST UNITS BUT TUNNELS NEED THOUGHT
_count_sub_objectives = {
	params ["_mkr"];
	if(_mkr in subObjectives) exitWith {
		{alive _x} count ((subObjectives get _mkr) select 0)
	};
	0
};

private _activeZoneLimit = 15;
if(isNil "activeZones") then {
	activeZones = createHashMap;
};
{
	if({alive _x} count (units _y) == 0 && (_x call _count_sub_objectives) == 0) then {
		_x setMarkerColor "ColorBlue";
		if(_x in subObjectives) then {
			deleteMarker ((subObjectives get _x) select 1);
			subObjectives deleteAt  _x;
		};
		deleteGroup _y;
		activeZones deleteAt _x;
	}
} forEach activeZones;

_triggerPlayers = allPlayers select {getPosATL _x select 2 < 50  AND (speed _x) < 100}; //don't care about flying players over 50m or going over 100kmh
_needActivating = [];
_needCiviActivating = [];
if(count activeZones < _activeZoneLimit) then {
	_needActivating = activeAreaMarkers select { 
		_mrk = _x; 
		_minDist = (selectMin (allPlayers apply {_x distance2D (getMarkerPos _mrk)}));
		(getMarkerColor _x) == "ColorOpfor" AND !(_x in activeZones) AND  _minDist < 500 AND _minDist > 100 
	};
	if(((count activeZones) + (count _needActivating)) > _activeZoneLimit) then {
		_needCiviActivating = [];
		_needActivating = _needActivating select [0, 3];
	};
} else {
	// DEBUG
	// systemChat format["Active Zone limit Reached no more zones will spawn. ActiveZoneCount: %1", count activeZones];
};
_needsDeactivatingKeys = (keys activeZones) select {
	_mrk = _x;
	(selectMin (_triggerPlayers apply {_x distance2D (getMarkerPos _mrk)})) > 700
}; 


//Activate Zone and spawn units;
{
	_grp = createGroup [east, false];
	_mkr = _x;
	_unitSet = "Inf_local";
	if(random 10 < 2) then {
		_unitSet = "Inf_regional";
	};
	_playerCount = 3 max (15 min (count (allPlayers select {(getMarkerPos _mkr) distance _x < 500})));
	for "_i" from 1 to _playerCount do {
		_grp createUnit [(["VC", _unitSet] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
	};
	if(random 10 < 5) then {
		_unit = _grp createUnit ["O_SFIA_officer_lxWS", getMarkerPos _mkr, [], 50, "NONE"];
		_unit addHeadgear "H_Beret_CSAT_01_F";
		_unit spawn TR_fnc_addHostileIntelAction;
	};
	[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
	[_grp, (getMarkerPos _x) , 50, 3, 0.1, 0.1, true] call CBAEXT_fnc_taskDefend;
	// _x setMarkerBrush "Cross"; //DEBUG
	activeZones set [_x, _grp];
	
} forEach _needActivating;

//Deactivate Zone and delete units;
{
	_grp = activeZones get _x;
	{
		deleteVehicle _x;	
	} forEach units _grp;
	deleteGroup _grp;
	// _x setMarkerBrush "Solid"; //DEBUG
	activeZones deleteAt _x;
	
} forEach _needsDeactivatingKeys;