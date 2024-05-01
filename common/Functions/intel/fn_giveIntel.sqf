params["_choise"];

_markerCount = count (_choise select 1);
_rangeTo = 100 max (500 - (_markerCount * 50));
_posx = (getpos (_choise select 0) select 0) + random [_rangeTo * -1, 0, _rangeTo];
_posy = (getpos (_choise select 0) select 1) + random [_rangeTo * -1, 0, _rangeTo];

_mkr = createMarker [format["intel%1%2", _posx, _posy],[_posx, _posy]];
_mkr setMarkerColorLocal "ColorCIV";

_mkr setMarkerTypeLocal "hd_dot";
_mkr setMarkerTextLocal format ["%1m", _rangeTo];
_mkr setMarkerSizeLocal [0.7,0.7];
_mkr setMarkerAlpha 1;
(_choise select 1) pushBack _mkr;