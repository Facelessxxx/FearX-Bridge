local PlayerData = {}
local PlayerLoaded = false

function FearX.GetPlayerData()
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return QBCore.Functions.GetPlayerData()
    elseif FearX.Framework == 'esx' then
        return ESX.GetPlayerData()
    elseif FearX.Framework == 'ox' then
        return Ox.GetPlayer()
    end
    return PlayerData
end

function FearX.IsPlayerLoaded()
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        local playerData = QBCore.Functions.GetPlayerData()
        return playerData and playerData.citizenid ~= nil
    elseif FearX.Framework == 'esx' then
        local playerData = ESX.GetPlayerData()
        return playerData and playerData.identifier ~= nil
    elseif FearX.Framework == 'ox' then
        return Ox.GetPlayer() ~= nil
    end
    return PlayerLoaded
end

function FearX.GetJob()
    local playerData = FearX.GetPlayerData()
    if not playerData then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return playerData.job and playerData.job.name or nil
    elseif FearX.Framework == 'esx' then
        return playerData.job and playerData.job.name or nil
    elseif FearX.Framework == 'ox' then
        return playerData.job or nil
    end
    return nil
end

function FearX.GetJobGrade()
    local playerData = FearX.GetPlayerData()
    if not playerData then return 0 end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return playerData.job and playerData.job.grade and playerData.job.grade.level or 0
    elseif FearX.Framework == 'esx' then
        return playerData.job and playerData.job.grade or 0
    elseif FearX.Framework == 'ox' then
        return playerData.jobGrade or 0
    end
    return 0
end

function FearX.GetJobLabel()
    local playerData = FearX.GetPlayerData()
    if not playerData then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return playerData.job and playerData.job.label or nil
    elseif FearX.Framework == 'esx' then
        return playerData.job and playerData.job.label or nil
    elseif FearX.Framework == 'ox' then
        return playerData.jobLabel or nil
    end
    return nil
end

function FearX.SetPlayerData(key, value)
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        local playerData = QBCore.Functions.GetPlayerData()
        playerData[key] = value
    elseif FearX.Framework == 'esx' then
        local playerData = ESX.GetPlayerData()
        playerData[key] = value
    elseif FearX.Framework == 'ox' then
        Ox.SetPlayerData(key, value)
    else
        PlayerData[key] = value
    end
end

function FearX.GetGang()
    local playerData = FearX.GetPlayerData()
    if not playerData then return nil end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return playerData.gang and playerData.gang.name or nil
    end
    return nil
end

function FearX.GetGangGrade()
    local playerData = FearX.GetPlayerData()
    if not playerData then return 0 end
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        return playerData.gang and playerData.gang.grade and playerData.gang.grade.level or 0
    end
    return 0
end

function FearX.TriggerCallback(name, cb, ...)
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        QBCore.Functions.TriggerCallback(name, cb, ...)
    elseif FearX.Framework == 'esx' then
        ESX.TriggerServerCallback(name, cb, ...)
    elseif FearX.Framework == 'ox' then
        local result = lib.callback(name, false, ...)
        if cb then cb(result) end
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    Wait(1000)
    
    if FearX.Framework == 'qb' or FearX.Framework == 'qbx' then
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            PlayerLoaded = true
        end)
        
        RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
            PlayerData.job = JobInfo
        end)
        
        RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
            PlayerData.gang = GangInfo
        end)
        
    elseif FearX.Framework == 'esx' then
        RegisterNetEvent('esx:playerLoaded', function(xPlayer)
            PlayerData = xPlayer
            PlayerLoaded = true
        end)
        
        RegisterNetEvent('esx:setJob', function(job)
            PlayerData.job = job
        end)
        
    elseif FearX.Framework == 'ox' then
        RegisterNetEvent('ox:playerLoaded', function()
            PlayerLoaded = true
        end)
    end
end)