
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
L.SUGGESTIONS_HELP = "Suggested achievements are listed here based on your current location. Also listed are any achievements you were reminded about through a tooltip within the last 2 minutes or that have a timer which started recently.";
L.SUGGESTIONS_REFRESH = "Refresh";
L.SUGGESTIONS_EMPTY = "Overachiever has no suggestions for you at this time.";
L.SUGGESTIONS_RESULTS = "%d |4suggestion:suggestions; found.";
L.SUGGESTIONS_RESULTS_TRADESKILL = "%s: %d |4suggestion:suggestions; found.";
L.SUGGESTIONS_EMPTY_TRADESKILL = "%s: Overachiever has no suggestions for you at this time.";
L.SUGGESTIONS_LOCATION = "Location:"
L.SUGGESTIONS_LOCATION_TIP = "Override Zone/Instance Location"
L.SUGGESTIONS_LOCATION_TIP2 = "Leave blank to get suggestions for your current location or start typing to get a matching valid zone or instance name to use instead. Press |cffffffffTab|r to cycle between locations that match the text to the left of the cursor. |cffffffffShift+Tab|r cycles in reverse order. If the cursor is at the leftmost position, it cycles between all valid locations."
L.SUGGESTIONS_LOCATION_SUBZONE = "Subzone:"
L.SUGGESTIONS_LOCATION_NOSUBZONE = "(unspecified)"

L.WATCH_TAB = "Watch";
L.WATCH_HELP = "Create your watch list by |cffffffffalt+clicking|r on achievements in the other tabs or achievement chat links. |cffffffffAlt+click|r on one displayed here to stop watching it.";
L.WATCH_EMPTY = "Your watch list is empty. Alt+click on an achievement in another tab or an achievement's chat link to watch it.";
L.WATCH_EMPTY_SHORT = "Empty List";
L.WATCH_DISPLAYEDLIST = "Displayed List:";
L.WATCH_DEFAULTLIST = "Default List:";
L.WATCH_DEFAULTLIST_TIP = "The specified list will be the Displayed List at the beginning of each session.";
L.WATCH_COPY = "Copy to List:";
L.WATCH_COPY_TIP = "When enabled, if you |cffffffffshift+alt+click|r on an achievement on this tab, it will be added to the specified watch list.";
L.WATCH_LIST_GLOBAL = "Global";
L.WATCH_LIST_PERCHAR = "Character-specific";
L.WATCH_NEW = "New";
L.WATCH_DELETE = "Delete";
L.WATCH_CLEAR = "Clear";
L.WATCH_COPY = "Copy To:";
L.WATCH_POPUP_NEWLIST = "Enter the name of your new achievement watch list:";
L.WATCH_POPUP_DELETELIST = "Are you sure you want to permanently delete the current achievement watch list?";
L.WATCH_POPUP_CLEARLIST = "Are you sure you want to clear the contents of the current achievement watch list?";

L.TAB_SORT = "Sort by:";
L.TAB_SORT_NAME = "Name";
L.TAB_SORT_ID = "ID";
L.TAB_SORT_POINTS = "Point value";
L.TAB_SORT_COMPLETE = "Date completed";
L.TAB_HELP = "|cffffffffCtrl-click|r on an achievement to jump to its place in the standard UI.|n|nA |cffffffffblue background|r means it is part of a series for which you haven't completed an earlier step.|n|nA |cffffffffred background|r means it cannot be found in the standard UI for this character because it is exclusive to the opposing faction or is an unacquired Feat of Strength.|n|nA |cffffffffgreen background|r means a reminder about this achievement was displayed in a tooltip recently or it has a timer which started recently.";

if (locale == "deDE") then  -- German
--@localization(locale="deDE", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="subtable")@

elseif (locale == "frFR") then  -- French
--@localization(locale="frFR", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="subtable")@

elseif (locale == "zhTW") then  -- Traditional Chinese
--@localization(locale="zhTW", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="subtable")@

elseif (locale == "zhCN") then  -- Simplified Chinese
--@localization(locale="zhCN", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="subtable")@

elseif (locale == "ruRU") then  -- Russian
--@localization(locale="ruRU", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="subtable")@

elseif (locale == "koKR") then  -- Korean
--@localization(locale="koKR", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="subtable")@

elseif (locale == "esES" or locale == "esMX") then  -- Spanish
--@localization(locale="esES", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="subtable")@

	if (locale == "esMX") then  -- Spanish (Mexican)
--@localization(locale="esMX", format="lua_additive_table", namespace="Tabs", handle-subnamespaces="concat")@

	-- We had to use "concat" instead of "subtable" for Curse's handle-subnamespaces substitution scheme so
	-- esMX's L.SUBZONES doesn't entirely overwrite esES's. This puts them in the format "SUBZONES/<key>";
	-- we'll iterate over the table to find those and put the values in the proper place:
		local tab = L.SUBZONES
		for k,v in pairs(L) do
			if (strsub(k, 1, 9) == "SUBZONES/") then
				tab[strsub(k, 10)] = v
				L[k] = nil
			end
		end
	end

end
if (not L.SUBZONES) then
	L.SUBZONES = {
	-- Ulduar:
		["Formation Grounds"] = "Formation Grounds",
		["Razorscale's Aerie"] = "Razorscale's Aerie",
		["The Assembly of Iron"] = "The Assembly of Iron",
		["The Celestial Planetarium"] = "The Celestial Planetarium",
		["The Clash of Thunder"] = "The Clash of Thunder",
		["The Colossal Forge"] = "The Colossal Forge",
		["The Conservatory of Life"] = "The Conservatory of Life",
		["The Descent into Madness"] = "The Descent into Madness",
		["The Halls of Winter"] = "The Halls of Winter",
		["The Observation Ring"] = "The Observation Ring",
		["The Prison of Yogg-Saron"] = "The Prison of Yogg-Saron",
		["The Scrapyard"] = "The Scrapyard",
		["The Shattered Walkway"] = "The Shattered Walkway",
		["The Spark of Imagination"] = "The Spark of Imagination",
	-- Icecrown:
		["Argent Tournament Grounds"] = "Argent Tournament Grounds",
		["The Ring of Champions"] = "The Ring of Champions",
		["Argent Pavilion"] = "Argent Pavilion",
		["The Argent Valiants' Ring"] = "The Argent Valiants' Ring",
		["The Aspirants' Ring"] = "The Aspirants' Ring",
		["The Alliance Valiants' Ring"] = "The Alliance Valiants' Ring",
		["Silver Covenant Pavilion"] = "Silver Covenant Pavilion",
		["Sunreaver Pavilion"] = "Sunreaver Pavilion",
		["The Horde Valiants' Ring"] = "The Horde Valiants' Ring",
	}
end