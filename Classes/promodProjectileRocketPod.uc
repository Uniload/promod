class promodProjectileRocketPod extends EquipmentClasses.ProjectileRocketPod config(promod);

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	damageAmt=20.000000
	radiusDamageAmt=13.000000
}
