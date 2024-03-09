
------------------------- TESTS -----------------------------

local function OnRefreshInventoryWindowContainers(iSInventoryPage, state)
	-- Triggered during the process of refreshing inventory containers.
	print("---------- OnRefreshInventoryWindowContainers ----------")
	print("iSInventoryPage = ", iSInventoryPage)
	print("state = ", state)
	
	-- Does player square have a charger?
	local square = getPlayer():getSquare()
	if square ~= nil then
		if not square:getModData().hasCharger then
			square:getModData().hasCharger = false
		end
		print("    - Pos X =", square:getX())
		print("    - Pos Y =", square:getY())
		print("    - Pos Z =", square:getZ())
		--getCell()
		print("HAS CHARGER = ", square:getModData().hasCharger)
	end
	
	-- Print all backpacks and check if their square has a charger
	print("backpacks = ", iSInventoryPage.backpacks)
	for i,v in ipairs(iSInventoryPage.backpacks) do
		print ("  - container = ", v.inventory:getType())
		
		if v.inventory:getType() == "SmallBatteryCharger" then
			local square = v.inventory:getParent():getSquare()
			if not square:getModData().hasCharger then
				square:getModData().hasCharger = false
			end
			print("    - Has Charger = ", square:getModData().hasCharger)
			print("    - Pos X =", square:getX())
			print("    - Pos Y =", square:getY())
			print("    - Pos Z =", square:getZ())
		end
		
		-- if v.inventory ~= nil then
			-- local parent = v.inventory:getParent()
			-- if parent ~= nil then
				-- square = parent:getSquare()
			-- else
				-- square = nil
			-- end
			-- if square ~= nil then
				-- if not square:getModData().hasCharger then
					-- square:getModData().hasCharger = false
				-- end
				-- print("    - Has Charger = ", square:getModData().hasCharger)
			-- end
		-- end
	end
	print("--------------------------------------------------------")
end
--Events.OnRefreshInventoryWindowContainers.Add(OnRefreshInventoryWindowContainers)

local function OnObjectAdded(object)
	-- Triggered when an object is added to the map.
	print("---------- OnObjectAdded ----------")
	print("object = ", object)
	print ("  - container = ", object:getContainer():getType())
	if object:getContainer():getType() == "SmallBatteryCharger" then
		object:getSquare():getModData().hasCharger = true
		local square = getPlayer():getSquare()
		if square ~= nil then
			square:getModData().hasCharger = true
			print("    - Pos X =", square:getX())
			print("    - Pos Y =", square:getY())
			print("    - Pos Z =", square:getZ())
		end
	end
	print("---------- OnObjectAdded ----------")
end
--Events.OnObjectAdded.Add(OnObjectAdded)

local function OnTileRemoved(object)
	-- Triggered when a tile object has been removed.
	print("---------- OnTileRemoved ----------")
	print("object = ", object)
	print ("  - container = ", object:getContainer():getType())
	if object:getContainer():getType() == "SmallBatteryCharger" then
		object:getSquare():getModData().hasCharger = false
		local square = getPlayer():getSquare()
		if square ~= nil then
			square:getModData().hasCharger = false
		end
	end
	print("---------- OnTileRemoved ----------")
end
--Events.OnTileRemoved.Add(OnTileRemoved)

local function OnPreFillWorldObjectContextMenu(player, context, worldObjects, test)
	-- Triggered before context menu for world objects is filled.
	print("---------- OnPreFillWorldObjectContextMenu ----------")
	print("player = ", player)
	print("context = ", context)
	print("worldObjects = ", worldObjects)
	print("test = ", test)
	print("---------- OnPreFillWorldObjectContextMenu ----------")
end
--Events.OnPreFillWorldObjectContextMenu.Add(OnPreFillWorldObjectContextMenu)

local function OnFillWorldObjectContextMenu(playerIndex, context, worldObjects, test)
	-- Triggered when world object context menus are being filled.
	print("---------- OnFillWorldObjectContextMenu ----------")
	print("playerIndex = ", playerIndex)
	print("context = ", context)
	print("worldObjects = ", worldObjects)
	print("test = ", test)
	print("---------- OnFillWorldObjectContextMenu ----------")
end
--Events.OnFillWorldObjectContextMenu.Add(OnFillWorldObjectContextMenu)


--------------------------- LESS USEFUL (for now) --------------------------------------

local function OnDestroyIsoThumpable(thumpable)
	-- Triggered when a thumpable object is being destroyed. Not seen so far...
	print("---------- OnDestroyIsoThumpable ----------")
	print("thumpable = ", thumpable)
	print("---------- OnDestroyIsoThumpable ----------")
end
--Events.OnDestroyIsoThumpable.Add(OnDestroyIsoThumpable)

local function OnContainerUpdate(container)
	-- Triggered when a container is being updated. Seems to only happen after a container tile is removed.
	print("---------- OnContainerUpdate ----------")
	print("container = ", container)
	print("---------- OnContainerUpdate ----------")
end
--Events.OnContainerUpdate.Add(OnContainerUpdate)

local function OnDoTileBuilding2(chunk, render, x, y, z, square)
	-- Triggered when a building tile is being set. Spams while picking up or adding a moveable tile.
	print("---------- OnDoTileBuilding2 ----------")
	print("chunk = ", chunk)
	print("render = ", render)
	print("x = ", x)
	print("y = ", y)
	print("z = ", z)
	print("square = ", square)
	print("---------- OnDoTileBuilding2 ----------")
end
--Events.OnDoTileBuilding2.Add(OnDoTileBuilding2)

local function OnFillContainer(roomName, containerType, itemContainer)
	-- Triggered after a container has been filled. Seems to happen when containers are being filled on world creation.
	print("---------- OnFillContainer ----------")
	print("roomName = ", roomName)
	print("containerType = ", containerType)
	print("itemContainer = ", itemContainer)
	print("-------------------------------------")
end
--Events.OnFillContainer.Add(OnFillContainer)

local function OnObjectAboutToBeRemoved(object)
	-- Triggered when an object is about to get removed.
	print("---------- OnObjectAboutToBeRemoved ----------")
	print("object = ", object)
	print ("  - container = ", object:getContainer():getType())
	print("---------- OnObjectAboutToBeRemoved ----------")
end
--Events.OnObjectAboutToBeRemoved.Add(OnObjectAboutToBeRemoved)

local function OnWaterAmountChange(object, waterAmount)
	-- Triggered when the amount of water in an object has changed.
	print("---------- OnWaterAmountChange ----------")
	print("object = ", object)
	print("waterAmount = ", waterAmount)
	print("---------- OnWaterAmountChange ----------")
end
--Events.OnWaterAmountChange.Add(OnWaterAmountChange)

local function AddXP(character, perk, level)
	-- Triggered when a player gains XP.
	print("---------- AddXP ----------")
	print("character = ", character)
	print("perk = ", perk)
	print("level = ", level)
	print("---------- AddXP ----------")
end
--Events.AddXP.Add(AddXP)

local function LoadGridsquare(square)
	-- Triggered when a square is being loaded. Stalls PZ on start game.
	print("---------- LoadGridsquare ----------")
	print("square = ", square)
	print("---------- LoadGridsquare ----------")
end
--Events.LoadGridsquare.Add(LoadGridsquare)