fx_version 'cerulean'
game 'gta5'

name 'fearx-bridge'
author 'FearX Development'
version '1.0.0'
description 'Advanced Framework Bridge System for FiveM'

shared_scripts {
    'config/config.lua',
    'shared/utils.lua'
}

client_scripts {
    'client/framework.lua',
    'client/inventory.lua',
    'client/ui.lua',
    'client/target.lua',
    'client/main.lua'
}

server_scripts {
    'server/framework.lua',
    'server/inventory.lua',
    'server/player.lua',
    'server/main.lua'
}

dependencies {
    '/server:4752',
    '/gameBuild:2189'
}