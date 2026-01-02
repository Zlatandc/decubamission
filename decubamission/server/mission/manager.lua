--- Mission Manager
--- Crea e registra missioni
--- NON gestisce reward

MissionManager = {}

-- TODO: createMission(data)
-- TODO: destroyMission(id)
-- TODO: getMission(id)

return MissionManager
--- Mission Manager
--- Responsabile della creazione, registrazione e distruzione missioni
--- NON gestisce reward
--- NON comunica con il client

MissionManager = {}

-- =========================
-- INTERNAL STATE
-- =========================

--- @type table<number, table>
local missions = {}

--- @type number
local nextMissionId = 0

-- =========================
-- PRIVATE HELPERS
-- =========================

--- Generate a unique mission id
--- @return number
local function generateMissionId()
    nextMissionId += 1
    return nextMissionId
end

-- =========================
-- PUBLIC API
-- =========================

--- Create a new mission
--- @param data table Mission definition
--- @return table mission
function MissionManager.createMission(data)
    assert(type(data) == 'table', 'Mission data must be a table')
    assert(data.type, 'Mission must have a type')
    assert(data.owner, 'Mission must have an owner')

    local id = generateMissionId()

    local mission = {
        id = id,
        type = data.type,
        owner = data.owner,

        players = {
            [data.owner] = true
        },

        entities = data.entities or {},

        state = 'created',
        createdAt = os.time()
    }

    missions[id] = mission

    print(('[MissionManager] Mission %s created (type: %s)'):format(id, mission.type))

    return mission
end

--- Get mission by id
--- @param missionId number
--- @return table|nil
function MissionManager.getMission(missionId)
    return missions[missionId]
end

--- Destroy a mission
--- @param missionId number
--- @param reason string|nil
function MissionManager.destroyMission(missionId, reason)
    local mission = missions[missionId]
    if not mission then
        return false
    end

    missions[missionId] = nil

    print(('[MissionManager] Mission %s destroyed (%s)'):format(
        missionId,
        reason or 'no reason'
    ))

    return true
end

--- Get all active missions (admin/debug)
--- @return table
function MissionManager.getAllMissions()
    return missions
end

return MissionManager
