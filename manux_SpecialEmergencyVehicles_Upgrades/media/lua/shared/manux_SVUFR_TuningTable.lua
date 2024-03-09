require "ATA2TuningTable"
require "SVUFR_TuningTable"

local function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

local NewCarTuningTable = {}
-- Entries
-- NewCarTuningTable["TemplateFili"] = {
	-- addPartsFromVehicleScript = "",
	-- parts = {}
-- }
NewCarTuningTable["86bounderHAzardmaterials"] = {
    addPartsFromVehicleScript = "",
    parts = {}
}
NewCarTuningTable["86econolinervFBIMHQLG"] = {
    addPartsFromVehicleScript = "",
    parts = {}
}
NewCarTuningTable["86econolinervLVMHQLG"] = {
    addPartsFromVehicleScript = "",
    parts = {}
}

-- 86bounderHAzardmaterials - RV, expanded rack and stupid levels of annoying to work with
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2ProtectionWindshield"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindshield"])
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2ProtectionWindshieldRear"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindshieldRear"])
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2Bullbar"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2Bullbar"])
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2ProtectionTrunk"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionTrunk"])
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2ProtectionHood"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionHood"])
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2ProtectionDoorMiddleRight"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionDoorMiddleRight"])
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2InteractiveTrunkRoofRack"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2InteractiveTrunkRoofRack"])
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2InteractiveTrunkRoofRack"].Default.containerCapacity = 100
NewCarTuningTable["86bounderHAzardmaterials"].parts["ATA2ProtectionWheels"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWheels"])


-- 86econolinervFBIMHQLG - RV, expanded rack and stupid levels of annoying to work with
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionWindowFrontLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindowFrontLeft"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionWindowFrontRight"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindowFrontRight"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionWindowMiddleLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindowMiddleLeft"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionWindshield"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindshield"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionWindshieldRear"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindshieldRear"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2Bullbar"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2Bullbar"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionTrunk"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionTrunk"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionTrunk"].Light.protection = {"TruckBed", "GasTank"}
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionTrunk"].Heavy.protection = {"TruckBed", "GasTank"}
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionHood"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionHood"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionDoorFrontLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionDoorFrontLeft"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionDoorFrontRight"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionDoorFrontRight"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionDoorMiddleLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionDoorMiddleLeft"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2InteractiveTrunkRoofRack"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2InteractiveTrunkRoofRack"])
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2InteractiveTrunkRoofRack"].Default.containerCapacity = 100
NewCarTuningTable["86econolinervFBIMHQLG"].parts["ATA2ProtectionWheels"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWheels"])

-- 86econolinervLVMHQLG - RV, expanded rack and stupid levels of annoying to work with
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionWindowFrontLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindowFrontLeft"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionWindowFrontRight"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindowFrontRight"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionWindowMiddleLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindowMiddleLeft"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionWindshield"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindshield"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionWindshieldRear"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWindshieldRear"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2Bullbar"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2Bullbar"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionTrunk"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionTrunk"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionTrunk"].Light.protection = {"TruckBed", "GasTank"}
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionTrunk"].Heavy.protection = {"TruckBed", "GasTank"}
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionHood"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionHood"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionDoorFrontLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionDoorFrontLeft"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionDoorFrontRight"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionDoorFrontRight"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionDoorMiddleLeft"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionDoorMiddleLeft"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2InteractiveTrunkRoofRack"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2InteractiveTrunkRoofRack"])
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2InteractiveTrunkRoofRack"].Default.containerCapacity = 100
NewCarTuningTable["86econolinervLVMHQLG"].parts["ATA2ProtectionWheels"] = copy(ATA2TuningTable["TemplateFili"].parts["ATA2ProtectionWheels"])

ATA2Tuning_AddNewCars(NewCarTuningTable)