---@diagnostic disable: undefined-global

fx_version 'cerulean'
game 'gta5'

description 'AK-Bank Card and ATM System'
author 'Your Name'
version '1.0.0'

-- Client-side scripts that will run for players
client_scripts {
    'client/main.lua'
}

-- Server-side scripts that will run on the server
server_scripts {
    'server/main.lua'
}

-- Main UI page
ui_page 'html/ui.html'

-- All files used by the system
files {
    'html/ui.html',
    'html/style.css',
    'html/script.js'
}

-- Enable Lua 5.4
lua54 'yes'
