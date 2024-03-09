local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 22800
local cellPosY = 12600

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





local function ATAPrisonBusexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().ATAPrisonBuspos[2][1])
        player:setY(player:getModData().ATAPrisonBuspos[2][2])
        player:setZ(player:getModData().ATAPrisonBuspos[2][3])
        player:setLx(player:getModData().ATAPrisonBuspos[2][1])
        player:setLy(player:getModData().ATAPrisonBuspos[2][2])
        player:setLz(player:getModData().ATAPrisonBuspos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().ATAPrisonBuspos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function ATAPrisonBusexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().ATAPrisonBuspos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local ATAPrisonBusinfo = player:getModData().ATAPrisonBuspos[3]


    square=getCell():getGridSquare((cellPosX+2)+(ATAPrisonBusinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(ATAPrisonBusinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().ATAPrisonBuspos[4]*60 and _y<=(cellPosY+7)+player:getModData().ATAPrisonBuspos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().ATAPrisonBuspos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,ATAPrisonBusexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(ATAPrisonBusexit)

---------------------------------------------------------------------------------------------------------------------------

local function ATAPrisonBusEveryHours()
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

Events.EveryHours.Add(ATAPrisonBusEveryHours)








local ATAPrisonBusnumpos={}
ATAPrisonBusnumpos[1]={0,0}
ATAPrisonBusnumpos[2]={1,0}
ATAPrisonBusnumpos[3]={2,0}
ATAPrisonBusnumpos[4]={3,0}
ATAPrisonBusnumpos[5]={4,0}
ATAPrisonBusnumpos[6]={0,1}
ATAPrisonBusnumpos[7]={1,1}
ATAPrisonBusnumpos[8]={2,1}
ATAPrisonBusnumpos[9]={3,1}
ATAPrisonBusnumpos[10]={4,1}
ATAPrisonBusnumpos[11]={0,2}
ATAPrisonBusnumpos[12]={1,2}
ATAPrisonBusnumpos[13]={2,2}
ATAPrisonBusnumpos[14]={3,2}
ATAPrisonBusnumpos[15]={4,2}
ATAPrisonBusnumpos[16]={0,3}
ATAPrisonBusnumpos[17]={1,3}
ATAPrisonBusnumpos[18]={2,3}
ATAPrisonBusnumpos[19]={3,3}
ATAPrisonBusnumpos[20]={4,3}
ATAPrisonBusnumpos[21]={0,4}
ATAPrisonBusnumpos[22]={1,4}
ATAPrisonBusnumpos[23]={2,4}
ATAPrisonBusnumpos[24]={3,4}
ATAPrisonBusnumpos[25]={4,4}

local housedel
local housedelY

local function ATAPrisonBusLoadGridsquare(square)
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
        Events.LoadGridsquare.Remove(ATAPrisonBusLoadGridsquare)
    end
end

local function enterATAPrisonBus(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().ATAPrisonBusnum==nil then
                getGameTime():getModData().ATAPrisonBusnum=0
    
                
            end
            getGameTime():getModData().ATAPrisonBusnum=getGameTime():getModData().ATAPrisonBusnum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().ATAPrisonBusnum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=ATAPrisonBusnumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().ATAPrisonBuspos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
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
        Events.LoadGridsquare.Add(ATAPrisonBusLoadGridsquare)
    end
end

local function ATAPrisonBusOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    if vehicle:getScript():getFullName() ~= "Base.ATAPrisonBus" then return end
    -- if vehicle:getSeat(player)==2
    -- print(vehicle:getSeat(player))
    if vehicle:getSeat(player)>=2 then
        if player:isNPC() then return end
        local ATAPrisonBusenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, enterATAPrisonBus, 0,player,vehicle)
        ATAPrisonBusenter:initialise()
        ATAPrisonBusenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(ATAPrisonBusOnSwitchVehicleSeat)
