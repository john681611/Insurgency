
params ["_faction", "_type"];

// Call ([_faction, _type] call AW_fnc_getUnits)
// Format Faction Hash => Type Hash => Unit/Group Array
private _unitMap = createHashMapFromArray ([
	["VC", createHashMapFromArray [
		["MBT",[
			"O_SFIA_MBT_02_cannon_lxWS",.2
			]
		],
		["Car",[
			"O_Tura_Offroad_armor_lxWS", .5,
			"O_Tura_Offroad_armor_AT_lxWS", .5,
			"O_Tura_Offroad_armor_armed_lxWS", .5
			]
		],
		["Inf_local",[
				"O_Tura_defector_lxWS", .5,
				"O_Tura_deserter_lxWS", .5,
				"O_Tura_hireling_lxWS", .5,
				"O_Tura_scout_lxWS", .5,
				"O_Tura_medic2_lxWS", .5,
				"O_Tura_enforcer_lxWS", .5,
				"O_Tura_thug_lxWS", .5,
				"O_Tura_watcher_lxWS", .5
			]
		],
		["Inf_regional",[
			"O_SFIA_Soldier_AAA_lxWS", .5,
			"O_SFIA_Soldier_AAT_lxWS", .5,
			"O_SFIA_Soldier_AR_lxWS", .5,
			"O_SFIA_crew_lxWS", .5,
			"O_SFIA_Soldier_GL_lxWS", .5,
			"O_SFIA_pilot_lxWS", .5,
			"O_SFIA_medic_lxWS", .5,
			"O_SFIA_repair_lxWS", .5,
			"O_SFIA_soldier_lxWS", .5,
			"O_SFIA_sharpshooter_lxWS", .5,
			"O_SFIA_Soldier_universal_lxWS", .5,
			"O_SFIA_exp_lxWS", .5,
			"O_SFIA_soldier_aa_lxWS", .5,
			"O_SFIA_soldier_at_lxWS", .5,
			"O_SFIA_Soldier_TL_lxWS", .5
			]
		],
		["turret",[
				"O_Tura_HMG_02_lxWS", .5,
				"O_Tura_HMG_02_high_lxWS", .5,
				"O_Tura_Mortar_lxWS", .5,
				"O_Tura_ZU23_lxWS", .5
		]],
		["AA",[
				"O_Tura_Truck_02_aa_lxWS", .5,
				"O_Tura_ZU23_lxWS", .5
		]],
		["Arty",[
				"O_Tura_Mortar_lxWS", .5
		]],
		["Supply",[
			"SFIA_Box_Ammo_lxWS", .5,
			"SFIA_Box_Support_lxWS", .5,
			"SFIA_Box_Wps_lxWS", .5
		]]
		]
	],
	["CIV", createHashMapFromArray [
		["Inf",[
				"C_Journalist_lxWS", .5,
				"C_Tak_03_A_lxWS", .5,
				"C_Tak_01_B_lxWS", .5,
				"C_Tak_02_A_lxWS", .5,
				"C_Djella_01_lxWS", .5,
				"C_Man_smart_casual_2_F_afro", .5
				]
			],
		["Inf_local",[
				"C_Djella_01_lxWS", .5,
				"C_Djella_02_lxWS", .5,
				"C_Djella_03_lxWS", .5,
				"C_Djella_04_lxWS", .5,
				"C_Djella_05_lxWS", .5,
				"C_Tak_02_A_lxWS", .5,
				"C_Tak_02_B_lxWS", .5,
				"C_Tak_02_C_lxWS", .5,
				"C_Tak_03_A_lxWS", .5,
				"C_Tak_03_B_lxWS", .5,
				"C_Tak_03_C_lxWS", .5,
				"C_Tak_01_A_lxWS", .5,
				"C_Tak_01_B_lxWS", .5,
				"C_Tak_01_C_lxWS", .5
				]
			],
		["Car",[
				"C_Offroad_lxWS", .5,
				"C_Truck_02_cargo_lxWS", .5,
				"C_Truck_02_flatbed_lxWS", .5,
				"C_Kart_01_Red_F", .1,
				"C_Offroad_02_unarmed_F", .5,
				"C_Offroad_01_repair_F", .5,
				"C_Tractor_01_F", .5,
				"C_Van_02_service_F", .5,
				"C_Van_02_vehicle_F", .5,
				"C_Van_02_transport_F", .5
				]
			]
		]	
	]
]);


((_unitMap get _faction) get _type) call BIS_fnc_selectRandomWeighted;
