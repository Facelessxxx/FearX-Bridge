function FearX.AddMoney(playerId, moneyType, amount)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    amount = math.floor(amount)
    moneyType = moneyType or 'cash'
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        player.Functions.AddMoney(moneyType, amount)
    elseif FearX.Framework == 'esx' then
        if moneyType == 'cash' then
            player.addMoney(amount)
        elseif moneyType == 'bank' then
            player.addAccountMoney('bank', amount)
        else
            player.addAccountMoney(moneyType, amount)
        end
    elseif FearX.Framework == 'ox' then
        player.addCurrency(moneyType, amount)
    end
    return true
end

function FearX.RemoveMoney(playerId, moneyType, amount)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    amount = math.floor(amount)
    moneyType = moneyType or 'cash'
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.Functions.RemoveMoney(moneyType, amount)
    elseif FearX.Framework == 'esx' then
        if moneyType == 'cash' then
            return player.removeMoney(amount)
        elseif moneyType == 'bank' then
            return player.removeAccountMoney('bank', amount)
        else
            return player.removeAccountMoney(moneyType, amount)
        end
    elseif FearX.Framework == 'ox' then
        return player.removeCurrency(moneyType, amount)
    end
    return false
end

function FearX.GetMoney(playerId, moneyType)
    local player = FearX.GetPlayer(playerId)
    if not player then return 0 end
    
    moneyType = moneyType or 'cash'
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.money[moneyType] or 0
    elseif FearX.Framework == 'esx' then
        if moneyType == 'cash' then
            return player.getMoney()
        elseif moneyType == 'bank' then
            return player.getAccount('bank').money
        else
            local account = player.getAccount(moneyType)
            return account and account.money or 0
        end
    elseif FearX.Framework == 'ox' then
        return player.getCurrency(moneyType) or 0
    end
    return 0
end

function FearX.SetMoney(playerId, moneyType, amount)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    amount = math.floor(amount)
    moneyType = moneyType or 'cash'
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        player.Functions.SetMoney(moneyType, amount)
    elseif FearX.Framework == 'esx' then
        if moneyType == 'cash' then
            player.setMoney(amount)
        elseif moneyType == 'bank' then
            player.setAccountMoney('bank', amount)
        else
            player.setAccountMoney(moneyType, amount)
        end
    elseif FearX.Framework == 'ox' then
        player.setCurrency(moneyType, amount)
    end
    return true
end

function FearX.TransferMoney(fromId, toId, moneyType, amount)
    local fromPlayer = FearX.GetPlayer(fromId)
    local toPlayer = FearX.GetPlayer(toId)
    
    if not fromPlayer or not toPlayer then
        return false, 'Player not found'
    end
    
    amount = math.floor(amount)
    moneyType = moneyType or 'bank'
    
    local fromMoney = FearX.GetMoney(fromId, moneyType)
    if fromMoney < amount then
        return false, 'Insufficient funds'
    end
    
    if FearX.RemoveMoney(fromId, moneyType, amount) then
        FearX.AddMoney(toId, moneyType, amount)
        return true, 'Transfer successful'
    end
    
    return false, 'Transfer failed'
end

function FearX.GetPlayerName(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
    elseif FearX.Framework == 'esx' then
        return player.getName()
    elseif FearX.Framework == 'ox' then
        return player.get('firstName') .. ' ' .. player.get('lastName')
    end
    return GetPlayerName(playerId)
end

function FearX.GetPlayerPhone(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.charinfo.phone
    elseif FearX.Framework == 'esx' then
        return player.getCharVar('phoneNumber')
    elseif FearX.Framework == 'ox' then
        return player.get('phoneNumber')
    end
    return nil
end

function FearX.KickPlayer(playerId, reason)
    reason = reason or 'You have been kicked from the server'
    DropPlayer(playerId, reason)
end

function FearX.BanPlayer(playerId, reason, duration)
    reason = reason or 'You have been banned from the server'
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        TriggerEvent('qb-admin:server:ban', playerId, duration, reason)
    elseif FearX.Framework == 'esx' then
        TriggerEvent('esx_ban:banPlayer', playerId, reason, duration)
    else
        DropPlayer(playerId, reason)
    end
end