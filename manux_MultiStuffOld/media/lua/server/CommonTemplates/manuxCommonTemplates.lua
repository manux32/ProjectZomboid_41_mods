-- require 'CommonTemplates/CommonTemplates.lua'

ManuxCommonTemplates = {}
ManuxCommonTemplates.Init = {}
ManuxCommonTemplates.Update = {}


--***********************************************************
--**                                                       **
--**                    Fridge n Freezer                   **
--**                                                       **
--***********************************************************

--local FridgeBatteryChange = -0.000020
local FridgeBatteryChange = -0.000010

function ManuxCommonTemplates.Update.Freezer(vehicle, part, elapsedMinutes)
	-- print("CommonTemplates.Update.Freezer")
	local currentTemp = part:getItemContainer():getTemprature()
	-- print("Freezer currentTemp: ", currentTemp)
	--local minTemp = 0.2
	local minTemp = 0.1
	local maxTemp = 1.0
	if part:getInventoryItem() and part:getItemContainer() then
		if part:getModData().tsarslib.active and vehicle:getBatteryCharge() > 0.00010 then
			part:setLightActive(true)
			
			-- manux new
			part:getItemContainer():setCustomTemperature(minTemp)
			
			local foodItems = part:getItemContainer():getItemsFromCategory("Food")
			local newFreezerTable = {}
			for i=1, foodItems:size() do
				local item = foodItems:get(i-1)
				if item:canBeFrozen() then
					local prevAge = part:getModData().tsarslib.freezer[item:getID()]
					if prevAge then
						item:setAge(prevAge + (item:getAge() - prevAge) * 0.02)
					end
					item:setFreezingTime(100)
					item:freeze()
					newFreezerTable[item:getID()] = item:getAge()	
				end
			end
			part:getModData().tsarslib.freezer = newFreezerTable
			
			if not vehicle:isEngineRunning() then
				VehicleUtils.chargeBattery(vehicle, FridgeBatteryChange * elapsedMinutes)
			end
			-- manux new end
			
		else
			if currentTemp < maxTemp then
				part:getItemContainer():setCustomTemperature(currentTemp + (0.04 * elapsedMinutes))
			elseif currentTemp >= maxTemp then
				part:getItemContainer():setCustomTemperature(maxTemp)
				part:setLightActive(false)
			end
		end
	end
end
CommonTemplates.Update.Freezer = ManuxCommonTemplates.Update.Freezer;


--local BatteryChargerBatteryChange = -0.000010
local BatteryChargerBatteryChange = -0.000001

--***********************************************************
--**                                                       **
--**                     BatteryCharger                    **
--**                                                       **
--***********************************************************

function ManuxCommonTemplates.Update.BatteryCharger(trailer, part, elapsedMinutes)
	if part:getInventoryItem() then
		local chargeOld = part:getInventoryItem():getUsedDelta()
		local charge = chargeOld
		-- Running the engine charges the battery
		if elapsedMinutes > 0 and trailer:getBatteryCharge() > 0.00010 then
			charge = math.min(charge + elapsedMinutes * 0.0005, 1.0)
		end
		if charge ~= chargeOld then
			part:getInventoryItem():setUsedDelta(charge)
			if VehicleUtils.compareFloats(chargeOld, charge, 2) then
				trailer:transmitPartUsedDelta(part)
			end
			if not trailer:isEngineRunning() then
				VehicleUtils.chargeBattery(trailer, BatteryChargerBatteryChange * elapsedMinutes)
			end
		end
	end
end
CommonTemplates.Update.BatteryCharger = ManuxCommonTemplates.Update.BatteryCharger;