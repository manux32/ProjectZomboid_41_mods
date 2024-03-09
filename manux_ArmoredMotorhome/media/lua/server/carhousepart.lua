housecarparta = {}
housecarparta.Create = {}
housecarparta.Init = {}
function housecarparta.Create.housecarparta(vehicle, part)
	part = vehicle:getPartById("housecarparta")
    part:setModelVisible("housecarparta", true)
end
function housecarparta.Init.housecarparta(vehicle, part)

    -- part:setInventoryItem(nil)
	part = vehicle:getPartById("housecarparta")
    part:setModelVisible("housecarparta", true)
end

housecarpartbullbar = {}
housecarpartbullbar.update = {}
function housecarpartbullbar.update.housecarpartbullbar(vehicle, part)

    if  part:getCondition()>0 and part:getInventoryItem() then
        part:setModelVisible("housecarpartbullbar", true)
        
    else
        -- part = vehicle:getPartById("housecarpartbullbar"):getInventoryItem()
        part:setModelVisible("housecarpartbullbar", false)
    end

    -- print(part:getCondition())
        
end

housecarpartgun1 = {}
housecarpartgun1.update = {}
function housecarpartgun1.update.housecarpartgun1(vehicle, part)

    if  part:getCondition()>0 and part:getInventoryItem() then
        part:setModelVisible("housecarpartgun1", true)
        
    else
        -- part = vehicle:getPartById("housecarpartbullbar"):getInventoryItem()
        part:setModelVisible("housecarpartgun1", false)
    end
        
end

-- housecarpartgun1 = {}
-- housecarpartgun1.Create = {}
-- housecarpartgun1.Init = {}

-- housecarpartgun1.update.housecarpartgun1
-- function housecarpartgun1.Create.housecarpartgun1(vehicle, part)
-- 	part = vehicle:getPartById("housecarpartgun1")
--     part:setModelVisible("housecarpartgun1", true)
-- end
-- function housecarpartgun1.Init.housecarpartgun1(vehicle, part)
-- 	part = vehicle:getPartById("housecarpartgun1")
--     part:setModelVisible("housecarpartgun1", true)
-- end

housecarpartgun2 = {}
housecarpartgun2.Create = {}
housecarpartgun2.Init = {}
function housecarpartgun2.Create.housecarpartgun2(vehicle, part)
	-- part = vehicle:getPartById("housecarpartgastank")
    -- part:setModelVisible("housecarpartgastank", true)
end
function housecarpartgun2.Init.housecarpartgun2(vehicle, part)
	-- part = vehicle:getPartById("housecarpartgastank")
    -- part:setModelVisible("housecarpartgastank", true)
end