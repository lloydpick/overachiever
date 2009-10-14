
--
--  Overachiever - Tabs: Suggestions.lua
--    by Tuhljin
--
--  If you don't wish to use the suggestions tab, feel free to delete this file or rename it (e.g. to
--  Suggestions_unused.lua). The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS

local LBZ = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()
local LBI = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetLookupTable()
local LBIR = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetReverseLookupTable()

local RecentReminders = Overachiever.RecentReminders

local IsAlliance = UnitFactionGroup("player") == "Alliance"

-- ZONE-SPECIFIC ACHIEVEMENTS
----------------------------------------------------

local ACHID_ZONE_NUMQUESTS
if (IsAlliance) then
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
		{ 940, 389, 396, 306 },	-- "Gurubashi Arena Grand Master", "Master Angler of Stranglethorn"
-- Outland
	["Blade's Edge Mountains"] = 1276,	-- "Blade's Edge Bomberman"
	["Nagrand"] = { 939, "1576:1" },	-- "Hills Like White Elekk", "Of Blood and Anguish"
	["Netherstorm"] = 545,		-- "Shave and a Haircut"
	["Shattrath City"] =	-- "My Sack is "Gigantique"", "Old Man Barlowned", "Kickin' It Up a Notch"
		{ 1165, 905, 906 },
	["Terokkar Forest"] = { 905, 1275 },	-- "Old Man Barlowned", "Bombs Away"
-- Northrend
	["Borean Tundra"] = 561,	-- "D.E.H.T.A's Little P.I.T.A."
	["Dragonblight"] = { 1277, 547 },	-- "Rapid Defense", "Veteran of the Wrathgate"
	["Dalaran"] = { 2096, 1956, 1958, 545, 1998, IsAlliance and 1782 or 1783, 3217 },
	["Grizzly Hills"] = { "1596:1" },	-- "Guru of Drakuru"
	["Sholazar Basin"] =		-- "The Snows of Northrend", "Honorary Frenzyheart",
		{ 938, 961, 962 },	-- "Savior of the Oracles"
	["Zul'Drak"] = { "1576:2", "1596:2" },	-- "Of Blood and Anguish", "Guru of Drakuru"
	["Wintergrasp"] = { 2199, 1717, 1751, 1755, 1727, 1723 },
}
if (IsAlliance) then
  tinsert(ACHID_ZONE_MISC["Grizzly Hills"], 2016) -- "Grizzled Veteran"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 1737)	-- "Destruction Derby"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 1752)	-- "Master of Wintergrasp"
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
  tinsert(ACHID_ZONE_MISC["Grizzly Hills"], 2017) -- "Grizzled Veteran"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 2476)	-- "Destruction Derby"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 2776)	-- "Master of Wintergrasp"
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
tinsert(ACHID_ZONE_MISC["Stormwind City"], "150:2")
tinsert(ACHID_ZONE_MISC["Orgrimmar"], "150:1")
-- "Old Crafty" and "Old Ironjaw":
tinsert(ACHID_ZONE_MISC["Orgrimmar"], 1836)
tinsert(ACHID_ZONE_MISC["Ironforge"], 1837)

-- INSTANCES - ANY DIFFICULTY (any group size):
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
	--["Onyxia's Lair"] = 684, -- This is now a Feat of Strength
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
	["Serpentshrine Cavern"] = { 694, 144 },	-- "Serpentshrine Cavern", "The Lurker Above"
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
}
-- Battlegrounds
ACHID_INSTANCES["Eye of the Storm"] = { 1171, 587, 1258, 211 }
if (IsAlliance) then
	ACHID_INSTANCES["Alterac Valley"] = { 1167, 907 }
	ACHID_INSTANCES["Arathi Basin"] = { 1169, 907 }
	ACHID_INSTANCES["Warsong Gulch"] = { 1172, 1259, 907 }
	ACHID_INSTANCES["Strand of the Ancients"] = 2194
	ACHID_INSTANCES["Isle of Conquest"] = { 3857, 3845, 3846 }
else
	ACHID_INSTANCES["Alterac Valley"] = { 1168, 714 }
	ACHID_INSTANCES["Arathi Basin"] = { 1170, 714 }
	ACHID_INSTANCES["Warsong Gulch"] = { 1173, 1259, 714 }
	ACHID_INSTANCES["Strand of the Ancients"] = 2195
	ACHID_INSTANCES["Isle of Conquest"] = { 3957, 3845, 4176 }
end
-- For all battlegrounds:
local ACHID_BATTLEGROUNDS = { 238, 245, IsAlliance and 246 or 1005, 247, 229, 227, 231, 1785 }

-- INSTANCES - NORMAL ONLY (any group size):
local ACHID_INSTANCES_NORMAL = {
}

-- INSTANCES - HEROIC ONLY (any group size):
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
	["Halls of Stone"] = { 496, 1866, 2154, 2155 },
	["Gundrak"] = { 495, 2040, 2152, 1864, 2058 },
	["Azjol-Nerub"] = { 491, 1860, 1296, 1297 },
	["Halls of Lightning"] = { 497, 2042, 1867, 1834 },
	["Utgarde Keep"] = { 489, 1919 },
	["The Nexus"] = { 490, 2037, 2036, 2150 },
	["Drak'Tharon Keep"] = { 493, 2039, 2057, 2151 },
	["Ahn'kahet: The Old Kingdom"] = { 492, 2056, 1861, 1862, 2038 },
	["The Oculus"] = { 498, 1868, 1871, 2044, 2045, 2046 },
	["The Violet Hold"] = { 494, 2153, 1865, 2041, 1816 },
	["The Culling of Stratholme"] = { 500, 1872, 1817 },
	["Utgarde Pinnacle"] = { 499, 1873, 2043, 2156, 2157 },
}

-- INSTANCES - 10-MAN ONLY (normal or heroic):
local ACHID_INSTANCES_10 = {
-- Lich King Raids
	["Naxxramas"] = { 2146, 576, 578, 572, 1856, 2176, 2178, 2180, 568, 2187, 1996, 1997, 1858, 564, 2182, 2184,
		566, 574, 562 },
	["The Eye of Eternity"] = { 622, 1874, 2148, 1869 },
	["The Obsidian Sanctum"] = { 1876, 2047, 2049, 2050, 2051, 624 },
	["Vault of Archavon"] = { 1722, 3136, 3836, 4016 },
}

-- INSTANCES - 25-MAN ONLY (normal or heroic):
local ACHID_INSTANCES_25 = {
-- Lich King Raids
	["Naxxramas"] = { 2186, 579, 565, 577, 575, 2177, 563, 567, 1857, 569, 573, 1859, 2139, 2181, 2183, 2185,
		2147, 2140, 2179 },
	["Vault of Archavon"] = { 1721, 3137, 3837, 4017 },
	["The Eye of Eternity"] = { 623, 1875, 1870, 2149 },
	["The Obsidian Sanctum"] = { 625, 2048, 2052, 2053, 2054, 1877 },
}

-- INSTANCES - NORMAL 10-MAN ONLY:
local ACHID_INSTANCES_10_NORMAL = {
}

-- INSTANCES - HEROIC 10-MAN ONLY:
local ACHID_INSTANCES_10_HEROIC = {
}

-- INSTANCES - NORMAL 25-MAN ONLY:
local ACHID_INSTANCES_25_NORMAL = {
}

-- INSTANCES - HEROIC 25-MAN ONLY:
local ACHID_INSTANCES_25_HEROIC = {
}


local function ZoneLookup(zoneName)
  return LBZ[zoneName] or zoneName
end


-- TRADESKILL ACHIEVEMENTS
----------------------------------------------------

local ACHID_TRADESKILL = {
	["Cooking"] = IsAlliance and 1563 or 1784,	-- "Hail to the Chef"
	["Fishing"] = 1516,				-- "Accomplished Angler"
}

local ACHID_TRADESKILL_ZONE = {
	["Cooking"] = {
		["Dalaran"] = { 1998, IsAlliance and 1782 or 1783, 3217, 3296 },
			-- "Dalaran Cooking Award", "Our Daily Bread", "Chasing Marcia", "Cooking with Style"
		["Shattrath City"] = 906	-- "Kickin' It Up a Notch"
        },
	["Fishing"] = {
		["Dalaran"] = { 2096, 1958 },	-- "The Coin Master", "I Smell A Giant Rat"
		["Ironforge"] = 1837,		-- "Old Ironjaw"
		["Orgrimmar"] = {1836,"150:1"},	-- "Old Crafty", "The Fishing Diplomat"
		["Serpentshrine Cavern"] = 144,	-- "The Lurker Above"
		["Shattrath City"] = 905,	-- "Old Man Barlowned"
		["Stranglethorn Vale"] = 306,	-- "Master Angler of Stranglethorn"
		["Stormwind City"] = "150:2",	-- "The Fishing Diplomat"
		["Terokkar Forest"] = { 905, 726 },	-- "Old Man Barlowned", "Mr. Pinchy's Magical Crawdad Box"
		["Zul'Gurub"] = 560,		-- "Deadliest Catch"
        }
}

local ACHID_TRADESKILL_BG = { Cooking = 1785 }	-- "Dinner Impossible"


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
                "Interface\\AddOns\\Overachiever_Tabs\\SuggestionsWatermark", L.SUGGESTIONS_HELP, OnLoad,
                ACHIEVEMENT_FILTER_INCOMPLETE)
frame.AchList_checkprev = true

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

local suggested

local function Refresh_Add(...)
  local id, _, complete, nextid
  for i=1, select("#", ...) do
    id = select(i, ...)
    if (id) then

      if (type(id) == "table") then
        Refresh_Add(unpack(id))

      elseif (type(id) == "string") then
        local crit
        id, crit = strsplit(":", id)
        id, crit = tonumber(id), tonumber(crit)
        _, _, _, complete = GetAchievementInfo(id)
        if (complete) then
          nextid, complete = GetNextAchievement(id)
          if (nextid) then
            local name = GetAchievementCriteriaInfo(id, crit)
            while (complete and GetAchievementCriteriaInfo(nextid, crit) == name) do
            -- Find first incomplete achievement in the chain that has this criteria:
              id = nextid
              nextid, complete = GetNextAchievement(id)
            end
            if (nextid and GetAchievementCriteriaInfo(nextid, crit) == name) then
              id = nextid
            end
          end
        end
        suggested[id] = crit
        -- Known limitation (of no consequence at this time due to which suggestions actually use this feature):
        -- If an achievement is suggested due to multiple criteria, only one of them is reflected by this.
        -- (A future fix may involve making it a table when there's more than one, though it would need to check
        -- against adding the same criteria number twice.)

      else
        _, _, _, complete = GetAchievementInfo(id)
        if (complete) then
          nextid, complete = GetNextAchievement(id)
          if (nextid) then
            while (complete) do  -- Find first incomplete achievement in the chain:
              id = nextid
              nextid, complete = GetNextAchievement(id)
            end
            id = nextid or id
          end
        end
        suggested[id] = true
      end

    end
  end
end

local TradeskillSuggestions

local function getDifficulty(inInstance)
  if (inInstance) then
  -- Returns: <Heroic?>, <25-player Raid?>
    local name, itype, diff = GetInstanceInfo()
    if (itype == "raid") then
      return (diff > 2), (diff == 2 or diff == 4)
    else
      return (diff > 1), false
    end
  else
  -- Returns: <Heroic Dungeon?>, <Heroic Raid?>, <Raid set for 25 players?>
    local d = GetDungeonDifficulty()
    local r = GetRaidDifficulty()
    return (d > 1), (r > 2), (r == 2 or r == 4)
  end
end

local function Refresh()
  if (not frame:IsVisible()) then  return;  end
  suggested = suggested and wipe(suggested) or {}

  -- Suggestions based on an open tradeskill window or whether a fishing pole is equipped:
  TradeskillSuggestions = GetTradeSkillLine()
  local tradeskill = LBIR[TradeskillSuggestions]
  if (not ACHID_TRADESKILL[tradeskill] and IsEquippedItemType("Fishing Poles")) then
    TradeskillSuggestions, tradeskill = LBI["Fishing"], "Fishing"
  end
  if (ACHID_TRADESKILL[tradeskill]) then
    Refresh_Add(ACHID_TRADESKILL[tradeskill])
    if (ACHID_TRADESKILL_ZONE[tradeskill]) then
      local zone = GetRealZoneText()
      Refresh_Add(ACHID_TRADESKILL_ZONE[tradeskill][zone])
    end
    local _, instype = IsInInstance()
    if (instype == "pvp") then  -- If in a battleground:
      Refresh_Add(ACHID_TRADESKILL_BG[tradeskill])
    end
  else
    TradeskillSuggestions = nil

  -- Suggestions for your location:
    local inInstance, instype = IsInInstance()
    if (inInstance) then
      local zone = GetRealZoneText()
      if (not zone or zone == "") then  zone = GetSubZoneText();  end
      zone = ZoneLookup(zone)
      Refresh_Add(ACHID_INSTANCES[zone])
      if (instype == "pvp") then  -- If in a battleground:
        Refresh_Add(ACHID_BATTLEGROUNDS)
      end

      local heroic, twentyfive = getDifficulty(true)
      if (heroic) then
        if (twentyfive) then
          Refresh_Add(ACHID_INSTANCES_HEROIC[zone], ACHID_INSTANCES_25[zone], ACHID_INSTANCES_25_HEROIC[zone])
        else
          Refresh_Add(ACHID_INSTANCES_HEROIC[zone], ACHID_INSTANCES_10[zone], ACHID_INSTANCES_10_HEROIC[zone])
        end
      else
        if (twentyfive) then
          Refresh_Add(ACHID_INSTANCES_NORMAL[zone], ACHID_INSTANCES_25[zone], ACHID_INSTANCES_25_NORMAL[zone])
        else
          Refresh_Add(ACHID_INSTANCES_NORMAL[zone], ACHID_INSTANCES_10[zone], ACHID_INSTANCES_10_NORMAL[zone])
        end
      end

    else
      local zone, subz = GetRealZoneText(), GetSubZoneText()
      zone, subz = ZoneLookup(zone), ZoneLookup(subz)
      Refresh_Add(Overachiever.ExploreZoneIDLookup(zone), ACHID_ZONE_NUMQUESTS[zone], ACHID_ZONE_MISC[zone])
      -- Also look for instance achievements for an instance you're near if we can look it up easily (since many zones
      -- have subzones with the instance name when you're near the instance entrance and some instance entrances are
      -- actually in their own "zone" using the instance's zone name):
      Refresh_Add(ACHID_INSTANCES[subz] or ACHID_INSTANCES[zone])

      local heroicD, heroicR, twentyfive = getDifficulty(false)
      local ach10, ach25 = ACHID_INSTANCES_10[subz] or ACHID_INSTANCES_10[zone], ACHID_INSTANCES_25[subz] or ACHID_INSTANCES_25[zone]
      local achH10, achH25 = ACHID_INSTANCES_10_HEROIC[subz] or ACHID_INSTANCES_10_HEROIC[zone], ACHID_INSTANCES_25_HEROIC[subz] or ACHID_INSTANCES_25_HEROIC[zone]
      local achN10, achN25 = ACHID_INSTANCES_10_NORMAL[subz] or ACHID_INSTANCES_10_NORMAL[zone], ACHID_INSTANCES_25_NORMAL[subz] or ACHID_INSTANCES_25_NORMAL[zone]
      local heroic

      if (ach10 or ach25 or achH10 or achH25 or achN10 or achN25) then
      -- If there are 10-man or 25-man specific achievements, this is a raid:
        if (heroicR) then
          if (twentyfive) then
            Refresh_Add(ACHID_INSTANCES_HEROIC[subz] or ACHID_INSTANCES_HEROIC[zone], ach25, achH25)
          else
            Refresh_Add(ACHID_INSTANCES_HEROIC[subz] or ACHID_INSTANCES_HEROIC[zone], ach10, achH10)
          end
        else
          if (twentyfive) then
            Refresh_Add(ACHID_INSTANCES_NORMAL[subz] or ACHID_INSTANCES_NORMAL[zone], ach25, achN25)
          else
            Refresh_Add(ACHID_INSTANCES_NORMAL[subz] or ACHID_INSTANCES_NORMAL[zone], ach10, achN10)
          end
        end
      -- Not a raid:
      elseif (heroicD) then
        Refresh_Add(ACHID_INSTANCES_HEROIC[subz] or ACHID_INSTANCES_HEROIC[zone])
      else
        Refresh_Add(ACHID_INSTANCES_NORMAL[subz] or ACHID_INSTANCES_NORMAL[zone])
      end
    end

    -- Suggestions from recent reminders:
    Overachiever.RecentReminders_Check()
    for id in pairs(RecentReminders) do
      suggested[id] = true
    end
  end

  local list, count = frame.AchList, 0
  wipe(list)
  local critlist = frame.AchList_criteria and wipe(frame.AchList_criteria)
  if (not critlist) then
    critlist = {}
    frame.AchList_criteria = critlist
  end
  for id,v in pairs(suggested) do
    count = count + 1
    list[count] = id
    if (v ~= true) then
      critlist[id] = v
    end
  end

  Overachiever_SuggestionsFrameContainerScrollBar:SetValue(0)
  frame:ForceUpdate(true)
end

function frame.SetNumListed(num)
  if (num > 0) then
    NoSuggestionsLabel:Hide()
    if (TradeskillSuggestions) then
      ResultsLabel:SetText(L.SUGGESTIONS_RESULTS_TRADESKILL:format(TradeskillSuggestions, num))
    else
      ResultsLabel:SetText(L.SUGGESTIONS_RESULTS:format(num))
    end
  else
    NoSuggestionsLabel:Show()
    if (TradeskillSuggestions) then
      NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY_TRADESKILL:format(TradeskillSuggestions))
    else
      NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY)
    end
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
ResultsLabel:SetWidth(178)
ResultsLabel:SetJustifyH("LEFT")
ResultsLabel:SetText(" ")

panel:SetScript("OnShow", Refresh)

NoSuggestionsLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
NoSuggestionsLabel:SetPoint("TOP", frame, "TOP", 0, -189)
NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY)
NoSuggestionsLabel:SetWidth(490)

frame:RegisterEvent("TRADE_SKILL_SHOW")
frame:RegisterEvent("TRADE_SKILL_CLOSE")
frame:SetScript("OnEvent", Refresh)


-- SUPPORT FOR OTHER ADDONS
----------------------------------------------------

-- Open suggestions tables up for other addons to read or manipulate:
Overachiever.SUGGESTIONS = {
	zone_numquests = ACHID_ZONE_NUMQUESTS,
	zone = ACHID_ZONE_MISC,
	instance = ACHID_INSTANCES,
	bg = ACHID_BATTLEGROUNDS,
	instance_normal = ACHID_INSTANCES_NORMAL,
	instance_heroic = ACHID_INSTANCES_HEROIC,
	instance_10 = ACHID_INSTANCES_10,
	instance_25 = ACHID_INSTANCES_25,
	instance_10_normal = ACHID_INSTANCES_10_NORMAL,
	instance_10_heroic = ACHID_INSTANCES_10_HEROIC,
	instance_25_normal = ACHID_INSTANCES_25_NORMAL,
	instance_25_heroic = ACHID_INSTANCES_25_HEROIC,
	tradeskill = ACHID_TRADESKILL,
	tradeskill_zone = ACHID_TRADESKILL_ZONE,
	tradeskill_bg = ACHID_TRADESKILL_BG,
}



--[[
-- /run Overachiever.Debug_GetIDsInCat( GetAchievementCategory(GetTrackedAchievements()) )
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
