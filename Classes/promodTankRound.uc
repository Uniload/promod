class promodTankRound extends EquipmentClasses.ProjectileMortar;

simulated function bool projectileTouchProcessing(Actor Other, vector TouchLocation, vector TouchNormal)
{
	if (Other.IsA('BaseCatapult') || Other.IsA('DeployedCatapult'))
	{
		return false;
	}
	return super.projectileTouchProcessing(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	LifeSpan=10.000000
	GravityScale=1.200000
}
