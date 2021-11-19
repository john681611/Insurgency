params["_unit", "_range", ["_canKill", false]];

_opts = keys subObjectives;

if(alive _unit) then {
	if(_canKill) then {
		systemChat "Player: Tell me what you know about the VC otherwise you may never see tomorrow.";
	} else {
		systemChat "Player: Can you tell me what you know about local VC movements?";
	};
};

_nearGreen = ({ markerColor _x == 'ColorGreen'} count ([_unit, markers, [], 200] call TR_fnc_getAjacentMarkers)) > 0;
_civChance = if(_nearGreen) then {3} else {1};
_diceRoll = if (alive _unit) then { (random 10) > _civChance } else { (random 10) > 4 };

if(count _opts == 0 and _diceRoll) exitWith {
	if(alive _unit) then {
		systemChat "Civ: I know nothing, leave me alone!";
		if(_canKill && (random 10) < 2) then {
			_unit setDamage 1;
		};
	} else {
		 hint "You find nothing";
	};
	_unit setVariable ["notSearched", false, true];
};

_choise = selectRandom _opts;
_IsHostage = (subObjectives get _choise) select 0 select 0 in hostages;
_message = "Enemy location spotted";
if(_IsHostage) then {
	systemChat "You find Intel on a hostage!";
	_message = "Hostage spotted";
} else {
	hint "You find intel on a enemy location!";
};
_posx = (getMarkerPos _choise select 0) + random [-200, 0, 200];
_posy = (getMarkerPos _choise select 1) + random [-200, 0, 200];
_now = date;
_hour = if (_now select 3 > 9) then { _now select 3 } else { format ["0%1",_now select 3] };
_min = if (_now select 4 > 9) then { _now select 4 } else { format ["0%1",_now select 4] };

_mkr = createMarker [format["intel%1%2", _posx, _posy],[_posx, _posy]];
_mkr setMarkerColorLocal "ColorUNKNOWN";
if(_IsHostage) then {
	_mkr setMarkerColorLocal "ColorCIV";
};
_mkr setMarkerTypeLocal "hd_unknown";
_mkr setMarkerTextLocal format ["Intel: %1 nearby: %2:%3 %4/%5", _message, _hour, _min, _now select 2,_now select 1];
_mkr setMarkerSizeLocal [0.7,0.7];
_mkr setMarkerAlpha 1;

if(_canKill && (random 10) < 2) then {
	_unit setDamage 1;
};

_unit setVariable ["notSearched", false, true];