function FearX.AddItem(playerId, item, amount, metadata)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    amount = amount or 1
    metadata = metadata or {}
    
    if FearX.Inventory == 'ox' then
        return exports.ox_inventory:AddItem(playerId, item, amount, metadata)
    elseif FearX.Inventory == 'qb' then
        return player.Functions.AddItem(item, amount, false, metadata)
    elseif FearX.Inventory == 'esx' then
        player.addInventoryItem(item, amount)
        return true
    elseif FearX.Inventory == 'qs' then
        return exports['qs-inventory']:AddItem(playerId, item, amount, false, metadata)
    elseif FearX.Inventory == 'ps' then
        return exports['ps-inventory']:AddItem(playerId, item, amount, false, metadata)
    end
    return false
end

function FearX.RemoveItem(playerId, item, amount, slot)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    amount = amount or 1
    
    if FearX.Inventory == 'ox' then
        return exports.ox_inventory:RemoveItem(playerId, item, amount, nil, slot)
    elseif FearX.Inventory == 'qb' then
        return player.Functions.RemoveItem(item, amount, slot)
    elseif FearX.Inventory == 'esx' then
        player.removeInventoryItem(item, amount)
        return true
    elseif FearX.Inventory == 'qs' then
        return exports['qs-inventory']:RemoveItem(playerId, item, amount, slot)
    elseif FearX.Inventory == 'ps' then
        return exports['ps-inventory']:RemoveItem(playerId, item, amount, slot)
    end
    return false
end

function FearX.GetItem(playerId, item)
    local player = FearX.GetPlayer(playerId)
    if not player then return nil end
    
    if FearX.Inventory == 'ox' then
        return exports.ox_inventory:GetItem(playerId, item)
    elseif FearX.Inventory == 'qb' then
        return player.Functions.GetItemByName(item)
    elseif FearX.Inventory == 'esx' then
        return player.getInventoryItem(item)
    elseif FearX.Inventory == 'qs' then
        return exports['qs-inventory']:GetItem(playerId, item)
    elseif FearX.Inventory == 'ps' then
        return exports['ps-inventory']:GetItem(playerId, item)
    end
    return nil
end

function FearX.GetItemCount(playerId, item)
    local itemData = FearX.GetItem(playerId, item)
    if not itemData then return 0 end
    
    if FearX.Inventory == 'ox' then
        return itemData.count or 0
    elseif FearX.Inventory == 'qb' then
        return itemData.amount or 0
    elseif FearX.Inventory == 'esx' then
        return itemData.count or 0
    elseif FearX.Inventory == 'qs' then
        return itemData.amount or 0
    elseif FearX.Inventory == 'ps' then
        return itemData.amount or 0
    end
    return 0
end

function FearX.CanCarryItem(playerId, item, amount)
    amount = amount or 1
    
    if FearX.Inventory == 'ox' then
        return exports.ox_inventory:CanCarryItem(playerId, item, amount)
    elseif FearX.Inventory == 'qb' then
        local player = FearX.GetPlayer(playerId)
        if not player then return false end
        local totalWeight = QBCore.Player.GetTotalWeight(player.PlayerData.items)
        local itemInfo = QBCore.Shared.Items[item:lower()]
        if not itemInfo then return false end
        return (totalWeight + (itemInfo.weight * amount)) <= QBCore.Config.Player.MaxWeight
    elseif FearX.Inventory == 'esx' then
        local player = FearX.GetPlayer(playerId)
        if not player then return false end
        return player.canCarryItem(item, amount)
    elseif FearX.Inventory == 'qs' then
        return exports['qs-inventory']:CanCarryItem(playerId, item, amount)
    elseif FearX.Inventory == 'ps' then
        return exports['ps-inventory']:CanCarryItem(playerId, item, amount)
    end
    return true
end

function FearX.GetPlayerInventory(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return {} end
    
    if FearX.Inventory == 'ox' then
        return exports.ox_inventory:GetPlayerItems(playerId)
    elseif FearX.Inventory == 'qb' then
        return player.PlayerData.items or {}
    elseif FearX.Inventory == 'esx' then
        return player.inventory or {}
    elseif FearX.Inventory == 'qs' then
        return exports['qs-inventory']:GetPlayerItems(playerId)
    elseif FearX.Inventory == 'ps' then
        return exports['ps-inventory']:GetPlayerItems(playerId)
    end
    return {}
end