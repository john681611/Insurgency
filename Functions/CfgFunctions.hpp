class IA
{
	tag = "TR";
	class script
	{
		file = "Functions";
		
		class addToAllCurators {};
		class createHostage {};
		class getUnits {};
		class getUnitsFromConfigGroup {};
		class hideInBuilding {};
		class spawnGroup {};
		class spawnForce{};
		class spawnUnit {};
		class spawnVehicle {};
		class teleport{};
		class teleportAddAction{};
		class spawnSuppliesAddAction{};
		class freeAddAction{};
		class freeUnit{};
		class dropHostage{};
		class togglePostAddAction{};
		class togglePost{};
		class createTunnel{};
		class spawnSubObjective{};
		class updateHostageTask{};
		class updateCacheTask{};

	};

	class MAP
	{
		file = "Functions\map";
		class getMarkers{};
		class setRandomZonesTo{};
		class generateTrail{};
		class getAjacentMarkers{};
		class generateAOE{};
		class liseningPass{};
		class activeAreaPass{};
		class combatPass{};
		class spawnAO{};
		class spawnBastion{};
		class trackPost{};
		class trackVeh{};
		class getNearbyMarkers{};
		class initMainLoop{};
	}

	class INTEL
	{
		file = "Functions\intel";
		class tryIntel{};
		class addHostileIntelAction{};
		class addCivIntelAction{};
	}


	class PLAYER
	{
		file = "Functions\player";
		class runMarker{};
		class initEarplugs{}
	}

	class PERSISTANCE
	{
		file = "Functions\persistance";
		class saveState{};
		class loadState{}
	}
};

class CBAEXT
{
	tag = "CBAEXT";
	class script
	{
		file = "Functions\CBAEXT";
		class addWaypoint{};
		class taskDefend{};
		class taskPatrol{};
		class taskAttack{};

	};
};

class COMP
{
	tag = "COMP"
	class script
	{
		file = "Compositions";
		class camp{}
	}
}