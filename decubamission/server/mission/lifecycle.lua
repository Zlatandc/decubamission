-- Mission Lifecycle

MissionLifecycle = {}

local function onMissionStart(mission)
    print('[MissionLifecycle] start ' .. mission.id)
end

local function onMissionCompleted(mission)
    print('[MissionLifecycle] completed ' .. mission.id)
end

local function onMissionFailed(mission)
    print('[MissionLifecycle] failed ' .. mission.id)
end

local function onMissionDestroyed(mission, reason)
    print('[MissionLifecycle] destroyed ' .. mission.id)
    MissionManager.destroyMission(mission.id, reason)
end

function MissionLifecycle.handleStateChange(mission, newState, reason)
    if not mission then return end

    if newState == 'running' then
        onMissionStart(mission)
    elseif newState == 'completed' then
        onMissionCompleted(mission)
    elseif newState == 'failed' then
        onMissionFailed(mission)
    elseif newState == 'destroyed' then
        onMissionDestroyed(mission, reason)
    end
end
