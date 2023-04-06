_message = format ["Destroy %1 Caches", {alive (_x select 0)} count ammoCaches];
[
	"TK2",
	[
		(("TK2" call BIS_fnc_taskDescription) select 0) select 0,
		_message,
		""
	]
] call BIS_fnc_taskSetDescription;
["TaskUpdated", ["", _message]] remoteExec ["BIS_fnc_showNotification", 0];
[] call TR_fnc_saveState;