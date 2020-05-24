class promodSniperProjectileDamageType extends EquipmentClasses.ProjectileDamageTypeDefault;

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	headDamageModifier=1.400000
	backDamageModifier=1.000000
	vehicleDamageModifier=1.000000
	deathMessageIconMaterial=Texture'GUITribes.InvButtonSniperRifle'
}
