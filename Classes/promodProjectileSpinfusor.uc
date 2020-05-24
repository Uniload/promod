class promodProjectileSpinfusor extends EquipmentClasses.ProjectileSpinfusor;

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	radiusDamageSize=650.000000
	radiusDamageMomentum=255000.000000
	MaxVelocity=10000.000000
	Lifespan=6.000000
}
