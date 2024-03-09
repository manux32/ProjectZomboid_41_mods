if VehicleZoneDistribution then

    VehicleZoneDistribution.parkingstall.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 2}
    VehicleZoneDistribution.trailerpark.vehicles["Base.ArmoredMotorhome"] = {index = 4, spawnChance = 3}
    VehicleZoneDistribution.bad.vehicles["Base.ArmoredMotorhome"] = {index = 0, spawnChance = 3}
    VehicleZoneDistribution.junkyard.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 2}
    VehicleZoneDistribution.ranger.vehicles["Base.ArmoredMotorhome"] = {index = 0, spawnChance = 3}
    VehicleZoneDistribution.good.vehicles["Base.ArmoredMotorhome"] = {index = 0, spawnChance = 2}
    -- Trafficjam spawns --
    VehicleZoneDistribution.trafficjamw.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 10}
    VehicleZoneDistribution.trafficjame.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 5}
    VehicleZoneDistribution.trafficjamn.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 6}
    VehicleZoneDistribution.trafficjams.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 5}
    -- Military spawn --
    VehicleZoneDistribution.military = VehicleZoneDistribution.military or {}
    VehicleZoneDistribution.military.vehicles = VehicleZoneDistribution.military.vehicles or {}
    VehicleZoneDistribution.military.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 5}
    VehicleZoneDistribution.military.vehicles["Base.ArmoredMotorhome"] = {index = -1, spawnChance = 6}
end