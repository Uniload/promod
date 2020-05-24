class promodProjectileEnergyBlade extends Gameplay.Projectile;

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	damageTypeClass=Class'promodBladeProjectileDamageType'
}
