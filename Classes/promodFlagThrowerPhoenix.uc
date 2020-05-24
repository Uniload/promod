class promodFlagThrowerPhoenix extends GameClasses.FlagThrowerPhoenix config (promod);

var config float FlagInheritedVelocity;
var config int FlagVelocity;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetFlagThrow();
}

function SetFlagThrow()
{
	local promodFlagThrowerPhoenix PnxFlag;
	foreach AllActors(class'promodFlagThrowerPhoenix', PnxFlag)
		if(PnxFlag != None)
		{
			PnxFlag.projectileInheritedVelFactor = FlagInheritedVelocity;
			PnxFlag.projectileVelocity = FlagVelocity;
		}
}

defaultproperties
{
	FlagInheritedVelocity=0.600000
	FlagVelocity=1400.000000
}
