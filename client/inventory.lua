function FearX.OpenInventory()
    if FearX.Inventory == 'ox' then
        exports.ox_inventory:openInventory('player')
    elseif FearX.Inventory == 'qb' then
        TriggerEvent('inventory:client:openInventory')
    elseif FearX.Inventory == 'esx' then
        TriggerEvent('esx_inventoryhud:openInventory')
    elseif FearX.Inventory == 'qs' then
        exports['qs-inventory']:openInventory()
    elseif FearX.Inventory == 'ps' then
        TriggerEvent('inventory:client:openInventory')
    end
end

function FearX.GetInventory()
    if FearX.Inventory == 'ox' then
        return exports.ox_inventory:GetPlayerItems()
    elseif FearX.Inventory == 'qb' then
        local playerData = FearX.GetPlayerData()
        return playerData.items or {}
    elseif FearX.Inventory == 'esx' then
        local playerData = FearX.GetPlayerData()
        return playerData.inventory or {}
    end
    return {}
end

function FearX.HasItem(itemName, amount)
    amount = amount or 1
    
    if FearX.Inventory == 'ox' then
        local count = exports.ox_inventory:GetItemCount(itemName)
        return count >= amount, count
    elseif FearX.Inventory == 'qb' then
        local playerData = FearX.GetPlayerData()
        if not playerData.items then return false, 0 end
        
        local count = 0
        for _, item in pairs(playerData.items) do
            if item.name == itemName then
                count = count + item.amount
            end
        end
        return count >= amount, count
    elseif FearX.Inventory == 'esx' then
        local playerData = FearX.GetPlayerData()
        if not playerData.inventory then return false, 0 end
        
        for _, item in pairs(playerData.inventory) do
            if item.name == itemName then
                return item.count >= amount, item.count
            end
        end
        return false, 0
    end
    return false, 0
end

function FearX.GetItemCount(itemName)
    local hasItem, count = FearX.HasItem(itemName, 1)
    return count
end

function FearX.UseItem(itemName, cb)
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        RegisterNetEvent('QBCore:Client:UseItem', function(item)
            if item.name == itemName then
                if cb then cb(item) end
            end
        end)
    elseif FearX.Framework == 'esx' then
        RegisterNetEvent('esx:useItem', function(item)
            if item.name == itemName then
                if cb then cb(item) end
            end
        end)
    end
end

function FearX.GetItemData(itemName)
    local inventory = FearX.GetInventory()
    
    for _, item in pairs(inventory) do
        if item.name == itemName then
            return item
        end
    end
    return nil
end