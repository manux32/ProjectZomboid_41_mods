
function GiveXP_Tailoring(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, ingredients:size() * 5);
end

function GiveXP_Carpentry(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, ingredients:size() * 5);
end

function GiveXP_Electrical(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Electricity, ingredients:size() * 5);
end

function GiveXP_MetalWelding(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, ingredients:size() * 5);
end


-------------------------- COMBOS --------------------------

function GiveXP_Electrical_Tailoring(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Electricity, ingredients:size() * 2.5);
	player:getXp():AddXP(Perks.Tailoring, ingredients:size() * 2.5);
end

function GiveXP_MetalWelding_Electrical(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, ingredients:size() * 2.5);
	player:getXp():AddXP(Perks.Electricity, ingredients:size() * 2.5);
end

-- Other Perks calls examples (IsoPlayer.Perks):
--Perks.Cooking
--Perks.Farming
--Perks.Fishing
--Perks.Trapping
--Perks.Mechanics
--Perks.Doctor
