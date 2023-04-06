//TODO filter listeners see if quicker
_saveMap = profilenamespace getvariable(format["InsurgencySave%1",worldName]);
markers = [];
for "_i" from 0 to (count (_saveMap get 'markers'))-1 do {
private _mrker = (_saveMap get 'markers') select _i;
	_mark = createMarker [_mrker get "id", _mrker get "pos"];
	_mark setMarkerShapeLocal "RECTANGLE";
	_mark setMarkerBrushLocal "Solid";
	_mark setMarkerTypeLocal "Warning";
	_mark setMarkerAlphaLocal 0.2; 
	_mark setMarkerSizeLocal [50,50];
	_mark setMarkerColor (_mrker get "colour");
	markers pushBackUnique _mark;
};

{
	[_x get 'unitPos'] call TR_fnc_createHostage;
	{
		_mkr = createMarker [_x get 'id', _x get 'pos'];
		_mkr setMarkerColorLocal "ColorCIV";
		_mkr setMarkerTypeLocal "hd_dot";
		_mkr setMarkerTextLocal (_x get 'text');
		_mkr setMarkerSizeLocal [0.7,0.7];
		_mkr setMarkerAlpha 1;
		_arrayLength = count hostages;
		(hostages select _arrayLength) pushBack _mkr;
		publicVariable "hostages";
		
	} forEach (_x get 'markers');
} forEach  (_saveMap get 'hostages');

{
	_veh = [(_x get 'unitPos'), 50,(["VC", "Supply"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	_veh addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		(selectRandom  ["Bomb_03_F" ,"Bo_GBU12_LGB"]) createVehicle (getpos _unit);
		ammoCaches deleteAt (ammoCaches find _unit);
		publicVariable "ammoCaches";
		call TR_fnc_updateCacheTask;
	}];
	[(_x get 'unitPos'), 50, [_veh]] call TR_fnc_hideInBuilding;
	ammoCaches pushBack [_veh,[]];
	publicVariable "ammoCaches";
	{
		_mkr = createMarker [_x get 'id', _x get 'pos'];
		_mkr setMarkerColorLocal "ColorCIV";
		_mkr setMarkerTypeLocal "hd_dot";
		_mkr setMarkerTextLocal (_x get 'text');
		_mkr setMarkerSizeLocal [0.7,0.7];
		_mkr setMarkerAlpha 1;
		_arrayLength = count ammoCaches;
		(ammoCaches select _arrayLength) pushBack _mkr;
		publicVariable "ammoCaches";
		
	} forEach (_x get 'markers');
} forEach  (_saveMap get 'ammoCaches');


{
	private _subObjMkr = createMarker [_x get 'id', _x get 'pos'];
	private _type = _x get 'type';
	private _mkr = _x get 'markerRef';

	if(_type == "o_antiair") then {
	_subObjMkr setMarkerType "o_antiair";
	_veh = [_mkr, 50,(["VC", "AA"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
	subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
	};


	if(_type == "o_armor") then {
		_subObjMkr setMarkerType "o_armor";
		_veh = [_mkr, 50,(["VC", "MBT"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
		subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
	};

	if(_type == "o_art") then {
		_subObjMkr setMarkerType "o_art";
		_veh = [_mkr, 50,(["VC", "Arty"] call TR_fnc_getUnits), true] call TR_fnc_spawnVehicle;
		subObjectives set [_mkr, [(crew _veh) + [_veh], _subObjMkr]];
	};
	
} forEach (_saveMap get 'subobj');

savedhostagesCount = _saveMap get 'saved';

call TR_fnc_updateHostageTask;
call TR_fnc_updateCacheTask;
systemChat "loaded state";
