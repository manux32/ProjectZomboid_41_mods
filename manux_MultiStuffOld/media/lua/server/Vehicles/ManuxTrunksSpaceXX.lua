manuxTrunkSize = {};

function manuxTrunkSize.createPartInventoryItem(part)
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
					if ZombRand(100) > (100 - (100/part:getItemType():size())) or i == part:getItemType():size() - 1 then
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
				if (itemType:contains("Trunk") or itemType:contains("TruckBed") or itemType:contains("GloveBox") or itemType:contains("Seat"))then
					targetMaxCap = part:getContainerCapacity();
					targetMaxCap = targetMaxCap * 5;
					item:setMaxCapacity(targetMaxCap);
				end
			end
			-- mod by manux - end
			
			--if part:getContainerCapacity() and part:getContainerCapacity() > 0 then
			--	item:setMaxCapacity(part:getContainerCapacity());
			--end
			
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
VehicleUtils.createPartInventoryItem = manuxTrunkSize.createPartInventoryItem;
