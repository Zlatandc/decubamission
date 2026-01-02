--- Mission Client Registry
--- Contiene SOLO handler client-side
--- Nessuna logica missione

MissionClient = {}

MissionClient.handlers = {}

--- Register a mission state handler
--- @param state string
--- @param fn function
function MissionClient.register(state, fn)
    MissionClient.handlers[state] = fn
end

--- Dispatch state change
--- @param missionId number
--- @param data table
function MissionClient.dispatch(missionId, data)
    local handler = MissionClient.handlers[data.state]
    if handler then
        handler(missionId, data)
    end
end
------debug
MissionClient.register('running', function(id, data)
    print('[CLIENT] Mission running:', id)
end)

MissionClient.register('destroyed', function(id, data)
    print('[CLIENT] Mission destroyed:', id)
end)
