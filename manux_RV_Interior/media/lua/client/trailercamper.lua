local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 22500
local cellPosY = 12000


local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local supportedVehicles = Set {
"Base.Trailercamperscamp", 
"Base.86econoline", 
"Base.86econolineflorist", 
"Base.fhq92Econoline",
"Base.fhq92EconolineValkyrie",
"Base.fhq92EconolinePanel",
"Base.fhq92EconolinePAYDAY",
"Base.VanSpecial",
"Base.VanSpiffo",
"Base.VanAmbulance",
"Base.Van_Transit",
"Base.Van_KnoxDisti",
"Base.Van_MassGenFac",
"Base.Van_LectroMax",
"Base.Van",
"Base.astrovan",
"Base.m113a1",
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





local function trailercamperexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().trailercamperpos[2][1])
        player:setY(player:getModData().trailercamperpos[2][2])
        player:setZ(player:getModData().trailercamperpos[2][3])
        player:setLx(player:getModData().trailercamperpos[2][1])
        player:setLy(player:getModData().trailercamperpos[2][2])
        player:setLz(player:getModData().trailercamperpos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().trailercamperpos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function trailercamperexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().trailercamperpos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local trailercamperinfo = player:getModData().trailercamperpos[3]


    square=getCell():getGridSquare((cellPosX+2)+(trailercamperinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(trailercamperinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().trailercamperpos[4]*60 and _y<=(cellPosY+7)+player:getModData().trailercamperpos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().trailercamperpos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,trailercamperexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(trailercamperexit)

---------------------------------------------------------------------------------------------------------------------------

local function trailercamperEveryHours()
    for y=0,4 do
        for u=0,4 do

            local square=getCell():getGridSquare(cellPosX+60*y,(cellPosY+15)+60*u,0)
            if square then
                local objects=square:getObjects()
                if objects then
                    for i=1,objects:size() do
                        if instanceof(objects:get(i-1), "IsoGenerator") then
                            objects:get(i-1):setFuel(batteryPower*100)
                            objects:get(i-1):setCondition(genCondition)
                            objects:get(i-1):setActivated(true)
                            if (batteryPower*100) <= 0 then
                                objects:get(i-1):setActivated(false)
                            end
                            print("updategen")
                        end
                    end
                end
            end
        end
    end
	-- Your code here
end

Events.EveryHours.Add(trailercamperEveryHours)







local trailercampernumpos={}
trailercampernumpos[1]={0,0}
trailercampernumpos[2]={1,0}
trailercampernumpos[3]={2,0}
trailercampernumpos[4]={3,0}
trailercampernumpos[5]={4,0}
trailercampernumpos[6]={0,1}
trailercampernumpos[7]={1,1}
trailercampernumpos[8]={2,1}
trailercampernumpos[9]={3,1}
trailercampernumpos[10]={4,1}
trailercampernumpos[11]={0,2}
trailercampernumpos[12]={1,2}
trailercampernumpos[13]={2,2}
trailercampernumpos[14]={3,2}
trailercampernumpos[15]={4,2}
trailercampernumpos[16]={0,3}
trailercampernumpos[17]={1,3}
trailercampernumpos[18]={2,3}
trailercampernumpos[19]={3,3}
trailercampernumpos[20]={4,3}
trailercampernumpos[21]={0,4}
trailercampernumpos[22]={1,4}
trailercampernumpos[23]={2,4}
trailercampernumpos[24]={3,4}
trailercampernumpos[25]={4,4}

local housedel
local housedelY

local function trailercamperLoadGridsquare(square)
    if square:getX()==cellPosX+60*housedel and square:getY()==(cellPosY+15)+60*housedelY and square:getZ() ==0 then
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
        Events.LoadGridsquare.Remove(trailercamperLoadGridsquare)
    end
end

local function entertrailercamper(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().trailercampernum==nil then
                getGameTime():getModData().trailercampernum=0
    
                
            end
            getGameTime():getModData().trailercampernum=getGameTime():getModData().trailercampernum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().trailercampernum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=trailercampernumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().trailercamperpos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
        --[[
		batteryPower = 0
        if vehicle:getVehicleTowedBy() ~=nil then
            --genCondition = player:getVehicle():getVehicleTowedBy():getPartById("Battery"):getCondition()
            batteryPower = player:getVehicle():getVehicleTowedBy():getBatteryCharge()
        end
		]]--
        batteryPower = 100
        Events.OnTick.Remove(ChimeTick)
        vehicle:exit(player)
        player:setX((cellPosX+1)+60*housedel)
        player:setY((cellPosY+4)+60*housedelY)
        player:setZ(0)
        player:setLx((cellPosX+1)+60*housedel)
        player:setLy((cellPosY+4)+60*housedelY)
        player:setLz(0)
        Events.LoadGridsquare.Add(trailercamperLoadGridsquare)
    end
end

local function trailercamperOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    --if vehicle:getScript():getFullName() ~= "Base.Trailercamperscamp" then return end
	if not supportedVehicles[vehicle:getScript():getFullName()] then return end
    -- if vehicle:getSeat(player)==2
    -- print(vehicle:getSeat(player))
    --if vehicle:getSeat(player)>=2 then
	if vehicle:getSeat(player)>=1 then
        if player:isNPC() then return end
        local trailercamperenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, entertrailercamper, 0,player,vehicle)
        trailercamperenter:initialise()
        trailercamperenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(trailercamperOnSwitchVehicleSeat)
