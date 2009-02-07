
--
--  Overachiever - Tabs: Watch.lua
--    by Tuhljin
--
--  If you don't wish to use the watch tab, feel free to delete this file or rename it (e.g. to Watch_unused.lua).
--  The addon's other features will work regardless.
--

-- This future tab will allow you to create lists of achievements to be shown here, both per character and
-- for all your characters.
--
-- Plans:
-- - Right-click on an achievement in the achievement UI to toggle watching it globally or right-shift-click to
--   toggle watching it for the current character.
-- - The tab will flash briefly when something is toggled. Try flashing a different color depending on whether
--   adding to or removing from the watch list.
-- -

--[[

local L = OVERACHIEVER_STRINGS

local frame = Overachiever.BuildNewTab("Overachiever_WatchFrame", L.SUGGESTIONS_TAB,
                "Interface\\AddOns\\Overachiever_Tabs\\SuggestionsWatermark", "Suggestions help goes here.")
--]]
