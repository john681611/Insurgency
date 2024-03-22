//Get all buildings on an Island (also catches editor placed (or spawned via script) buildings).
private ["_toClipboard","_toLogfile","_start","_mapSize","_center","_radius","_buildings"];
_locations = createHashMap;
_cache = profilenamespace getvariable [(format["InsurgencyCache%1",worldName]), createHashMap];
if(count (keys _cache) == 0 OR ("RESETMAPCACHE" call BIS_fnc_getParamValue == 1)) then { //CLEAR OVERIDE NEEDED
	_mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
	_center = [(_mapSize/2), (_mapSize/2), 0];
	_radius = [0,0,0] distance2D _center;
	{
		if(!([_x] call BIS_fnc_isBuildingEnterable)) then { continue };
		_pos = getPos _x;
		_rounded_x = (ceil ((_pos select 0) / 100)) * 100 - 50;
		_rounded_y = (ceil ((_pos select 1) / 100)) * 100 - 50;
		_index = format ["%1-%2", _rounded_x, _rounded_y];
		_locations set [_index, [_rounded_x, _rounded_y]];
	}forEach (_center nearObjects ["Building", _radius]);
	profilenamespace setvariable [(format["InsurgencyCache%1",worldName]), _locations];
} else {
	systemChat "Used Marker cache";
	_locations = _cache;
};

markers = [];
{
	if!(_y inArea safezone) then {
		_mark = createMarker [_x, _y];
		_mark setMarkerShapeLocal "RECTANGLE";
		_mark setMarkerBrushLocal "Solid";
		_mark setMarkerTypeLocal "Warning";
		_mark setMarkerAlphaLocal 0.2; 
		_mark setMarkerSize [50,50];
		markers pushBackUnique _mark;
	}
} forEach _locations;