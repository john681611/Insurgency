params ["_faction", "_type"];
// call ([_faction, _type] call AW_fnc_getUnits)
// format faction Hash => type Hash => Unit/group Array
private _unitMap = createHashMapFromArray ([
	["VC", createHashMapFromArray [
		["MBT", [
			"UK3CB_TKM_O_T34", .1,
			"UK3CB_TKM_O_T55", .1,
			"UK3CB_TKM_O_BMP1", .1,
			"UK3CB_TKM_O_BTR60", .1,
			"UK3CB_TKM_O_MTLB_PKT", .1
		]
	],
	["Car", [
		"UK3CB_TKM_O_Datsun_Pkm", .5,
		"UK3CB_TKM_O_UAZ_Open", .5,
		"UK3CB_TKM_O_Hilux_GMG", .5,
		"UK3CB_TKM_O_Hilux_Rocket", .5,
		"UK3CB_TKM_O_Hilux_Pkm", .5,
		"UK3CB_TKM_O_LR_SPG9", .5,
		"UK3CB_TKM_O_UAZ_Dshkm", .5,
		"UK3CB_TKM_O_YAVA", .5,
		"UK3CB_TKM_O_Ural_Covered", .5
	]
],
['Inf_officer', ["UK3CB_TKA_O_SO", .5]],
["Inf_local", [
	"UK3CB_TKM_O_SL", .5,
	"UK3CB_TKM_O_TL", .5,
	"UK3CB_TKM_O_MD", .5,
	"UK3CB_TKM_O_MK", .5,
	"UK3CB_TKM_O_LAT", .5,
	"UK3CB_TKM_O_RIF_1", .5,
	"UK3CB_TKM_O_ENG", .5,
	"UK3CB_TKM_O_DEM", .5,
	"UK3CB_TKM_O_AT", .5,
	"UK3CB_TKM_O_MG", .5,
	"UK3CB_TKM_O_AR", .5
]
],
["Inf_local", [
	"UK3CB_TKM_O_SL", .5,
	"UK3CB_TKM_O_TL", .5,
	"UK3CB_TKM_O_MD", .5,
	"UK3CB_TKM_O_MK", .5,
	"UK3CB_TKM_O_LAT", .5,
	"UK3CB_TKM_O_RIF_1", .5,
	"UK3CB_TKM_O_ENG", .5,
	"UK3CB_TKM_O_DEM", .5,
	"UK3CB_TKM_O_AT", .5,
	"UK3CB_TKM_O_MG", .5,
	"UK3CB_TKM_O_AR", .5
]
],
["Inf_regional", [
	"UK3CB_TKA_O_AA", .5,
	"UK3CB_TKA_O_AA_ASST", .5,
	"UK3CB_TKA_O_SNI", .5,
	"UK3CB_TKA_O_SPOT", .5,
	"UK3CB_TKA_O_AR", .5,
	"UK3CB_TKA_O_GL", .5,
	"UK3CB_TKA_O_LAT", .5,
	"UK3CB_TKA_O_LMG", .5,
	"UK3CB_TKA_O_MG", .5,
	"UK3CB_TKA_O_MK", .5,
	"UK3CB_TKA_O_MD", .5,
	"UK3CB_TKA_O_RIF_1", .5,
	"UK3CB_TKA_O_RIF_2", .5,
	"UK3CB_TKA_O_SL", .5
]
],
["turret", [
	"UK3CB_TKM_O_DSHKM", .5,
	"UK3CB_TKM_O_KORD", .5,
	"UK3CB_TKM_O_KORD_high", .5,
	"UK3CB_TKM_O_SPG9", .5
]],
["AA", [
	"UK3CB_TKM_O_MTLB_ZU23", .5,
	"UK3CB_TKM_O_V3S_Zu23", .5,
	"UK3CB_TKM_O_Ural_Zu23", .5,
	"UK3CB_TKM_O_Hilux_Zu23_Front", .5
]],
["Arty", [
	"UK3CB_TKM_O_D30", .5,
	"UK3CB_TKM_O_2b14_82mm", .5,
	"UK3CB_TKM_O_Hilux_Rocket_Arty", .5,
	"UK3CB_TKM_O_Hilux_Mortar", .5,
	"UK3CB_TKM_O_Hilux_Rocket", .5
]],
["Supply", [
	"SFIA_Box_Ammo_lxWS", .5,
	"SFIA_Box_Support_lxWS", .5,
	"SFIA_Box_Wps_lxWS", .5
]]
]
],
["CIV", createHashMapFromArray [
	["Inf_Hostage", [
		"C_Journalist_lxWS", .5,
		"C_Tak_03_A_lxWS", .5,
		"C_Tak_01_B_lxWS", .5,
		"C_Tak_02_A_lxWS", .5,
		"C_Djella_01_lxWS", .5,
		"C_Man_smart_casual_2_F_afro", .5
	]
],
["Inf_local", [
	"UK3CB_TKC_C_CIV", .5,
	"UK3CB_TKC_C_SPOT", .5,
	"UK3CB_TKC_C_WORKER", .5
]
],
["Car", [
	"UK3CB_MEC_C_Ikarus", .5,
	"UK3CB_MEC_C_Datsun_Civ_Closed", .5,
	"UK3CB_MEC_C_Datsun_Civ_Open", .5,
	"UK3CB_MEC_C_Hilux_Ambulance", .5,
	"UK3CB_MEC_C_Hilux_Civ_Open", .5,
	"UK3CB_MEC_C_Hilux_Civ_Closed", .5,
	"UK3CB_MEC_C_Kamaz_Open", .5,
	"UK3CB_MEC_C_Lada_Taxi", .5,
	"UK3CB_MEC_C_LR_Open", .5,
	"UK3CB_MEC_C_V3S_Repair", .5,
	"UK3CB_MEC_C_Skoda", .5,
	"UK3CB_MEC_C_S1203_Amb", .5,
	"UK3CB_MEC_C_Tractor_Old", .5,
	"UK3CB_MEC_C_TT650", .5,
	"UK3CB_MEC_C_Gaz24", .5,
	"UK3CB_MEC_C_YAVA", .5,
	"UK3CB_MEC_C_Golf", .5
]
]
]
]
]);

((_unitMap get _faction) get _type) call BIS_fnc_selectRandomWeighted;