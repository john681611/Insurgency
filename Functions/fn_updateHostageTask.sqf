private _hostageCount = {captive (_x select 0)} count hostages;
private _message = format ["Recover %1 Hostages", _hostageCount];
[
	"TK1",
	[
		(("TK1" call BIS_fnc_taskDescription) select 0) select 0,
		_message,
		""
	]
] call BIS_fnc_taskSetDescription;
private _canUpdate = true;
if(_hostageCount == 0 and savedhostagesCount > 3) then {
	["TK1","Succeeded"] call BIS_fnc_taskSetState;
	["TaskSucceeded", ["", "Hostages Saved"]] remoteExec ["BIS_fnc_showNotification", 0];
	_canUpdate = false;
};

if(_hostageCount == 0 and savedhostagesCount < 3) then {
	["TK1","Failed"] call BIS_fnc_taskSetState;
	["TaskFailed", ["", "Too many hostages lost"]] remoteExec ["BIS_fnc_showNotification", 0];
	_canUpdate = false;
};
if(_canUpdate) then {
	["TaskUpdated", ["", _message]] remoteExec ["BIS_fnc_showNotification", 0];
};
[] call TR_fnc_saveState;