PrefabFiles = {"darkteleporter"}

local crsDTColors = {"red", "green", "blue", "yellow"}

Assets = {}
for k=1, #crsDTColors, 1 do 
	table.insert(Assets, Asset("ATLAS", "images/inventoryimages/darkteleporter_"..crsDTColors[k]..".xml"))
	table.insert(Assets, Asset("ATLAS", "minimap/darkteleporter_"..crsDTColors[k]..".xml"))
end

local STRINGS = GLOBAL.STRINGS
local REC = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local getConfig = GetModConfigData

-- MAP ICONS --

for k=1, #crsDTColors, 1 do
	AddMinimapAtlas("minimap/darkteleporter_"..crsDTColors[k]..".xml")
end

-- STRINGS --

STRINGS.NAMES.DARKTELEPORTER_RED = "Red Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_RED = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_RED = "Teleportation is awesome!"
STRINGS.NAMES.DARKTELEPORTER_GREEN = "Green Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_GREEN = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_GREEN = "Teleportation is awesome!"
STRINGS.NAMES.DARKTELEPORTER_BLUE = "Blue Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_BLUE = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_BLUE = "Teleportation is awesome!"
STRINGS.NAMES.DARKTELEPORTER_YELLOW = "Yellow Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_YELLOW = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_YELLOW = "Teleportation is awesome!"

-- RECIPES --

local crsRecipeTabs = {REC.TOOLS, REC.SURVIVAL, REC.FARM, REC.SCIENCE, REC.TOWN, REC.REFINE, REC.MAGIC,}
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

local function crsAddRecipe(col)
    local mats = {Ingredient("marble", getConfig("cfgMarble")), Ingredient("purplegem", getConfig("cfgGems")), Ingredient("nightmarefuel", getConfig("cfgFuel"))}
    return AddRecipe("darkteleporter_"..col, mats, recipeTab, recipeTech, "darkteleporter_placer", nil, nil, nil, nil, "images/inventoryimages/darkteleporter_"..col..".xml")
end
-- add recipes
crsAddRecipe("red") crsAddRecipe("green") crsAddRecipe("blue") crsAddRecipe("yellow")
