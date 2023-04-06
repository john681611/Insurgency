_cacheCount = {alive (_x select 0)} count ammoCaches;
_message = format ["Destroy %1 Caches", _cacheCount];
[
	"TK2",
	[
		(("TK2" call BIS_fnc_taskDescription) select 0) select 0,
		_message,
		""
	]
] call BIS_fnc_taskSetDescription;

if(_cacheCount == 0) then {
	["TK2","Succeeded"] call BIS_fnc_taskSetState;
	["TaskSucceeded", ["", "Ammo caches destroyed"]] remoteExec ["BIS_fnc_showNotification", 0];
} else {
	["TaskUpdated", ["", _message]] remoteExec ["BIS_fnc_showNotification", 0];
};

[] call TR_fnc_saveState;