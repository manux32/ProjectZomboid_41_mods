
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


local chargeFactor = 0.15 -- The higher the number, the less time it takes to charge batteries.
local powerDisplayLastTime = 0
local powerDisplayMinDelay = 0.01 -- To not repeat the power status display when player stays close to the charger.

local function UpdateBatteries(character)
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
				
				-- Power status display
				if curTime - powerDisplayLastTime > powerDisplayMinDelay then
					if hasPower then
						character:Say("Charger has Power!", 0.0, 1.0, 0.0, UIFont["Medium"], 0, "radio")
					else
						character:Say("No Power Here!", 1.0, 0.2, 0.2, UIFont["Medium"], 0, "radio")
					end
				end
				powerDisplayLastTime = curTime
				
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
			end
			chargerIso:getModData().lastBatList = curBatList
		end
    end
end

function UpdateBatteries_Good_NotClean(character)
    if not character then return end
    local playerNum = character and character:getPlayerNum() or -1;
	
    -- get all the surrounding container inventories of the player
    for i,v in ipairs(getPlayerLoot(playerNum).inventoryPane.inventoryPage.backpacks) do
		--print ("UpdateBatteries v.inventory Type = ", v.inventory:getType())
		
		-- TMP: Debug Util to empty batteries when put in a crate containers.
		Debug_EmptyBatteries(v.inventory)
		
		--if v.inventory:getType() == "SmallBatteryCharger" and v.inventory:getItems():size() > 0 then
		if v.inventory:getType() == "SmallBatteryCharger" then
			local chargerIso = v.inventory:getParent()
			local hasPower = IsOnPoweredSquare(chargerIso)
			print("hasPower = ", hasPower)
			
			local curTime = getGameTime():getWorldAgeHours() -- can also use getMinutesStamp() but it goes by slow steps.
			--print("Game WorldAgeHours = ", getGameTime():getWorldAgeHours())
			
			local items = v.inventory:getItems()
			local itemsSize = items:size()
			--local curBatList = ArrayList.new()
			local curBatList = {}
			
			if not chargerIso:getModData().lastBatList then
				chargerIso:getModData().lastBatList = {}
				--chargerIso:getModData().lastItemSize = -1
			end
			
			if itemsSize > 0 then
				for i=0,itemsSize-1 do
					local item = items:get(i)
					if item:getType() == "Battery" then
						--curBatList:add(item:getID())
						curBatList[item:getID()] = 1
						local curCharge = item:getUsedDelta()
						--print("Current Charge = ", curCharge)
						
						if hasPower and curCharge < 1.0 then
							-- Timer init and reset.
							--if not item:getModData().BatLastCharge or item:getModData().BatLastCharge ~= curCharge then 
							--if not item:getModData().BatLastCharge or chargerIso:getModData():lastItemSize ~= itemsSize then 
							--if not item:getModData().BatLastCharge or not chargerIso:getModData().lastBatList[item:getID()] then
							if not item:getModData().BatLastTime or not chargerIso:getModData().lastBatList[item:getID()] then
								item:getModData().BatLastTime = curTime --- 0.01
								--item:getModData().BatLastCharge = curCharge
							end
							-- Add new charge
							local lastTime = item:getModData().BatLastTime
							local newDelta = curTime - lastTime
							if newDelta > 0.0 then
								item:setUsedDelta(curCharge + (newDelta * 3.0))
							end
							item:getModData().BatLastTime = curTime
							--item:getModData().BatLastCharge = curCharge
							--chargerIso:getModData():lastItemSize = itemsSize
						else
							-- Failsafe for when batteries are full or when power cuts out. It stops their timer so that it resets next time.
							--item:getModData().BatLastCharge = -1
							--item:getModData().BatLastCharge = nil
						end
					end
				end
			end
			chargerIso:getModData().lastBatList = curBatList
			--chargerIso:getModData().lastItemSize = itemsSize
		end
    end
end

local function CheckAllChargers()
	--if not getPlayer():getModData().BatteryChargers or getPlayer():getModData().BatteryChargers == nil then
	--local player = getSpecificPlayer(0)
	local player = getPlayer()
	--if not getPlayer():getModData().BatteryChargers then
	if not player:getModData().BatteryChargers then
		return
	end
	
	--allChargers = getPlayer():getModData().BatteryChargers
	allChargers = player:getModData().BatteryChargers
	for chargerIso, inventory in pairs(allChargers) do
		if inventory ~= nil then
			print ("CheckAllChargers inventory Type = ", inventory:getType())
			local hasPower = IsOnPoweredSquare(chargerIso)
			print("CheckAllChargers hasPower = ", hasPower)
			--CheckCharger(chargerIso, inventory)
		else
			print("CheckAllChargers: inventory = nil")
		end
	end
	
	-- for key, value in pairs(getPlayer():getModData().BatteryChargers) do
		-- print("CheckAllChargers Iter key = ", key)
		-- print("CheckAllChargers Iter value = ", value)
		-- local chargerIso = value
		-- CheckCharger(chargerIso)
	-- end
end

local function CheckCharger(chargerIso, inventory)
	local curTime = getGameTime():getWorldAgeHours()
	local hasPower = IsOnPoweredSquare(chargerIso)
	print("CheckCharger hasPower = ", hasPower)
	
	if hasPower then
		UpdateBatteries(chargerIso, inventory)
		chargerIso:getModData().lastChargeTime = curTime
	else
		chargerIso:getModData().lastChargeTime = -1
	end
	
	-- if not hasPower or not chargerIso:getModData().lastChargeTime then
		-- chargerIso:getModData().lastChargeTime = -1
	-- end
	
	-- if hasPower and chargerIso:getModData().lastChargeTime ~= -1 then
		-- chargerIso:getModData().lastChargeTime = curTime
	-- end
end

function GetNearbyBatteryChargers(character)
	if not character then 
		return 
	end
    local playerNum = character and character:getPlayerNum() or -1;
    -- get all the surrounding container inventories of the player
	local player = getPlayer()
	local containerList = {}
    for i,v in ipairs(getPlayerLoot(playerNum).inventoryPane.inventoryPage.backpacks) do
		--print ("GetNearbyBatteryChargers v.inventory Type = ", v.inventory:getType())
		
		-- TMP: Debug Util to empty batteries when put in a crate container.
		Debug_EmptyBatteries(v.inventory)
		
		-- Get Chargers
		if v.inventory:getType() == "SmallBatteryCharger" then
			
			if not player:getModData().BatteryChargers then
				player:getModData().BatteryChargers = {}
			end
			
			local chargerIso = v.inventory:getParent()
			
			-- Register Chargers
			--getPlayer():getModData().BatteryChargers[chargerIso:getId()] = chargerIso
			--character:getModData().BatteryChargers[chargerIso:getId()] = chargerIso
			if v.inventory:getItems():size() > 0 then
				player:getModData().BatteryChargers[chargerIso] = v.inventory
				containerList[chargerIso] = v.inventory
			else
				player:getModData().BatteryChargers[chargerIso] = nil
			end
			
		end
	end
	return containerList
end

function OnFillContainer(roomName, containerType, itemContainer)
	print("OnFillContainer container Type = ", itemContainer:getType())
	print("OnFillContainer container items size = ", itemContainer:getItems():size())
end

function UpdateBatteries2(character)
	--local nearbyContainers = GetNearbyBatteryChargers(character)
	--local nearbyContainers = GetNearbyBatteryChargers(getPlayer())
	local nearbyContainers = GetNearbyBatteryChargers(getSpecificPlayer(0))
	--GetNearbyBatteryChargers(character)
	--nearbyContainers = character:getModData().BatteryChargers
	for chargerIso, inventory in pairs(nearbyContainers) do
		--print ("UpdateBatteries2 inventory Type = ", inventory:getType())
		--print ("UpdateBatteries2 chargerIso Type = ", chargerIso:getType())
		local hasPower = IsOnPoweredSquare(chargerIso)
		--print("UpdateBatteries2 hasPower = ", hasPower)
	end
end

function UpdateBatteries_Fail(chargerIso, inventory)
	local curTime = getGameTime():getWorldAgeHours()
	local items = inventory:getItems()
	if items:size() > 0 then
		for i=0,items:size()-1 do
			local item = items:get(i)
			--print("    UpdateBatteries: Charger Item Type = ", item:getType())
			if item:getType() == "Battery" then
				--print("Battery ID = ", item:getID())
				--print("Battery Charge = ", item:getUsedDelta())
				
				local lastTime = chargerIso:getModData().lastChargeTime
				
				if lastTime ~= -1 and item:getUsedDelta() < 1.0 then
					if not item:getModData().BatLastCharge or item:getModData().BatLastCharge ~= item:getUsedDelta() then 
						--item:getModData().BatLastTime = curTime
						item:getModData().BatLastCharge = item:getUsedDelta()
					end
					--local lastTime = item:getModData().BatLastTime
					local newDelta = curTime - lastTime
					if newDelta > 0.0 then
						item:setUsedDelta(item:getUsedDelta() + (newDelta * 0.8))
					end
					--item:getModData().BatLastTime = curTime
					item:getModData().BatLastCharge = item:getUsedDelta()
				-- else
					-- item:getModData().BatLastCharge = -1
				end
			end
		end
	end
end

function UpdateBatteries_old(character)
    if not character then return end
    local playerNum = character and character:getPlayerNum() or -1;
    -- get all the surrounding container inventories of the player
	
    for i,v in ipairs(getPlayerLoot(playerNum).inventoryPane.inventoryPage.backpacks) do
		--print ("UpdateBatteries v.inventory Type = ", v.inventory:getType())
		
		-- TMP: Debug Util to empty batteries when put in a crate container.
		Debug_EmptyBatteries(v.inventory)
		
		if v.inventory:getType() == "SmallBatteryCharger" then
			
			if not character:getModData().BatteryChargers then
				character:getModData().BatteryChargers = {}
			end
			
			local chargerIso = v.inventory:getParent()
			
			--getPlayer():getModData().BatteryChargers[chargerIso:getId()] = chargerIso
			character:getModData().BatteryChargers[chargerIso:getId()] = chargerIso
			
			--------------- STOPPED HERE --------------
			CheckCharger(chargerIso)
			
			--local hasPower = IsOnPoweredSquare(character)
			--print ("UpdateBatteries v.inventory parent Type = ", chargerIso:getType())
			local hasPower = IsOnPoweredSquare(chargerIso)
			print("hasPower = ", hasPower)
			
			local curTime = getGameTime():getWorldAgeHours()
			--print("Game MinutesStamp = ", getGameTime():getMinutesStamp())
			--print("Game WorldAgeHours = ", getGameTime():getWorldAgeHours())
			
			
			
			--[[
			if hasPower then
				if not chargerIso:getModData().powerStart then
					chargerIso:getModData().powerStart = curTime
				end
				if not chargerIso:getModData().powerOffTime then
					chargerIso:getModData().powerOffTime = 0.0
				end
				if chargerIso:getModData().powerStop and chargerIso:getModData().powerStart > chargerIso:getModData().powerStop then
					chargerIso:getModData().powerOffTime += chargerIso:getModData().powerStart - chargerIso:getModData().powerStop
				end
			end
			
			if not hasPower then
				chargerIso:getModData().powerStop = curTime
			end
			]]
			
			
			local items = v.inventory:getItems()
			if items:size() > 0 then
				for i=0,items:size()-1 do
					local item = items:get(i)
					--print("    UpdateBatteries: Charger Item Type = ", item:getType())
					if item:getType() == "Battery" then
						--print("Battery ID = ", item:getID())
						--print("Battery Charge = ", item:getUsedDelta())
						
						if hasPower and item:getUsedDelta() < 1.0 then
							if not item:getModData().BatLastCharge or item:getModData().BatLastCharge ~= item:getUsedDelta() then 
								item:getModData().BatLastTime = curTime
								item:getModData().BatLastCharge = item:getUsedDelta()
							end
							local lastTime = item:getModData().BatLastTime
							local newDelta = curTime - lastTime
							if newDelta > 0.0 then
								item:setUsedDelta(item:getUsedDelta() + (newDelta * 0.8))
							end
							item:getModData().BatLastTime = curTime
							item:getModData().BatLastCharge = item:getUsedDelta()
						else
							item:getModData().BatLastCharge = -1
						end
					end
				end
			end
		end
    end
end

--[[
function UpdateBatteries_OldTest(player)
	--wait for players to put something into an insulated container, or to come into contact with a new one.
	--look on floor for containers
	player_floor = ISInventoryPage.GetFloorContainer(player:getPlayerNum()):getItems()
	for i=0,player_floor:size()-1 do
		local floorItem = player_floor:get(i)
		print("UpdateBatteries - Floor item type = ", floorItem:getType())
		
		if floorItem:getType() == "manux_BedsWithStorage.SmallBatteryCharger" then
			
			local items = floorItem:getItemContainer():getItems()
			if items:size() > 0 then
				
				for i=0,items:size()-1 do
					local item = items:get(i)
					print("    UpdateBatteries: Charger Item = ", item)
					print("    UpdateBatteries: Charger Item Type = ", item:getType())
				end
			end
		end
	end
end
]]

function OnLoadTest()
	--if getSpecificPlayer(0):getModData()["toto"] ~= nil then
	if getPlayer():getModData()["toto"] ~= nil then
		print("OnLoadTest = ", getSpecificPlayer(0):getModData()["toto"] )
	else
		print("OnLoadTest = toto does not exist")
	end
end

function OnSaveTest()
	--getSpecificPlayer(0):getModData()["toto"] = "GUGU"
	getPlayer():getModData()["toto"] = "GUGU"
end


--Events.EveryOneMinute.Add(CheckAllChargers)
Events.OnPlayerUpdate.Add(UpdateBatteries)
--Events.OnFillContainer.Add(OnFillContainer)
--Events.OnSave.Add(OnSaveTest) --Doesn't work, saves after player is offloaded.
--Events.EveryOneMinute.Add(OnLoadTest)
--Events.OnPlayerUpdate.Add(OnSaveTest)