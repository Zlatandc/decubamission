fx_version 'cerulean'
game 'gta5'

name 'decubamission'
author 'Decuba'
description 'Mission system with server-authoritative rewards'
version '1.0.0'

lua54 'yes'

-- =========================
-- SHARED
-- =========================
shared_scripts {
    'shared/enums.lua',
    'shared/config.lua',
    'shared/missions.lua'
}

-- =========================
-- SERVER
-- =========================
server_scripts {
    '@oxmysql/lib/MySQL.lua', -- se usi oxmysql
    'server/bootstrap.lua',

    -- mission core
    'server/mission/*.lua',

    -- reward system
    'server/reward/*.lua',

    -- inventory adapter
    'server/inventory/*.lua',
    'server/inventory/providers/*.lua',

    -- admin
    'server/admin/*.lua',

    -- storage & sharding
    'server/storage/*.lua',

    -- debug
    'server/debug/*.lua'
}

-- =========================
-- CLIENT
-- =========================
client_scripts {
    'client/listener.lua',
    'client/registry.lua',

    'client/missions/*.lua',
    'client/ai/*.lua',
    'client/zones/*.lua',
    'client/ui/admin/nui.lua'
}

-- =========================
-- FILES NUI
-- =========================
ui_page 'client/ui/admin/index.html'

files {
    'client/ui/admin/index.html',
    'client/ui/admin/style.css',
    'client/ui/admin/app.js'
}
