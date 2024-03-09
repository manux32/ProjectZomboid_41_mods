--[[ttrTrunkSizeRatio = 5;
ttrTrunkSizeTreshold = 165;
ttrTrunkSize = {};--]]

manuxSizeScale = 2;
manuxMinTrunkSize = 150;
manuxTrunkSize = {};

--function ttrTrunkSize.createPartInventoryItem(part)
function manuxTrunkSize.createPartInventoryItem(part)
-- copied from lua/server/Vehicles/Vehicles.lua from pz41.50
	if not part:getItemType() or part:getItemType():isEmpty() then return nil end
	local item;
	if not part:getInventoryItem() then
		local v = part:getVehicle();
--		if not part:isSpecificItem() then
			local chosenKey = ""
			for i=1,part:getItemType():size() do
				chosenKey = chosenKey .. part:getItemType():get(i-1) .. ';'
			end
			local itemType = v:getChoosenParts():get(chosenKey);
			-- never init this part, we choose a random part in the itemtype available, so every tire will be the same, every seats... (no 2 normal tire and 2 sports tire e.g)
			-- part quality is always in the same order, 0 = bad, max = good
			-- we random the part quality depending on the engine quality
			if not itemType then
				for i=0, part:getItemType():size() - 1 do
					if ZombRand(100) > v:getEngineQuality() or i == part:getItemType():size() - 1 then
					--if ZombRand(100) > (100 - (100/part:getItemType():size())) or i == part:getItemType():size() - 1 then
						itemType = part:getItemType():get(i);
						-- removed old brake
						itemType = itemType:gsub("Base.OldBrake", "Base.NormalBrake");
						v:getChoosenParts():put(chosenKey, itemType);
						break;
					end
				end
			end
			item = InventoryItemFactory.CreateItem(itemType);
			local conditionMultiply = 100/item:getConditionMax();
			
			-- mod by manux
			local targetMaxCap = nil;
			if part:getContainerCapacity() and part:getContainerCapacity() > 0 then
				targetMaxCap = part:getContainerCapacity();
				item:setMaxCapacity(targetMaxCap);
			elseif part:getItemContainer() then
				targetMaxCap = item:getMaxCapacity();
			end
			if targetMaxCap then
				local itemTypeLower = itemType:lower();
				--local itemNameLower = item:getName():lower();
				if (itemTypeLower:contains("trunk") or itemTypeLower:contains("truckbed"))then
					if targetMaxCap < manuxMinTrunkSize then
						targetMaxCap = manuxMinTrunkSize;
					end
					targetMaxCap = targetMaxCap * manuxSizeScale;
					item:setMaxCapacity(targetMaxCap);
				elseif (itemTypeLower:contains("seat") or itemTypeLower:contains("glove") or itemTypeLower:contains("bag") or itemTypeLower:contains("storage") or itemTypeLower:contains("compartment") or itemTypeLower:contains("container") or itemTypeLower:contains("box") or itemTypeLower:contains("armory"))then	
					targetMaxCap = targetMaxCap * manuxSizeScale;
					item:setMaxCapacity(targetMaxCap);
				end
			end
			-- mod by manux - end
			
			--[[ mod by ttr
			local targetMaxCap = nil;
			if part:getContainerCapacity() and part:getContainerCapacity() > 0 then
				targetMaxCap = part:getContainerCapacity();
			elseif part:getItemContainer() then
				targetMaxCap = item:getMaxCapacity();
			end
			if targetMaxCap then
				if  targetMaxCap < ttrTrunkSizeTreshold and (itemType:contains("Trunk") or itemType:contains("TruckBed"))then
					targetMaxCap = targetMaxCap * ttrTrunkSizeRatio;
				end
				item:setMaxCapacity(targetMaxCap);
			end
			-- mod by ttr - end--]]
			item:setConditionMax(item:getConditionMax()*conditionMultiply);
			item:setCondition(item:getCondition()*conditionMultiply);
--		else
--			item = InventoryItemFactory.CreateItem(part:getItemType():get(0));
--		end
--		if not item then return; end
		part:setRandomCondition(item);
		part:setInventoryItem(item)
	end
	return part:getInventoryItem()
end
--VehicleUtils.createPartInventoryItem = ttrTrunkSize.createPartInventoryItem;
VehicleUtils.createPartInventoryItem = manuxTrunkSize.createPartInventoryItem;

--[[

ttrTrunkSize.UninstallComplete = {}
ttrTrunkSize.InstallComplete = {}
ttrTrunkSize.TestInstall = {}

function ttrTrunkSize.UninstallComplete.Seat(vehicle, part, chr)
	local trunk = vehicle:getPartById("TruckBed")
	if trunk then
		local container = trunk:getItemContainer()
		if container then
			local wght = container:getMaxWeight()
			local wghtc = container:getCapacityWeight()
			container.capacity = wght + 50
		end
	end
end
function ttrTrunkSize.InstallComplete.Seat(vehicle, part, chr)
	local trunk = vehicle:getPartById("TruckBed")
	if trunk then
	container = trunk:getItemContainer()
		if container then
			container.Capacity = container.Capacity - 1050
		end
	end
end
function ttrTrunkSize.TestInstall.Seat(vehicle, part, chr)
	return Vehicles.UninstallTest.Default(vehicle, part, chr)
end
]]--