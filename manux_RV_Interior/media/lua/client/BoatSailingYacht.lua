local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 22500
local cellPosY = 13200

local function OnPlayerEntercar(player)


    local square = player:getCurrentSquare()
    if square==nil then return end
    local vehicle=square:getVehicleContainer()
    if vehicle~=nil then
        vehicle:enter(1, player)
        Events.OnTick.Add(TickControl.main)
        Events.OnPlayerUpdate.Remove(OnPlayerEntercar)
        

        
    end


    




    

    -- vehicle:enter(0, player)
	-- Your code here
end





local function BoatSailingYachtexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)
        player:getSprite():getProperties():Set(IsoFlagType.invisible)
        player:setX(player:getModData().BoatSailingYachtpos[2][1])
        player:setY(player:getModData().BoatSailingYachtpos[2][2])
        player:setZ(player:getModData().BoatSailingYachtpos[2][3])
        player:setLx(player:getModData().BoatSailingYachtpos[2][1])
        player:setLy(player:getModData().BoatSailingYachtpos[2][2])
        player:setLz(player:getModData().BoatSailingYachtpos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().BoatSailingYachtpos[5])
        Events.OnTick.Remove(TickControl.main)
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function BoatSailingYachtexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().BoatSailingYachtpos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local BoatSailingYachtinfo = player:getModData().BoatSailingYachtpos[3]


    square=getCell():getGridSquare((cellPosX+2)+(BoatSailingYachtinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(BoatSailingYachtinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().BoatSailingYachtpos[4]*60 and _y<=(cellPosY+13)+player:getModData().BoatSailingYachtpos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().BoatSailingYachtpos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,BoatSailingYachtexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(BoatSailingYachtexit)

---------------------------------------------------------------------------------------------------------------------------

local function BoatSailingYachtEveryHours()
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

Events.EveryHours.Add(BoatSailingYachtEveryHours)








local BoatSailingYachtnumpos={}
BoatSailingYachtnumpos[1]={0,0}
BoatSailingYachtnumpos[2]={1,0}
BoatSailingYachtnumpos[3]={2,0}
BoatSailingYachtnumpos[4]={3,0}
BoatSailingYachtnumpos[5]={4,0}
BoatSailingYachtnumpos[6]={0,1}
BoatSailingYachtnumpos[7]={1,1}
BoatSailingYachtnumpos[8]={2,1}
BoatSailingYachtnumpos[9]={3,1}
BoatSailingYachtnumpos[10]={4,1}
BoatSailingYachtnumpos[11]={0,2}
BoatSailingYachtnumpos[12]={1,2}
BoatSailingYachtnumpos[13]={2,2}
BoatSailingYachtnumpos[14]={3,2}
BoatSailingYachtnumpos[15]={4,2}
BoatSailingYachtnumpos[16]={0,3}
BoatSailingYachtnumpos[17]={1,3}
BoatSailingYachtnumpos[18]={2,3}
BoatSailingYachtnumpos[19]={3,3}
BoatSailingYachtnumpos[20]={4,3}
BoatSailingYachtnumpos[21]={0,4}
BoatSailingYachtnumpos[22]={1,4}
BoatSailingYachtnumpos[23]={2,4}
BoatSailingYachtnumpos[24]={3,4}
BoatSailingYachtnumpos[25]={4,4}

local housedel
local housedelY

local function BoatSailingYachtLoadGridsquare(square)
    if square:getX()==(cellPosX+1)+60*housedel and square:getY()==(cellPosY+15)+60*housedelY and square:getZ() ==0 then
        local NewGenerator
        local objects = square:getObjects()
        if square:getObjects():size()>1 and instanceof(square:getObjects():get(1), "IsoGenerator") then
            print("havegenerator")
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
        Events.LoadGridsquare.Remove(BoatSailingYachtLoadGridsquare)
    end
end

local function enterBoatSailingYacht(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().BoatSailingYachtnum==nil then
                getGameTime():getModData().BoatSailingYachtnum=0
    
                
            end
            getGameTime():getModData().BoatSailingYachtnum=getGameTime():getModData().BoatSailingYachtnum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().BoatSailingYachtnum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=BoatSailingYachtnumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().BoatSailingYachtpos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
        --genCondition = player:getVehicle():getPartById("Battery"):getCondition()
        batteryPower = player:getVehicle():getBatteryCharge()
        Events.OnTick.Remove(ChimeTick)
        vehicle:exit(player)
        player:setX((cellPosX+2)+60*housedel)
        player:setY((cellPosY+8)+60*housedelY)
        player:setZ(0)
        player:setLx((cellPosX+2)+60*housedel)
        player:setLy((cellPosY+8)+60*housedelY)
        player:setLz(0)
        Events.LoadGridsquare.Add(BoatSailingYachtLoadGridsquare)
    end
end

local function BoatSailingYachtOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    if vehicle:getScript():getFullName() ~= "Base.BoatSailingYacht" and vehicle:getScript():getFullName() ~= "Base.BoatSailingYacht_Ground" then return end
    -- if vehicle:getSeat(player)>=2
    -- print(vehicle:getSeat(player))
    if vehicle:getSeat(player)>=2 then
        if player:isNPC() then return end
        local BoatSailingYachtenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, enterBoatSailingYacht, 0,player,vehicle)
        BoatSailingYachtenter:initialise()
        BoatSailingYachtenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(BoatSailingYachtOnSwitchVehicleSeat)
