-- For <float> use SetFGlobalVar
-- obsolete
-- these consts are in consts.cfg now

function GeneralConsts()
	SetIGlobalVar( "AI.General.Artillery.TimeToForgetAntiArtillery", 20000 );
	SetIGlobalVar( "AI.General.Artillery.TimeToForgetUnit", 60000 );
	SetIGlobalVar( "AI.General.Artillery.TimeToArtilleryFire", 0 );
	SetFGlobalVar( "AI.General.Artillery.ProbabilityToShootAfterArtilleryFire", 1.0 );
	SetIGlobalVar( "AI.General.Artillery.ShootsOfArtilleryFire", 10 );
	SetIGlobalVar( "AI.General.Artillery.MinWeightToArtilleryFire", 3 ); --was 50
	SetIGlobalVar( "AI.General.TimeDontSeeTheEnemyBeforeForget", 30000 );
	SetFGlobalVar( "AI.General.PlayerForceMultiply", 2.0 );
end;

function AIconsts()
	---- COMMON ----

	--SetIGlobalVar( "AI.Common.MaxFireRangeToShootByLine", 1056 );
	--SetIGlobalVar( "AI.Common.NumToScanInSegm", 50 );
	--SetIGlobalVar( "AI.Common.BehUpdateDuration", 1500 );
	--SetIGlobalVar( "AI.Common.SoldierBehUpdateDuration", 2000 );
	SetIGlobalVar( "AI.Common.DeadSeeTime", 1000 ); -- dead continue see for this time (ticks)
	SetIGlobalVar( "AI.Common.TimeToReturnGun", 4000 ); -- time before turret must be rotated to the default direction
	SetIGlobalVar( "AI.Common.MinRotateAngle", 35 ); -- minimal base rotation angle for targeting
	SetIGlobalVar( "AI.Common.NumToScanInSegm", 50 );
	SetIGlobalVar( "AI.Common.TimeBeforeCamouflage", 5000 );
	SetIGlobalVar( "AI.Common.RadiusOfHitNotify", 160 );
	SetIGlobalVar( "AI.Common.TimeOfHitNotify", 1000 );
	SetIGlobalVar( "AI.Common.CallForHelpRadius", 500 ); -- player units' call for help radius (ai points)
	SetIGlobalVar( "AI.Common.AICallForHelpRadius", 2000 ); -- ai units' call for help radius (ai points)
	SetIGlobalVar( "AI.Common.GuardStateRadius", 960 );
	SetFGlobalVar( "AI.Common.GoodAttackProbability", 0.4 );
	SetFGlobalVar( "AI.Common.AreaDamageCoeff", 0.3 );
	SetIGlobalVar( "AI.Common.TankTrackHitPoints", 20 ); -- HP of tracks for repairing
	SetIGlobalVar( "AI.Common.FenceSegmentRuPrice", 2000 );
	SetIGlobalVar( "AI.Common.TrenchSegmentRuPrice", 1000 );
	SetFGlobalVar( "AI.Common.TrajectoryLineRatio", 0.7 );
	SetFGlobalVar( "AI.Common.TrajectoryBombG", 0.0001 );
	SetFGlobalVar( "AI.Common.AmbushBeginAttackCriteria", 0.5 );
	SetFGlobalVar( "AI.Common.CoeffForRandomDelay", 1.2 );
	SetFGlobalVar( "AI.Common.HeightForVisRadiusInc", 10.0 );
	SetFGlobalVar( "AI.Common.DamageForMassiveDamageFatality", 0.8 );
	SetFGlobalVar( "AI.Common.MassiveDamageFatalityProbability", 0.5 );
	SetFGlobalVar( "AI.Common.HpPercentageToWaitMedic", 0.5 ); -- HP condition for acks set
	SetFGlobalVar( "AI.Common.TankPitCover", 0.6 ); -- common AABBCoeff (silhoette) multipliyer
	SetIGlobalVar( "AI.Common.UnitEntrenchTime", 1500 ); -- entrench time per 1 ai tile (ms)
	--SetIGlobalVar( "AI.Common.TimeOfPreDisappearNotify", 500 );
	SetIGlobalVar( "AI.Common.ArmorForAreaDamage", 300 ); -- maximum armor that can be penetrated by area damage
	
	---- INFANTRY ----

	SetIGlobalVar( "AI.Infantry.SpyGlassRadius", 1600 ); -- ai points
	SetIGlobalVar( "AI.Infantry.SpyGlassAngle", 45 ); -- degrees
	SetFGlobalVar( "AI.Infantry.LyingSoldierCover", 0.6 ); -- common
	SetFGlobalVar( "AI.Infantry.LyingSpeedFactor", 0.4 ); -- common speed multipliyer
	SetIGlobalVar( "AI.Infantry.RadiusOfFormation", 960 ); -- ai points
	SetIGlobalVar( "AI.Infantry.TimeOfLyingUnderFire", 5000 ); -- ticks
	SetIGlobalVar( "AI.Infantry.StandLieRandomDelay", 2500 ); -- ticks
	SetIGlobalVar( "AI.Infantry.SquadMemberLeaveInterval", 500 ); -- delay between infantry leaving container (ms)
	SetIGlobalVar( "AI.Infantry.MaxDistanceToThrowGrenade", 320 ); -- ai points
	SetIGlobalVar( "AI.Infantry.FullHealthTime", 4000 ); -- healing time
	
	---- ENGINEERS ----

	SetIGlobalVar( "AI.Engineers.MineVisRadius", 96 );
	SetIGlobalVar( "AI.Engineers.MineClearRadius", 224 );
	SetIGlobalVar( "AI.Engineers.EngineerRepearPerQuant", 213 );
	SetIGlobalVar( "AI.Engineers.EngineerFenceLenghtPerQuant", 15 );
	SetIGlobalVar( "AI.Engineers.EngineerEntrenchLenghtPerQuant", 15 );
	SetIGlobalVar( "AI.Engineers.EngineerResupplyPerQuant", 320 );
	SetIGlobalVar( "AI.Engineers.EngineerFenceLenghtPerQuant", 15 );
	SetIGlobalVar( "AI.Engineers.EngineerMineCheckPeriod", 1000 );
	SetIGlobalVar( "AI.Engineers.EngineerLoadRuPerQuant", 320 );
	SetIGlobalVar( "AI.Engineers.TimeQuant", 160 );
	SetFGlobalVar( "AI.Engineers.EngineerAntitankHealthPerQuant", 1.1 );
	SetIGlobalVar( "AI.Engineers.MineAPersRuPrice", 1000 );
	SetIGlobalVar( "AI.Engineers.MineATankRuPrice", 1500 );
	SetIGlobalVar( "AI.Engineers.EngineerRuCarryWeight", 5000 );
	SetIGlobalVar( "AI.Engineers.RepairCostAdjust", 175 );
	
	---- AVIATION ----

	SetIGlobalVar( "AI.Aviation.DiveBeforeExplodeTime", 5000 );
	SetIGlobalVar( "AI.Aviation.DiveAfterExplodeTime", 150 );
	SetIGlobalVar( "AI.Aviation.PlaneGuardStateRadius", 2560 );
	SetIGlobalVar( "AI.Aviation.ShturmovikApproachRadius", 640 );
	SetIGlobalVar( "AI.Aviation.PlaneMinHeight", 300 );
	SetFGlobalVar( "AI.Aviation.PlanesBombHeight", 0.8 );
	SetIGlobalVar( "AI.Aviation.GroundAttack.MechNuberToDropBombs", 1 );
	SetIGlobalVar( "AI.Aviation.GroundAttack.InfantryNuberToDropBombs", 20 );
	
	---- ARTILLERY ----

	SetIGlobalVar( "AI.Artillery.ThresholdInstallTime", 0 );
	SetIGlobalVar( "AI.Artillery.ShootsToRange", 4 );
	SetFGlobalVar( "AI.Artillery.RandgedDispersionRadiusBonus", 0.7 );
	SetIGlobalVar( "AI.Artillery.RangedAreaRadius", 716 );
	SetIGlobalVar( "AI.Artillery.MaxAntiArtilleryRadius", 6400 );
	SetIGlobalVar( "AI.Artillery.MinAntiArtilleryRadius", 384 );
	SetIGlobalVar( "AI.Artillery.ShotsToMinimizeLocationRadius", 13 );
	SetIGlobalVar( "AI.Artillery.RevealCirclePeriod", 3000 );
	SetIGlobalVar( "AI.Artillery.RadiusToStartAntiartilleryFire", 640 );
	SetIGlobalVar( "AI.Artillery.RelocationRadius", 160 );
	SetIGlobalVar( "AI.Artillery.AudibilityTime", 20000 );
	SetIGlobalVar( "AI.Artillery.ArtilleryRevealCoefficient", 1000 );
	-- dispersion --
	SetFGlobalVar( "AI.Artillery.DispersionRatio.LineMin", 1.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.LineMax", 1.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.HowitserMin", 1.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.HowitserMax", 2.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.BombMin", 2.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.BombMax", 2.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.CannonMin", 3.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.CannonMax", 3.5 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.RocketMin", 1.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.RocketMax", 0.5 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.GrenadeMin", 1.0 );
	SetFGlobalVar( "AI.Artillery.DispersionRatio.GrenadeMax", 1.0 );

	---- BUILDINGS ----

	SetFGlobalVar( "AI.Buildings.DefaultFireplaceCoverage", 0.25 ); -- result cover = const_cover * fireplace_cover
	SetFGlobalVar( "AI.Buildings.CureSpeedInBuilding", 0.005 );
	SetIGlobalVar( "AI.Buildings.TimeOfBuildingAlarm", 8000 );
	SetIGlobalVar( "AI.Buildings.CampingTime", 2000 ); -- time to wait inside building before storming it (ticks)
	SetFGlobalVar( "AI.Buildings.InsideObjWeaponFactor", 0.5 ); -- weapon range inside building
	SetIGlobalVar( "AI.Buildings.InsideObjCombatPeriod", 500 ); -- time of two soldiers combat (ticks)
	SetFGlobalVar( "AI.Buildings.BurningSpeed", 0.0002 );
	SetFGlobalVar( "AI.Buildings.HPPercentToEscapeFromBuilding", 0.1 );
	
	---- FOLLOW ----
	
	SetIGlobalVar( "AI.Follow.StopRadius", 288 );
	SetIGlobalVar( "AI.Follow.EqualizeSpeedRadius", 384 );
	SetIGlobalVar( "AI.Follow.GoRadius", 352 );
	SetIGlobalVar( "AI.Follow.WaitRadius", 768 );
	
	---- TRANSPORT AND RESUPPLY ----
	
	SetIGlobalVar( "AI.TransportAndResupply.MainStorageHealingSpeed", 50 );
	SetIGlobalVar( "AI.TransportAndResupply.ResupplyRadius", 640 );
	SetIGlobalVar( "AI.TransportAndResupply.TransportRuCapacity", 35000 );
	SetIGlobalVar( "AI.TransportAndResupply.TransportLoadTime", 3000 );
	SetIGlobalVar( "AI.TransportAndResupply.TransportLoadRuDistance", 400 );
	SetIGlobalVar( "AI.TransportAndResupply.ResupplyOffset", 200 );
	SetFGlobalVar( "AI.TransportAndResupply.ResupplyBalanceCoeff", 0.0000001 );
	SetIGlobalVar( "AI.TransportAndResupply.ResupplyMaxPathLenght", 232 );
	--SetIGlobalVar( "AI.TransportAndResupply.SoldierRUPrice", 3500 ); -- obsolete
	SetIGlobalVar( "AI.TransportAndResupply.TakeStorageOwnershipRadius", 300 );
	SetIGlobalVar( "AI.TransportAndResupply.LandDistance", 50 );
	
	---- ANTIAVIATION ARTILLERY ----

	SetIGlobalVar( "AI.AntiAviationArtillery.AimIterations", 1 );
	
	---- PARATROOPERS ----
	
	SetFGlobalVar( "AI.Paratroopers.ParatrooperFallSpeed", 0.05 );
	SetIGlobalVar( "AI.Paratroopers.ParadropSpread", 4 );
	SetIGlobalVar( "AI.Paratroopers.PlaneParadropInterval", 80 );
	SetIGlobalVar( "AI.Paratroopers.PlaneParadropIntervalPerpMin", 20 );
	SetIGlobalVar( "AI.Paratroopers.PlaneParadropIntervalPerpMax", 50 );
	SetIGlobalVar( "AI.Paratroopers.ParatrooperGroundScanPeriod", 200 );
	
	---- COMBAT SITUATION ----
	
	SetIGlobalVar( "AI.CombatSituation.Damage", 1500 );
	SetIGlobalVar( "AI.CombatSituation.TimeDamage", 10000 );
	SetIGlobalVar( "AI.CombatSituation.MovingEnemyMechNumber", 2 );
	SetIGlobalVar( "AI.CombatSituation.MovingEnemyInfantryNumber", 20 );

	---- REVEAL INFO ---- check for unit etype string names
	
	SetFGlobalVar( "AI.RevealInfo.arm_light.Query", 0.1 );
	SetFGlobalVar( "AI.RevealInfo.arm_light.MovingOff", 1.0 );
	SetIGlobalVar( "AI.RevealInfo.arm_light.Distance", 64 );
	SetIGlobalVar( "AI.RevealInfo.arm_light.Time", 1000 );
	SetFGlobalVar( "AI.RevealInfo.arm_medium.Query", 1.0 ); -- 0.2
	SetFGlobalVar( "AI.RevealInfo.arm_medium.MovingOff", 0.5 );
	SetIGlobalVar( "AI.RevealInfo.arm_medium.Distance", 128 );
	SetIGlobalVar( "AI.RevealInfo.arm_medium.Time", 2000 );
	SetFGlobalVar( "AI.RevealInfo.arm_heavy.Query", 0.3 );
	SetFGlobalVar( "AI.RevealInfo.arm_heavy.MovingOff", 0.4 );
	SetIGlobalVar( "AI.RevealInfo.arm_heavy.Distance", 160 );
	SetIGlobalVar( "AI.RevealInfo.arm_heavy.Time", 3000 );
	SetFGlobalVar( "AI.RevealInfo.arm_super.Query", 0.5 );
	SetFGlobalVar( "AI.RevealInfo.arm_super.MovingOff", 0.2 );
	SetIGlobalVar( "AI.RevealInfo.arm_super.Distance", 192 );
	SetIGlobalVar( "AI.RevealInfo.arm_super.Time", 5000 );	
	SetFGlobalVar( "AI.RevealInfo.spg_antitank.Query", 0.2 );
	SetFGlobalVar( "AI.RevealInfo.spg_antitank.MovingOff", 0.5 );
	SetIGlobalVar( "AI.RevealInfo.spg_antitank.Distance", 128 );
	SetIGlobalVar( "AI.RevealInfo.spg_antitank.Time", 2000 );
	SetFGlobalVar( "AI.RevealInfo.spg_assault.Query", 0.3 );
	SetFGlobalVar( "AI.RevealInfo.spg_assault.MovingOff", 0.4 );
	SetIGlobalVar( "AI.RevealInfo.spg_assault.Distance", 160 );
	SetIGlobalVar( "AI.RevealInfo.spg_assault.Time", 3000 );	
	SetFGlobalVar( "AI.RevealInfo.spg_aagun.Query", 0.1 );
	SetFGlobalVar( "AI.RevealInfo.spg_aagun.MovingOff", 1.0 );
	SetIGlobalVar( "AI.RevealInfo.spg_aagun.Distance", 64 );
	SetIGlobalVar( "AI.RevealInfo.spg_aagun.Time", 1000 );	
	SetFGlobalVar( "AI.RevealInfo.spg_super.Query", 0.5 );
	SetFGlobalVar( "AI.RevealInfo.spg_super.MovingOff", 0.2 );
	SetIGlobalVar( "AI.RevealInfo.spg_super.Distance", 192 );
	SetIGlobalVar( "AI.RevealInfo.spg_super.Time", 5000 );	
	SetFGlobalVar( "AI.RevealInfo.art_gun.Query", 0.2 );
	SetFGlobalVar( "AI.RevealInfo.art_gun.MovingOff", 0.5 );
	SetIGlobalVar( "AI.RevealInfo.art_gun.Distance", 64 );
	SetIGlobalVar( "AI.RevealInfo.art_gun.Time", 1500 );	
	SetFGlobalVar( "AI.RevealInfo.art_mortar.Query", 0.1 );
	SetFGlobalVar( "AI.RevealInfo.art_mortar.MovingOff", 1.0 );
	SetIGlobalVar( "AI.RevealInfo.art_mortar.Distance", 64 );
	SetIGlobalVar( "AI.RevealInfo.art_mortar.Time", 1000 );
	SetFGlobalVar( "AI.RevealInfo.art_rocket.Query", 0 );
	SetFGlobalVar( "AI.RevealInfo.art_rocket.MovingOff", 0 );
	SetIGlobalVar( "AI.RevealInfo.art_rocket.Distance", 0 );
	SetIGlobalVar( "AI.RevealInfo.art_rocket.Time", 0 );
	SetFGlobalVar( "AI.RevealInfo.art_heavy_gun.Query", 0.3 );
	SetFGlobalVar( "AI.RevealInfo.art_heavy_gun.MovingOff", 0.4 );
	SetIGlobalVar( "AI.RevealInfo.art_heavy_gun.Distance", 160 );
	SetIGlobalVar( "AI.RevealInfo.art_heavy_gun.Time", 3000 );
	SetFGlobalVar( "AI.RevealInfo.art_super.Query", 0.5 );
	SetFGlobalVar( "AI.RevealInfo.art_super.MovingOff", 0.2 );
	SetIGlobalVar( "AI.RevealInfo.art_super.Distance", 192 );
	SetIGlobalVar( "AI.RevealInfo.art_super.Time", 5000 );
	SetFGlobalVar( "AI.RevealInfo.art_heavy_mg.Query", 0.1 );
	SetFGlobalVar( "AI.RevealInfo.art_heavy_mg.MovingOff", 1.0 );
	SetIGlobalVar( "AI.RevealInfo.art_heavy_mg.Distance", 64 );
	SetIGlobalVar( "AI.RevealInfo.art_heavy_mg.Time", 1000 );	
	SetFGlobalVar( "AI.RevealInfo.art_aagun.Query", 0.2 );
	SetFGlobalVar( "AI.RevealInfo.art_aagun.MovingOff", 0.5 );
	SetIGlobalVar( "AI.RevealInfo.art_aagun.Distance", 128 );
	SetIGlobalVar( "AI.RevealInfo.art_aagun.Time", 2000 );
	SetFGlobalVar( "AI.RevealInfo.train_armor.Query", 0.3 );
	SetFGlobalVar( "AI.RevealInfo.train_armor.MovingOff", 0.4 );
	SetIGlobalVar( "AI.RevealInfo.train_armor.Distance", 160 );
	SetIGlobalVar( "AI.RevealInfo.train_armor.Time", 3000 );	
	
	---- DIFFICULTY LEVELS ----
	-- easy --
	SetFGlobalVar( "AI.Levels.Easy.Friends.Silhouette", 1.0 );
	SetFGlobalVar( "AI.Levels.Easy.Friends.Piercing", 2.0 );
	SetFGlobalVar( "AI.Levels.Easy.Friends.Damage", 2.0 );
	SetFGlobalVar( "AI.Levels.Easy.Friends.RotateSpeed", 2.0 );
	SetFGlobalVar( "AI.Levels.Easy.Friends.Dispersion", 0.7 );
	
	SetFGlobalVar( "AI.Levels.Easy.Enemies.Silhouette", 1.0 );
	SetFGlobalVar( "AI.Levels.Easy.Enemies.Piercing", 0.8 );
	SetFGlobalVar( "AI.Levels.Easy.Enemies.Damage", 0.5 );
	SetFGlobalVar( "AI.Levels.Easy.Enemies.RotateSpeed", 0.5 );
	SetFGlobalVar( "AI.Levels.Easy.Enemies.Dispersion", 1.2 );
	-- normal --
	SetFGlobalVar( "AI.Levels.Normal.Friends.Silhouette", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Friends.Piercing", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Friends.Damage", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Friends.RotateSpeed", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Friends.Dispersion", 1.0 );
	
	SetFGlobalVar( "AI.Levels.Normal.Enemies.Silhouette", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Enemies.Piercing", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Enemies.Damage", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Enemies.RotateSpeed", 1.0 );
	SetFGlobalVar( "AI.Levels.Normal.Enemies.Dispersion", 1.0 );
	-- hard --
	SetFGlobalVar( "AI.Levels.Hard.Friends.Silhouette", 1.0 );
	SetFGlobalVar( "AI.Levels.Hard.Friends.Piercing", 0.8 );
	SetFGlobalVar( "AI.Levels.Hard.Friends.Damage", 0.8 );
	SetFGlobalVar( "AI.Levels.Hard.Friends.RotateSpeed", 1.0 );
	SetFGlobalVar( "AI.Levels.Hard.Friends.Dispersion", 1.0 );
	
	SetFGlobalVar( "AI.Levels.Hard.Enemies.Silhouette", 0.8 );
	SetFGlobalVar( "AI.Levels.Hard.Enemies.Piercing", 1.2 );
	SetFGlobalVar( "AI.Levels.Hard.Enemies.Damage", 1.2 );
	SetFGlobalVar( "AI.Levels.Hard.Enemies.RotateSpeed", 1.0 );
	SetFGlobalVar( "AI.Levels.Hard.Enemies.Dispersion", 1.0 );

	---- FLAGS ----
	
	SetIGlobalVar( "AI.Flags.Radius", 320 );
	SetIGlobalVar( "AI.Flags.PointsSpeed", 1 );
	SetIGlobalVar( "AI.Flags.PointsToReinforcement", 150 );
	SetIGlobalVar( "AI.Flags.TimeToCapture", 5000 );
	SetIGlobalVar( "AI.Flags.PlayerPointsSpeed", 1 );
end;

--GeneralConsts();
	SetIGlobalVar( "AI.General.Artillery.TimeToForgetAntiArtillery", 20000 );
	SetIGlobalVar( "AI.General.Artillery.TimeToForgetUnit", 60000 );
	SetIGlobalVar( "AI.General.Artillery.TimeToArtilleryFire", 0 );
	SetFGlobalVar( "AI.General.Artillery.ProbabilityToShootAfterArtilleryFire", 1.0 );
	SetIGlobalVar( "AI.General.Artillery.ShootsOfArtilleryFire", 10 );
	SetIGlobalVar( "AI.General.Artillery.MinWeightToArtilleryFire", 3 ); --was 50
	SetIGlobalVar( "AI.General.TimeDontSeeTheEnemyBeforeForget", 30000 );
	SetFGlobalVar( "AI.General.PlayerForceMultiply", 2.0 );
	Trace( GetIGlobalVar( "AI.General.Artillery.MinWeightToArtilleryFire", -123 ) ); --was 50
AIconsts();
Trace("Consts loaded.");