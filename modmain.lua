PrefabFiles = {"darkteleporter",}

Assets = {
    Asset("ATLAS", "images/inventoryimages/darkteleporter.xml"),
    Asset("ATLAS", "minimap/darkteleporter.xml"),
}

local STRINGS = GLOBAL.STRINGS
local REC = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local getConfig = GetModConfigData

-- MAP ICONS --

AddMinimapAtlas("minimap/darkteleporter.xml")

-- STRINGS --

STRINGS.NAMES.DARKTELEPORTER = "Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER = "Teleportation is awesome!"

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

local darkteleporter = AddRecipe("darkteleporter", {
    Ingredient("marble", getConfig("cfgMarble")),
    Ingredient("purplegem", getConfig("cfgGems")),
    Ingredient("nightmarefuel", getConfig("cfgFuel")),
}, recipeTab, recipeTech, "darkteleporter_placer")
darkteleporter.atlas = "images/inventoryimages/darkteleporter.xml"