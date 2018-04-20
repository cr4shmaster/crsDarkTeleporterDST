-- More information here: https://sites.google.com/view/cr4shmaster/dark-teleporter-ds-dst

name = "Dark Teleporter v1.0.2"
description = "A super cool teleporter."
author = "cr4shmaster"
version = "1.0.2"
forumthread = ""
api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"dark", "teleporter"}

local function crsSetCount(k)
    return {description = ""..k.."", data = k}
end

local function crsSetTab(k)
    local name = {"Tools", "Survival", "Farm", "Science", "Structures", "Refine", "Magic"}
    return {description = ""..name[k].."", data = k}
end

local function crsSetTech(k)
    local name = {"None", "Science Machine", "Alchemy Engine", "Prestihatitator", "Shadow Manip.", "Broken APS", "Repaired APS"}
    return {description = ""..name[k].."", data = k}
end

local crsDamage = {} for k=1,7,1 do crsDamage[k] = crsSetCount(k*10) end
local crsRange = {} for k=1,20,1 do crsRange[k] = crsSetCount(k*5) end
local crsIngredient = {} for k=1,20,1 do crsIngredient[k] = crsSetCount(k) end
local crsDuration = {} for k=1,12,1 do crsDuration[k] = crsSetCount(k*5) end
local crsRadius = {} for k=1,4,1 do crsRadius[k] = crsSetCount(k/2) end
local crsTab = {} for k=1,7,1 do crsTab[k] = crsSetTab(k) end
local crsTech = {} for k=1,7,1 do crsTech[k] = crsSetTech(k) end

configuration_options = {
    {name = "cfgRecipeTab", label = "Recipe Tab", options = crsTab, default = 1,},
    {name = "cfgRecipeTech", label = "Recipe Tech", options = crsTech, default = 5,},
    {name = "cfgMarble", label = "Marble", options = crsIngredient, default = 3,},
    {name = "cfgGems", label = "Purple Gems", options = crsIngredient, default = 1,},
    {name = "cfgFuel", label = "Nightmare Fuel", options = crsIngredient, default = 5,},
    {name = "cfgDTHealthCost", label = "Max Damage On Use", options = crsDamage, default = 30,},
    {name = "cfgDTCooldown", label = "On Use Disable For", options = crsDuration, default = 20,},
    {name = "cfgDTRange", label = "Teleport Range", options = crsRange, default = 20,},
    {name = "cfgDTRadius", label = "Activation Radius", options = crsRadius, default = .5,},
    {name = "cfgTestCheck", label = "Installed", options = {{description = "Yes", data = true}}, default = true,},
}
