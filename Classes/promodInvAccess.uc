class promodInvAccess extends Gameplay.InventoryStationAccess;

function bool CanBeUsedBy(Pawn user)
{
	local Character characterUser;
	local PlayerCharacterController playerController;

	playerController = PlayerCharacterController(user.controller);

	characterUser = Character(user);

	// do nothing if used by non-character
	if (characterUser == None)
		return false;

	// do nothing if no player controller
	if (playerController == None)
		return false;

	// if an enemy do nothing
	if (!accessControl.isOnCharactersTeam(characterUser))
		return false;

	// if user is currently using inventory station have user exit
	if (user == currentUser)
		return false;

	// do nothing if inventory station is currently begin used
	if (currentUser != None)
		return false;

	// do nothing if inventory station is not functional
	if (!accessControl.isFunctional())
		return false;
		
	return true;
}


defaultproperties
{
	DrawType = DT_None
	bHidden = false

	bAlwaysRelevant = false

	bHardAttach=true
	bCollideActors=false
	CollisionRadius=+0080.000000
	CollisionHeight=+0100.000000
	bCollideWhenPlacing=false
	bOnlyAffectPawns=true

	RemoteRole=ROLE_SimulatedProxy

	bWaitingForAccess=false

	healRateHealthFractionPerSecond=0.04

	bAutoFillCombatRoles	= true
	bAutoFillWeapons		= true
	bAutoFillPacks			= true
	bAutoConfigGrenades		= true
	bCanUseCustomLoadouts	= true

	bDispenseGrenades = true

	maxWeapons = 10
	numFallbackWeapons = 1;

	prompt = "Press '%1' to enter the Inventory Station"
	markerOffset = (X=0,Y=-80,Z=0)
}