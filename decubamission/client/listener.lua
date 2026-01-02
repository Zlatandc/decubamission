--- Client listener
--- Reagisce SOLO allo state bag
--- Nessuna logica missione

-- TODO: AddStateBagChangeHandler
-- TODO: dispatch to client registry

--- Mission Client Listener
--- Reagisce ai cambi di state bag delle missioni

local function onMissionStateChange(bagName, key, value)
    if key ~= 'mission' then return end
    if type(value) ~= 'table' then return end

    local missionId = value.id
    if not missionId then return end

    MissionClient.dispatch(missionId, value)
end

-- Listen for ALL mission state changes
AddStateBagChangeHandler(
    'mission',
    nil, -- global (qualsiasi entity)
    onMissionStateChange
)

