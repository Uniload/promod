class promodProjectileChaingun extends EquipmentClasses.ProjectileChaingun config(promod);

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	damageTypeClass=Class'promodDamageTypeChaingun'
	damageAmt=5.0
}
