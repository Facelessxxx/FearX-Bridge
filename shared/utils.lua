FearX = {}
FearX.Framework = nil
FearX.Inventory = nil
FearX.Menu = nil
FearX.Target = nil
FearX.Progress = nil
FearX.Notify = nil
FearX.TextUI = nil
FearX.Dispatch = nil

function FearX.Debug(msg)
    if Config.Debug then
        print('^3[fearx-bridge]^7 ' .. msg)
    end
end

function FearX.GetConvar(name, default)
    return GetConvar('fearx:' .. name, default)
end

function FearX.ResourceExists(resource)
    return GetResourceState(resource) == 'started'
end

function FearX.DetectFramework()
    local framework = FearX.GetConvar('framework', Config.Framework)
    
    if framework ~= 'auto' then
        return framework
    end
    
    for name, resource in pairs(Config.ResourceNames.frameworks) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected framework: ' .. name)
            return name
        end
    end
    
    return nil
end

function FearX.DetectInventory()
    local inventory = FearX.GetConvar('inventory', Config.Inventory)
    
    if inventory ~= 'auto' then
        return inventory
    end
    
    for name, resource in pairs(Config.ResourceNames.inventories) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected inventory: ' .. name)
            return name
        end
    end
    
    return FearX.Framework
end

function FearX.DetectTarget()
    local target = FearX.GetConvar('target', Config.Target)
    
    if target ~= 'auto' then
        return target
    end
    
    for name, resource in pairs(Config.ResourceNames.targets) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected target: ' .. name)
            return name
        end
    end
    
    return nil
end

function FearX.DetectMenu()
    local menu = FearX.GetConvar('menu', Config.Menu)
    
    if menu ~= 'auto' then
        return menu
    end
    
    for name, resource in pairs(Config.ResourceNames.menus) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected menu: ' .. name)
            return name
        end
    end
    
    return FearX.Framework
end

function FearX.DetectProgress()
    local progress = FearX.GetConvar('progress', Config.Progress)
    
    if progress ~= 'auto' then
        return progress
    end
    
    for name, resource in pairs(Config.ResourceNames.progress) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected progress: ' .. name)
            return name
        end
    end
    
    return FearX.Framework
end

function FearX.DetectNotify()
    local notify = FearX.GetConvar('notify', Config.Notify)
    
    if notify ~= 'auto' then
        return notify
    end
    
    for name, resource in pairs(Config.ResourceNames.notify) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected notify: ' .. name)
            return name
        end
    end
    
    return FearX.Framework
end

function FearX.DetectTextUI()
    local textui = FearX.GetConvar('textui', Config.TextUI)
    
    if textui ~= 'auto' then
        return textui
    end
    
    for name, resource in pairs(Config.ResourceNames.textui) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected textui: ' .. name)
            return name
        end
    end
    
    return FearX.Framework
end

function FearX.DetectDispatch()
    local dispatch = FearX.GetConvar('dispatch', Config.Dispatch)
    
    if dispatch ~= 'auto' then
        return dispatch
    end
    
    for name, resource in pairs(Config.ResourceNames.dispatch) do
        if FearX.ResourceExists(resource) then
            FearX.Debug('Detected dispatch: ' .. name)
            return name
        end
    end
    
    return nil
end