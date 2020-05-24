class promod extends Gameplay.Mutator config(promod);

const VERSION = "0.0.1";
const VERSION_NAME = "promod_v2";

var(Vehicles) config bool
	EnablePod,
	EnableRover,
	EnableRoverGun,
	EnableAssaultShip,
	EnableTank,
	TankUsesMortarProjectile;

var config float TankDefaultProjectileVelocity;
var config float TankMortarProjectileVelocity;
var config bool EnableDegrapple;
var config float GrapplerReelRate;
var config float GrapplerRPS;
var config int HOHealth;
var config int HOknockbackscale;

var config float SpinfusorPIVF;
var config float SpinfusorVelocity;
var config bool replaceBurnerWithPlasma;
var config float PlasmaVelocity;
var config float PlasmaPIVF;
var config float PlasmaEnergyUsage;
var config float BlasterSpread;
var config float BlasterBulletAmount;
var config float BlasterRoundsPerSecond;
var config float BlasterEnergyUsage;
var config float BlasterAmmoUsage;
var config float BlasterVelocity;
var config float BlasterPIVF;

var(Promod) config Array<class<Actor> > DisabledActors;

var(BaseDevices) config bool disableBaseRape;
var(BaseDevices) config Array<class<BaseDevice> > BaseRapeProtectedDevices;

var(Promod) config class<CombatRole> SpawnCombatRole;
var(Promod) config int SpawnInvincibility;

// ============================================================================

function PreBeginPlay()
{
	Super.PreBeginPlay();

	ModifyCharacters();
	ModifyPlayerStart();
	ModifyFlagThrower();
	ModifyVehicles();

	DestroyDisabledActors();
	if (disableBaseRape) ModifyBaseDevices(false);
}

function DestroyDisabledActors()
{
	local Actor actor;
	local int i;

	for (i=0; i < DisabledActors.Length; ++i) {
		foreach AllActors(DisabledActors[i], actor)
			actor.Destroy();
	}
}

function ModifyBaseDevices(optional bool canBeDamaged)
{
	local BaseDevice device;
	local int i;

	foreach AllActors(class'BaseDevice', device)
	{
		for (i=0; i < BaseRapeProtectedDevices.Length; ++i)
		{
			if(Left(device.Name, 8) == "catapult" || device.IsA(BaseRapeProtectedDevices[i].Name))
			{
				device.bCanBeDamaged = canBeDamaged;
				break;
			}
		}
	}
}

function ModifyCharacters()
{
	local Gameplay.GameInfo GameInfo;

	foreach AllActors(class'Gameplay.GameInfo', GameInfo)
	{
		GameInfo.Default.DefaultPlayerClassName = VERSION_NAME $ ".promodMultiplayerCharacter";
		GameInfo.DefaultPlayerClassName = VERSION_NAME $ ".promodMultiplayerCharacter";
	}
}

function ModifyPlayerStart()
{
	local Gameplay.MultiPlayerStart Start;

	forEach AllActors(class'Gameplay.MultiPlayerStart', Start)
	{
		Start.combatRole = SpawnCombatRole;
		Start.invincibleDelay = SpawnInvincibility;
	}
}

function ModifyFlagThrower()
{
	local GameClasses.CaptureFlagImperial ImpFlag;
	local GameClasses.CaptureFlagBeagle BEFlag;
	local GameClasses.CaptureFlagPhoenix PnxFlag;

	forEach AllActors(class'GameClasses.CaptureFlagImperial', ImpFlag)
		ImpFlag.carriedObjectClass = Class'promodFlagThrowerImperial';

	forEach AllActors(class'GameClasses.CaptureFlagBeagle', BEFlag)
		BEFlag.carriedObjectClass = Class'promodFlagThrowerBeagle';

	forEach AllActors(class'GameClasses.CaptureFlagPhoenix', PnxFlag)
		PnxFlag.carriedObjectClass = Class'promodFlagThrowerPhoenix';
}

function ModifyVehicles()
{
	local Gameplay.VehicleSpawnPoint vehiclePad;

	foreach AllActors(class'Gameplay.VehicleSpawnPoint', vehiclePad)
	{
		switch (vehiclePad.vehicleClass) {
			case class'VehicleClasses.VehiclePod':
				vehiclePad.setSwitchedOn(EnablePod);
				break;

			case class'VehicleClasses.VehicleAssaultShip':
				vehiclePad.setSwitchedOn(enableAssaultShip);
				break;

			case class'VehicleClasses.VehicleTank':
				vehiclePad.setSwitchedOn(enableTank);
				break;

			case class'VehicleClasses.VehicleBuggy':
				vehiclePad.setSwitchedOn(enableRover);
				if (enableRoverGun)
					vehiclePad.vehicleClass = class'RoverBuggyGun';
				else vehiclePad.vehicleClass = class'RoverBuggy';
				break;
		}
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
}

function Actor ReplaceActor(Actor Other)
{
	switch (true) {
		case Other.IsA('WeaponRocketPod'):
			WeaponRocketPod(Other).projectileClass = Class'promodProjectileRocketPod';
			break;

		case Other.IsA('WeaponHandGrenade'):
			WeaponHandGrenade(Other).projectileClass = Class'promodProjectileHandGrenade';
			break;

		case Other.IsA('WeaponBlaster'):
			WeaponBlaster(Other).projectileClass = Class'promodProjectileBlaster';
			WeaponBlaster(Other).spread = BlasterSpread;
			WeaponBlaster(Other).numberOfBullets = BlasterBulletAmount;
			WeaponBlaster(Other).roundsPerSecond = BlasterRoundsPerSecond;
			WeaponBlaster(Other).energyUsage = BlasterEnergyUsage;
			WeaponBlaster(Other).ammoUsage = BlasterAmmoUsage;
			WeaponBlaster(Other).projectileVelocity = BlasterVelocity;
			WeaponBlaster(Other).projectileInheritedVelFactor = BlasterPIVF;
			break;

		case Other.IsA('WeaponBuckler'):
			WeaponBuckler(Other).projectileClass = Class'promodProjectileBuckler';
			break;

		case Other.IsA('WeaponMortar'):
			WeaponMortar(Other).projectileClass = Class'promodProjectileMortar';
			break;

		case Other.IsA('WeaponGrenadeLauncher'):
			WeaponGrenadeLauncher(Other).projectileClass = Class'promodProjectileGrenadeLauncher';
			break;

		case Other.IsA('WeaponSpinfusor'):
			WeaponSpinfusor(Other).projectileClass = Class'promodProjectileSpinfusor';
			WeaponSpinfusor(Other).projectileInheritedVelFactor = SpinfusorPIVF;
			WeaponSpinfusor(Other).projectileVelocity = SpinfusorVelocity;
			break;

		case Other.IsA('WeaponEnergyBlade'):
			Other.Destroy();
			return ReplaceWith(Other, "promod_v1rc7.promodWeaponEnergyBlade");

		case Other.IsA('WeaponBurner'):
			if (replaceBurnerWithPlasma)
			{
				WeaponBurner(Other).projectileClass = Class'promodProjectilePlasma';
				WeaponBurner(Other).projectileInheritedVelFactor = PlasmaPIVF;
				WeaponBurner(Other).projectileVelocity = PlasmaVelocity;
				WeaponBurner(Other).energyUsage = PlasmaEnergyUsage;
				WeaponBurner(Other).localizedname = "Plasma gun";
			}

		case Other.IsA('WeaponVehicleTank'):
			WeaponVehicleTank(Other).projectileVelocity = TankDefaultProjectileVelocity;
			WeaponVehicleTank(Other).ammoUsage = 0;
			if(TankUsesMortarProjectile)
			{
				WeaponVehicleTank(Other).aimClass = Class'AimArcWeapons';
				WeaponVehicleTank(Other).projectileClass = Class'promod_v1rc7.promodTankRound';
			} else {
				WeaponVehicleTank(Other).aimClass = Class'AimProjectileWeapons';
			}
			break;

		case Other.IsA('Grappler'):
			if(EnableDegrapple)
				Grappler(Other).projectileClass = Class'promodDegrappleProjectile';
			else
				Grappler(Other).projectileClass = Class'Gameplay.GrapplerProjectile';
			Grappler(Other).reelInDelay = GrapplerReelRate;
			Grappler(Other).roundsPerSecond = GrapplerRPS;
			break;

		case Other.IsA('CatapultDeployable'):
			CatapultDeployable(Other).basedeviceClass = Class'promodDeployedCatapult';
			break;

		case Other.IsA('InventoryStationDeployable'):
			InventoryStationDeployable(Other).basedeviceClass = Class'promodDeployedInventoryStation';
			break;

		case Other.IsA('CloakPack'):
			Other.Destroy();
			return ReplaceWith(Other, VERSION_NAME $ ".promodanticloak");
	}

	return Super.ReplaceActor(Other);
}

defaultproperties
{

	DisabledActors(0)=class'BaseObjectClasses.BaseDeployableSpawnTurret'
	DisabledActors(1)=class'BaseObjectClasses.BaseTurret'
	DisabledActors(2)=class'BaseObjectClasses.StaticMeshRemovable'
	DisabledActors(3)=class'BaseObjectClasses.BaseDeployableSpawnShockMine'

	BaseRapeProtectedDevices(0)=class'BaseObjectClasses.BaseCatapult'
	BaseRapeProtectedDevices(1)=class'BaseObjectClasses.BaseDeployableSpawn'
	BaseRapeProtectedDevices(2)=class'BaseObjectClasses.BaseInventoryStation'
	BaseRapeProtectedDevices(3)=class'BaseObjectClasses.BasePowerGenerator'
	BaseRapeProtectedDevices(4)=class'BaseObjectClasses.BaseResupply'
	BaseRapeProtectedDevices(5)=class'BaseObjectClasses.BaseSensor'
	BaseRapeProtectedDevices(6)=class'BaseObjectClasses.BaseTurret'

	EnablePod=True
	EnableRover=True
	EnableRoverGun=True
	EnableAssaultShip=False
	EnableTank=False
	TankUsesMortarProjectile=False
	TankDefaultProjectileVelocity=6000
	TankMortarProjectileVelocity=6000
	EnableDegrapple=True
	GrapplerReelRate=0.5
	GrapplerRPS=1.0
	BlasterSpread=4
	BlasterBulletAmount=7
	BlasterRoundsPerSecond=0.4
	BlasterEnergyUsage=9
	BlasterAmmoUsage=0
	BlasterVelocity=3000
	BlasterPIVF=1
	HOHealth=195
	HOknockbackscale=1.04
	SpinfusorPIVF=0.5000
	SpinfusorVelocity=6800

	SpawnCombatRole=class'EquipmentClasses.CombatRoleLight'
	SpawnInvincibility=2

	PlasmaVelocity=4900
	PlasmaPIVF=0.5000
	PlasmaEnergyUsage=0.000000
}
