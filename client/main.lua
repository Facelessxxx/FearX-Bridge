CreateThread(function()
    FearX.Framework = FearX.DetectFramework()
    FearX.Inventory = FearX.DetectInventory()
    FearX.Menu = FearX.DetectMenu()
    FearX.Target = FearX.DetectTarget()
    FearX.Progress = FearX.DetectProgress()
    FearX.Notify = FearX.DetectNotify()
    FearX.TextUI = FearX.DetectTextUI()
    FearX.Dispatch = FearX.DetectDispatch()
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        local QBCore = exports['qb-core']:GetCoreObject()
        if FearX.Framework == 'qbx' then
            QBCore = exports['qbx-core']:GetCoreObject()
        end
        _G.QBCore = QBCore
    elseif FearX.Framework == 'esx' then
        local ESX = exports['es_extended']:getSharedObject()
        _G.ESX = ESX
    elseif FearX.Framework == 'ox' then
        local Ox = require('@ox_core/lib/init')
        _G.Ox = Ox
    end
    
    if FearX.ResourceExists('ox_lib') then
        _G.lib = exports.ox_lib
    end
    
    FearX.Debug('Framework: ' .. (FearX.Framework or 'none'))
    FearX.Debug('Inventory: ' .. (FearX.Inventory or 'none'))
    FearX.Debug('Menu: ' .. (FearX.Menu or 'none'))
    FearX.Debug('Target: ' .. (FearX.Target or 'none'))
    FearX.Debug('Progress: ' .. (FearX.Progress or 'none'))
    FearX.Debug('Notify: ' .. (FearX.Notify or 'none'))
    FearX.Debug('TextUI: ' .. (FearX.TextUI or 'none'))
    FearX.Debug('Dispatch: ' .. (FearX.Dispatch or 'none'))
    
    TriggerEvent('fearx-bridge:client:ready', {
        framework = FearX.Framework,
        inventory = FearX.Inventory,
        menu = FearX.Menu,
        target = FearX.Target,
        progress = FearX.Progress,
        notify = FearX.Notify,
        textui = FearX.TextUI,
        dispatch = FearX.Dispatch
    })
end)

function FearX.Dispatch(data)
    if FearX.Dispatch == 'cd' then
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = data.jobs or {'police'},
            coords = data.coords or GetEntityCoords(PlayerPedId()),
            title = data.title or 'Alert',
            message = data.message or 'No message provided',
            flash = data.flash or 0,
            unique_id = data.unique_id or math.random(1000000, 9999999),
            blip = data.blip or {
                sprite = 161,
                scale = 1.0,
                colour = 1,
                flashes = false,
                text = data.title or 'Alert',
                time = (data.time or 60) * 1000,
                sound = 1
            }
        })
    elseif FearX.Dispatch == 'ps' then
        exports['ps-dispatch']:CustomAlert({
            coords = data.coords or GetEntityCoords(PlayerPedId()),
            message = data.message or 'No message provided',
            dispatchCode = data.code or '10-00',
            description = data.title or 'Alert',
            radius = data.radius or 0,
            sprite = data.sprite or 161,
            color = data.color or 1,
            scale = data.scale or 1.0,
            length = data.length or 3,
            sound = data.sound or 'Lose_1st',
            sound2 = data.sound2 or 'GTAO_FM_Events_Soundset',
            offset = data.offset or false,
            flash = data.flash or false
        })
    elseif FearX.Dispatch == 'qs' then
        exports['qs-dispatch']:CreateDispatchCall({
            job = data.jobs or {'police'},
            callLocation = data.coords or GetEntityCoords(PlayerPedId()),
            callCode = {
                code = data.code or '10-00',
                snippet = data.title or 'Alert'
            },
            message = data.message or 'No message provided',
            flashes = data.flashes or false,
            image = data.image or nil,
            blip = {
                sprite = data.sprite or 161,
                scale = data.scale or 1.0,
                colour = data.color or 1,
                flashes = data.blipFlashes or true,
                text = data.title or 'Alert',
                time = (data.time or 60) * 1000
            }
        })
    elseif FearX.Dispatch == 'linden' then
        local dispatchData = {
            displayCode = data.code or '10-00',
            description = data.title or 'Alert',
            isImportant = data.important or 0,
            recipientList = data.jobs or {'police'},
            length = data.length or '10000',
            infoM = 'fa-info-circle',
            info = data.message or 'No message provided'
        }
        
        local blipData = {
            sprite = data.sprite or 161,
            scale = data.scale or 0.8,
            colour = data.color or 1,
            flashes = data.flashes or false,
            text = data.title or 'Alert',
            time = (data.time or 60) * 1000,
            sound = data.sound or 1
        }
        
        TriggerServerEvent('wf-alerts:svNotify', dispatchData, blipData, data.coords or GetEntityCoords(PlayerPedId()))
    end
end

RegisterNetEvent('fearx-bridge:client:initialize', function(bridgeData)
    if bridgeData then
        FearX.Framework = bridgeData.framework
        FearX.Inventory = bridgeData.inventory
        FearX.Menu = bridgeData.menu
        FearX.Target = bridgeData.target
        FearX.Progress = bridgeData.progress
        FearX.Notify = bridgeData.notify
        FearX.TextUI = bridgeData.textui
        FearX.Dispatch = bridgeData.dispatch
        
        FearX.Debug('Bridge initialized from server data')
    end
end)

exports('GetPlayerData', FearX.GetPlayerData)
exports('IsPlayerLoaded', FearX.IsPlayerLoaded)
exports('GetJob', FearX.GetJob)
exports('GetJobGrade', FearX.GetJobGrade)
exports('GetJobLabel', FearX.GetJobLabel)
exports('GetGang', FearX.GetGang)
exports('GetGangGrade', FearX.GetGangGrade)
exports('SetPlayerData', FearX.SetPlayerData)
exports('TriggerCallback', FearX.TriggerCallback)
exports('OpenInventory', FearX.OpenInventory)
exports('GetInventory', FearX.GetInventory)
exports('HasItem', FearX.HasItem)
exports('GetItemCount', FearX.GetItemCount)
exports('UseItem', FearX.UseItem)
exports('GetItemData', FearX.GetItemData)
exports('ShowNotification', FearX.ShowNotification)
exports('ShowProgressBar', FearX.ShowProgressBar)
exports('ShowTextUI', FearX.ShowTextUI)
exports('HideTextUI', FearX.HideTextUI)
exports('ShowMenu', FearX.ShowMenu)
exports('CloseMenu', FearX.CloseMenu)
exports('ShowInput', FearX.ShowInput)
exports('AddBoxZone', FearX.AddBoxZone)
exports('AddCircleZone', FearX.AddCircleZone)
exports('AddTargetEntity', FearX.AddTargetEntity)
exports('AddTargetModel', FearX.AddTargetModel)
exports('RemoveZone', FearX.RemoveZone)
exports('RemoveTargetEntity', FearX.RemoveTargetEntity)
exports('RemoveTargetModel', FearX.RemoveTargetModel)
exports('Dispatch', FearX.Dispatch)
exports('GetFramework', function() return FearX.Framework end)
exports('GetInventory', function() return FearX.Inventory end)
exports('GetMenu', function() return FearX.Menu end)
exports('GetTarget', function() return FearX.Target end)
exports('GetProgress', function() return FearX.Progress end)
exports('GetNotify', function() return FearX.Notify end)
exports('GetTextUI', function() return FearX.TextUI end)
exports('GetDispatch', function() return FearX.Dispatch end)