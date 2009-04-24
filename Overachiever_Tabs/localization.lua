
local L, locale = OVERACHIEVER_STRINGS, GetLocale()

L.SEARCH_TAB = "Search";
L.SEARCH_HELP = "Use this tab to search for achievements. You can also search for achievements by name or ID using slash commands. See Overachiever's readme.txt file for details.";
L.SEARCH_NAME = "Name:";
L.SEARCH_DESC = "Description:";
L.SEARCH_CRITERIA = "Criteria:";
L.SEARCH_REWARD = "Reward:";
L.SEARCH_ANY = "Any of the above:";
L.SEARCH_FULLLIST = "Search all achievements";
L.SEARCH_FULLLIST_TIP = "Include in the search achievements that aren't normally listed in the default UI, such as those exclusive to the opposing faction, unacquired Feats of Strength, etc.";
L.SEARCH_SUBMIT = "Search";
L.SEARCH_RESET = "Reset";
L.SEARCH_RESULTS = "Found %s |4achievement:achievements;.";

L.SUGGESTIONS_TAB = "Suggestions";
L.SUGGESTIONS_HELP = "Suggested achievements are listed here based on your current location. Also listed are any achievements you were reminded about through a tooltip within the last 2 minutes.";
L.SUGGESTIONS_REFRESH = "Refresh";
L.SUGGESTIONS_EMPTY = "Overachiever has no suggestions for you at this time.";
L.SUGGESTIONS_RESULTS = "%d |4suggestion:suggestions; found.";
L.SUGGESTIONS_RESULTS_TRADESKILL = "%s: %d |4suggestion:suggestions; found.";
L.SUGGESTIONS_EMPTY_TRADESKILL = "%s: Overachiever has no suggestions for you at this time.";

L.WATCH_TAB = "Watch";
L.WATCH_HELP = "Create your watch list by |cffffffffalt+clicking|r on achievements in the other tabs or achievement chat links. |cffffffffAlt+click|r on one displayed here to stop watching it.";
L.WATCH_EMPTY = "Your watch list is empty. Alt+click on an achievement in another tab or an achievement's chat link to watch it.";

L.TAB_SORT = "Sort by:";
L.TAB_SORT_NAME = "Name";
L.TAB_SORT_ID = "ID";
L.TAB_SORT_POINTS = "Point value";
L.TAB_SORT_COMPLETE = "Date completed";
L.TAB_HELP = "|cffffffffCtrl-click|r on an achievement to jump to its place in the standard UI.|n|nA |cffffffffblue background|r means it is part of a series for which you haven't completed an earlier step.|n|nA |cffffffffred background|r means it cannot be found in the standard UI for this character because it is exclusive to the opposing faction or is an unacquired Feat of Strength.|n|nA |cffffffffgreen background|r means a reminder about this achievement was displayed in a tooltip recently.";

if (locale == "deDE") then  -- German
--@localization(locale="deDE", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@

elseif (locale == "frFR") then  -- French
--@localization(locale="frFR", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@

elseif (locale == "zhTW") then  -- Traditional Chinese
--@localization(locale="zhTW", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@

elseif (locale == "zhCN") then  -- Simplified Chinese
--@localization(locale="zhCN", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@

elseif (locale == "ruRU") then  -- Russian
--@localization(locale="ruRU", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@

elseif (locale == "koKR") then  -- Korean
--@localization(locale="koKR", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@

elseif (locale == "esES" or locale == "esMX") then  -- Spanish
--@localization(locale="esES", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@

	if (locale == "esMX") then  -- Spanish (Mexican)
--@localization(locale="esMX", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="none")@
	end

end
