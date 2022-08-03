QBCore = {}

-- Tables --
local pedstable = {}
local promptstable = {}
local JobsDone = {}

-- Checks --
local hasJob = false
local hasBeenPaid = false
local PickedUp = false
local AttachedProp = false

-- Blips & Prompts --
local jobBlip

--------------------------------------
-------------- FUNCTIONS -------------
--------------------------------------

local function PickupWoodLocation()
    local player = PlayerPedId()
    local playercoords = GetEntityCoords(player)
    -- local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, playercoords.x, playercoords.y, playercoords.z, 1)
    -- local town = GetMapdataFromHashKey(town_hash)

    PickupLocation = math.random(1, #Config.Locations["Blackwater"]["WoodLocations"])

    -- if town == "BLACKWATER" then
    if not jobBlip then
        jobBlip = N_0x554d9d53f696d002(1664425300, Config.Locations["Blackwater"]["WoodLocations"][PickupLocation].coords.x, Config.Locations["Blackwater"]["WoodLocations"][PickupLocation].coords.y, Config.Locations["Blackwater"]["WoodLocations"][PickupLocation].coords.z)

        SetBlipSprite(jobBlip, 1116438174, 1)
        SetBlipScale(jobBlip, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, jobBlip, "Pickup Wood")
        exports['qbr-core']:Notify(9, 'Wood Location Marked', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')

        PickupWoodPrompt = exports['qbr-core']:createPrompt('Pickup Wood', Config.Locations["Blackwater"]["WoodLocations"][PickupLocation].coords, Config.Keys["G"], 'Pickup Wood', {
            type = 'client',
            event = 'qbr-construction:PickupWood',
        })
        table.insert(promptstable, PickupWoodPrompt)
    end
    -- end
end

local function GetPaycheck()

end

--------------------------------------
--------------- THREADS --------------
--------------------------------------

-- CreateThread(function()
--     while true do
--         Wait(10)
--         if hasJob then
--             local player = PlayerPedId()
--             local coords = GetEntityCoords(player)
--             if level == 1 then
--                 if not PickedUp then
--                     if GetDistanceBetweenCoords(coords, jobBlip.x, jobBlip.y, jobBlip.z, true) < 5  then
--                         DrawText3D(jobBlip.x, jobBlip.y, jobBlip.z, "Pickup Wood")
--                         if IsControlJustReleased(0, Config.Keys["G"]) then
--                             PickedUp = true
-- 							local WoodProp = CreateObject(GetHashKey("p_woodplank01x"), coords.x, coords.y, coords.z, 1, 0, 1)
--                             SetEntityAsMissionEntity(WoodProp, true, true)
--                             RequestAnimDict("mech_carry_box")
--                             while not HasAnimDictLoaded("mech_carry_box") do
--                                 Citizen.Wait(100)
--                             end
--                             Citizen.InvokeNative(0x6B9BBD38AB0796DF, WoodProp,player,GetEntityBoneIndexByName(player,"SKEL_R_Finger12"), 0.49, 0.0, 0.52, 0.0, 225.0, 35.0, true, true, false, true, 1, true)
--                             AttachedProp = true
--                             RemoveBlip(jobBlip)
--                             ClearGpsCustomRoute()
--                             SetGpsCustomRouteRender(false, 16, 16)
--                             TriggerEvent("qbr-construction:PlaceWoodBlip")
--                             Wait(500)
--                         end
--                     end
--                 elseif pickup then
--                     if GetDistanceBetweenCoords(coords, jobBlip.x, jobBlip.y, jobBlip.z, true) < 2  then
--                         DrawText3D(jobBlip.x, jobBlip.y, jobBlip.z, "Place Wood")
--                         if IsControlJustReleased(0, Config.keys["G"]) then
--                             if AttachedProp then
--                                 AttachedProp = false
--                                 DetachEntity(WoodProp,false,true)
--                                 ClearPedTasks(player)
--                                 DeleteObject(WoodProp)
--                             end
--                             Wait(500)
--                             TaskStartScenarioInPlace(player, GetHashKey(jobBlip.wa), 30000, true, false, false, false)
--                             local testplayer = exports["syn_minigame"]:taskBar(4000,7)
--                             local testplayer2
--                             local testplayer3
--                             local testplayer4
--                             Wait(1000)
--                             if testplayer == 100 then
--                                 testplayer2 = exports["syn_minigame"]:taskBar(3400,7)
--                             end
--                             Wait(1000)
--                             if testplayer2 == 100 then
--                                 testplayer3 = exports["syn_minigame"]:taskBar(3000,7)
--                             end
--                             Wait(1000)
--                             if testplayer3 == 100 then
--                                 testplayer4 = exports["syn_minigame"]:taskBar(2700,7)
--                             end
--                             if testplayer4 == 100 then
--                                 JobsDone = JobsDone + 1
--                                 PickedUp = false
--                                 RemoveBlip(missionblip)
--                                 ClearGpsCustomRoute()
--                                 SetGpsCustomRouteRender(false, 16, 16)
--                                 if totaltasks ~= JobsDone then
--                                     TriggerEvent("syn_construction:resettask")
--                                 else
--                                     TriggerEvent("vorp:TipBottom", Config.CleanLanguage.finishedtasks, 4000)
--                                 end
--                                 ClearPedTasks(player)
--                                 Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
--                             else
--                                 if quality > 10 then
--                                     quality = quality - 10
--                                     TriggerEvent("vorp:TipBottom", Config.CleanLanguage.messedup, 4000)
--                                 end
--                                 ClearPedTasks(player)
--                                 SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
--                                 Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
--                             end
--                             Wait(500)
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end)

--------------------------------------
--------------- EVENTS --------------
--------------------------------------

RegisterNetEvent('qbr-construction:StartJob')
AddEventHandler('qbr-construction:StartJob', function()
    if not hasJob then
        PickupWoodLocation()
        hasJob = true

        if Config.Prints then
            print(hasJob)
        end

    else
        exports['qbr-core']:Notify(9, 'You already have this job!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_RED')
    end
end)

RegisterNetEvent('qbr-construction:CheckIfPaycheckCollected')
AddEventHandler('qbr-construction:CheckIfPaycheckCollected', function()
    if not hasBeenPaid then
        GetPaycheck()
        hasBeenPaid = true

        if Config.Prints then
            print(hasBeenPaid)
        end
    else
        exports['qbr-core']:Notify(9, 'You have already been paid for your work!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_RED')
    end
end)

RegisterNetEvent('qbr-construction:PickupWood')
AddEventHandler('qbr-construction:PickupWood', function()
    local coords = GetEntityCoords(PlayerPedId())
    if hasJob then
        if not PickedUp then
            PickedUp = true
            local WoodProp = CreateObject(GetHashKey("p_woodplank01x"), coords.x, coords.y, coords.z, 1, 0, 1)
            SetEntityAsMissionEntity(WoodProp, true, true)
            RequestAnimDict("mech_carry_box")
            while not HasAnimDictLoaded("mech_carry_box") do
                Wait(100)
            end
            TaskPlayAnim(PlayerPedId(), "mech_carry_box", "idle", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
            -- Citizen.InvokeNative(0x6B9BBD38AB0796DF, WoodProp, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(),"SKEL_R_Finger12"), 0.0, 0.0, -0.40, 10.0, 10.0, 0.0, true, true, false, true, 1, true)
            Citizen.InvokeNative(0x6B9BBD38AB0796DF, WoodProp, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(),"SKEL_L_Hand"), 0.1, 0.15, 0.0, 90.0, 90.0, 20.0, true, true, false, true, 1, true)
            AttachedProp = true
            RemoveBlip(jobBlip)
            ClearGpsCustomRoute()
            SetGpsCustomRouteRender(false, 16, 16)
            -- TriggerEvent("qbr-construction:PlaceWoodBlip")
            Wait(500)
            for _,v in pairs(promptstable) do
                exports['qbr-core']:deletePrompt(v.PickupWoodPrompt)
            end
        end
    end
end)

--------------------------------------
--------------- JOB MENU -------------
--------------------------------------

RegisterNetEvent('qbr-construction:OpenJobMenu')
AddEventHandler('qbr-construction:OpenJobMenu', function()

    if not hasJob then

        jobMenu = {
            {
                header = "| Construction Job |",
                isMenuHeader = true,
            },
            {
                header = "Start Construction Job",
                txt = "",
                params = {
                    event = 'qbr-construction:StartJob',
                }
            },
            {
                header = "Close Menu",
                txt = '',
                params = {
                    event = '(x) Close Menu',
                }
            },
        }

    elseif hasJob then

        jobMenu = {
            {
                header = "| Construction Job |",
                isMenuHeader = true,
            },
            {
                header = "Collect Paycheck",
                txt = "",
                params = {
                    event = 'qbr-construction:CollectPaycheck',
                    isServer = true,
                }
            },
            {
                header = "Finish Job",
                txt = "",
                params = {
                    event = 'qbr-construction:CheckIfPaycheckCollected',
                    isServer = true,
                }
            },
            {
                header = "(x) Close Menu",
                txt = '',
                params = {
                    event = 'qbr-menu:closeMenu',
                }
            },
        }
    end

    exports['qbr-menu']:openMenu(jobMenu)
end)

--------------------------
------- PED SPAWNING -----
--------------------------

function SET_PED_RELATIONSHIP_GROUP_HASH ( iVar0, iParam0 )
    return Citizen.InvokeNative( 0xC80A74AC829DDD92, iVar0, _GET_DEFAULT_RELATIONSHIP_GROUP_HASH( iParam0 ) )
end

function _GET_DEFAULT_RELATIONSHIP_GROUP_HASH ( iParam0 )
    return Citizen.InvokeNative( 0x3CC4A718C258BDD0 , iParam0 );
end

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

CreateThread(function()
    for z, x in pairs(Config.JobNpc) do
        while not HasModelLoaded( GetHashKey(Config.JobNpc[z]["Model"]) ) do
            Wait(500)
            modelrequest( GetHashKey(Config.JobNpc[z]["Model"]) )
        end
        local npc = CreatePed(GetHashKey(Config.JobNpc[z]["Model"]), Config.JobNpc[z]["Pos"].x, Config.JobNpc[z]["Pos"].y, Config.JobNpc[z]["Pos"].z - 1, Config.JobNpc[z]["Heading"], false, false, 0, 0)
        while not DoesEntityExist(npc) do
            Wait(300)
        end
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
        FreezeEntityPosition(npc, false)
        SetEntityInvincible(npc, true)
        TaskStandStill(npc, -1)
        Wait(100)
        SET_PED_RELATIONSHIP_GROUP_HASH(npc, GetHashKey(Config.JobNpc[z]["Model"]))
        SetEntityCanBeDamagedByRelationshipGroup(npc, false, `PLAYER`)
        SetEntityAsMissionEntity(npc, true, true)
        SetModelAsNoLongerNeeded(GetHashKey(Config.JobNpc[z]["Model"]))
        table.insert(pedstable, npc)

        prompts = exports['qbr-core']:createPrompt('Construction Job', Config.JobNpc[z]["Pos"], 0xF3830D8E, 'Construction Job', {
            type = 'client',
            event = 'qbr-construction:OpenJobMenu',
        })
        table.insert(promptstable, prompts)
    end
end)

------------------------------------
------- RESOURCE START / STOP -----
------------------------------------

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _,v in pairs(pedstable) do
            DeletePed(v)
        end
        for _,v in pairs(promptstable) do
            exports['qbr-core']:deletePrompt(v)
        end
        if jobBlip ~= nil then
            RemoveBlip(jobBlip)
        end
    end
end)