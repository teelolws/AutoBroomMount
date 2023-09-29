local addonName, addon = ...

EventUtil.RegisterOnceFrameEventAndCallback("PLAYER_ENTERING_WORLD", function()
    local spellName = GetSpellInfo(419345)
    local usable = IsUsableSpell(spellName)
    local source, replacement = "C_MountJournal%.SummonByID%(0%)", "C_MountJournal.SummonByID(1799)"
    
    if not usable then
        source, replacement = "C_MountJournal%.SummonByID%(1799%)", "C_MountJournal.SummonByID(0)"
    end
    
    for macroIndex = 1, 138 do
        local name, icon, body = GetMacroInfo(macroIndex)
        if name and body and body:find(source) then
            body = body:gsub(source, replacement)
            EditMacro(macroIndex, name, icon, body)
        end
    end
end)
