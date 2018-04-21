local assets = {Asset("ANIM", "anim/darkteleporter.zip")}

local getConfig = GetModConfigData
local crsDarkTeleporterDST = getConfig("cfgTestCheck", "workshop-941067360") and "workshop-941067360" or "crsDarkTeleporterDST"
local radius = getConfig("cfgDTRadius", crsDarkTeleporterDST)
local range = getConfig("cfgDTRange", crsDarkTeleporterDST)
local healthCost = getConfig("cfgDTHealthCost", crsDarkTeleporterDST)
local cooldown = getConfig("cfgDTCooldown", crsDarkTeleporterDST)

local function crsOnHammered(inst, worker)
    if inst.components.workable then
        inst:RemoveComponent("workable")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst.AnimState:PlayAnimation("destroyed")
    inst:DoTaskInTime(0.5, function()
        inst:Remove()
    end)
end

local function crsDarkTeleporterFn (col)
    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.AnimState:SetBank("darkteleporter")
        inst.AnimState:SetBuild("darkteleporter")
        inst.AnimState:PlayAnimation(col, true)
        inst.entity:AddSoundEmitter()
        inst.AnimState:SetLayer(LAYER_BACKGROUND)
        inst.AnimState:SetSortOrder(3)
        
        inst:AddTag("crsDarkTeleporter_"..col)

        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon("darkteleporter_"..col..".tex")

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then return inst end
        
        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(6)
        inst.components.workable:SetOnFinishCallback(crsOnHammered)
        inst:AddComponent("playerprox")
        inst.components.playerprox:SetDist(radius, 1)
        inst.components.playerprox.onnear = function()
            local findDT = FindEntity(inst, range, function(DT)
                return DT:HasTag("crsDarkTeleporter_"..col)
            end)
            local x, y, z = inst.Transform:GetWorldPosition()
            local player = FindClosestPlayerInRange(x, y, z, radius)
            local item = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local hammer = (item and item.name == "Hammer")
            if findDT and findDT ~= inst and not findDT:HasTag("crsJustUsed") and not inst:HasTag("crsJustUsed") then
                if not hammer then 
                    inst:AddTag("crsJustUsed")
                    findDT:AddTag("crsJustUsed")
                    local target = findDT:GetPosition()
                    local fx = SpawnPrefab("small_puff")
                    local gamble = math.random(healthCost)
                    inst.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
                    player.Transform:SetPosition(target.x, target.y, target.z)
                    fx.Transform:SetPosition(target.x, target.y, target.z)
                    player.components.health:DoDelta(-gamble) -- does damage when used
                    inst:DoTaskInTime(cooldown, function()
                        inst:RemoveTag("crsJustUsed")
                        findDT:RemoveTag("crsJustUsed")
                    end)
                end 
            end
        end

        return inst
    end

    return Prefab("common/objects/darkteleporter_"..col, fn, assets)
end

return crsDarkTeleporterFn("red"),
    crsDarkTeleporterFn("green"),
    crsDarkTeleporterFn("blue"),
    crsDarkTeleporterFn("yellow"),
    MakePlacer("common/darkteleporter_placer", "darkteleporter", "darkteleporter", "red")