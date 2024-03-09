local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 22800
local cellPosY = 12000

local function OnPlayerEntercar(player)


    local square = player:getCurrentSquare()
    if square==nil then return end
    local vehicle=square:getVehicleContainer()
    if vehicle~=nil then
        vehicle:enter(1, player)
        Events.OnPlayerUpdate.Remove(OnPlayerEntercar)
        

        
    end


    




    

    -- vehicle:enter(0, player)
	-- Your code here
end





local function schoolbusexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().schoolbuspos[2][1])
        player:setY(player:getModData().schoolbuspos[2][2])
        player:setZ(player:getModData().schoolbuspos[2][3])
        player:setLx(player:getModData().schoolbuspos[2][1])
        player:setLy(player:getModData().schoolbuspos[2][2])
        player:setLz(player:getModData().schoolbuspos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().schoolbuspos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function schoolbusexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().schoolbuspos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local schoolbusinfo = player:getModData().schoolbuspos[3]


    square=getCell():getGridSquare((cellPosX+2)+(schoolbusinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(schoolbusinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().schoolbuspos[4]*60 and _y<=(cellPosY+13)+player:getModData().schoolbuspos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().schoolbuspos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,schoolbusexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(schoolbusexit)

---------------------------------------------------------------------------------------------------------------------------

local function schoolbusEveryHours()
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

Events.EveryHours.Add(schoolbusEveryHours)








local schoolbusnumpos={}
schoolbusnumpos[1]={0,0}
schoolbusnumpos[2]={1,0}
schoolbusnumpos[3]={2,0}
schoolbusnumpos[4]={3,0}
schoolbusnumpos[5]={4,0}
schoolbusnumpos[6]={0,1}
schoolbusnumpos[7]={1,1}
schoolbusnumpos[8]={2,1}
schoolbusnumpos[9]={3,1}
schoolbusnumpos[10]={4,1}
schoolbusnumpos[11]={0,2}
schoolbusnumpos[12]={1,2}
schoolbusnumpos[13]={2,2}
schoolbusnumpos[14]={3,2}
schoolbusnumpos[15]={4,2}
schoolbusnumpos[16]={0,3}
schoolbusnumpos[17]={1,3}
schoolbusnumpos[18]={2,3}
schoolbusnumpos[19]={3,3}
schoolbusnumpos[20]={4,3}
schoolbusnumpos[21]={0,4}
schoolbusnumpos[22]={1,4}
schoolbusnumpos[23]={2,4}
schoolbusnumpos[24]={3,4}
schoolbusnumpos[25]={4,4}

local housedel
local housedelY

local function schoolbusLoadGridsquare(square)
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
        Events.LoadGridsquare.Remove(schoolbusLoadGridsquare)
    end
end

local function enterschoolbus(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().schoolbusnum==nil then
                getGameTime():getModData().schoolbusnum=0
    
                
            end
            getGameTime():getModData().schoolbusnum=getGameTime():getModData().schoolbusnum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().schoolbusnum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=schoolbusnumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().schoolbuspos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
        --genCondition = player:getVehicle():getPartById("Battery"):getCondition()
        batteryPower = player:getVehicle():getBatteryCharge()
        Events.OnTick.Remove(ChimeTick)
        vehicle:exit(player)
        player:setX((cellPosX+1)+60*housedel)
        player:setY((cellPosY+6)+60*housedelY)
        player:setZ(0)
        player:setLx((cellPosX+1)+60*housedel)
        player:setLy((cellPosY+6)+60*housedelY)
        player:setLz(0)
        Events.LoadGridsquare.Add(schoolbusLoadGridsquare)
    end
end

local function schoolbusOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    if vehicle:getScript():getFullName() ~= "Base.schoolbus" then return end
    -- if vehicle:getSeat(player)>=2
    -- print(vehicle:getSeat(player))
    if vehicle:getSeat(player)>=2 then
        if player:isNPC() then return end
        local schoolbusenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, enterschoolbus, 0,player,vehicle)
        schoolbusenter:initialise()
        schoolbusenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(schoolbusOnSwitchVehicleSeat)
