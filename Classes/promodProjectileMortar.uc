class promodProjectileMortar extends EquipmentClasses.ProjectileMortar;

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

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
	LifeSpan=11.000000
}
