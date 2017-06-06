PrefabFiles = {
    "darkteleporter",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/darkteleporter.xml"),
    Asset("IMAGE", "images/inventoryimages/darkteleporter.tex"),
    Asset("ATLAS", "minimap/darkteleporter.xml"),
    Asset("IMAGE", "minimap/darkteleporter.tex"),
}

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
IsDLCEnabled = GLOBAL.IsDLCEnabled
getConfig = GetModConfigData
GetPlayer = GLOBAL.GetPlayer
FindEntity = GLOBAL.FindEntity
EQUIPSLOTS = GLOBAL.EQUIPSLOTS
SpawnPrefab = GLOBAL.SpawnPrefab

-- MAP ICONS --

AddMinimapAtlas("minimap/darkteleporter.xml")

-- STRINGS --

STRINGS.NAMES.DARKTELEPORTER = "Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER = "Teleportation is awesome!"

-- RECIPES --

local crsRecipeTabs = {
    RECIPETABS.TOOLS,
    RECIPETABS.SURVIVAL,
    RECIPETABS.FARM,
    RECIPETABS.SCIENCE,
    RECIPETABS.TOWN,
    RECIPETABS.REFINE,
    RECIPETABS.MAGIC,
}
local recipeTab = crsRecipeTabs[getConfig("cfgRecipeTab")]

local crsRecipeTechs = {
    TECH.NONE,
    TECH.SCIENCE_ONE, -- Science Machine
    TECH.SCIENCE_TWO, -- Alchemy Engine
    TECH.MAGIC_TWO, -- Prestihatitator
    TECH.MAGIC_THREE, -- Shadow Manipulator
    TECH.ANCIENT_TWO, -- Broken APS
    TECH.ANCIENT_FOUR, -- Repaired APS
    TECH.OBSIDIAN_TWO, -- Obsidian Workbench
}
local recipeTech = crsRecipeTechs[getConfig("cfgRecipeTech")]

local darkteleporter = AddRecipe("darkteleporter", {
    Ingredient("marble", getConfig("cfgMarble")),
    Ingredient("purplegem", getConfig("cfgGems")),
    Ingredient("nightmarefuel", getConfig("cfgFuel")),
}, recipeTab, recipeTech, "darkteleporter_placer")
darkteleporter.atlas = "images/inventoryimages/darkteleporter.xml"

-- TELEPORTATION --

local radius = GetModConfigData("cfgDTRadius")
local range = GetModConfigData("cfgDTRange")
local healthCost = GetModConfigData("cfgDTHeathCost")
local cooldown = GetModConfigData("cfgDTCooldown")

AddPrefabPostInit("darkteleporter", function (inst)
    inst.components.playerprox:SetDist(radius, 1)
    inst.components.playerprox.onnear = function()
        local findDT = FindEntity(inst, range, function(DT) 
            return DT:HasTag("crsDarkTeleporter")
        end)
        local item = GetPlayer().components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        local hammer = (item and item.name == "Hammer")
        if findDT and findDT ~= inst and not findDT:HasTag("crsJustUsed") and not inst:HasTag("crsJustUsed") then
            if not hammer then 
                inst:AddTag("crsJustUsed")
                findDT:AddTag("crsJustUsed")
                local target = findDT:GetPosition()
                local fx = SpawnPrefab("small_puff")
                local gamble = math.random(healthCost)
                inst.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
                GetPlayer().Transform:SetPosition(target.x, target.y, target.z)
                fx.Transform:SetPosition(target.x, target.y, target.z)
                GetPlayer().components.health:DoDelta(-gamble) -- does damage when used
                inst:DoTaskInTime(cooldown, function()
                    inst:RemoveTag("crsJustUsed")
                    findDT:RemoveTag("crsJustUsed")
                end)
            end 
        end
    end 
end)
