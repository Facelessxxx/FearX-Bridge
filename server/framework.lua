function FearX.GetPlayer(playerId)
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return QBCore.Functions.GetPlayer(playerId)
    elseif FearX.Framework == 'esx' then
        return ESX.GetPlayerFromId(playerId)
    elseif FearX.Framework == 'ox' then
        return Ox.GetPlayer(playerId)
    end
    return nil
end

function FearX.GetAllPlayers()
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return QBCore.Functions.GetPlayers()
    elseif FearX.Framework == 'esx' then
        return ESX.GetPlayers()
    elseif FearX.Framework == 'ox' then
        return Ox.GetPlayers()
    end
    return {}
end

function FearX.GetPlayerJob(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.job.name
    elseif FearX.Framework == 'esx' then
        return player.job.name
    elseif FearX.Framework == 'ox' then
        return player.get('job')
    end
    return nil
end

function FearX.GetPlayerJobGrade(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return 0 end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.job.grade.level
    elseif FearX.Framework == 'esx' then
        return player.job.grade
    elseif FearX.Framework == 'ox' then
        return player.get('jobGrade') or 0
    end
    return 0
end

function FearX.GetPlayerJobLabel(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.job.label
    elseif FearX.Framework == 'esx' then
        return player.job.label
    elseif FearX.Framework == 'ox' then
        return player.get('jobLabel')
    end
    return nil
end

function FearX.GetPlayerGang(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.gang and player.PlayerData.gang.name or nil
    end
    return nil
end

function FearX.GetPlayerGangGrade(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return 0 end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.gang and player.PlayerData.gang.grade and player.PlayerData.gang.grade.level or 0
    end
    return 0
end

function FearX.SetPlayerJob(playerId, job, grade)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    grade = grade or 0
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        player.Functions.SetJob(job, grade)
    elseif FearX.Framework == 'esx' then
        player.setJob(job, grade)
    elseif FearX.Framework == 'ox' then
        player.set('job', job)
        player.set('jobGrade', grade)
    end
    return true
end

function FearX.SetPlayerGang(playerId, gang, grade)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    grade = grade or 0
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        player.Functions.SetGang(gang, grade)
    end
    return true
end

function FearX.GetIdentifier(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return player.PlayerData.citizenid
    elseif FearX.Framework == 'esx' then
        return player.identifier
    elseif FearX.Framework == 'ox' then
        return player.identifier
    end
    return nil
end

function FearX.GetPlayerCoords(playerId)
    local ped = GetPlayerPed(playerId)
    if not ped then return nil end
    return GetEntityCoords(ped)
end

function FearX.HasPermission(playerId)
    local player = FearX.GetPlayer(playerId)
    if not player then return false end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        for _, group in pairs(Config.AdminGroups) do
            if QBCore.Functions.HasPermission(playerId, group) then
                return true
            end
        end
    elseif FearX.Framework == 'esx' then
        for _, group in pairs(Config.AdminGroups) do
            if player.getGroup() == group then
                return true
            end
        end
    elseif FearX.Framework == 'ox' then
        for _, group in pairs(Config.AdminGroups) do
            if player.hasGroup(group) then
                return true
            end
        end
    end
    return false
end

function FearX.CreateCallback(name, cb)
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        QBCore.Functions.CreateCallback(name, cb)
    elseif FearX.Framework == 'esx' then
        ESX.RegisterServerCallback(name, cb)
    elseif FearX.Framework == 'ox' then
        lib.callback.register(name, cb)
    end
end