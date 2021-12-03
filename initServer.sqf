[] call TR_fnc_getMarkers;
publicVariable "markers";
noise = [20, "ColorOpfor", []] call TR_fnc_setRandomZonesTo;
[noise, markers, 5, "ColorOpfor", ["ColorOrange"]] spawn TR_fnc_generateAOE;


factions = ["VC"];
hostages = [];
publicVariable "hostages";
savedhostagesCount = 0;
publicVariable "savedhostagesCount";
subObjectives = createHashMap;
{_x spawn TR_fnc_spawnSubObjective;} forEach noise;

_startTime = random 24;
skipTime _startTime;

[] spawn TR_fnc_initMainLoop;
addMissionEventHandler ["HandleDisconnect",{deleteMarker format["%1",(_this select 2)]; deletevehicle (_this select 0)}];
hint "Finished setting up the map";


respawnTime = 5;
publicVariable "respawnTime";
addMissionEventHandler ["EntityKilled",{ 
 params ["_killedUnit","_killer","_triggerMan"]; 
	if ((_killedUnit call BIS_fnc_objectSide) isEqualTo civilian AND side _triggerMan isEqualTo west) then { 
		_killedUnit globalChat "Each time an innocent person is killed it gets harder to bring in reinforcements";
		respawnTime = respawnTime + 5;
		publicVariable "respawnTime";
	}; 
}];

while {true} do {
	sleep 3600;
	respawnTime = 5;
	publicVariable "respawnTime";
};

