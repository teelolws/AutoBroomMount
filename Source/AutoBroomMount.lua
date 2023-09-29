local addonName, addon = ...

local function update()
    local spellName = GetSpellInfo(368896)
    local dragonridingUsable = IsUsableSpell(spellName)
    
    spellName = GetSpellInfo(419345)
    local broomUsable = true--IsUsableSpell(spellName)
    local source, replacement = "C_MountJournal%.SummonByID%(0%)", "C_MountJournal.SummonByID(1799)"
    
    if dragonridingUsable or (not broomUsable) then
        source, replacement = "C_MountJournal%.SummonByID%(1799%)", "C_MountJournal.SummonByID(0)"
    end
    
    for macroIndex = 1, 138 do
        local name, icon, body = GetMacroInfo(macroIndex)
        if name and body and body:find(source) then
            body = body:gsub(source, replacement)
            EditMacro(macroIndex, name, icon, body)
        end
    end
end

EventUtil.RegisterOnceFrameEventAndCallback("PLAYER_ENTERING_WORLD", update)
EventRegistry:RegisterFrameEventAndCallback("MOUNT_JOURNAL_USABILITY_CHANGED", update)
