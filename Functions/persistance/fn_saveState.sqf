//TODO filter listeners see if quicker
_markers_state = [];
for "_i" from 0 to (count markers)-1 do {
	private _mrker = markers select _i;
	private _hash = createHashMapFromArray [
		['id', _mrker],
		['pos', getMarkerPos _mrker],
		['colour', getMarkerColor _mrker]];
	_markers_state pushBackUnique _hash;
};

_hostage_state = [];
{
	private _intelMarkrs = [];
	{
		private _hash = createHashMapFromArray [
		['id', _x],
		['pos', getMarkerPos _x],
		['text', markerText _x]];
		_intelMarkrs pushBackUnique _hash;
		
	} forEach (_x select 1);
	private _hash = createHashMapFromArray [
		['unitPos', getPos(_x select 0)],
		['markers', _intelMarkrs]];
	_hostage_state pushBackUnique _hash;
} forEach (hostages select {captive (_x select 0)});


_subObj_state = [];
{
	private _subMarker = _y select 1;
	private _hash = createHashMapFromArray [
		['id', _subMarker],
		['markerRef', _x],
		['pos', getMarkerPos _subMarker],
		['type', getMarkerType _subMarker]];
	_subObj_state pushBackUnique _hash;
} forEach subObjectives;

profilenamespace setVariable [(format["InsurgencySave%1",worldName]), createHashMapFromArray [
	['markers', _markers_state],
	['subobj', _subObj_state],
	['hostages', _hostage_state],
	['saved', savedhostagesCount]
]];
systemChat "saved state";
