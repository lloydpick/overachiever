
--
--  Overachiever - Tabs: Suggestions.lua
--    by Tuhljin
--
--  If you don't wish to use the suggestions tab, feel free to delete this file or rename it (e.g. to
--  Suggestions_unused.lua). The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS

local RecentReminders = Overachiever.RecentReminders

-- ZONE-SPECIFIC ACHIEVEMENTS
----------------------------------------------------

local ACHID_ZONE_NUMQUESTS
if (UnitFactionGroup("player") == "Alliance") then
  ACHID_ZONE_NUMQUESTS = {
  -- Outland
	["Blade's Edge Mountains"] = 1193,
	["Zangarmarsh"] = 1190,
	["Netherstorm"] = 1194,
	["Hellfire Peninsula"] = 1189,
	["Terokkar Forest"] = 1191,
	["Shadowmoon Valley"] = 1195,
	["Nagrand"] = 1192,
  -- Northrend
	["Icecrown"] = 40,
	["Dragonblight"] = 35,
	["Howling Fjord"] = 34,
	["Borean Tundra"] = 33,
	["Sholazar Basin"] = 39,
	["Zul'Drak"] = 36,
	["Grizzly Hills"] = 37,
	["The Storm Peaks"] = 38,
  }
else
  ACHID_ZONE_NUMQUESTS = {
  -- Outland
	["Blade's Edge Mountains"] = 1193,
	["Zangarmarsh"] = 1190,
	["Netherstorm"] = 1194,
	["Hellfire Peninsula"] = 1271,
	["Terokkar Forest"] = 1272,
	["Shadowmoon Valley"] = 1195,
	["Nagrand"] = 1273,
  -- Northrend
	["Icecrown"] = 40,
	["Dragonblight"] = 1359,
	["Howling Fjord"] = 1356,
	["Borean Tundra"] = 1358,
	["Sholazar Basin"] = 39,
	["Zul'Drak"] = 36,
	["Grizzly Hills"] = 1357,
	["The Storm Peaks"] = 38,
  }
end

local ACHID_ZONE_MISC = {
-- Eastern Kingdoms
	["Stranglethorn Vale"] =	-- "The Green Hills of Stranglethorn", "Gurubashi Arena Master",
		{ 940, 389, 396 },	-- "Gurubashi Arena Grand Master"
-- Outland
	["Blade's Edge Mountains"] = 1276,	-- "Blade's Edge Bomberman"
	["Nagrand"] = 939,		-- "Hills Like White Elekk"
	["Netherstorm"] = 545,		-- "Shave and a Haircut"
	["Shattrath City"] = { 1165, 905 },	-- "My Sack is "Gigantique"", "Old Man Barlowned"
	["Terokkar Forest"] = { 905, 1275 },	-- "Old Man Barlowned", "Bombs Away"
-- Northrend
	["Borean Tundra"] = 561,	-- "D.E.H.T.A's Little P.I.T.A."
	["Dragonblight"] = { 1277, 547 },	-- "Rapid Defense", "Veteran of the Wrathgate"
	["Dalaran"] = { 2096, 1956, 1958, 545 },
	["Sholazar Basin"] =		-- "The Snows of Northrend", "Honorary Frenzyheart",
		{ 938, 961, 962 },	-- "Savior of the Oracles"
	["Wintergrasp"] = { 1752, 2199, 1737, 1717, 1739, 1751, 1755, 1727, 1731, 1723 },
}
if (UnitFactionGroup("player") == "Alliance") then
  ACHID_ZONE_MISC["Grizzly Hills"] = 2016	-- "Grizzled Veteran"
  -- "City Defender", "Shave and a Haircut":
  ACHID_ZONE_MISC["Stormwind City"] = { 388, 545 }
  ACHID_ZONE_MISC["Ironforge"] = { 388, 545 }
  ACHID_ZONE_MISC["Darnassus"] = 388
  ACHID_ZONE_MISC["The Exodar"] = 388
  -- "Wrath of the Alliance", faction leader kill, "For The Alliance!":
  ACHID_ZONE_MISC["Orgrimmar"] = { 604, 610, 614 }
  ACHID_ZONE_MISC["Thunder Bluff"] = { 604, 611, 614 }
  ACHID_ZONE_MISC["Undercity"] = { 604, 612, 614 }
  ACHID_ZONE_MISC["Silvermoon City"] = { 604, 613, 614 }
else
  ACHID_ZONE_MISC["Grizzly Hills"] = 2017	-- "Grizzled Veteran"
  -- "City Defender", "Shave and a Haircut":
  ACHID_ZONE_MISC["Orgrimmar"] = { 1006, 545 }
  ACHID_ZONE_MISC["Thunder Bluff"] = 1006
  ACHID_ZONE_MISC["Undercity"] = { 1006, 545 }
  ACHID_ZONE_MISC["Silvermoon City"] = 1006
  -- "Wrath of the Horde", faction leader kill, "For The Horde!":
  ACHID_ZONE_MISC["Stormwind City"] = { 603, 615, 619 }
  ACHID_ZONE_MISC["Ironforge"] = { 603, 616, 619 }
  ACHID_ZONE_MISC["Darnassus"] = { 603, 617, 619 }
  ACHID_ZONE_MISC["The Exodar"] = { 603, 618, 619 }
end
-- "The Fishing Diplomat":
tinsert(ACHID_ZONE_MISC["Stormwind City"], 150)
tinsert(ACHID_ZONE_MISC["Orgrimmar"], 150)
-- "Old Crafty" and "Old Ironjaw":
tinsert(ACHID_ZONE_MISC["Orgrimmar"], 1836)
tinsert(ACHID_ZONE_MISC["Ironforge"], 1837)

local ACHID_INSTANCES = {
-- Classic Dungeons
	["The Deadmines"] = 628,
	["Ragefire Chasm"] = 629,
	["Wailing Caverns"] = 630,
	["Shadowfang Keep"] = 631,
	["Blackfathom Deeps"] = 632,
	["The Stockade"] = 633,		-- "Stormwind Stockade"
	["Gnomeregan"] = 634,
	["Razorfen Kraul"] = 635,
	["Razorfen Downs"] = 636,
	["Scarlet Monastery"] = 637,
	["Uldaman"] = 638,
	["Zul'Farrak"] = 639,
	["Maraudon"] = 640,
	["Sunken Temple"] = 641,
	["Blackrock Depths"] = 642,
	["Lower Blackrock Spire"] = 643,
	["Upper Blackrock Spire"] = { 1307, 2188 },	-- "Upper Blackrock Spire", "Leeeeeeeeeeeeeroy!"
	["Dire Maul"] = 644,
	["Scholomance"] = 645,
	["Stratholme"] = 646,
-- Classic Raids
	["Zul'Gurub"] = { 688, 560, 957 },	-- "Zul'Gurub", "Deadliest Catch", "Hero of the Zandalar"
	["Ruins of Ahn'Qiraj"] = 689,
	["Onyxia's Lair"] = 684,
	["Molten Core"] = 686,
	["Blackwing Lair"] = 685,
	["Temple of Ahn'Qiraj"] = 687,
-- Burning Crusade
	["Auchenai Crypts"] = 666,
	["The Mechanar"] = 658,
	["Zul'Aman"] = 691,
	["The Blood Furnace"] = 648,
	["Hellfire Ramparts"] = 647,
	["Mana-Tombs"] = 651,
	["The Botanica"] = 659,
	["Shadow Labyrinth"] = 654,
	["Sunwell Plateau"] = 698,
	["Black Temple"] = 697,			-- "The Black Temple"
	["Hyjal Summit"] = 695,			-- "The Battle for Mount Hyjal"
	["Tempest Keep"] = 696,
	["Sethekk Halls"] = 653,
	["Old Hillsbrad Foothills"] = 652,	-- "The Escape From Durnholde"
	["The Black Morass"] = 655,		-- "Opening of the Dark Portal"
	["Magtheridon's Lair"] = 693,
	["Gruul's Lair"] = 692,
	["Karazhan"] = 690,
	["The Steamvault"] = 656,
	["Serpentshrine Cavern"] = 694,
	["The Shattered Halls"] = 657,
	["The Slave Pens"] = 649,
	["The Underbog"] = 650,			-- "Underbog"
	["Magisters' Terrace"] = 661,		-- "Magister's Terrace"
	["The Arcatraz"] = 660,
-- Lich King Dungeons
	["The Culling of Stratholme"] = 479,
	["Utgarde Keep"] = 477,
	["Drak'Tharon Keep"] = 482,
	["Gundrak"] = 484,
	["Ahn'kahet: The Old Kingdom"] = 481,
	["Halls of Stone"] = 485,
	["Utgarde Pinnacle"] = 488,
	["The Oculus"] = 487,
	["Halls of Lightning"] = 486,
	["The Nexus"] = 478,
	["The Violet Hold"] = 483,
	["Azjol-Nerub"] = 480,
-- Lich King Raids
	["Naxxramas"] = { 2146, 576, 578, 572, 1856, 2176, 2178, 2180, 568, 2187, 1996, 1997, 1858, 564, 2182, 2184,
		566, 574, 562 },
	["The Eye of Eternity"] = { 622, 1874, 2148, 1869 },
	["The Obsidian Sanctum"] = { 1876, 2047, 2049, 2050, 2051, 624 },
	["Vault of Archavon"] = 1722,
}

local ACHID_INSTANCES_HEROIC = {
-- Burning Crusade
	["Auchenai Crypts"] = 672,
	["The Blood Furnace"] = 668,
	["The Slave Pens"] = 669,
	["Hellfire Ramparts"] = 667,
	["Mana-Tombs"] = 671,
	["The Underbog"] = 670,			-- "Heroic: Underbog"
	["Old Hillsbrad Foothills"] = 673,	-- "Heroic: The Escape From Durnholde"
	["Magisters' Terrace"] = 682,		-- "Heroic: Magister's Terrace"
	["The Arcatraz"] = 681,
	["The Mechanar"] = 679,
	["The Shattered Halls"] = 678,
	["The Steamvault"] = 677,
	["The Botanica"] = 680,
	["The Black Morass"] = 676,		-- "Heroic: Opening of the Dark Portal"
	["Shadow Labyrinth"] = 675,
	["Sethekk Halls"] = 674,
-- Lich King Dungeons
	["Halls of Stone"] = 496,
	["Gundrak"] = 495,
	["Azjol-Nerub"] = 491,
	["Halls of Lightning"] = 497,
	["Utgarde Keep"] = 489,
	["The Nexus"] = 490,
	["Drak'Tharon Keep"] = 493,
	["Ahn'kahet: The Old Kingdom"] = 492,
	["The Oculus"] = 498,
	["The Violet Hold"] = 494,
	["The Culling of Stratholme"] = 500,
	["Utgarde Pinnacle"] = 499,
-- Lich King Raids
	["Vault of Archavon"] = 1721,
}

local ACHID_INSTANCES_HEROIC_EXTRA = {
-- Lich King Dungeons
	["Azjol-Nerub"] = { 1860, 1296, 1297 },
	["Utgarde Pinnacle"] = { 1873, 2043, 2156, 2157 },
	["Gundrak"] = { 2040, 2152, 1864, 2058 },
	["The Oculus"] = { 1868, 1871, 2044, 2045, 2046 },
	["Ahn'kahet: The Old Kingdom"] = { 2056, 1861, 1862, 2038 },
	["Utgarde Keep"] = 1919,
	["The Violet Hold"] = { 2153, 1865, 2041, 1816 },
	["Drak'Tharon Keep"] = { 2039, 2057, 2151 },
	["The Culling of Stratholme"] = { 1872, 1817 },
	["The Nexus"] = { 2037, 2036, 2150 },
	["Halls of Lightning"] = { 2042, 1867, 1834 },
	["Halls of Stone"] = { 1866, 2154, 2155 },
-- Lich King Raids
	["Naxxramas"] = { 2186, 579, 565, 577, 575, 2177, 563, 567, 1857, 569, 573, 1859, 2139, 2181, 2183, 2185,
		2147, 2140, 2179 },
	["The Eye of Eternity"] = { 623, 1875, 1870, 2149 },
	["The Obsidian Sanctum"] = { 625, 2048, 2052, 2053, 2054, 1877 },
}

local LBZ = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()
local function ZoneLookup(zoneName)
  return LBZ[zoneName] or zoneName
end


-- SUGGESTIONS TAB CREATION AND HANDLING
----------------------------------------------------

local VARS
local frame, panel, sortdrop
local RefreshBtn, NoSuggestionsLabel, ResultsLabel

local function SortDrop_OnSelect(self, value)
  VARS.SuggestionsSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function OnLoad(v)
  VARS = v
  sortdrop:SetSelectedValue(VARS.SuggestionsSort or 0)
end

frame, panel = Overachiever.BuildNewTab("Overachiever_SuggestionsFrame", L.SUGGESTIONS_TAB,
                "Interface\\AddOns\\Overachiever_Tabs\\SuggestionsWatermark", L.SUGGESTIONS_HELP, OnLoad)

sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_SuggestionsFrameSortDrop", panel, {
  {
    text = L.TAB_SORT_NAME,
    value = 0
  },
  {
    text = L.TAB_SORT_COMPLETE,
    value = 1
  },
  {
    text = L.TAB_SORT_POINTS,
    value = 2
  },
  {
    text = L.TAB_SORT_ID,
    value = 3
  };
})
sortdrop:SetLabel(L.TAB_SORT, true)
sortdrop:SetPoint("TOPLEFT", panel, "TOPLEFT", -16, -22)
sortdrop:OnSelect(SortDrop_OnSelect)

local function Refresh_AddIncomplete(list, ...)
  local id, _, complete
  for i=1, select("#", ...) do
    id = select(i, ...)
    if (id) then
      if (type(id) == "table") then
        Refresh_AddIncomplete(list, unpack(id))
      else
        _, _, _, complete = GetAchievementInfo(id)
        if (not complete) then
          list[#list+1] = id
        else
          id, complete = GetNextAchievement(id)
          if (id) then
            while (complete) do  -- Find first incomplete achievement in the chain
              id, complete = GetNextAchievement(id)
            end
            if (id) then  list[#list+1] = id;  end
          end
        end
      end
    end
  end
end

local temptab

local function Refresh()
  local list = frame.AchList
  wipe(list)

  if (IsInInstance()) then
    local zone = GetRealZoneText()
    if (not zone or zone == "") then  zone = GetSubZoneText();  end
    zone = ZoneLookup(zone)
    Refresh_AddIncomplete( list, ACHID_INSTANCES[zone] )
    if (GetInstanceDifficulty() > 1) then  -- If current instance is Heroic
      Refresh_AddIncomplete(list, ACHID_INSTANCES_HEROIC[zone], ACHID_INSTANCES_HEROIC_EXTRA[zone])
    end
  else
    local zone, subz = GetRealZoneText(), GetSubZoneText()
    zone, subz = ZoneLookup(zone), ZoneLookup(subz)
    Refresh_AddIncomplete(list, Overachiever.ExploreZoneIDLookup(zone), ACHID_ZONE_NUMQUESTS[zone], ACHID_ZONE_MISC[zone])
    -- Also look for instance achievements for an instance you're near if we can look it up easily (since many zones
    -- have subzones with the instance name when you're near the instance entrance and some instance entrances are
    -- actually in their own "zone" using the instance's zone name):
    Refresh_AddIncomplete(list, ACHID_INSTANCES[subz] or ACHID_INSTANCES[zone])
    if (GetCurrentDungeonDifficulty() > 1) then  -- If option currently set to Heroic difficulty
      Refresh_AddIncomplete(list, ACHID_INSTANCES_HEROIC[subz] or ACHID_INSTANCES_HEROIC[zone],
        ACHID_INSTANCES_HEROIC_EXTRA[subz] or ACHID_INSTANCES_HEROIC_EXTRA[zone])
    end
  end

  temptab = temptab or {}
  Overachiever.RecentReminders_Check()
  for id,t in pairs(RecentReminders) do
    local found
    for i,v in ipairs(list) do
      if (v == id) then
        found = true
        break
      end
    end
    if (not found) then  temptab[#temptab+1] = id;  end
  end
  Refresh_AddIncomplete(list, unpack(temptab))
  wipe(temptab)

  Overachiever_SuggestionsFrameContainerScrollBar:SetValue(0)
  frame:ForceUpdate(true)
  local num = #list
  if (num > 0) then
    NoSuggestionsLabel:Hide()
    ResultsLabel:SetText(L.SUGGESTIONS_RESULTS:format(num))
  else
    NoSuggestionsLabel:Show()
    ResultsLabel:SetText(" ")
  end
end

RefreshBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
RefreshBtn:SetWidth(75); RefreshBtn:SetHeight(21)
RefreshBtn:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 16, -14)
RefreshBtn:SetText(L.SUGGESTIONS_REFRESH)
RefreshBtn:SetScript("OnClick", Refresh)

ResultsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ResultsLabel:SetPoint("TOPLEFT", RefreshBtn, "BOTTOMLEFT", 0, -8)
ResultsLabel:SetText(" ")

panel:SetScript("OnShow", Refresh)

NoSuggestionsLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
NoSuggestionsLabel:SetPoint("TOP", frame, "TOP", 0, -189)
NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY)
NoSuggestionsLabel:SetWidth(490)

--[[
local InfoLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
InfoLabel:SetPoint("LEFT", panel, "LEFT", 0, 25)
InfoLabel:SetWidth(180)
InfoLabel:SetJustifyH("LEFT")
InfoLabel:SetText(L.SUGGESTIONS_INFO)
--]]


--[[
-- /run Overachiever.Debug_GetIDsInCat( GetAchievementCategory(GetTrackedAchievement()) )
function Overachiever.Debug_GetIDsInCat(cat)
  local tab = Overachiever_Settings.Debug_AchIDsInCat
  if (not tab) then  Overachiever_Settings.Debug_AchIDsInCat = {};  tab = Overachiever_Settings.Debug_AchIDsInCat;  end
  local catname = GetCategoryInfo(cat)
  tab[catname] = {}
  tab = tab[catname]
  local id, n
  for i=1,GetCategoryNumAchievements(cat) do
    id, n = GetAchievementInfo(cat, i)
    tab[n] = id
  end
end
--]]
