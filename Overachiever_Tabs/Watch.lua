
--
--  Overachiever - Tabs: Watch.lua
--    by Tuhljin
--
--  If you don't wish to use the watch tab, feel free to delete this file or rename it (e.g. to Watch_unused.lua).
--  The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS

local VARS, CurrentWatchList
local frame, panel, sortdrop, listdrop, listdrop_menu, deflistdrop, deflistdrop_menu, listdrop_OnSelect, deflistdrop_OnSelect
local NoneWatchedLabel, Refresh, skipRefresh

local function SortDrop_OnSelect(self, value)
  VARS.WatchSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function OnLoad(v, oldver)
  VARS = v
  sortdrop:SetSelectedValue(VARS.WatchSort or 0)

  -- Create standard lists:
  local realm, char = GetRealmName(), UnitName("player")
  VARS.WatchLists_Realms = VARS.WatchLists_Realms or {}
  VARS.WatchLists_Realms[realm] = VARS.WatchLists_Realms[realm] or {}
  VARS.WatchLists_Realms[realm][char] = VARS.WatchLists_Realms[realm][char] or {}
  VARS.WatchLists_General = VARS.WatchLists_General or {}
  VARS.WatchLists = VARS.WatchLists or {}
  if (not VARS.WatchedList) then
    VARS.WatchedList = 0
  elseif (oldver == nil) then  -- If prior to v0.56 (which introduced version tracking for these settings):
    for id in pairs(VARS.WatchedList) do  -- Migrate to new table:
      VARS.WatchLists_General[id] = true
    end
    VARS.WatchedList = 0
  end
  
  -- With existing items, set usable references for menu's OnSelect function:
  listdrop_menu[1].Overachiever_list = VARS.WatchLists_General
  listdrop_menu[2].Overachiever_list = VARS.WatchLists_Realms[realm][char]
  -- Add custom lists to dropdown menus:
  for name,tab in pairs(VARS.WatchLists) do
    tinsert(listdrop_menu, {  text = name, value = name, Overachiever_list = tab  })
    tinsert(deflistdrop_menu, {  text = name, value = name, Overachiever_list = tab  })
  end
  -- Add realm/character lists to dropdown menu:
  for rname,rtab in pairs(VARS.WatchLists_Realms) do
    local menuList, num = {}, 0
    for cname,tab in pairs(rtab) do
      if (rname ~= realm or cname ~= char) then  -- Don't add the current character; it is included in the first tier of the menu.
        tinsert(menuList, {  text = cname, value = rname..":"..cname, Overachiever_list = tab  })
        num = num + 1
      end
    end
    if (num > 0) then
      tinsert(listdrop_menu, {  text = rname, hasArrow = true, TjDDM_notCheckable = 1, keepShownOnClick = 1, menuList = menuList  })
    end
  end

  skipRefresh = true
  listdrop:SetMenu()
  deflistdrop:SetMenu()
  listdrop:OnSelect(listdrop_OnSelect) -- Put before SetSelectedValue so CurrentWatchList can be set easily.
  listdrop:SetSelectedValue(VARS.WatchedList == 1 and realm..":"..char or VARS.WatchedList)
  deflistdrop:SetSelectedValue(VARS.WatchedList)
  deflistdrop:OnSelect(deflistdrop_OnSelect)
  skipRefresh = nil

  CurrentWatchList = CurrentWatchList or VARS.WatchLists_General  -- Default, in case the list we looked for doesn't exist.

  frame:RegisterEvent("PLAYER_LOGOUT")
end

frame, panel = Overachiever.BuildNewTab("Overachiever_WatchFrame", L.WATCH_TAB,
                 "Interface\\AddOns\\Overachiever_Tabs\\WatchWatermark", L.WATCH_HELP, OnLoad)

sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_WatchFrameSortDrop", panel, {
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

function frame.SetNumListed(num)
  if (num > 0) then
    if (NoneWatchedLabel) then  NoneWatchedLabel:Hide();  end
  elseif (not NoneWatchedLabel) then
    NoneWatchedLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    NoneWatchedLabel:SetPoint("TOP", frame, "TOP", 0, -189)
    NoneWatchedLabel:SetText(L.WATCH_EMPTY)
    NoneWatchedLabel:SetWidth(490)
  else
    NoneWatchedLabel:Show()
  end
end


function Refresh()
  if (skipRefresh) then  return;  end
  local list, count = frame.AchList, 0
  wipe(list)
  for id in pairs(CurrentWatchList) do
    count = count + 1
    list[count] = id
  end
  Overachiever_WatchFrameContainerScrollBar:SetValue(0)
  frame:ForceUpdate(true)
end

panel:SetScript("OnShow", Refresh)

function frame.SetAchWatchList(id, add)
  if (add) then
    CurrentWatchList[id] = true
    PlaySound("igMainMenuOptionCheckBoxOn")
  else
    CurrentWatchList[id] = nil
    PlaySound("igMainMenuOptionCheckBoxOff")
  end
  if (frame:IsShown()) then
    Refresh()
  else
    Overachiever.FlashTab(frame.tab)
  end
end

local orig_AchievementButton_OnClick = AchievementButton_OnClick
AchievementButton_OnClick = function(self, ignoreModifiers, ...)
  if (not ignoreModifiers and IsAltKeyDown()) then
    frame.SetAchWatchList(self.id, true)
    return;
  end
  orig_AchievementButton_OnClick(self, ignoreModifiers, ...)
end



-- SUPPORT MULTIPLE WATCH LISTS
----------------------------------------------------

listdrop_menu = {  {  text = L.WATCH_LIST_GLOBAL, value = 0  },  {  text = UnitName("player"), value = GetRealmName()..":"..UnitName("player")  };  }
listdrop = TjDropDownMenu.CreateDropDown("Overachiever_WatchFrameListDrop", panel, listdrop_menu)
listdrop:SetLabel(L.WATCH_LISTS, true)
listdrop:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 0, -18)
listdrop:SetDropDownWidth(158)

deflistdrop_menu = {  {  text = L.WATCH_LIST_GLOBAL, value = 0  },  {  text = L.WATCH_LIST_PERCHAR, value = 1  };  }
deflistdrop = TjDropDownMenu.CreateDropDown("Overachiever_WatchFrameDefListDrop", panel, deflistdrop_menu)
deflistdrop:SetLabel(L.WATCH_DEFAULTLIST, true)
deflistdrop:SetPoint("TOPLEFT", listdrop, "BOTTOMLEFT", 0, -18)
deflistdrop:SetDropDownWidth(158)

function listdrop_OnSelect(self, value, oldvalue, tab)
  CurrentWatchList = tab.Overachiever_list
  Refresh()
end

function deflistdrop_OnSelect(self, value)
  VARS.WatchedList = value
end

frame:SetScript("OnEvent", function()  -- React to "PLAYER_LOGOUT" event:
  -- Remove unused character-specific watch lists:
  local cnum
  for realm,rtab in pairs(VARS.WatchLists_Realms) do
    cnum = 0
    for char,ctab in pairs (rtab) do
      if (next(ctab) == nil) then  -- If there aren't any keys in the table, remove it.
        rtab[char] = nil
      else
        cnum = cnum + 1
      end
    end
    if (cnum == 0) then  VARS.WatchLists_Realms[realm] = nil;  end
  end
end);


--[[
-- /run Overachiever.Debug_DumpWatch()
function Overachiever.Debug_DumpWatch()
  local tab = {}
  for id in pairs(CurrentWatchList) do
    tab[#tab+1] = id
  end
  sort(tab)
  local s = "{ "..strjoin(", ", unpack(tab)).." }"
  print(s)
  error(s)
end
--]]
