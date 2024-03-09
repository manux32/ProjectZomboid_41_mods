
local function IsOnPoweredSquare(isoOrPlayer)
    return ((SandboxVars.AllowExteriorGenerator and isoOrPlayer:getSquare():haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and not isoOrPlayer:getSquare():isOutside()))
end

-- [Debug]: Debug Util to empty batteries charge when put in a crate container.
local function Debug_EmptyBatteries(inventory)
	if inventory:getType() == "crate" then
		local items = inventory:getItems()
		if items:size() > 0 then
			for i=0,items:size()-1 do
				local item = items:get(i)
				if item:getType() == "Battery" then
					item:setUsedDelta(0.0)
				end
			end
		end
	end
end

local function CreateIsoAttachSprite(spriteName)
	local isoSprite = getSprite(spriteName)
	isoSprite:setName(spriteName)
	local spriteInstance = IsoSpriteInstance.get(isoSprite)
	local attachSprite = ArrayList.new(4)
	result = {[0]=attachSprite, [1]=spriteInstance}
	return result
end

-- Using pre-created attachSprites didn't work anymore when teleporting to a vehicle interior. Was mixing up tile overlays with random crap.
--local greenLightSpriteData = CreateIsoAttachSprite("manux_Tiles_Devices_01_4")
--local redLightSpriteData = CreateIsoAttachSprite("manux_Tiles_Devices_01_3")

local function SetIsoAttachSprite(isoObject, spriteData)
	attachSprite = spriteData[0]
	isoObject:setAttachedAnimSprite(attachSprite)
	attachSprite:add(spriteData[1])
end

local startGameSpritesInit = {}
local chargeFactor = 0.15 -- The higher the number, the less time it takes to charge batteries.

local function UpdateBatteries_OLD(character)
    if not character then return end
    local playerNum = character and character:getPlayerNum() or -1;
	
    -- Get all the surrounding container inventories of the player
    for i,v in ipairs(getPlayerLoot(playerNum).inventoryPane.inventoryPage.backpacks) do
		--print ("UpdateBatteries v.inventory Type = ", v.inventory:getType())
		
		-- [Debug]: Debug Util to empty batteries charge when put in a crate container.
		Debug_EmptyBatteries(v.inventory)
		
		-- It's a Battery Charger container!
		if v.inventory:getType() == "SmallBatteryCharger" then
			local chargerIso = v.inventory:getParent()	-- get the Charger Tile
			local items = v.inventory:getItems()
			local itemsSize = items:size()
			
			if not chargerIso:getModData().lastBatList then
				chargerIso:getModData().lastBatList = {}
			end
			
			-- Do we have items inside?
			local curBatList = {}
			if itemsSize > 0 then
				local curTime = getGameTime():getWorldAgeHours() -- can also use getMinutesStamp() but it goes by slow steps.
				--print("Game WorldAgeHours = ", getGameTime():getWorldAgeHours())
				local hasPower = IsOnPoweredSquare(chargerIso)
				--print("hasPower = ", hasPower)
				
				if not chargerIso:getModData().lastPowerStatus then
					chargerIso:getModData().lastPowerStatus = "nil"
				end
				
				-- Power status display
				--if chargerIso:getModData().lastPowerStatus ~= tostring(hasPower) then
				if not startGameSpritesInit[chargerIso] or chargerIso:getModData().lastPowerStatus ~= tostring(hasPower) then
					if hasPower then
						local greenLightSpriteData = CreateIsoAttachSprite("manux_Tiles_Devices_01_4")
						SetIsoAttachSprite(chargerIso, greenLightSpriteData)
						character:Say("Charger has Power!", 0.0, 1.0, 0.0, UIFont["Medium"], 0, "radio")
					else
						local redLightSpriteData = CreateIsoAttachSprite("manux_Tiles_Devices_01_3")
						SetIsoAttachSprite(chargerIso, redLightSpriteData)
						character:Say("No Power Here!", 1.0, 0.4, 0.4, UIFont["Medium"], 0, "radio")
					end
					startGameSpritesInit[chargerIso] = true
				end
				chargerIso:getModData().lastPowerStatus = tostring(hasPower)
				
				-- Find Batteries
				for i=0,itemsSize-1 do
					local item = items:get(i)
					
					-- It's a Battery!
					if item:getType() == "Battery" then
						curBatList[item:getID()] = 1
						local curCharge = item:getUsedDelta()
						
						if hasPower and curCharge < 1.0 then
							-- Timer init and reset: Resets batteries Timer if they were taken out and put back in a charger.
							if not item:getModData().BatLastTime or not chargerIso:getModData().lastBatList[item:getID()] then
								item:getModData().BatLastTime = curTime
							end
							-- Add new charge
							local newDelta = curTime - item:getModData().BatLastTime
							if newDelta > 0.0 then
								item:setUsedDelta(curCharge + (newDelta * chargeFactor))
							end
							item:getModData().BatLastTime = curTime
						end
					end
				end
			else
				chargerIso:setAttachedAnimSprite(nil)
				chargerIso:getModData().lastPowerStatus = "nil"
			end
			chargerIso:getModData().lastBatList = curBatList
		end
    end
end

local function UpdateBatteries(batChargerInventory)
	local chargerIso = batChargerInventory:getParent()	-- get the Charger Tile
	local items = batChargerInventory:getItems()
	local itemsSize = items:size()
	
	if not chargerIso:getModData().lastBatList then
		chargerIso:getModData().lastBatList = {}
	end
	
	-- Do we have items inside?
	local curBatList = {}
	if itemsSize > 0 then
		local curTime = getGameTime():getWorldAgeHours() -- can also use getMinutesStamp() but it goes by slow steps.
		--print("Game WorldAgeHours = ", getGameTime():getWorldAgeHours())
		local hasPower = IsOnPoweredSquare(chargerIso)
		--print("hasPower = ", hasPower)
		
		if not chargerIso:getModData().lastPowerStatus then
			chargerIso:getModData().lastPowerStatus = "nil"
		end
		
		-- Power status display
		--if chargerIso:getModData().lastPowerStatus ~= tostring(hasPower) then
		if not startGameSpritesInit[chargerIso] or chargerIso:getModData().lastPowerStatus ~= tostring(hasPower) then
			if hasPower then
				local greenLightSpriteData = CreateIsoAttachSprite("manux_Tiles_Devices_01_4")
				SetIsoAttachSprite(chargerIso, greenLightSpriteData)
				getPlayer():Say("Charger has Power!", 0.0, 1.0, 0.0, UIFont["Medium"], 0, "radio")
			else
				local redLightSpriteData = CreateIsoAttachSprite("manux_Tiles_Devices_01_3")
				SetIsoAttachSprite(chargerIso, redLightSpriteData)
				getPlayer():Say("No Power Here!", 1.0, 0.4, 0.4, UIFont["Medium"], 0, "radio")
			end
			startGameSpritesInit[chargerIso] = true
		end
		chargerIso:getModData().lastPowerStatus = tostring(hasPower)
		
		-- Find Batteries
		for i=0,itemsSize-1 do
			local item = items:get(i)
			
			-- It's a Battery!
			if item:getType() == "Battery" then
				curBatList[item:getID()] = 1
				local curCharge = item:getUsedDelta()
				
				if hasPower and curCharge < 1.0 then
					-- Timer init and reset: Resets batteries Timer if they were taken out and put back in a charger.
					if not item:getModData().BatLastTime or not chargerIso:getModData().lastBatList[item:getID()] then
						item:getModData().BatLastTime = curTime
					end
					-- Add new charge
					local newDelta = curTime - item:getModData().BatLastTime
					if newDelta > 0.0 then
						item:setUsedDelta(curCharge + (newDelta * chargeFactor))
					end
					item:getModData().BatLastTime = curTime
				end
			end
		end
	else
		chargerIso:setAttachedAnimSprite(nil)
		chargerIso:getModData().lastPowerStatus = "nil"
	end
	chargerIso:getModData().lastBatList = curBatList
end

local function GetChargers(inventoryList)
	-- If there are chargers nearby, update their batteries
	local allChargers = {}
	local hasCharger = false
	for i,v in ipairs(inventoryList) do	
		
		-- [Debug]: Debug Util to empty batteries charge when put in a crate container.
		Debug_EmptyBatteries(v.inventory)
		
		if v.inventory:getType() == "SmallBatteryCharger" then
			hasCharger = true
			allChargers[i] = v.inventory
			UpdateBatteries(v.inventory)
		end
	end
	
	if hasCharger == false then
		return false
	else
		return allChargers
	end
end

local function UpdateChargers(inventoryList)
	-- Does player square have a charger registered?
	local player = getPlayer()
	local square = player:getSquare()
	if square ~= nil then
		local hasCharger = square:getModData().hasCharger
		-- print("    - Pos X =", square:getX())
		-- print("    - Pos Y =", square:getY())
		-- print("    - Pos Z =", square:getZ())
		
		-- If there's a charger registered, find it/them and update them.
		if hasCharger then
			-- If there are chargers nearby, update their batteries
			local reallyHasCharger = false
			for i,v in ipairs(inventoryList) do	
				
				-- [Debug]: Debug Util to empty batteries charge when put in a crate container.
				--Debug_EmptyBatteries(v.inventory)
				
				if v.inventory:getType() == "SmallBatteryCharger" then
					reallyHasCharger = true
					UpdateBatteries(v.inventory)
				end
			end
			
			-- print("----------------- UpdateChargers -----------------")
			-- print("HAS CHARGER = ", hasCharger)
			-- print("reallyHasCharger = ", reallyHasCharger)
			-- print("--------------------------------------------------")
			
			-- Doesn't work, sets squares that shouldn't to false. Timing or square position issue maybe?
			-- if not reallyHasCharger then
				-- player:getSquare():getModData().hasCharger = false
			-- end
		end
	else
		-- Sometimes the player square is nil, like when teleporting to a vehicle interior.
		--print("Player square is NIL!")
	end
end

local function OnRefreshInventoryWindowContainers(iSInventoryPage, state)
	-- When availlable inventories change, update battery chargers that are nearby.
	--print("---------- OnRefreshInventoryWindowContainers ----------")
	--print("iSInventoryPage = ", iSInventoryPage)
	--print("state = ", state)
	UpdateChargers(iSInventoryPage.backpacks)
	--print("--------------------------------------------------------")
end

local function EveryTenMinutes()
	-- Also update batteries when player is idle near a charger.
	--print("----------------- EveryTenMinutes -----------------")
	UpdateChargers(getPlayerLoot(getPlayer():getPlayerNum()).inventoryPane.inventoryPage.backpacks)
	--print("---------------------------------------------------")
end

local function SetAllNearbySquaresHasChargerState(curSquare, newState)
	-- Sets all nearby squares' modData to the new .hasCharger state.
	curSquare:getModData().hasCharger = newState
	local curX = curSquare:getX()
	local curY = curSquare:getY()
	local curZ = curSquare:getZ()
	
	local otherSquare = curSquare:getCell():getGridSquare(curX + 1, curY, curZ)
	otherSquare:getModData().hasCharger = newState
	otherSquare = curSquare:getCell():getGridSquare(curX - 1, curY, curZ)
	otherSquare:getModData().hasCharger = newState
	otherSquare = curSquare:getCell():getGridSquare(curX, curY + 1, curZ)
	otherSquare:getModData().hasCharger = newState
	otherSquare = curSquare:getCell():getGridSquare(curX, curY - 1, curZ)
	otherSquare:getModData().hasCharger = newState
	
	otherSquare = curSquare:getCell():getGridSquare(curX + 1, curY + 1, curZ)
	otherSquare:getModData().hasCharger = newState
	otherSquare = curSquare:getCell():getGridSquare(curX + 1, curY - 1, curZ)
	otherSquare:getModData().hasCharger = newState
	otherSquare = curSquare:getCell():getGridSquare(curX - 1, curY + 1, curZ)
	otherSquare:getModData().hasCharger = newState
	otherSquare = curSquare:getCell():getGridSquare(curX - 1, curY - 1, curZ)
	otherSquare:getModData().hasCharger = newState
end

local function OnObjectAdded(object)
	-- Triggered when an object is added to the map.
	-- print("---------- OnObjectAdded ----------")
	-- print("object = ", object)
	-- print ("  - container = ", object:getContainer():getType())
	if object ~= nil and object:getContainer() ~= nil then
		if object:getContainer():getType() == "SmallBatteryCharger" then
			SetAllNearbySquaresHasChargerState(object:getSquare(), true)
		end
	end
	--print("-----------------------------------")
end

local function OnTileRemoved(object)
	-- Triggered when a tile object has been removed.
	-- print("---------- OnTileRemoved ----------")
	-- print("object = ", object)
	if object ~= nil and object:getContainer() ~= nil then
		--print ("  - container = ", object:getContainer():getType())
		if object:getContainer():getType() == "SmallBatteryCharger" then
			SetAllNearbySquaresHasChargerState(object:getSquare(), false)
		end
	end
	--print("-----------------------------------")
end


Events.OnRefreshInventoryWindowContainers.Add(OnRefreshInventoryWindowContainers)
Events.EveryTenMinutes.Add(EveryTenMinutes)
Events.OnObjectAdded.Add(OnObjectAdded)
Events.OnTileRemoved.Add(OnTileRemoved)
--Events.OnPlayerUpdate.Add(UpdateBatteries)
