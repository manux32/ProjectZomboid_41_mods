local function cahouseEveryHours()
    for y=0,4 do
        for u=0,4 do

            local square=getCell():getGridSquare(1501+60*y,8406+60*u,2)
            if square then
                local objects=square:getObjects()
                if objects then
                    for i=1,objects:size() do
                        if instanceof(objects:get(i-1), "IsoGenerator") then
                            objects:get(i-1):setFuel(99999)
                            objects:get(i-1):setCondition(99999)
                            print("updategen")
                        end
                    end
                end
            end
        end
    end
	-- Your code here
end

Events.EveryHours.Add(cahouseEveryHours)








local carhousenumpos={}
carhousenumpos[1]={0,0}
carhousenumpos[2]={1,0}
carhousenumpos[3]={2,0}
carhousenumpos[4]={3,0}
carhousenumpos[5]={4,0}
carhousenumpos[6]={0,1}
carhousenumpos[7]={1,1}
carhousenumpos[8]={2,1}
carhousenumpos[9]={3,1}
carhousenumpos[10]={4,1}
carhousenumpos[11]={0,2}
carhousenumpos[12]={1,2}
carhousenumpos[13]={2,2}
carhousenumpos[14]={3,2}
carhousenumpos[15]={4,2}
carhousenumpos[16]={0,3}
carhousenumpos[17]={1,3}
carhousenumpos[18]={2,3}
carhousenumpos[19]={3,3}
carhousenumpos[20]={4,3}
carhousenumpos[21]={0,4}
carhousenumpos[22]={1,4}
carhousenumpos[23]={2,4}
carhousenumpos[24]={3,4}
carhousenumpos[25]={4,4}

local housedel
local housedelY

local function carhouseLoadGridsquare(square)
    if square:getX()==1501+60*housedel and square:getY()==8406+60*housedelY and square:getZ() ==2 then
        local NewGenerator
        local objects = square:getObjects()
        -- if square:getObjects():size()<=1 then return end
        if square:getObjects():size()>1 and instanceof(square:getObjects():get(1), "IsoGenerator") then
            print("havegenerator")
            NewGenerator = square:getObjects():get(1)
            NewGenerator:setConnected(true)
            NewGenerator:setFuel(99999)
            NewGenerator:setCondition(99999)
            NewGenerator:setActivated(true)
            NewGenerator:setSurroundingElectricity()


        else
            print("nohavegenerator")
            
            NewGenerator = IsoGenerator.new(nil,getCell(),square)
            NewGenerator:setConnected(true)
            NewGenerator:setFuel(99999)
            NewGenerator:setCondition(99999)
            NewGenerator:setActivated(true)
            NewGenerator:setSurroundingElectricity()
        end
        Events.LoadGridsquare.Remove(carhouseLoadGridsquare)
    end
end

local function entercarhouse(this,button,player,vehicle)
    if button.internal == "YES" then
        if vehicle:getModData().carishousenum ==nil then

            if getGameTime():getModData().carhousenum==nil then
                getGameTime():getModData().carhousenum=0
    
                
            end
            getGameTime():getModData().carhousenum=getGameTime():getModData().carhousenum+1
            vehicle:getModData().carishousenum=getGameTime():getModData().carhousenum
            -- if vehicle:getModData().carishousenum>25 then return end

        end
        local detxy=carhousenumpos[vehicle:getModData().carishousenum]
        if detxy==nil then return end
        housedel=detxy[1]
        housedelY=detxy[2]

        player:getModData().carhousepos={true,{player:getX(),player:getY(),player:getZ()},housedel,housedelY}
        vehicle:exit(player)
        player:setX(1501+60*housedel)
        player:setY(8406+60*housedelY)
        player:setZ(0)
        player:setLx(1501+60*housedel)
        player:setLy(8406+60*housedelY)
        player:setLz(0)
        Events.LoadGridsquare.Add(carhouseLoadGridsquare)
    end
end

local function carhouseOnSwitchVehicleSeat(player)
	local vehicle = player:getVehicle()
    if vehicle:getScript():getFullName() ~= "Base.ArmoredMotorhome" then return end
    -- if vehicle:getSeat(player)==2
    -- print(vehicle:getSeat(player))
    if vehicle:getSeat(player)==2 then
        local carhouseenter = ISModalDialog:new(0,0, 250, 150, getText("IGUI_jinruchefang"), true, nil, entercarhouse, 0,player,vehicle)
        carhouseenter:initialise()
        carhouseenter:addToUIManager()
        
    end

end

Events.OnSwitchVehicleSeat.Add(carhouseOnSwitchVehicleSeat)