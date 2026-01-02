RegisterCommand('missiondebug', function(source)
    local mission = MissionManager.createMission({
        type = 'debug',
        owner = source
    })

    -- PARTENZA
    MissionState.set(mission, 'running', 'debug start')

    -- FINE DOPO 5 SECONDI
    SetTimeout(5000, function()
        MissionState.set(mission, 'destroyed', 'debug end')
    end)
end)
