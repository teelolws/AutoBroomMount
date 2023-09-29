# AutoBroomMount
Switches your Mount macro for a Broom macro during Hallow's End

Great news! We finally have a permanent Broom mount that goes in to our collection, starting from the Trading Post of October 2023!

Want your mount macro to switch to using the Broom Mount during Hallow's End without having to do anything? This addon will automate that for you.

The requirement is simple: use a mount macro that has `C_MountJournal.SummonByID(0)` in it somewhere. This is the call to Summon Random Favorite Mount.

Examples of Mount Macros you might use that will be compatible:

- A generic call to use the Random Favorite Mount button, and nothing else:

`/run C_MountJournal.SummonByID(0)`

- For a Shaman to use Ghost Wolf if a mount is unavailable:

`#showtooltip
/cast [combat][nooutdoors] Ghost Wolf
/run if not InCombatLockdown() then C_MountJournal.SummonByID(0) end`

- Heres a Druid one I wrote that chooses Cat Form / Travel Form / Dragonriding depending on circumstances:

`#showtooltip
/cancelaura Bear Form
/cancelaura Cat Form
/cast [flyable,nocombat] Travel Form
/cast [combat] Travel Form
/cast [nooutdoors] Cat Form
/run if SecureCmdOptionParse "nocombat,noflyable,outdoors"then C_MountJournal.SummonByID(0) end`

As long as you macro that Summon Random Favorite Mount button then this will work.
