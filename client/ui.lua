function FearX.ShowNotification(text, type, duration)
    type = type or 'inform'
    duration = duration or 5000
    
    if FearX.Notify == 'ox' and lib then
        lib.notify({
            title = 'Notification',
            description = text,
            type = type,
            duration = duration
        })
    elseif FearX.Notify == 'qb' and QBCore then
        QBCore.Functions.Notify(text, type, duration)
    elseif FearX.Notify == 'esx' and ESX then
        ESX.ShowNotification(text)
    elseif FearX.Notify == 'okok' and FearX.ResourceExists('okokNotify') then
        exports['okokNotify']:Alert('Notification', text, duration, type)
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(false, true)
    end
end

function FearX.ShowProgressBar(options, cb)
    if FearX.Progress == 'ox' and lib then
        local success = lib.progressBar({
            duration = options.duration or 5000,
            label = options.label or 'Loading...',
            useWhileDead = options.useWhileDead or false,
            canCancel = options.canCancel or true,
            disable = options.disable or {
                car = true,
                move = true,
                combat = true
            },
            anim = options.anim,
            prop = options.prop
        })
        if cb then cb(success) end
    elseif FearX.Progress == 'qb' and QBCore then
        QBCore.Functions.Progressbar(options.name or 'progress', options.label or 'Loading...', options.duration or 5000, options.useWhileDead or false, options.canCancel or true, {
            disableMovement = options.disable and options.disable.move or true,
            disableCarMovement = options.disable and options.disable.car or true,
            disableMouse = false,
            disableCombat = options.disable and options.disable.combat or true,
        }, options.anim or {}, options.prop or {}, {}, function()
            if cb then cb(true) end
        end, function()
            if cb then cb(false) end
        end)
    elseif FearX.Progress == 'esx' and FearX.ResourceExists('esx_progressbar') then
        exports['esx_progressbar']:Progressbar(options.label or 'Loading...', options.duration or 5000, {
            FreezePlayer = options.disable and options.disable.move or true,
            animation = options.anim,
            onFinish = function()
                if cb then cb(true) end
            end,
            onCancel = function()
                if cb then cb(false) end
            end
        })
    else
        if cb then cb(true) end
    end
end

function FearX.ShowTextUI(text, type)
    if FearX.TextUI == 'ox' and lib then
        lib.showTextUI(text, {
            position = type or 'right-center'
        })
    elseif FearX.TextUI == 'qb' and FearX.ResourceExists('qb-drawtext') then
        exports['qb-drawtext']:ShowText(text, type or 'left')
    elseif FearX.TextUI == 'esx' and FearX.ResourceExists('esx_textui') then
        exports['esx_textui']:TextUI(text, type or 'info')
    else
        BeginTextCommandDisplayHelp('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end

function FearX.HideTextUI()
    if FearX.TextUI == 'ox' and lib then
        lib.hideTextUI()
    elseif FearX.TextUI == 'qb' and FearX.ResourceExists('qb-drawtext') then
        exports['qb-drawtext']:HideText()
    elseif FearX.TextUI == 'esx' and FearX.ResourceExists('esx_textui') then
        exports['esx_textui']:HideUI()
    end
end

function FearX.ShowMenu(options, cb)
    if FearX.Menu == 'ox' and lib then
        local menu = {}
        for i, option in ipairs(options) do
            menu[#menu + 1] = {
                title = option.header,
                description = option.txt,
                onSelect = function()
                    if cb then cb(i) end
                end
            }
        end
        lib.registerMenu({
            id = 'fearx_menu',
            title = options.title or 'Menu',
            options = menu
        })
        lib.showMenu('fearx_menu')
    elseif FearX.Menu == 'qb' and FearX.ResourceExists('qb-menu') then
        exports['qb-menu']:openMenu(options)
    elseif FearX.Menu == 'esx' and ESX then
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
            title = options.title or 'Menu',
            align = 'top-left',
            elements = options
        }, function(data, menu)
            if cb then cb(data.current.value) end
        end, function(data, menu)
            menu.close()
        end)
    end
end

function FearX.CloseMenu()
    if FearX.Menu == 'ox' and lib then
        lib.hideMenu()
    elseif FearX.Menu == 'qb' and FearX.ResourceExists('qb-menu') then
        exports['qb-menu']:closeMenu()
    elseif FearX.Menu == 'esx' and ESX then
        ESX.UI.Menu.CloseAll()
    end
end

function FearX.ShowInput(options, cb)
    if FearX.Menu == 'ox' and lib then
        local input = lib.inputDialog(options.title or 'Input', options.inputs or {})
        if cb then cb(input) end
    elseif FearX.Menu == 'qb' and FearX.ResourceExists('qb-input') then
        local dialog = exports['qb-input']:ShowInput(options)
        if cb then cb(dialog) end
    elseif FearX.Menu == 'esx' and ESX then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'input', {
            title = options.title or 'Input'
        }, function(data, menu)
            if cb then cb(data.value) end
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
    end
end