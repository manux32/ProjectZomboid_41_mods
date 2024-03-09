--local allpart={"HeadlightRight","HeadlightLeft","SeatBigTrunkbed","SuspensionFrontLeft","SuspensionFrontRight","SuspensionRearLeft","SuspensionRearRight","DoorFrontLeft","DoorFrontRight","EngineDoor","WindowFrontLeft","WindowFrontRight","WindshieldRear","Windshield","TruckBed","GasTank"}
local allpart={
"housecarpartbullbar","DoorRear","Muffler",
"BrakeFrontLeft","BrakeFrontRight","BrakeRearLeft","BrakeRearRight",
"HeadlightRight","HeadlightLeft","HeadlightRearLeft","HeadlightRearRight",
"SeatBigTrunkbed",
"SuspensionFrontLeft","SuspensionFrontRight","SuspensionRearLeft","SuspensionRearRight",
"DoorFrontLeft","DoorFrontRight","EngineDoor",
"WindowFrontLeft","WindowFrontRight","WindshieldRear","Windshield",
"TruckBed","GasTank"}
local speallpart={"TireFrontLeft","TireFrontRight","TireRearLeft","TireRearRight"}

local function TheSuperDozerArmor(playerobj)
    local vehicle = playerobj:getVehicle()
    if vehicle == nil then return end
    if vehicle:getScript():getFullName() ~= "Base.ArmoredMotorhome" then return end
    

    -- print(part:getDelta())

    -- ISVehicleMechanics.onCheatRepair(playerobj, vehicle)

    if ZombRand(40)==0 then

        for i=1 ,#allpart do
            vehicle:getPartById(allpart[i]):setCondition(100)
        end



        for i=1 ,#speallpart do
            local partz=vehicle:getPartById(speallpart[i])
            if partz:getInventoryItem() then
                ISVehicleMechanics.onCheatRepairPart(playerobj, partz)
                
            end

            
            -- vehicle:getPartById(speallpart[i]):setCondition(100)
            -- ISVehicleMechanics.onCheatRepair(playerobj, vehicle)
        end

        
        


    end
    
    if not vehicle:isEngineRunning() then return end
    local part = vehicle:getPartById("GasTank")
    local gascondition = part:getContainerContentAmount()
    -- print(gascondition)
    --part:setContainerContentAmount(gascondition-0.0003)
	part:setContainerContentAmount(gascondition-0.0001)




    
    local partitem =vehicle:getPartById("housecarpartbullbar")
    if ZombRand(4)~=1 then return end
    if vehicle:getEngineSpeed() > 1300 and partitem:getCondition()>0 and partitem:getInventoryItem() then
        local angle = vehicle:getAngleY()
        -- print(math.ceil(vehicle:getAngleX()),"....",math.ceil(angle),"......",math.ceil(vehicle:getAngleX()))
        local deltt = {}
        deltt[1] = math.sin(math.rad(angle))
        if math.abs(vehicle:getAngleZ())  > 90 then
            deltt[2] = -math.cos(math.rad(angle))
        else
            deltt[2] = math.cos(math.rad(angle))
        end
        local xxx =vehicle:getX()
        local yyy = vehicle:getY()
        xxx  = math.ceil(xxx + 4.5*deltt[1])
        yyy =  math.ceil(yyy + 4.5*deltt[2])
        -- print(math.ceil(6*deltt[1]),".....",math.ceil(6*deltt[2]))
        local square
        for xx = -2 , 2 do
            for yy = -2 , 2 do
                square = getCell():getGridSquare(xxx + xx,yyy + yy,0)
                local objects = square:getObjects()
                local zombie = square:getZombie()
                if zombie and vehicle:getSpeed2D()>2.8 then
                    zombie:setHealth(0)
					--[[
                    if ZombRand(250)==0 then
                        partitem:setCondition(partitem:getCondition()-2)
                        
                    end
					--]]
                    
                
                end
                for index=0, objects:size()-1 do
                    local treetree = objects:get(index)
                    if instanceof(treetree, "IsoTree") then
                        treetree:Damage(treetree:getMaxHealth())
						--[[
                        if ZombRand(250)==0 then
                            partitem:setCondition(partitem:getCondition()-2)
                            
                        end
						--]]
                        if not treetree:getModData().soundbreak then
                            treetree:getModData().soundbreak = 1
                            vehicle:playSound("VehicleHitTree")
                        end

                        -- if not vehicle:getEmitter():isPlaying("BreakObject") then
                        --     -- vehicle:playSound("breakdoor")
                            
                        -- end
                        
                    end         
                end
            end
        end
    end     
end

Events.OnPlayerUpdate.Add(TheSuperDozerArmor)