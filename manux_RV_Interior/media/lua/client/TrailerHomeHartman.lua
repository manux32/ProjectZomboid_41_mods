local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 22800
local cellPosY = 12900


local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local supportedVehicles = Set {
"Base.TrailerHomeHartman", 
"Base.fhq92EconolineT3Ambulance", 
"Base.moveurself", 
"Base.67commando",
"Base.67commandoT50", 
"Base.67commandoPolice", 
"Base.StepVanMail",
"Base.ATA_VanDeRumba",
}


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





local function TrailerHomeHartmanexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().TrailerHomeHartmanpos[2][1])
        player:setY(player:getModData().TrailerHomeHartmanpos[2][2])
        player:setZ(player:getModData().TrailerHomeHartmanpos[2][3])
        player:setLx(player:getModData().TrailerHomeHartmanpos[2][1])
        player:setLy(player:getModData().TrailerHomeHartmanpos[2][2])
        player:setLz(player:getModData().TrailerHomeHartmanpos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().TrailerHomeHartmanpos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function TrailerHomeHartmanexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().TrailerHomeHartmanpos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local TrailerHomeHartmaninfo = player:getModData().TrailerHomeHartmanpos[3]


    square=getCell():getGridSquare((cellPosX+2)+(TrailerHomeHartmaninfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(TrailerHomeHartmaninfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().TrailerHomeHartmanpos[4]*60 and _y<=(cellPosY+7)+player:getModData().TrailerHomeHartmanpos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().TrailerHomeHartmanpos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,TrailerHomeHartmanexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(TrailerHomeHartmanexit)

---------------------------------------------------------------------------------------------------------------------------

local function TrailerHomeHartmanEveryHours()
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

Events.EveryHours.Add(TrailerHomeHartmanEveryHours)








local TrailerHomeHartmannumpos={}
TrailerHomeHartmannumpos[1]={0,0}
TrailerHomeHartmannumpos[2]={1,0}
TrailerHomeHartmannumpos[3]={2,0}
TrailerHomeHartmannumpos[4]={3,0}
TrailerHomeHartmannumpos[5]={4,0}
TrailerHomeHartmannumpos[6]={0,1}
TrailerHomeHartmannumpos[7]={1,1}
TrailerHomeHartmannumpos[8]={2,1}
TrailerHomeHartmannumpos[9]={3,1}
TrailerHomeHartmannumpos[10]={4,1}
TrailerHomeHartmannumpos[11]={0,2}
TrailerHomeHartmannumpos[12]={1,2}
TrailerHomeHartmannumpos[13]={2,2}
TrailerHomeHartmannumpos[14]={3,2}
TrailerHomeHartmannumpos[15]={4,2}
TrailerHomeHartmannumpos[16]={0,3}
TrailerHomeHartmannumpos[17]={1,3}
TrailerHomeHartmannumpos[18]={2,3}
TrailerHomeHartmannumpos[19]={3,3}
TrailerHomeHartmannumpos[20]={4,3}
TrailerHomeHartmannumpos[21]={0,4}
TrailerHomeHartmannumpos[22]={1,4}
TrailerHomeHartmannumpos[23]={2,4}
TrailerHomeHartmannumpos[24]={3,4}
TrailerHomeHartmannumpos[25]={4,4}

local housedel
local housedelY

local function TrailerHomeHartmanLoadGridsquare(square)
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
        Events.LoadGridsquare.Remove(TrailerHomeHartmanLoadGridsquare)
    end
end

local function enterTrailerHomeHartman(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().TrailerHomeHartmannum==nil then
                getGameTime():getModData().TrailerHomeHartmannum=0
    
                
            end
            getGameTime():getModData().TrailerHomeHartmannum=getGameTime():getModData().TrailerHomeHartmannum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().TrailerHomeHartmannum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=TrailerHomeHartmannumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().TrailerHomeHartmanpos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
        --genCondition = player:getVehicle():getPartById("Battery"):getCondition()
        --batteryPower = player:getVehicle():getBatteryCharge()
        batteryPower = 100
        Events.OnTick.Remove(ChimeTick)
        vehicle:exit(player)
        player:setX((cellPosX+2)+60*housedel)
        player:setY((cellPosY+4)+60*housedelY)
        player:setZ(0)
        player:setLx((cellPosX+2)+60*housedel)
        player:setLy((cellPosY+4)+60*housedelY)
        player:setLz(0)
        Events.LoadGridsquare.Add(TrailerHomeHartmanLoadGridsquare)
    end
end

local function TrailerHomeHartmanOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    --if vehicle:getScript():getFullName() ~= "Base.TrailerHomeHartman" then return end
	if not supportedVehicles[vehicle:getScript():getFullName()] then return end
    -- if vehicle:getSeat(player)==2
    -- print(vehicle:getSeat(player))
    --if vehicle:getSeat(player)>=2 then
	if vehicle:getSeat(player)>=1 then
        if player:isNPC() then return end
        local TrailerHomeHartmanenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, enterTrailerHomeHartman, 0,player,vehicle)
        TrailerHomeHartmanenter:initialise()
        TrailerHomeHartmanenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(TrailerHomeHartmanOnSwitchVehicleSeat)
