// THIS WILL LIKELY WORK for MOST units BUT TUNNELS NEED THOUGHT
_count_sub_objectives = {
	params ["_mkr"];
	if (_mkr in subObjectives) exitWith {
		{
			alive _x
		} count ((subObjectives get _mkr) select 0)
	};
	0
};

private _activeZoneLimit = 15;
if (isNil "activeZones") then {
	activeZones = createHashMap;
	activeZonesCivs = createHashMap;
	cooldownZones = createHashMap
};
{
	if({
		alive _x
	} count (units _y) == 0 && (_x call _count_sub_objectives) == 0) then {
		_x setMarkerColor "ColorBlue";
		if (_x in subObjectives) then {
			deleteMarker ((subObjectives get _x) select 1);
			subObjectives deleteAt _x;
		};
		deleteGroup _y;
		activeZones deleteAt _x;
		if ("HOLDGROUND" call BIS_fnc_getParamValue == -1) then {
			[] call TR_fnc_saveState;
		} else {
			cooldownZones set [_x, 300];
		}
	}
} forEach activeZones;

_triggerPlayers = allPlayers select {
	getPosATL _x select 2 < 50 and (speed _x) < 100
};// don't care about flying players over 50m or going over 100kmh
_needActivating = [];
_needCiviActivating = [];
if (count activeZones < _activeZoneLimit) then {
	_needActivating = activeAreaMarkers select {
		_mrk = _x;
		_minDist = (selectMin (allPlayers apply {
			_x distance2D (getMarkerPos _mrk)
		}));
		_activate = (getMarkerColor _mrk) == "ColorOpfor" and !(_mrk in activeZones) and _minDist < 500 and _minDist > 80;
		if (_activate) then {
			_nehiborsCount = {
				_x != _mrk && ((getMarkerPos _x) distance2D (getMarkerPos _mrk)) < 150
			} count activeAreaMarkers;
			if (_nehiborsCount > 4) then {
				_dist = 500 - (100 * (_nehiborsCount - 4));
				_activate = _minDist < _dist;
			};
		};
		_activate
	};
	if (((count activeZones) + (count _needActivating)) > _activeZoneLimit) then {
		_needCiviActivating = [];
		_needActivating = _needActivating select [0, 3];
	};
} else {
	// DEBUG
	// systemChat format["Active Zone limit Reached no more zones will spawn. ActiveZoneCount: %1", count activeZones];
};
_needsDeactivatingKeys = (keys activeZones) select {
	_mrk = _x;
	(selectMin (_triggerPlayers apply {
		_x distance2D (getMarkerPos _mrk)
	})) > 700
};

// Activate Zone and spawn units;
{
	_grp = createGroup [east, false];
	_mkr = _x;
	_unitSet = "Inf_local";
	if (random 10 < 2) then {
		_unitSet = "Inf_regional";
	};
	_playerCount = 3 max (15 min (count (allPlayers select {
		(getMarkerPos _mkr) distance _x < 500
	})));
	if (count (getMarkerPos _mkr nearObjects ["Building", 50]) <= 3) then {
		_playerCount = floor(_playerCount/2);
	};
	for "_i" from 0 to _playerCount do {
		_grp createUnit [(["VC", _unitSet] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
	};
	if (random 10 < 5) then {
		_unit = _grp createUnit [(["VC", "Inf_officer"] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
		_unit addHeadgear "H_Beret_CSAT_01_F";
		_unit spawn TR_fnc_addHostileIntelAction;
	};

	if ((count ((getMarkerPos _x) nearRoads 50)) > 0 && random 10 < 3) then {
		_veh = [_mkr, 50, (["VC", "Car"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
		(crew _veh) joinSilent _grp;
	};

	[units _grp] remoteExec ["TR_fnc_addToAllCurators", 2];
	if (!(isnil "lambs_wp_fnc_taskGarrison")) then {
		[_grp, (getMarkerPos _x), 50, [], true, false, 2, true] call lambs_wp_fnc_taskGarrison;
	} else {
		[_grp, (getMarkerPos _x), 50, 1, 0.1, 0.7, true] call CBAEXT_fnc_taskDefend;
	};
	// _x setMarkerBrush "Cross";// DEBUG
	activeZones set [_x, _grp];

	if (random 10 < 3) then {
		_grpCiv = createGroup [civilian, false];
		for "_i" from 1 to (ceil (random 5)) do {
			_grpCiv createUnit [(["CIV", "Inf_local"] call TR_fnc_getUnits), getMarkerPos _mkr, [], 50, "NONE"];
		};
		if ((count ((getMarkerPos _x) nearRoads 50)) > 0 && random 10 < 3) then {
			_vehCiv = [_mkr, 50, (["CIV", "Car"] call TR_fnc_getUnits), true, civilian] call TR_fnc_spawnVehicle;
			(crew _vehCiv) joinSilent _grpCiv;
		};
		[units _grpCiv] remoteExec ["TR_fnc_addToAllCurators", 2];
		if (!(isnil "lambs_wp_fnc_taskCamp")) then {
			[_grpCiv, (getMarkerPos _x), 50, [], true, true] call lambs_wp_fnc_taskCamp;
		} else {
			[_grpCiv, (getMarkerPos _x), 50, 1, 0.1, 0.6, true] call CBAEXT_fnc_taskDefend;
		};
		activeZonesCivs set [_x, _grpCiv];
	};
} forEach _needActivating;

// Deactivate Zone and delete units;
{
	_grp = activeZones get _x;
	{
		deleteVehicle _x;
	} forEach units _grp;
	deleteGroup _grp;
	// _x setMarkerBrush "Solid";// DEBUG
	activeZones deleteAt _x;

	if (_x in activeZonesCivs) then {
		_grpCiv = activeZonesCivs get _x;
		{
			deleteVehicle _x;
		} forEach units _grpCiv;
		deleteGroup _grpCiv;
	};
} forEach _needsDeactivatingKeys;

{
	private _mkr = _x;
	if (_y > 0) then {
		cooldownZones set [_x, _y -3]
	} else {
		private _minDist = (selectMin (allPlayers apply {
			_x distance2D (getMarkerPos _mkr)
		}));
		if (_minDist > ("HOLDGROUND" call BIS_fnc_getParamValue)) then {
			_x setMarkerColor "ColorOpfor";
		};
	};
} forEach cooldownZones;

{
	_hostage = _x select 0;
	if (alive _hostage && _hostage distance2D (getMarkerPos "respawn_west") < 50) then {
		[_hostage] call TR_fnc_dropHostage;
	};
} forEach hostages;