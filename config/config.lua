Config = {}

Config.Framework = 'auto'
Config.Inventory = 'auto'
Config.Menu = 'auto'
Config.Target = 'auto'
Config.Progress = 'auto'
Config.Notify = 'auto'
Config.TextUI = 'auto'
Config.Dispatch = 'auto'

Config.Debug = false

Config.ResourceNames = {
    frameworks = {
        qb = 'qb-core',
        esx = 'es_extended',
        qbx = 'qbx-core',
        ox = 'ox_core'
    },
    inventories = {
        ox = 'ox_inventory',
        qb = 'qb-inventory',
        esx = 'esx_inventoryhud',
        qs = 'qs-inventory',
        ps = 'ps-inventory',
        origen = 'origen_inventory'
    },
    menus = {
        ox = 'ox_lib',
        qb = 'qb-menu',
        esx = 'esx_menu_default'
    },
    targets = {
        ox = 'ox_target',
        qb = 'qb-target',
        bt = 'bt-target'
    },
    progress = {
        ox = 'ox_lib',
        qb = 'qb-progressbar',
        esx = 'esx_progressbar'
    },
    notify = {
        ox = 'ox_lib',
        qb = 'qb-notify',
        esx = 'esx_notify',
        okok = 'okokNotify'
    },
    textui = {
        ox = 'ox_lib',
        qb = 'qb-drawtext',
        esx = 'esx_textui'
    },
    dispatch = {
        cd = 'cd_dispatch',
        ps = 'ps-dispatch',
        qs = 'qs-dispatch',
        linden = 'linden_outlawalert'
    }
}

Config.AdminGroups = {
    'admin',
    'superadmin',
    'owner',
    'god'
}