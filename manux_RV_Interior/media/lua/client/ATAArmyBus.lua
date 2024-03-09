local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 23100
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





local function ATAArmyBusexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().ATAArmyBuspos[2][1])
        player:setY(player:getModData().ATAArmyBuspos[2][2])
        player:setZ(player:getModData().ATAArmyBuspos[2][3])
        player:setLx(player:getModData().ATAArmyBuspos[2][1])
        player:setLy(player:getModData().ATAArmyBuspos[2][2])
        player:setLz(player:getModData().ATAArmyBuspos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().ATAArmyBuspos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function ATAArmyBusexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().ATAArmyBuspos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local ATAArmyBusinfo = player:getModData().ATAArmyBuspos[3]


    square=getCell():getGridSquare((cellPosX+2)+(ATAArmyBusinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(ATAArmyBusinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().ATAArmyBuspos[4]*60 and _y<=(cellPosY+7)+player:getModData().ATAArmyBuspos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().ATAArmyBuspos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,ATAArmyBusexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(ATAArmyBusexit)

---------------------------------------------------------------------------------------------------------------------------

local function ATAArmyBusEveryHours()
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

Events.EveryHours.Add(ATAArmyBusEveryHours)








local ATAArmyBusnumpos={}
ATAArmyBusnumpos[1]={0,0}
ATAArmyBusnumpos[2]={1,0}
ATAArmyBusnumpos[3]={2,0}
ATAArmyBusnumpos[4]={3,0}
ATAArmyBusnumpos[5]={4,0}
ATAArmyBusnumpos[6]={0,1}
ATAArmyBusnumpos[7]={1,1}
ATAArmyBusnumpos[8]={2,1}
ATAArmyBusnumpos[9]={3,1}
ATAArmyBusnumpos[10]={4,1}
ATAArmyBusnumpos[11]={0,2}
ATAArmyBusnumpos[12]={1,2}
ATAArmyBusnumpos[13]={2,2}
ATAArmyBusnumpos[14]={3,2}
ATAArmyBusnumpos[15]={4,2}
ATAArmyBusnumpos[16]={0,3}
ATAArmyBusnumpos[17]={1,3}
ATAArmyBusnumpos[18]={2,3}
ATAArmyBusnumpos[19]={3,3}
ATAArmyBusnumpos[20]={4,3}
ATAArmyBusnumpos[21]={0,4}
ATAArmyBusnumpos[22]={1,4}
ATAArmyBusnumpos[23]={2,4}
ATAArmyBusnumpos[24]={3,4}
ATAArmyBusnumpos[25]={4,4}

local housedel
local housedelY

local function ATAArmyBusLoadGridsquare(square)
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
        Events.LoadGridsquare.Remove(ATAArmyBusLoadGridsquare)
    end
end

local function enterATAArmyBus(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().ATAArmyBusnum==nil then
                getGameTime():getModData().ATAArmyBusnum=0
    
                
            end
            getGameTime():getModData().ATAArmyBusnum=getGameTime():getModData().ATAArmyBusnum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().ATAArmyBusnum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=ATAArmyBusnumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().ATAArmyBuspos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
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
        Events.LoadGridsquare.Add(ATAArmyBusLoadGridsquare)
    end
end

local function ATAArmyBusOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    if vehicle:getScript():getFullName() ~= "Base.ATAArmyBus" then return end
    -- if vehicle:getSeat(player)==2
    -- print(vehicle:getSeat(player))
    if vehicle:getSeat(player)>=2 then
        if player:isNPC() then return end
        local ATAArmyBusenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, enterATAArmyBus, 0,player,vehicle)
        ATAArmyBusenter:initialise()
        ATAArmyBusenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(ATAArmyBusOnSwitchVehicleSeat)
