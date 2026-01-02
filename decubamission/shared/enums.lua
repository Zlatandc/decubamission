--- Enumerazioni globali
--- Evita stringhe magiche

Enums = {}

Enums.MissionState = {
    CREATED = 'created',
    RUNNING = 'running',
    COMPLETED = 'completed',
    FAILED = 'failed'
}

Enums.RewardStatus = {
    PENDING = 'pending',
    CONFIRMED = 'confirmed',
    ROLLED_BACK = 'rolled_back'
}

return Enums
