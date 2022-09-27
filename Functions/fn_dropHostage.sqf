params ["_triggerList"];

if (!isServer) exitWith {};
{
	savedhostagesCount = savedhostagesCount + 1; 
	publicVariable "savedhostagesCount";
	deleteVehicle _x;
	call TR_fnc_updateHostageTask;
} forEach (_triggerList select {_x in (hostages apply {_x select 0})});