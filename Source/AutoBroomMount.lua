local addonName, addon = ...

local function unmute()
    UnmuteSoundFile(567489)
    UnmuteSoundFile(567524)
end

local function mute()
    MuteSoundFile(567489)
    MuteSoundFile(567524)
end

local function update()
    if InCombatLockdown() then return end
    
    local spellName = C_Spell.GetSpellInfo(368896).name
    
    local holidayActive = false
    for i = 1, GetNumRandomDungeons() do
        if GetLFGRandomDungeonInfo(i) == 285 then
            holidayActive = true
        end
    end
    
    local broomUsable = false
    spellName = C_Spell.GetSpellInfo(419345).name
    broomUsable = C_Spell.IsSpellUsable(spellName)
    
    local source, replacement = "C_MountJournal%.SummonByID%(1799%)", "C_MountJournal.SummonByID(0)"
    
    if holidayActive and broomUsable then
        source, replacement = "C_MountJournal%.SummonByID%(0%)", "C_MountJournal.SummonByID(1799)"
    end
    
    for macroIndex = 1, 138 do
        local name, icon, body = GetMacroInfo(macroIndex)
        if name and body and body:find(source) then
            body = body:gsub(source, replacement)
            EditMacro(macroIndex, name, icon, body)
        end
    end
    
    if GetCursorInfo() then return end
    
    if holidayActive and broomUsable then
        for slotID = 1, 120 do
            if GetActionTexture(slotID) then
                local actionType, actionID, subType = GetActionInfo(slotID)
                if (actionType == "summonmount") and (actionID == 268435455) then
                    mute()
                    PickupAction(slotID)
                    ClearCursor()
                    C_Spell.PickupSpell(419345)
                    PlaceAction(slotID)
                    RunNextFrame(unmute)
                end
            end
        end
    else
        for slotID = 1, 120 do
            if GetActionTexture(slotID) then
                local actionType, actionID, subType = GetActionInfo(slotID)
                if ((actionType == "summonmount") and (actionID == 1799)) or ((actionType == "companion") and (actionID == 419345) and (subType == "MOUNT")) then
                    mute()
                    PickupAction(slotID)
                    ClearCursor()
                    C_MountJournal.Pickup(0)
                    PlaceAction(slotID)
                    RunNextFrame(unmute)
                end
            end
        end
    end
end

EventUtil.RegisterOnceFrameEventAndCallback("PLAYER_ENTERING_WORLD", update)
EventRegistry:RegisterFrameEventAndCallback("MOUNT_JOURNAL_USABILITY_CHANGED", update)
EventRegistry:RegisterFrameEventAndCallback("PLAYER_REGEN_ENABLED", update)
