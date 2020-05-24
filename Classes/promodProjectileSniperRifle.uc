class promodProjectileSniperRifle extends EquipmentClasses.ProjectileSniperRifle config(promod);

var config int SniperSensorDmg;

// Removed simulation to avoid displaying "non-reg" projectile explosions
function ProjectileTouch(Actor Other, vector TouchLocation, vector TouchNormal)
{
	if(BaseObjectClasses.BaseSensor(Other) != None)
	{
		damageAmt = SniperSensorDmg;
	}
	super.ProjectileTouch(Other, TouchLocation, TouchNormal);
}

defaultproperties
{
	SniperSensorDmg=0
	damageAmt=50.000000
	damageTypeClass=Class'promodSniperProjectileDamageType'
}
