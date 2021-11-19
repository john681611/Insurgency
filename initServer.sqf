[] call TR_fnc_getMarkers;
publicVariable "markers";
noise = [20, "ColorOpfor", []] call TR_fnc_setRandomZonesTo;
[noise, markers, 5, "ColorOpfor", ["ColorOrange"]] spawn TR_fnc_generateAOE;


factions = ["VC"];
hostages = [];
savedhostagesCount = 0;
publicVariable "savedhostagesCount";
subObjectives = createHashMap;
{_x spawn TR_fnc_spawnSubObjective;} forEach noise;

_startTime = random 24;
skipTime _startTime;

[] spawn TR_fnc_initMainLoop;
addMissionEventHandler ["HandleDisconnect",{deleteMarker format["%1",(_this select 2)]; deletevehicle (_this select 0)}];
hint "Finished setting up the map";

