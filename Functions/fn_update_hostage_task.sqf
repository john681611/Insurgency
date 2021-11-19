_message = format ["Recover %1 Hostages", {captive _x} count hostages];
[
	"TK1",
	[
		(("TK1" call BIS_fnc_taskDescription) select 0) select 0,
		_message,
		""
	]
] call BIS_fnc_taskSetDescription;
["TaskUpdated", ["", _message]] remoteExec ["BIS_fnc_showNotification", 0];	