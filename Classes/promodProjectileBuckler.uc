class promodProjectileBuckler extends EquipmentClasses.ProjectileBuckler;

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
}
