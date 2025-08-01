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
    
    FearX.Debug('Server initialized with:')
    FearX.Debug('Framework: ' .. (FearX.Framework or 'none'))
    FearX.Debug('Inventory: ' .. (FearX.Inventory or 'none'))
    FearX.Debug('Menu: ' .. (FearX.Menu or 'none'))
    FearX.Debug('Target: ' .. (FearX.Target or 'none'))
    FearX.Debug('Progress: ' .. (FearX.Progress or 'none'))
    FearX.Debug('Notify: ' .. (FearX.Notify or 'none'))
    FearX.Debug('TextUI: ' .. (FearX.TextUI or 'none'))
    FearX.Debug('Dispatch: ' .. (FearX.Dispatch or 'none'))
end)

RegisterNetEvent('fearx-bridge:server:requestPlayerData', function()
    local src = source
    local player = FearX.GetPlayer(src)
    if player then
        TriggerClientEvent('fearx-bridge:client:receivePlayerData', src, player)
    end
end)

exports('GetPlayer', FearX.GetPlayer)
exports('GetAllPlayers', FearX.GetAllPlayers)
exports('GetPlayerJob', FearX.GetPlayerJob)
exports('GetPlayerJobGrade', FearX.GetPlayerJobGrade)
exports('GetPlayerJobLabel', FearX.GetPlayerJobLabel)
exports('GetPlayerGang', FearX.GetPlayerGang)
exports('GetPlayerGangGrade', FearX.GetPlayerGangGrade)
exports('SetPlayerJob', FearX.SetPlayerJob)
exports('SetPlayerGang', FearX.SetPlayerGang)
exports('GetIdentifier', FearX.GetIdentifier)
exports('GetPlayerCoords', FearX.GetPlayerCoords)
exports('HasPermission', FearX.HasPermission)
exports('CreateCallback', FearX.CreateCallback)
exports('AddItem', FearX.AddItem)
exports('RemoveItem', FearX.RemoveItem)
exports('GetItem', FearX.GetItem)
exports('GetItemCount', FearX.GetItemCount)
exports('CanCarryItem', FearX.CanCarryItem)
exports('GetPlayerInventory', FearX.GetPlayerInventory)
exports('AddMoney', FearX.AddMoney)
exports('RemoveMoney', FearX.RemoveMoney)
exports('GetMoney', FearX.GetMoney)
exports('SetMoney', FearX.SetMoney)
exports('TransferMoney', FearX.TransferMoney)
exports('GetPlayerName', FearX.GetPlayerName)
exports('GetPlayerPhone', FearX.GetPlayerPhone)
exports('KickPlayer', FearX.KickPlayer)
exports('BanPlayer', FearX.BanPlayer)