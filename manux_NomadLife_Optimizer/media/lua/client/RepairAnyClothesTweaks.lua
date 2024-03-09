if getActivatedMods():contains("ItemTweakerAPI") then
	require("ItemTweaker_Core");
else return end

-- New ones
TweakItem("Base.Metro_Coat", "FabricType", "Leather");
TweakItem("Base.Chain_Coat", "FabricType", "Leather");
TweakItem("Base.Chain_Mask", "FabricType", "Leather");
TweakItem("Base.Chain_Pants", "FabricType", "Leather");
TweakItem("Base.Chain_Pants_Rolled", "FabricType", "Leather");
TweakItem("Base.Military_Gaiter", "FabricType", "Leather");
TweakItem("Base.Military_Gaiter_Loose", "FabricType", "Leather");
TweakItem("Base.OZK_Gaiter", "FabricType", "Leather");
TweakItem("Base.OZK_Gaiter_Loose", "FabricType", "Leather");

-- Adjust items to be repairable
--[[
TweakItem("Base.Armor_Defender", "FabricType", "Leather");
TweakItem("Base.Armor_Defender_Set", "FabricType", "Leather");
TweakItem("Base.Bag_Plate_Carrier", "FabricType", "Leather");
TweakItem("Base.SET_Armor", "FabricType", "Leather");
TweakItem("Base.SET_Armor_FULL", "FabricType", "Leather");
TweakItem("Base.Wolf_Plate_Carrier", "FabricType", "Leather");
TweakItem("Base.Wolf_Plate_Carrier_B", "FabricType", "Leather");
TweakItem("Base.EOD_Armor", "FabricType", "Leather");
TweakItem("Base.JUGG_Armor", "FabricType", "Leather");
TweakItem("Base.Armor_Dozer", "FabricType", "Leather");
TweakItem("Base.EXO_Suit", "FabricType", "Leather");
TweakItem("Base.EXO_Suit_ON", "FabricType", "Leather");
TweakItem("Base.Suit_Chempak", "FabricType", "Leather");
TweakItem("Base.Bag_Plate_Carrier", "FabricType", "Leather");
TweakItem("Base.Armor_6B13", "FabricType", "Leather");
TweakItem("Base.Sheriff_Vest", "FabricType", "Leather");
TweakItem("Base.Sheriff_Vest_Full", "FabricType", "Leather");
TweakItem("Base.Bag_Sniper_Hood", "FabricType", "Leather");
TweakItem("Base.Bag_Sniper_Hood_ON", "FabricType", "Leather");
TweakItem("Base.Bag_Sniper_Suit", "FabricType", "Leather");
TweakItem("Base.Bag_Sniper_Suit_Off", "FabricType", "Leather");
TweakItem("Base.Military_Cloak", "FabricType", "Leather");
TweakItem("Base.Military_Cloak_OFF", "FabricType", "Leather");
TweakItem("Base.Military_Ghillie", "FabricType", "Leather");
TweakItem("Base.Military_Ghillie_B", "FabricType", "Leather");
TweakItem("Base.Military_Ghillie_C", "FabricType", "Leather");
TweakItem("Base.Military_Ghillie_D", "FabricType", "Leather");
TweakItem("Base.Boots_Heather", "FabricType", "Leather");
TweakItem("Base.Boots_Bennett", "FabricType", "Leather");
TweakItem("Base.Boots_James", "FabricType", "Leather");
TweakItem("Base.Shoes_Lisa", "FabricType", "Leather");
TweakItem("Base.Boots_Maria", "FabricType", "Leather");
TweakItem("Base.Tac_Boots", "FabricType", "Leather");
TweakItem("Base.Boots_Trackstar", "FabricType", "Leather");
TweakItem("Base.Susie_Boots", "FabricType", "Leather");
TweakItem("Base.SET_Boots", "FabricType", "Leather");
TweakItem("Base.Ashe_Boots", "FabricType", "Leather");
TweakItem("Base.Mechanic_Boots", "FabricType", "Leather");
TweakItem("Base.Rabbit_Suit", "FabricType", "Leather");
TweakItem("Base.Rabbit_Suit_Blue", "FabricType", "Leather");
TweakItem("Base.Rabbit_Suit_Green", "FabricType", "Leather");
TweakItem("Base.Rabbit_Suit_Grey", "FabricType", "Leather");
TweakItem("Base.Rabbit_Suit_Purple", "FabricType", "Leather");
TweakItem("Base.Rabbit_Suit_Yellow", "FabricType", "Leather");
TweakItem("Base.USCM_Boots", "FabricType", "Leather");
TweakItem("Base.USCM_Armor", "FabricType", "Leather");
--]]