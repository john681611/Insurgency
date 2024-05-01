params["_unit", "_range", ["_canKill", false]];

_opts = hostages + ammoCaches;
_diceRoll = (random 10) > 4 ;

if(count _opts == 0 and _diceRoll) exitWith {
	hint "You find nothing";
	_unit setVariable ["notSearched", false, true];
};

systemChat "You find Intel!";
_choise = _opts selectRandomWeighted (_opts apply { ((count (_x select 1)) + 1) / 10 });

[_choise] call TR_fnc_giveIntel;

_unit setVariable ["notSearched", false, true];