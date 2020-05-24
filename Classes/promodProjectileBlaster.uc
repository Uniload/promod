class promodProjectileBlaster extends EquipmentClasses.ProjectileBlaster;

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	bShouldBounce=true
	bounceTime=0.5
	maxBounces=2
	bounceCount=0
	damageAmt=7
	LifeSpan=3
	knockback=15000 // note that each individual shot applies knockback so this adds up to be quite large knockback
	knockbackAliveScale=0 //0.5 // we dont want to push alive characters back as much with the shotgun as ragdolls and havok objects
}
