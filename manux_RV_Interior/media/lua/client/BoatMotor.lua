local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 23100
local cellPosY = 12900

local function OnPlayerEntercar(player)


    local square = player:getCurrentSquare()
    if square==nil then return end
    local vehicle=square:getVehicleContainer()
    if vehicle~=nil then
        vehicle:enter(4, player)
        Events.OnTick.Add(TickControl.main)
        Events.OnPlayerUpdate.Remove(OnPlayerEntercar)
        

        
    end


    




    

    -- vehicle:enter(0, player)
	-- Your code here
end





local function BoatMotorexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)
        player:getSprite():getProperties():Set(IsoFlagType.invisible)
        player:setX(player:getModData().BoatMotorpos[2][1])
        player:setY(player:getModData().BoatMotorpos[2][2])
        player:setZ(player:getModData().BoatMotorpos[2][3])
        player:setLx(player:getModData().BoatMotorpos[2][1])
        player:setLy(player:getModData().BoatMotorpos[2][2])
        player:setLz(player:getModData().BoatMotorpos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().BoatMotorpos[5])
        Events.OnTick.Remove(TickControl.main)
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function BoatMotorexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().BoatMotorpos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local BoatMotorinfo = player:getModData().BoatMotorpos[3]


    square=getCell():getGridSquare((cellPosX+2)+(BoatMotorinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(BoatMotorinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().BoatMotorpos[4]*60 and _y<=(cellPosY+13)+player:getModData().BoatMotorpos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().BoatMotorpos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,BoatMotorexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(BoatMotorexit)

---------------------------------------------------------------------------------------------------------------------------

local function BoatMotorEveryHours()
    for y=0,4 do
        for u=0,4 do

            local square=getCell():getGridSquare((cellPosX+1)+60*y,(cellPosY+15)+60*u,0)
            if square then
                local objects=square:getObjects()
                if objects then
                    for i=1,objects:size() do
                        if instanceof(objects:get(i-1), "IsoGenerator") then
                            objects:get(i-1):setFuel(batteryPower*100)
                            objects:get(i-1):setCondition(genCondition)
                            print("updategen")
                        end
                    end
                end
            end
        end
    end
	-- Your code here
end

Events.EveryHours.Add(BoatMotorEveryHours)








local BoatMotornumpos={}
BoatMotornumpos[1]={0,0}
BoatMotornumpos[2]={1,0}
BoatMotornumpos[3]={2,0}
BoatMotornumpos[4]={3,0}
BoatMotornumpos[5]={4,0}
BoatMotornumpos[6]={0,1}
BoatMotornumpos[7]={1,1}
BoatMotornumpos[8]={2,1}
BoatMotornumpos[9]={3,1}
BoatMotornumpos[10]={4,1}
BoatMotornumpos[11]={0,2}
BoatMotornumpos[12]={1,2}
BoatMotornumpos[13]={2,2}
BoatMotornumpos[14]={3,2}
BoatMotornumpos[15]={4,2}
BoatMotornumpos[16]={0,3}
BoatMotornumpos[17]={1,3}
BoatMotornumpos[18]={2,3}
BoatMotornumpos[19]={3,3}
BoatMotornumpos[20]={4,3}
BoatMotornumpos[21]={0,4}
BoatMotornumpos[22]={1,4}
BoatMotornumpos[23]={2,4}
BoatMotornumpos[24]={3,4}
BoatMotornumpos[25]={4,4}

local housedel
local housedelY

local function BoatMotorLoadGridsquare(square)
    if square:getX()==(cellPosX+1)+60*housedel and square:getY()==(cellPosY+15)+60*housedelY and square:getZ() ==0 then
        local NewGenerator
        local objects = square:getObjects()
        if square:getObjects():size()>1 and instanceof(square:getObjects():get(1), "IsoGenerator") then
            print("updategen")
            NewGenerator = square:getObjects():get(1)
            NewGenerator:setConnected(true)
            NewGenerator:setFuel(batteryPower*100)
            NewGenerator:setCondition(genCondition)
            NewGenerator:setActivated(true)
            if (batteryPower*100) <= 0 then
                NewGenerator:setActivated(false)
            end
            NewGenerator:setSurroundingElectricity()


        else
            print("nohavegenerator")
            
            NewGenerator = IsoGenerator.new(nil,getCell(),square)
            NewGenerator:setConnected(true)
            NewGenerator:setFuel(batteryPower*100)
            NewGenerator:setCondition(genCondition)
            NewGenerator:setActivated(true)
            if (batteryPower*100) <= 0 then
                NewGenerator:setActivated(false)
            end
            NewGenerator:setSurroundingElectricity()
        end
        Events.LoadGridsquare.Remove(BoatMotorLoadGridsquare)
    end
end

local function enterBoatMotor(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().BoatMotornum==nil then
                getGameTime():getModData().BoatMotornum=0
    
                
            end
            getGameTime():getModData().BoatMotornum=getGameTime():getModData().BoatMotornum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().BoatMotornum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=BoatMotornumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().BoatMotorpos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
        --genCondition = player:getVehicle():getPartById("Battery"):getCondition()
        batteryPower = player:getVehicle():getBatteryCharge()
        Events.OnTick.Remove(ChimeTick)
        vehicle:exit(player)
        player:setX((cellPosX+1)+60*housedel)
        player:setY((cellPosY+7)+60*housedelY)
        player:setZ(0)
        player:setLx((cellPosX+1)+60*housedel)
        player:setLy((cellPosY+7)+60*housedelY)
        player:setLz(0)
        Events.LoadGridsquare.Add(BoatMotorLoadGridsquare)
    end
end

local function BoatMotorOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    if vehicle:getScript():getFullName() ~= "Base.BoatMotor" and vehicle:getScript():getFullName() ~= "Base.BoatMotor_Ground" then return end
    -- if vehicle:getSeat(player)>=2
    -- print(vehicle:getSeat(player))
    if vehicle:getSeat(player)>=1 and vehicle:getSeat(player)<=3 then
        if player:isNPC() then return end
        local BoatMotorenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, enterBoatMotor, 0,player,vehicle)
        BoatMotorenter:initialise()
        BoatMotorenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(BoatMotorOnSwitchVehicleSeat)
