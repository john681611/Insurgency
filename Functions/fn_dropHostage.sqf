params ["_hostage"];

if (!isServer) exitWith {};
savedhostagesCount = savedhostagesCount + 1; 
publicVariable "savedhostagesCount";
deleteVehicle _hostage;
call TR_fnc_updateHostageTask;
