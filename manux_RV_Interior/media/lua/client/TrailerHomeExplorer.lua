local zsquare
local genCondition = 9999
local batteryPower
local cellPosX = 22500
local cellPosY = 12900


local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local supportedVehicles = Set {
"Base.TrailerHomeExplorer", 
"Base.86econolineambulance", 
"Base.fhq92Econoline4Door",
"Base.fhq92EconolineXL",
"Base.80f350ambulance",
"Base.isuzubox",
"Base.isuzuboxelec",
"Base.isuzuboxfood",
"Base.ATAPetyarbuiltSleeper",
"Base.ATAPetyarbuiltSleeperLong",
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





local function trailerHomeExplorerexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().trailerHomeExplorerpos[2][1])
        player:setY(player:getModData().trailerHomeExplorerpos[2][2])
        player:setZ(player:getModData().trailerHomeExplorerpos[2][3])
        player:setLx(player:getModData().trailerHomeExplorerpos[2][1])
        player:setLy(player:getModData().trailerHomeExplorerpos[2][2])
        player:setLz(player:getModData().trailerHomeExplorerpos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().trailerHomeExplorerpos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function trailerHomeExplorerexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().trailerHomeExplorerpos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local trailerHomeExplorerinfo = player:getModData().trailerHomeExplorerpos[3]


    square=getCell():getGridSquare((cellPosX+2)+(trailerHomeExplorerinfo)*60,(cellPosY+6),0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = cellPosX+(trailerHomeExplorerinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=cellPosY+player:getModData().trailerHomeExplorerpos[4]*60 and _y<=(cellPosY+7)+player:getModData().trailerHomeExplorerpos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,(cellPosY+6)+player:getModData().trailerHomeExplorerpos[4]*60,0)

        context:addOption(getText("IGUI_exitrvinterior"), worldObjects,trailerHomeExplorerexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(trailerHomeExplorerexit)

---------------------------------------------------------------------------------------------------------------------------

local function trailerHomeExplorerEveryHours()
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

Events.EveryHours.Add(trailerHomeExplorerEveryHours)








local trailerHomeExplorernumpos={}
trailerHomeExplorernumpos[1]={0,0}
trailerHomeExplorernumpos[2]={1,0}
trailerHomeExplorernumpos[3]={2,0}
trailerHomeExplorernumpos[4]={3,0}
trailerHomeExplorernumpos[5]={4,0}
trailerHomeExplorernumpos[6]={0,1}
trailerHomeExplorernumpos[7]={1,1}
trailerHomeExplorernumpos[8]={2,1}
trailerHomeExplorernumpos[9]={3,1}
trailerHomeExplorernumpos[10]={4,1}
trailerHomeExplorernumpos[11]={0,2}
trailerHomeExplorernumpos[12]={1,2}
trailerHomeExplorernumpos[13]={2,2}
trailerHomeExplorernumpos[14]={3,2}
trailerHomeExplorernumpos[15]={4,2}
trailerHomeExplorernumpos[16]={0,3}
trailerHomeExplorernumpos[17]={1,3}
trailerHomeExplorernumpos[18]={2,3}
trailerHomeExplorernumpos[19]={3,3}
trailerHomeExplorernumpos[20]={4,3}
trailerHomeExplorernumpos[21]={0,4}
trailerHomeExplorernumpos[22]={1,4}
trailerHomeExplorernumpos[23]={2,4}
trailerHomeExplorernumpos[24]={3,4}
trailerHomeExplorernumpos[25]={4,4}

local housedel
local housedelY

local function trailerHomeExplorerLoadGridsquare(square)
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
        Events.LoadGridsquare.Remove(trailerHomeExplorerLoadGridsquare)
    end
end

local function entertrailerHomeExplorer(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().trailerHomeExplorernum==nil then
                getGameTime():getModData().trailerHomeExplorernum=0
    
                
            end
            getGameTime():getModData().trailerHomeExplorernum=getGameTime():getModData().trailerHomeExplorernum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().trailerHomeExplorernum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=trailerHomeExplorernumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().trailerHomeExplorerpos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
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
        Events.LoadGridsquare.Add(trailerHomeExplorerLoadGridsquare)
    end
end

local function trailerHomeExplorerOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    --if vehicle:getScript():getFullName() ~= "Base.TrailerHomeExplorer" then return end
	if not supportedVehicles[vehicle:getScript():getFullName()] then return end
    -- if vehicle:getSeat(player)==2
    -- print(vehicle:getSeat(player))
    --if vehicle:getSeat(player)>=2 then
	if vehicle:getSeat(player)>=1 then
        if player:isNPC() then return end
        local trailerHomeExplorerenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_enterrvinterior"), true, nil, entertrailerHomeExplorer, 0,player,vehicle)
        trailerHomeExplorerenter:initialise()
        trailerHomeExplorerenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(trailerHomeExplorerOnSwitchVehicleSeat)
