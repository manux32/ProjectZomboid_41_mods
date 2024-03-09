
local lastEnteredVehicle = nil
local lastEngineQuality = -1
local lastEngineCondition = -1
local damageReductionFactor = 0.1

local function ShowBatteryStatus(character, vehicle)
	local battery = vehicle:getPartById("Battery")
	if battery and battery:getInventoryItem() then
		local batLevel = battery:getInventoryItem():getUsedDelta() * 100
		local roundedBatLevel = tonumber(string.format("%.2f", batLevel))
		local textToDisplay = "Battery Level = " .. tostring(roundedBatLevel) .. "%"
		
		local textColor = {["r"]=0.0, ["g"]=1.0, ["b"]=0.0}
		if batLevel < 65.0 then
			textColor = {["r"]=1.0, ["g"]=1.0, ["b"]=0.0}
		end
		if batLevel < 35.0 then
			textColor = {["r"]=1.0, ["g"]=0.2, ["b"]=0.2}
		end
		
		--character:Say(textToDisplay, 0.0, 1.0, 0.0, UIFont["Medium"], 0, "radio")
		character:Say(textToDisplay, textColor["r"], textColor["g"], textColor["b"], UIFont["Medium"], 0, "radio")
	end
end

local function onEnterVehicle_SaveCurrentEngineCondition(character)
	local vehicle = character:getVehicle()
	if instanceof(character, 'IsoPlayer') and character:isLocalPlayer() then
		ShowBatteryStatus(character, vehicle)
		
		lastEnteredVehicle = vehicle
		lastEngineQuality = vehicle:getEngineQuality()
		
		local engine = vehicle:getPartById("Engine")
		lastEngineCondition = engine:getCondition()
	end
end

local function onExitVehicle_MinimizeEngineDamage(character)
	if instanceof(character, 'IsoPlayer') and character:isLocalPlayer() then
		ShowBatteryStatus(character, lastEnteredVehicle)
		
		-- Engine Quality
		local curEngineQuality = lastEnteredVehicle:getEngineQuality()
		local engineQualityDelta = lastEngineQuality - curEngineQuality
		local newEngineQuality = lastEngineQuality - (engineQualityDelta * damageReductionFactor)
		lastEnteredVehicle:setEngineFeature(newEngineQuality, lastEnteredVehicle:getEngineLoudness(), lastEnteredVehicle:getEnginePower())
		
		-- Engine Condition
		local engine = lastEnteredVehicle:getPartById("Engine")
		local curEngineCondition = engine:getCondition()
		local engineConditionDelta = lastEngineCondition - curEngineCondition
		local newEngineCondition = lastEngineCondition - (engineConditionDelta * damageReductionFactor)
		engine:setCondition(newEngineCondition)
		
		lastEnteredVehicle = nil
	end
end


local function OnUseVehicle(character, vehicle, pressedNotTapped)
	print("BAZWELL !!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	-- if vehicle:isEngineRunning() then
		-- ShowBatteryStatus(character, vehicle)
	-- end
	ShowBatteryStatus(character, vehicle)
end


Events.OnEnterVehicle.Add(onEnterVehicle_SaveCurrentEngineCondition)
Events.OnExitVehicle.Add(onExitVehicle_MinimizeEngineDamage)
--Events.OnUseVehicle.Add(OnUseVehicle) -- doesn't work