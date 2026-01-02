--- Mission State Manager
--- Gestisce le transizioni di stato delle missioni
--- Server-authoritative
--- Nessuna logica di gameplay

local MissionState = {}

MissionLifecycle.handleStateChange(mission, newState, reason)



-- =========================
-- VALID STATES
-- =========================

MissionState.States = {
    CREATED   = 'created',
    RUNNING   = 'running',
    COMPLETED = 'completed',
    FAILED    = 'failed',
    DESTROYED = 'destroyed'
}

-- =========================
-- VALID TRANSITIONS
-- =========================

local validTransitions = {
    created = {
        running = true,
        destroyed = true
    },

    running = {
        completed = true,
        failed = true,
        destroyed = true
    },

    completed = {
        destroyed = true
    },

    failed = {
        destroyed = true
    }
}

-- =========================
-- INTERNAL HELPERS
-- =========================

--- Check if a state transition is valid
--- @param from string
--- @param to string
--- @return boolean
local function isValidTransition(from, to)
    return validTransitions[from] and validTransitions[from][to] == true
end

-- =========================
-- PUBLIC API
-- =========================

--- Set mission state with validation
--- @param mission table
--- @param newState string
--- @param reason string|nil
--- @return boolean
function MissionState.set(mission, newState, reason)
    assert(mission, 'Mission is required')
    assert(newState, 'New state is required')

    local currentState = mission.state

    if currentState == newState then
        return false
    end

    if not isValidTransition(currentState, newState) then
        print(('[MissionState] Invalid transition %s → %s (mission %s)')
            :format(currentState, newState, mission.id))
        return false
    end

    mission.state = newState
mission.stateChangedAt = os.time()

print(('[MissionState] Mission %s state changed: %s → %s (%s)')
    :format(
        mission.id,
        currentState,
        newState,
        reason or 'no reason'
    )
)

-- 🔗 LIFECYCLE HOOK (PUNTO UNICO)
MissionLifecycle.handleStateChange(mission, newState, reason)

return true

end

--- Check current mission state
--- @param mission table
--- @param state string
--- @return boolean
function MissionState.is(mission, state)
    return mission and mission.state == state
end

return MissionState
