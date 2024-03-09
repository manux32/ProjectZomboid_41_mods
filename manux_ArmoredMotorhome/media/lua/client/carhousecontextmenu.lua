local zsquare


local function OnPlayerEntercar(player)


    local square = player:getCurrentSquare()
    if square==nil then return end
    local vehicle=square:getVehicleContainer()
    if vehicle~=nil then
        vehicle:enter(2, player)
        Events.OnPlayerUpdate.Remove(OnPlayerEntercar)
        

        
    end


    




    

    -- vehicle:enter(0, player)
	-- Your code here
end





local function carhouseexitf(worldObjects,player)

    -- player=getPlayer(player)




    if luautils.walkAdj(player,zsquare) then

        -- print(zsquare)

        player:setX(player:getModData().carhousepos[2][1])
        player:setY(player:getModData().carhousepos[2][2])
        player:setZ(player:getModData().carhousepos[2][3])
        player:setLx(player:getModData().carhousepos[2][1])
        player:setLy(player:getModData().carhousepos[2][2])
        player:setLz(player:getModData().carhousepos[2][3])
    
        -- local vehicle=getVehicleById(player:getModData().carhousepos[5])
    
        Events.OnPlayerUpdate.Add(OnPlayerEntercar)
        
    end

    




    

    
    -- print(vehicle)

    -- print(vehicle
    -- local vehicle=

    -- print(getPlayer():getCurrentSquare():getVehicleContainer():enter(0, getPlayer()))

end



    
	




local function carhouseexit(player, context, worldObjects)
	-- if isClient() and getPlayer():getAccessLevel()=="Admin" then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
	-- elseif not isClient() then
	-- 	context:addOption("TilesPicker", worldObjects,BTPinit,player)
		
	-- end

    player=getPlayer(player)

    if player:getModData().carhousepos==nil then return end

    
    local square=player:getCurrentSquare()
    local _x=square:getX()
    local _y=square:getY()
    local _z=square:getZ()

    -- getCell():getGridSquare()
    

    local carhouseinfo = player:getModData().carhousepos[3]


    square=getCell():getGridSquare(1502+(carhouseinfo)*60,8406,0)


    -- if 

    -- if luautils.walkAdj(player,square) then


        
    -- end

    local __x = 1500+(carhouseinfo)*60
    if _x>=__x and _x<=__x+2 and _y>=8400+player:getModData().carhousepos[4]*60 and _y<=8407+player:getModData().carhousepos[4]*60 and _z==0 then
        zsquare=getCell():getGridSquare(__x+2,8406+player:getModData().carhousepos[4]*60,0)

        context:addOption(getText("IGUI_exitcarhouse"), worldObjects,carhouseexitf,player)
        
    end

    
		
	
end
Events.OnFillWorldObjectContextMenu.Add(carhouseexit)