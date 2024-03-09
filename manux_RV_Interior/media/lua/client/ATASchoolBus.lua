local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 22500
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





local function ATASchoolBusexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().ATASchoolBuspos[2][1])
        player:setY(player:getModData().ATASchoolBuspos[2][2])
        player:setZ(player:getModData().ATASchoolBuspos[2][3])
        player:setLx(player:getModData().ATASchoolBuspos[2][1])
        player:setLy(player:getModData().ATASchoolBuspos[2][2])
        player:setLz(player:getModData().ATASchoolBuspos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().ATASchoolBuspos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function ATASchoolBusexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().ATASchoolBuspos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local ATASchoolBusinfo = player:getModData().ATASchoolBuspos[3]


    square=getCell():getGridSquare((cellPosX+2)+(ATASchoolBusinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(ATASchoolBusinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().ATASchoolBuspos[4]*60 and _y<=(cellPosY+7)+player:getModData().ATASchoolBuspos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().ATASchoolBuspos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,ATASchoolBusexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(ATASchoolBusexit)

---------------------------------------------------------------------------------------------------------------------------

local function ATASchoolBusEveryHours()
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

Events.EveryHours.Add(ATASchoolBusEveryHours)








local ATASchoolBusnumpos={}
ATASchoolBusnumpos[1]={0,0}
ATASchoolBusnumpos[2]={1,0}
ATASchoolBusnumpos[3]={2,0}
ATASchoolBusnumpos[4]={3,0}
ATASchoolBusnumpos[5]={4,0}
ATASchoolBusnumpos[6]={0,1}
ATASchoolBusnumpos[7]={1,1}
ATASchoolBusnumpos[8]={2,1}
ATASchoolBusnumpos[9]={3,1}
ATASchoolBusnumpos[10]={4,1}
ATASchoolBusnumpos[11]={0,2}
ATASchoolBusnumpos[12]={1,2}
ATASchoolBusnumpos[13]={2,2}
ATASchoolBusnumpos[14]={3,2}
ATASchoolBusnumpos[15]={4,2}
ATASchoolBusnumpos[16]={0,3}
ATASchoolBusnumpos[17]={1,3}
ATASchoolBusnumpos[18]={2,3}
ATASchoolBusnumpos[19]={3,3}
ATASchoolBusnumpos[20]={4,3}
ATASchoolBusnumpos[21]={0,4}
ATASchoolBusnumpos[22]={1,4}
ATASchoolBusnumpos[23]={2,4}
ATASchoolBusnumpos[24]={3,4}
ATASchoolBusnumpos[25]={4,4}

local housedel
local housedelY

local function ATASchoolBusLoadGridsquare(square)
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
        Events.LoadGridsquare.Remove(ATASchoolBusLoadGridsquare)
    end
end

local function enterATASchoolBus(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().ATASchoolBusnum==nil then
                getGameTime():getModData().ATASchoolBusnum=0
    
                
            end
            getGameTime():getModData().ATASchoolBusnum=getGameTime():getModData().ATASchoolBusnum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().ATASchoolBusnum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=ATASchoolBusnumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().ATASchoolBuspos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
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
        Events.LoadGridsquare.Add(ATASchoolBusLoadGridsquare)
    end
end

local function ATASchoolBusOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    if vehicle:getScript():getFullName() ~= "Base.ATASchoolBus" then return end
    -- if vehicle:getSeat(player)==2
    -- print(vehicle:getSeat(player))
    if vehicle:getSeat(player)>=2 then
        if player:isNPC() then return end
        local ATASchoolBusenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, enterATASchoolBus, 0,player,vehicle)
        ATASchoolBusenter:initialise()
        ATASchoolBusenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(ATASchoolBusOnSwitchVehicleSeat)
