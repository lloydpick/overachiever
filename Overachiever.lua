
--
--  Overachiever
--    by Tuhljin
--


--Overachiever_Debug = true;

local THIS_VERSION = GetAddOnMetadata("Overachiever", "Version")
local THIS_TITLE = GetAddOnMetadata("Overachiever", "Title")

local ACHINFO_NAME = 2

Overachiever = {};

local L = OVERACHIEVER_STRINGS

local CATEGORIES_ALL, CATEGORY_EXPLOREROOT, CATEGORIES_EXPLOREZONES
local OptionsPanel
local MadeDraggable_AchFrame, MadeDragSave_AchFrame, MadeDraggable_AchTracker

Overachiever.DefaultSettings = {
  Tooltip_ShowProgress = true;
  Tooltip_ShowProgress_Other = true;
  Tooltip_ShowID = false;
  UI_SeriesTooltip = true;
  UI_RequiredForMetaTooltip = true;
  Tracker_GreenCheck = true;
  Explore_AutoTrack = false;
  Explore_AutoTrack_Completed = false;
  CritterTip_loved = true;
  CritterTip_killed = true;
  WellReadTip_read = true;
  AnglerTip_fished = true;
  LetItSnow_flaked = false;
  FistfulOfLove_petals = false;
  Item_consumed = false;
  Item_consumed_whencomplete = false;
  Draggable_AchFrame = true;
  DragSave_AchFrame = false;
  Draggable_AchTracker = false;
  DragLock_AchTracker = false;
  SoundAchIncomplete = 0;
  SoundAchIncomplete_AnglerCheckPole = true;
  Version = THIS_VERSION;
};


local function chatprint(msg, premsg)
  premsg = premsg or "["..THIS_TITLE.."]"
  DEFAULT_CHAT_FRAME:AddMessage("|cff7eff00"..premsg.."|r "..msg, 0.741, 1, 0.467);
end

local function copytab(from, to)
  for k,v in pairs(from) do
    if(type(v) == "table") then
      to[k] = {}
      copytab(v, to[k]);
    else
      to[k] = v;
    end
  end
end

local function sethook(frame, script, handler)
  local prev = frame:GetScript(script)
  if (prev) then
    frame:HookScript(script, handler)
  else
    frame:SetScript(script, handler)
  end
end

local function BuildCategoryInfo()
  Overachiever.UI_GetValidCategories()
  CATEGORY_EXPLOREROOT = GetAchievementCategory(OVERACHIEVER_ACHID.WorldExplorer);
  CATEGORIES_EXPLOREZONES = {};
  local name, parentID
  for i,id in ipairs(CATEGORIES_ALL) do
    name, parentID = GetCategoryInfo(id)
    if (parentID == CATEGORY_EXPLOREROOT) then
      CATEGORIES_EXPLOREZONES[#(CATEGORIES_EXPLOREZONES) + 1] = id;
    end
  end
end

local function getSelectedAchievement(ignoreTab)
  if (AchievementFrame and (ignoreTab or AchievementFrame.selectedTab == 1)) then
    return AchievementFrameAchievements.selection;
  end
end

local function expandCategory(category)
-- Based on part of AchievementFrame_SelectAchievement() in Blizzard_AchievementUI.lua
  for i, entry in next, ACHIEVEMENTUI_CATEGORIES do
    if ( entry.id == category ) then
      entry.collapsed = false;
    elseif ( entry.parent == category ) then
      entry.hidden = false;
    end
  end
  AchievementFrameCategories_Update()
end

local function openToAchievement(id, canToggleTracking)
  assert( (type(id)=="number"), "Invalid achievement ID." )
  local sel
  if (not AchievementFrame or not AchievementFrame:IsShown()) then
    ToggleAchievementFrame()
  elseif (canToggleTracking) then
    sel = getSelectedAchievement()
  end
  if (sel == id) then
    AchievementButton_ToggleTracking(id)
  else
    Overachiever.UI_SelectAchievement(id)
  end
end

local function isExplorationAchievement(id, zonesOnly)
  local cat = GetAchievementCategory(id)
  if (cat == CATEGORY_EXPLOREROOT) then
    if (not zonesOnly) then  return true;  end
  else
    local _, parentID = GetCategoryInfo(cat)
    if (parentID == CATEGORY_EXPLOREROOT) then  return true;  end
  end
end

local function getCategoryID(name)
  local n
  for i,id in ipairs(CATEGORIES_ALL) do
    n = GetCategoryInfo(id)
    if (n == name) then  return id;  end
  end
end

local function get_arg1_argN(n, arg1, ...)
  return arg1, select(n-1, ...)
end

local getAchievementID_cat, getAchievementID_tab
do
  local found

  function getAchievementID_cat(category, argnum, pattern, anyCase, getAll)
  -- Go over a given category, looking only at achievements that would normally be listed in the UI for the
  -- player character at this time:
    if (getAll) then  found = found and wipe(found) or {};  end
    if (anyCase) then  pattern = strlower(pattern);  end
    local id, ret, anyFound
    for i=1,GetCategoryNumAchievements(category) do
      id, ret = get_arg1_argN(argnum, GetAchievementInfo(category, i))
      if (anyCase) then  ret = strlower(ret);  end
      if ( strfind(ret, pattern, 1, true) ) then
        if (getAll) then
          found[#(found) + 1] = id;
          anyFound = true
        else
          return id;
        end
      end
    end
    if (anyFound) then
      return found;
    end
  end

  function getAchievementID_tab(tab, argnum, pattern, anyCase, getAll)
  -- Look at achievements whose IDs are in a given table:
    if (getAll) then  found = found and wipe(found) or {};  end
    if (anyCase) then  pattern = strlower(pattern);  end
    local ret, anyFound
    for i,id in ipairs(tab) do
      ret = select(argnum, GetAchievementInfo(id))
      if (anyCase) then  ret = strlower(ret);  end
      if ( strfind(ret, pattern, 1, true) ) then
        if (getAll) then
          found[#(found) + 1] = id;
          anyFound = true
        else
          return id;
        end
      end
    end
    if (anyFound) then
      return found;
    end
  end

end

local function getAchievementID(list, argnum, pattern, anyCase)
  list = list or CATEGORIES_ALL
  if (type(list) == "table") then
    local id
    for i,cat in ipairs(list) do
      id = getAchievementID_cat(cat, argnum, pattern, anyCase)
      if (id) then  return id;  end
    end
  elseif (type(list) == "number") then
    return getAchievementID_cat(list, argnum, pattern, anyCase)
  elseif (type(list) == "string") then
    local cat = getCategoryID(list)
    assert(cat, "Category not found.")
    return getAchievementID_cat(cat, argnum, pattern, anyCase)
  end
end

local searchResults
local function SearchAchievements(list, argnum, pattern, anyCase)
  list = list or CATEGORIES_ALL
  if (type(list) == "table") then
    -- Reuse table to avoid garbage generation
    searchResults = searchResults and wipe(searchResults) or {}
    local tab, anyFound
    for i,cat in ipairs(list) do
      tab = getAchievementID_cat(cat, argnum, pattern, anyCase, true)
      if (tab) then
        for _,v in ipairs(tab) do
          searchResults[#(searchResults) + 1] = v;
          anyFound = true
        end
      end
    end
    if (anyFound) then
      return searchResults;
    end
  elseif (type(list) == "number") then
    return getAchievementID_cat(list, argnum, pattern, anyCase, true)
  elseif (type(list) == "string") then
    local cat = getCategoryID(list)
    assert(cat, "Category not found.")
    return getAchievementID_cat(cat, argnum, pattern, anyCase, true)
  end
end

local function SearchAchievements_tab(list, argnum, pattern, anyCase)
  searchResults = searchResults and wipe(searchResults) or {}
  local tab, anyFound
  for k,sublist in pairs(list) do
    tab = getAchievementID_tab(sublist, argnum, pattern, anyCase, true)
    if (tab) then
      for _,v in ipairs(tab) do
        searchResults[#(searchResults) + 1] = v;
        anyFound = true
      end
    end
  end
  if (anyFound) then
    return searchResults;
  end
end


local function setTracking(id)
  SetTrackedAchievement(id)
  if (AchievementFrameAchievements_ForceUpdate) then
    AchievementFrameAchievements_ForceUpdate()
  end
end

local function SoundSelected(self, key, val, clicked)
  if (clicked) then  PlaySoundFile( self:Fetch() );  end
end


-- ACHIEVEMENT ID LOOKUP
--------------------------

local getAllAchievements --, getAllAchievementsInCat
do
  local ALL_ACHIEVEMENTS
  function getAllAchievements()
  -- Retrieve an array of all achievement IDs, including those not normally listed in the UI for this character.
    if (ALL_ACHIEVEMENTS) then  return ALL_ACHIEVEMENTS;  end
    local catlookup = {}
    for i,c in ipairs(CATEGORIES_ALL) do
      catlookup[c] = true
    end
    ALL_ACHIEVEMENTS = {}
    local size, id = 0
    for i = 1, 2750 do  -- 2750 is arbitrary. New patches with new achievements may mean this number must go up.
      id = GetAchievementInfo(i)
      if (id and catlookup[GetAchievementCategory(id)]) then  size = size + 1; ALL_ACHIEVEMENTS[size] = id;  end
    end
    catlookup = nil
    return ALL_ACHIEVEMENTS
  end

  --[[
  local ALL_ACHIEVEMENTS_BYCAT
  function getAllAchievementsInCat(cat)
    ALL_ACHIEVEMENTS_BYCAT = ALL_ACHIEVEMENTS_BYCAT or {}
    if (ALL_ACHIEVEMENTS_BYCAT[cat]) then  return ALL_ACHIEVEMENTS_BYCAT[cat];  end
    local tab, size, list = {}, 0, getAllAchievements()
    for i,id in ipairs(list) do
      if (GetAchievementCategory(id) == cat) then  size = size + 1; tab[size] = id;  end
    end
    ALL_ACHIEVEMENTS_BYCAT[cat] = tab
    return tab
  end
  --]]
end

local function BuildCriteriaLookupTab(...)
-- To be called in this fashion: BuildCriteriaLookupTab( <assetID1>, <table1>[, <assetID2>, <table2>[, ...]] )
  local num = select("#", ...)
  local list = getAllAchievements()
  local _, critType, assetID, a, tab
  for i,id in ipairs(list) do
    for i=1,GetAchievementNumCriteria(id) do
      _, critType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)

      for arg=1,num,2 do
        a, tab = select(arg, ...)
        if (critType == a) then
          if (tab[assetID]) then
            local v = tab[assetID]
            if (type(v) == "table") then
              v[#v+1] = id
            else
              tab[assetID] = { v, id }
            end
          else
            tab[assetID] = id
          end
        end
      end

    end
  end
end

local AchLookup_metaach --, AchLookup_kill
local function BuildCriteriaLookupTab_check()
  if (AchLookup_metaach or not Overachiever_Settings.UI_RequiredForMetaTooltip) then  return;  end
  AchLookup_metaach = {}
  BuildCriteriaLookupTab(8, AchLookup_metaach) -- 0, AchLookup_kill)
end


-- DRAGGABLE FRAMES
---------------------

local function CheckDraggable_AchFrame(self, key, val, clicked, LoadPos)
  if (AchievementFrame) then
    -- Check if draggable:
    if (Overachiever_Settings.Draggable_AchFrame) then
      if (not MadeDraggable_AchFrame) then
        TjDragIt.EnableDragging(AchievementFrame, AchievementFrameHeader, AchievementFrameCategoriesContainer,
                                AchievementFrameAchievementsContainer, AchievementFrameStatsContainer,
                                Overachiever_SearchFrameContainer, Overachiever_SuggestionsFrameContainer)
        MadeDraggable_AchFrame = true
      end
    elseif (MadeDraggable_AchFrame) then
      TjDragIt.DisableDragging(AchievementFrame, AchievementFrameHeader, AchievementFrameCategoriesContainer,
                               AchievementFrameAchievementsContainer, AchievementFrameStatsContainer,
                               Overachiever_SearchFrameContainer, Overachiever_SuggestionsFrameContainer)
      MadeDraggable_AchFrame = nil
    end
    if (key and AchievementFrame:IsShown()) then
    -- If option may have been changed by the user, frame needs to be hidden before changing its attributes.
      HideUIPanel(AchievementFrame)
    end
    -- Check if position saved:
    if (Overachiever_Settings.DragSave_AchFrame) then
      if (not MadeDragSave_AchFrame) then
        if (not Overachiever_CharVars.Pos_AchievementFrame) then
          Overachiever_CharVars.Pos_AchievementFrame = Overachiever_CharVars_Default and Overachiever_CharVars_Default.Pos_AchievementFrame or {}
        end
        TjDragIt.EnablePositionSaving(AchievementFrame, Overachiever_CharVars.Pos_AchievementFrame, LoadPos)
        AchievementFrame:SetAttribute("UIPanelLayout-enabled", false);
        MadeDragSave_AchFrame = true
      end
    elseif (MadeDragSave_AchFrame) then
      TjDragIt.DisablePositionSaving(AchievementFrame)
      AchievementFrame:SetAttribute("UIPanelLayout-enabled", true);
      MadeDragSave_AchFrame = nil
    end
  end
end

local orig_AchievementFrame_OnShow, orig_AchievementFrame_area

local function AchievementUI_FirstShown_post()
  Overachiever.MainFrame:Hide()
  -- Delayed setting the area attribute until now so that if Blizzard_AchievementUI was loaded just before the
  -- AchievementFrame is to be shown, AchievementFrame wouldn't be set as the current UI panel by code in
  -- UIParent.lua, which causes problems when we don't want it to interact with other UI panels in the standard
  -- way. (Set now instead of leaving it out because the player may want it to interact normally again later.)
  if (orig_AchievementFrame_area) then
    UIPanelWindows["AchievementFrame"].area = orig_AchievementFrame_area
    AchievementFrame:SetAttribute("UIPanelLayout-area", orig_AchievementFrame_area);
    orig_AchievementFrame_area = nil
  end
  CheckDraggable_AchFrame(nil, nil, nil, nil, true)
  if (not Overachiever_Settings.DragSave_AchFrame) then
  -- If we aren't saving the position, then re-open the frame to put it in the standard place. (It'll do this
  -- automatically from now on.)
    local prevfunc = AchievementFrame:GetScript("OnHide")
    AchievementFrame:SetScript("OnHide", nil)
    HideUIPanel(AchievementFrame)
    AchievementFrame:SetScript("OnHide", prevfunc)
    prevfunc = AchievementFrame:GetScript("OnShow")
    AchievementFrame:SetScript("OnShow", nil)
    ShowUIPanel(AchievementFrame)
    AchievementFrame:SetScript("OnShow", prevfunc)
  end
end

local function AchievementUI_FirstShown(...)
  AchievementFrame_OnShow = orig_AchievementFrame_OnShow
  orig_AchievementFrame_OnShow = nil
  -- Delayed call to AchievementUI_FirstShown_post() - let everything else process first:
  Overachiever.MainFrame:Show()
  -- Call original function:
  AchievementFrame_OnShow(...)
  AchievementUI_FirstShown = nil
end

local hooked_UIParent_ManageFramePositions, trackerposmanaging
local function post_UIParent_ManageFramePositions(...)
  if (trackerposmanaging or not Overachiever_Settings.Draggable_AchTracker or not AchievementWatchFrame:IsShown()) then
    return;
  end
  trackerposmanaging = true
  local prevfunc = AchievementWatchFrame:GetScript("OnHide")
  AchievementWatchFrame:SetScript("OnHide", nil)  -- Eliminates some of the redundancy
  AchievementWatchFrame:Hide()  -- Prevent moving the tracker in UIParent.lua's FramePositionDelegate:UIParentManageFramePositions()
  AchievementWatchFrame:SetScript("OnHide", prevfunc)
  UIParent_ManageFramePositions(...)  -- Need to call again to divorce other frames' positions from the watch frame.
    -- This call is redundant - even moreso than it appears on the surface - but the more efficient method caused
    -- taint. Try the other way again in future versions of WoW which supposedly will fix this.
  prevfunc = AchievementWatchFrame:GetScript("OnShow")
  AchievementWatchFrame:SetScript("OnShow", nil)  -- Eliminates some of the redundancy
  AchievementWatchFrame:Show()
  AchievementWatchFrame:SetScript("OnShow", prevfunc)
  TjDragIt.LoadPosition(AchievementWatchFrame, Overachiever_CharVars.Pos_AchievementWatchFrame)
  trackerposmanaging = nil
end

local function CheckDraggable_AchTracker()
  local custompos, locked = Overachiever_Settings.Draggable_AchTracker, Overachiever_Settings.DragLock_AchTracker
  if (custompos) then
    if (not hooked_UIParent_ManageFramePositions) then
      hooksecurefunc("UIParent_ManageFramePositions", post_UIParent_ManageFramePositions)
      hooked_UIParent_ManageFramePositions = true
    end
    if (not Overachiever_CharVars.Pos_AchievementWatchFrame) then
      Overachiever_CharVars.Pos_AchievementWatchFrame = Overachiever_CharVars_Default and Overachiever_CharVars_Default.Pos_AchievementWatchFrame or {}
    end
    if (locked) then
      TjDragIt.LoadPosition(AchievementWatchFrame, Overachiever_CharVars.Pos_AchievementWatchFrame)
    elseif (not MadeDraggable_AchTracker) then
      TjDragIt.EnableDragging(AchievementWatchFrame)
      TjDragIt.EnablePositionSaving(AchievementWatchFrame, Overachiever_CharVars.Pos_AchievementWatchFrame, true)
      MadeDraggable_AchTracker = true
    end
  end
  if (MadeDraggable_AchTracker and (not custompos or locked)) then
    TjDragIt.DisableDragging(AchievementWatchFrame)
    AchievementWatchFrame:EnableMouse(false)
    TjDragIt.DisablePositionSaving(AchievementWatchFrame)
    MadeDraggable_AchTracker = nil
  end
  UIParent_ManageFramePositions()
end


-- ACHIEVEMENT HYPERLINK HOOK
-------------------------------

local orig_SetItemRef = SetItemRef
SetItemRef = function(link, text, button, ...)
  if ( strsub(link, 1, 11) == "achievement" and IsControlKeyDown() ) then
    local id = strsplit(":", strsub(link, 13));
    id = tonumber(id)
    openToAchievement(id, true)
    return;
  end
  return orig_SetItemRef(link, text, button, ...)
end

-- ACHIEVEMENT TRACKER CHANGES
--------------------------------

-- local orig_AchievementWatchButton_OnClick = AchievementWatchButton_OnClick

-- We're replacing this function instead of just hooking it because in addition to some new functionality, we prefer
-- an openToAchievement() call instead of a direct AchievementFrame_SelectAchievement() call.
AchievementWatchButton_OnClick = function()
  if (IsShiftKeyDown()) then
    if (not ChatFrameEditBox:IsVisible()) then  ChatFrameEditBox:Show()  end
    local link = GetAchievementLink(AchievementWatchFrame.achievementID)
    ChatEdit_InsertLink(link)
  else
    openToAchievement(AchievementWatchFrame.achievementID)
  end
end

local function TrackerBtnOnEnter(self)
  GameTooltip:SetOwner(self, "ANCHOR_NONE");
  local x, y = self:GetCenter();
  if (y < UIParent:GetHeight() / 6) then
    GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPRIGHT")
  else
    GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMRIGHT")
  end
  local link = GetAchievementLink(AchievementWatchFrame.achievementID)
  GameTooltip:SetHyperlink(link)
end

local function TrackerBtnOnLeave()
  GameTooltip:Hide()
end

-- There are normally no OnEnter or OnLeave scripts for this button, but we check for them in case something else
-- adds one.
sethook(AchievementWatchLine1Button, "OnEnter", TrackerBtnOnEnter)
sethook(AchievementWatchLine1Button, "OnLeave", TrackerBtnOnLeave)

local function CreateGreenCheck(refobj)
  local frame = CreateFrame("Frame", nil, refobj)
  frame:SetWidth(20); frame:SetHeight(16);
  frame.tex = frame:CreateTexture(nil, "ARTWORK")
  frame.tex:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Criteria-Check")
  frame.tex:SetTexCoord(0, 0.625, 0, 1)
  frame.tex:SetWidth(20); frame.tex:SetHeight(16);
  frame:SetPoint("RIGHT", refobj, "LEFT", 0, -3)
  frame.tex:SetPoint("LEFT")
  frame:SetFrameLevel(refobj:GetFrameLevel() + 1)
  return frame;
end

local function GreenCheckUpdate()
  if (Overachiever_Settings.Tracker_GreenCheck and Overachiever_CharVars.TrackedAch) then
    local _, _, _, complete = GetAchievementInfo(Overachiever_CharVars.TrackedAch)
    if (complete) then
      Overachiever.TrackingGreenCheck = Overachiever.TrackingGreenCheck or CreateGreenCheck(AchievementWatchLine1Button)
      Overachiever.TrackingGreenCheck:Show()
      return;
    end
  end
  if (Overachiever.TrackingGreenCheck and Overachiever.TrackingGreenCheck:IsVisible()) then
    Overachiever.TrackingGreenCheck:Hide()
  end
end

local function saveTrackedAchievement(id, ...)
  if (id == 0) then  id = nil;  end
  Overachiever_CharVars.TrackedAch = id;
  GreenCheckUpdate()
end
hooksecurefunc("SetTrackedAchievement", saveTrackedAchievement)

local function AutoTrackCheck_Explore(noClearing)
-- noClearing will evaluate to true when called through TjOptions since it passes an object for this first arg.
  if (Overachiever_Settings.Explore_AutoTrack) then
    local tracked = GetTrackedAchievement()
    -- Don't switch tracked achievement if we're currently tracking a non-Explore achievement.
    if (not tracked or isExplorationAchievement(tracked, true)) then
      local id
      if (not IsInInstance()) then
        local zone = GetRealZoneText()
        if (zone and zone ~= "") then
          id = Overachiever.ExploreZoneIDLookup(zone) or
               getAchievementID(CATEGORIES_EXPLOREZONES, ACHINFO_NAME, zone, true)
        end
      end
      if (not id) then
        if (not noClearing) then  setTracking(0);  end
      elseif (id ~= tracked) then
        local _, _, _, complete = GetAchievementInfo(id)
        if (not complete or Overachiever_Settings.Explore_AutoTrack_Completed) then
          setTracking(id)
        elseif (complete and not noClearing) then
          setTracking(0)
        end
      end
    end
  end
end


-- META-CRITERIA TOOLTIP
--------------------------

local orig_AchievementButton_GetMeta

local function MetaCriteriaOnEnter(self)
  if (self.id) then
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
    local link = GetAchievementLink(self.id)
    GameTooltip:SetHyperlink(link)
    if (MouseIsOver(GameTooltip)) then
      GameTooltip:ClearAllPoints()
      GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    end
  -- If for some reason the ID isn't there but a date completed is (something that probably shouldn't happen), fall
  -- back to the way tooltips were handled in Blizzard_AchievementUI.xml's MetaCriteriaTemplate:
  elseif ( self.date ) then
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:AddLine(string.format(ACHIEVEMENT_META_COMPLETED_DATE, self.date), 1, 1, 1);
    GameTooltip:Show();
  end
end

local function new_AchievementButton_GetMeta(...)
  local frame = orig_AchievementButton_GetMeta(...)
  frame:SetScript("OnEnter", MetaCriteriaOnEnter)
  return frame;
end


-- TOOLTIP FOR UI'S ACHIEVEMENT BUTTONS
-----------------------------------------

local achbtnOnEnter, achbtnOnLeave, achBtnRedisplay
local AddAchListToTooltip
do
  local button
  local r_sel, g_sel, b_sel = 0.741, 1, 0.467
  local r_com, g_com, b_com = 0.25, 0.75, 0.25
  local r_inc, g_inc, b_inc = 0.6, 0.6, 0.6
  local temptab

  function AddAchListToTooltip(tooltip, list)
    if (type(list) == "table") then
      local _, name, completed, anycomplete
      temptab = temptab or {}
      for i,ach in ipairs(list) do
        _, name, _, completed = GetAchievementInfo(ach)
        if (completed) then
          anycomplete = true
        else
          completed = false  -- nil becomes false for use in temptab.
        end
        temptab[name] = temptab[name] or completed
        -- It being complete takes precedence, since if the name was already used, but this time it's complete,
        -- the previous one must've been for the other faction.
      end
      for name,completed in pairs(temptab) do
        if (completed) then
          tooltip:AddLine(name, r_com, g_com, b_com)
          tooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
        else
          tooltip:AddLine(name, 1, 1, 1) --, r_inc, g_inc, b_inc)
          if (anycomplete) then
            tooltip:AddTexture(""); -- fake texture to push the text over
          end
        end
      end
      wipe(temptab)
    else
      local _, name, _, completed = GetAchievementInfo(list)
      if (completed) then
        tooltip:AddLine(name, r_com, g_com, b_com)
        tooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
      else
        tooltip:AddLine(name, 1, 1, 1) --, r_inc, g_inc, b_inc)
      end
    end
  end

  function achbtnOnEnter(self)
    button = self
    local id, tipset = self.id

    if (Overachiever_Settings.UI_SeriesTooltip and (GetNextAchievement(id) or GetPreviousAchievement(id))) then
      GameTooltip:SetOwner(self, "ANCHOR_NONE")
      GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 8, 0)
      GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
      tipset = true
      GameTooltip:AddLine(L.SERIESTIP)
      GameTooltip:AddLine(" ")
      local ach = GetPreviousAchievement(id)
      local first, _, name, anycomplete
      while (ach) do  -- Find first achievement in the series:
        first = ach
        ach = GetPreviousAchievement(ach)
      end
      ach = first or id
      local completed = select(4, GetAchievementInfo(ach))
      while (ach) do
        _, name = GetAchievementInfo(ach)
        if (ach == id) then
          GameTooltip:AddLine(name, r_sel, g_sel, b_sel)
        elseif (completed) then
          GameTooltip:AddLine(name, r_com, g_com, b_com)
        else
          GameTooltip:AddLine(name, r_inc, g_inc, b_inc)
        end
        if (completed) then
          GameTooltip:AddTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
          anycomplete = true
        elseif (anycomplete) then
          GameTooltip:AddTexture(""); -- fake texture to push the text over
        end
        ach, completed = GetNextAchievement(ach)
      end
      GameTooltip:AddLine(" ")
    end

    if (Overachiever_Settings.UI_RequiredForMetaTooltip and AchLookup_metaach[id]) then
      if (not tipset) then
        GameTooltip:SetOwner(self, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 8, 0)
        GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
        tipset = true
      end
      GameTooltip:AddLine(L.REQUIREDFORMETATIP)
      GameTooltip:AddLine(" ")
      AddAchListToTooltip(GameTooltip, AchLookup_metaach[id])
      GameTooltip:AddLine(" ")
    end

    if (tipset) then
      GameTooltip:Show()
      return true
    end
  end

  function achbtnOnLeave(self)
    button = nil
    GameTooltip:Hide()
  end

  -- This function is needed to handle cases where OnEnter isn't triggered again because the frame scrolls down
  -- but the cursor remains on the same button:
  function achBtnRedisplay()
    if (button) then
      if (not achbtnOnEnter(button)) then
        GameTooltip:Hide()
      end
    end
  end
end


-- GLOBAL FUNCTIONS
-----------------------

function Overachiever.OnEvent(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
--[[
  if (Overachiever_Debug and (arg1 or arg2 or arg3 or arg4 or arg5 or arg6 or arg7 or arg8 or arg9)) then
    print("Overachiever event:", event)
    print(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
  end
--]]
  if (event == "PLAYER_ENTERING_WORLD") then
    Overachiever.MainFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    Overachiever.MainFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

    BuildCategoryInfo()
    BuildCategoryInfo = nil

    local _, ACH_LoveCritters, ACH_LoveCritters2, ACH_PestControl, ACH_WellRead, ACH_HigherLearning, ACH_Scavenger, ACH_OutlandAngler
    local ACH_NorthrendAngler, ACH_LetItSnow, ACH_FistfulOfLove, ACH_HappyHour, ACH_TastesLikeChicken
    _, ACH_LoveCritters = GetAchievementInfo(OVERACHIEVER_ACHID.LoveCritters)
    _, ACH_LoveCritters2 = GetAchievementInfo(OVERACHIEVER_ACHID.LoveCritters2)
    _, ACH_PestControl = GetAchievementInfo(OVERACHIEVER_ACHID.PestControl)
    _, ACH_WellRead = GetAchievementInfo(OVERACHIEVER_ACHID.WellRead)
    _, ACH_HigherLearning = GetAchievementInfo(OVERACHIEVER_ACHID.HigherLearning)
    _, ACH_Scavenger = GetAchievementInfo(OVERACHIEVER_ACHID.Scavenger)
    _, ACH_OutlandAngler = GetAchievementInfo(OVERACHIEVER_ACHID.OutlandAngler)
    _, ACH_NorthrendAngler = GetAchievementInfo(OVERACHIEVER_ACHID.NorthrendAngler)
    _, ACH_LetItSnow = GetAchievementInfo(OVERACHIEVER_ACHID.LetItSnow)
    _, ACH_FistfulOfLove = GetAchievementInfo(OVERACHIEVER_ACHID.FistfulOfLove)
    _, ACH_HappyHour = GetAchievementInfo(OVERACHIEVER_ACHID.HappyHour)
    _, ACH_TastesLikeChicken = GetAchievementInfo(OVERACHIEVER_ACHID.TastesLikeChicken)

    -- Handle clients that aren't at WoW 3.0.8 yet (Chinese):
    ACH_LoveCritters2 = ACH_LoveCritters2 or L.OPT_ACHUNKNOWN
    ACH_PestControl = ACH_PestControl or L.OPT_ACHUNKNOWN

    local items = {
	{ type = "labelwrap", text = L.OPT_LABEL_TOOLTIPS, topBuffer = 1 },
	{ variable = "Tooltip_ShowProgress", text = L.OPT_SHOWPROGRESS,
	  tooltip = L.OPT_SHOWPROGRESS_TIP },
	{ variable = "Tooltip_ShowProgress_Other", text = L.OPT_SHOWPROGRESS_OTHER,
	  tooltip = L.OPT_SHOWPROGRESS_OTHER_TIP },
	{ variable = "Tooltip_ShowID", text = L.OPT_SHOWID },

	{ type = "labelwrap", text = L.OPT_LABEL_ACHTWO:format(ACH_LoveCritters, ACH_LoveCritters2),
	  topBuffer = 4 },
	{ variable = "CritterTip_loved", text = L.OPT_CRITTERTIPS,
	  tooltip = L.OPT_CRITTERTIPS_TIP },

	{ type = "labelwrap", text = '"'..ACH_PestControl..'"',
	  topBuffer = 4 },
	{ variable = "CritterTip_killed", text = L.OPT_PESTCONTROLTIPS,
	  tooltip = L.OPT_PESTCONTROLTIPS_TIP },

	{ type = "labelwrap", text = L.OPT_LABEL_ACHTWO:format(ACH_WellRead, ACH_HigherLearning),
	  topBuffer = 4 },
	{ variable = "WellReadTip_read", text = L.OPT_WELLREADTIPS,
	  tooltip = L.OPT_WELLREADTIPS_TIP },

	{ type = "labelwrap", text = L.OPT_LABEL_ACHTHREE:format(ACH_Scavenger, ACH_OutlandAngler, ACH_NorthrendAngler),
	  topBuffer = 4 },
	{ variable = "AnglerTip_fished", text = L.OPT_ANGLERTIPS,
	  tooltip = L.OPT_ANGLERTIPS_TIP },

	{ type = "labelwrap", text = L.OPT_LABEL_ACHTWO:format(ACH_HappyHour, ACH_TastesLikeChicken),
	  topBuffer = 4 },
	{ variable = "Item_consumed", text = L.OPT_CONSUMEITEMTIPS,
	  tooltip = L.OPT_CONSUMEITEMTIPS_TIP, tooltip2 = L.OPT_CONSUMEITEMTIPS_TIP2.."|n|cffffffff"..L.OPT_CONSUMEITEMTIPS_TIP3,
	  OnChange = Overachiever.BuildItemLookupTab },
	{ variable = "Item_consumed_whencomplete", text = L.OPT_CONSUMEITEMTIPS_WHENCOMPLETE,
	  OnChange = Overachiever.BuildItemLookupTab, xOffset = 10 },

	{ type = "labelwrap", text = '"'..ACH_FistfulOfLove..'"', topBuffer = 4, xOffset = 0 },
	{ variable = "FistfulOfLove_petals", text = L.OPT_FISTFULOFLOVETIPS,
	  tooltip = L.OPT_FISTFULOFLOVETIPS_TIP },

	{ type = "labelwrap", text = '"'..ACH_LetItSnow..'"', topBuffer = 4 },
	{ variable = "LetItSnow_flaked", text = L.OPT_LETITSNOWTIPS,
	  tooltip = L.OPT_LETITSNOWTIPS_TIP },

	{ type = "labelwrap", text = L.OPT_LABEL_TRACKING, topBuffer = 4 },
	{ variable = "Tracker_GreenCheck", text = L.OPT_TRACKERGREENCHECK,
	  tooltip = L.OPT_TRACKERGREENCHECK_TIP, OnChange = GreenCheckUpdate },
	{ variable = "Explore_AutoTrack", text = L.OPT_AUTOTRACKEXPLORE,
	  tooltip = L.OPT_AUTOTRACKEXPLORE_TIP, OnChange = AutoTrackCheck_Explore },
	{ variable = "Explore_AutoTrack_Completed", text = L.OPT_AUTOTRACKEXPLORE_COMPLETED,
	  xOffset = 10, OnChange = AutoTrackCheck_Explore },

	{ type = "labelwrap", text = L.OPT_LABEL_DRAG, topBuffer = 4, xOffset = 0 },
	{ variable = "Draggable_AchFrame", text = L.OPT_DRAG_ACHFRAME,
	  OnChange = CheckDraggable_AchFrame },
	{ variable = "DragSave_AchFrame", text = L.OPT_DRAGSAVE, xOffset = 10,
	  OnChange = CheckDraggable_AchFrame },
	{ variable = "Draggable_AchTracker", text = L.OPT_DRAG_ACHTRACKER, xOffset = 0,
	  OnChange = CheckDraggable_AchTracker },
	{ variable = "DragLock_AchTracker", text = L.OPT_DRAGLOCK, xOffset = 10,
	  OnChange = CheckDraggable_AchTracker },

	{ type = "sharedmedia", mediatype = "sound", variable = "SoundAchIncomplete", text = L.OPT_SELECTSOUND,
	  tooltip = L.OPT_SELECTSOUND_TIP, tooltip2 = L.OPT_SELECTSOUND_TIP2,
	  xOffset = 0, topBuffer = 10, OnChange = SoundSelected },
	{ variable = "SoundAchIncomplete_AnglerCheckPole", text = L.OPT_SELECTSOUND_ANGLERCHECKPOLE,
	  tooltip = L.OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP, xOffset = 10 },

	{ type = "labelwrap", text = L.OPT_LABEL_MAINUI, topBuffer = 4, xOffset = 0 },
	{ variable = "UI_SeriesTooltip", text = L.OPT_UI_SERIESTIP,
	  tooltip = L.OPT_UI_SERIESTIP_TIP },
	{ variable = "UI_RequiredForMetaTooltip", text = L.OPT_UI_REQUIREDFORMETATIP,
	  tooltip = L.OPT_UI_REQUIREDFORMETATIP_TIP, OnChange = BuildCriteriaLookupTab_check },
    }

    local oldver
    OptionsPanel, oldver = TjOptions.CreatePanel(THIS_TITLE, nil, {
	title = THIS_TITLE.." v"..THIS_VERSION,
	itemspacing = 3,
	scrolling = true,
	items = items,
	variables = "Overachiever_Settings",
	defaults = Overachiever.DefaultSettings
    });

    if (oldver and oldver ~= THIS_VERSION) then
      Overachiever_Settings.Version = THIS_VERSION
      for k,v in pairs(Overachiever.DefaultSettings) do
      -- Add options new to this version, set to default:
        if (Overachiever_Settings[k] == nil) then
          Overachiever_Settings[k] = v;
        end
      end
    end

    local tracked = GetTrackedAchievement()
    if (Overachiever_CharVars) then
      if (not tracked) then  -- Resume tracking from last session.
        tracked = Overachiever_CharVars.TrackedAch
      end
    else
      Overachiever_CharVars = {};
    end
    Overachiever_CharVars.Version = THIS_VERSION
    setTracking( (tracked or 0) )

    CheckDraggable_AchTracker()

    AutoTrackCheck_Explore(true)

    sethook(GameTooltip, "OnTooltipSetUnit", Overachiever.ExamineSetUnit)
    sethook(GameTooltip, "OnShow", Overachiever.ExamineOneLiner)
    sethook(GameTooltip, "OnTooltipSetItem", Overachiever.ExamineItem)
    sethook(ItemRefTooltip, "OnTooltipSetItem", Overachiever.ExamineItem)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", Overachiever.ExamineAchievementTip)
    hooksecurefunc(GameTooltip, "SetHyperlink", Overachiever.ExamineAchievementTip)

    Overachiever.BuildItemLookupTab()
    BuildCriteriaLookupTab_check()

  elseif (event == "ZONE_CHANGED_NEW_AREA") then
    AutoTrackCheck_Explore()

  elseif (event == "ACHIEVEMENT_EARNED" and arg1 == Overachiever_CharVars.TrackedAch) then
    GreenCheckUpdate()

  elseif (event == "ADDON_LOADED" and arg1 == "Blizzard_AchievementUI") then
    Overachiever.MainFrame:UnregisterEvent("ADDON_LOADED")
    -- Meta-criterea creation intercept:
    orig_AchievementButton_GetMeta = AchievementButton_GetMeta
    AchievementButton_GetMeta = new_AchievementButton_GetMeta
    -- Add "series" tooltip to default achievement buttons:
    Overachiever.UI_HookAchButtons(AchievementFrameAchievements.buttons, AchievementFrameAchievementsContainerScrollBar)
    -- Allow closing frame with Escape even when UIPanelLayout-enabled is set to false:
    tinsert(UISpecialFrames, "AchievementFrame");

    -- Make main achievement UI draggable:
    -- - Prevent UIParent.lua from seeing area field (or it'll do things that mess up making the frame draggable).
    orig_AchievementFrame_area = UIPanelWindows["AchievementFrame"].area
    UIPanelWindows["AchievementFrame"].area = nil
    -- - Hook the first OnShow call to complete this. (Not done now in case saved variables aren't ready or the frame
    --   isn't showing right away.)
    orig_AchievementFrame_OnShow = AchievementFrame_OnShow
    AchievementFrame_OnShow = AchievementUI_FirstShown

  elseif (event == "PLAYER_LOGOUT") then
    local charvars = Overachiever_CharVars
    if (charvars.Pos_AchievementFrame or charvars.Pos_AchievementWatchFrame) then
    -- Set standard location for these frames for other characters that don't have positions saved yet:
      Overachiever_CharVars_Default = {
        Pos_AchievementFrame = charvars.Pos_AchievementFrame,
        Pos_AchievementWatchFrame = charvars.Pos_AchievementWatchFrame
      }
    end

  end
end

function Overachiever.SearchForAchievement(isCustomList, searchList, argnum, msg, toChat, givelist, retTable)
-- If isCustomList is false (or nil), searchList should either be nil or an array of achievement category ID numbers.
-- If isCustomList is true, searchList should be an array of achievement ID numbers.
-- If isCustomList is 2, searchList should be a table containing such arrays.
  if (not searchList) then  isCustomList = nil;  end
  if (not givelist and not toChat) then
    if (isCustomList) then
      if (isCustomList == 2) then
        local id
        for k,sublist in pairs(searchList) do
          id = getAchievementID_tab(sublist, argnum, msg, true)
          if (id) then  return id;  end
        end
        return;
      else
        return getAchievementID_tab(searchList, argnum, msg, true)
      end
    else
      return getAchievementID(searchList, argnum, msg, true)
    end
  end
  local tab
  if (isCustomList) then
    if (isCustomList == 2) then
      tab = SearchAchievements_tab(searchList, argnum, msg, true)
    else
      tab = getAchievementID_tab(searchList, argnum, msg, true, true)
    end
  else
    tab = SearchAchievements(searchList, argnum, msg, true)
  end
  if (tab) then
    local id = tab[1]
    if (toChat) then  chatprint(L.MSG_OPENINGTO..GetAchievementLink(id));  end
    local tab2
    if (givelist) then
      tab2 = type(retTable) == "table" and wipe(retTable) or {}
      copytab(tab, tab2)
      if (not toChat) then  return tab2;  end
    end
    local size = #(tab)
    if (size == 2) then
      chatprint(L.MSG_ONEFOUND..GetAchievementLink(tab[2]))
    elseif (size > 2) then
      chatprint(L.MSG_NUMFOUNDLIST:format(size-1))
      local a, b, c
      for i=2,size,3 do
        a, b, c = tab[i], tab[i+1], tab[i+2]
        a, b, c = GetAchievementLink(a), b and GetAchievementLink(b), c and GetAchievementLink(c)
        if (b) then  a = a.."  --  "..b;  end
        if (c) then  a = a.."  --  "..c;  end
        chatprint(a, "-- ")
      end
    end
    return tab2 or id
  elseif (toChat) then
    chatprint(L.MSG_NAMENOTFOUND:format(msg))
  end
end

function Overachiever.OpenTab(name)
  if (not AchievementFrame or not AchievementFrame:IsShown()) then
    ToggleAchievementFrame()
  end
  local frame = getglobal(name)
  if (frame) then  Overachiever.OpenTab_frame(frame);  end
end

function Overachiever.UI_SelectAchievement(id, failFunc, ...)
  local retOK, ret1 = pcall(AchievementFrame_SelectAchievement, id)
  if (retOK) then
    local category = GetAchievementCategory(id)
    local _, parentID = GetCategoryInfo(category)
    if (parentID == -1) then
      expandCategory(category)
    end
  else
    chatprint(L.MSG_ACHNOTFOUND)
    if (Overachiever_Debug) then
      chatprint(ret1, "[Error]")
    elseif (failFunc) then
      failFunc(...)
    else
    -- Open to summary to hide potentially problematic (though interesting) listing of irregular achievements:
      AchievementCategoryButton_OnClick(AchievementFrameCategoriesContainerButton1)
    end
  end
end

function Overachiever.UI_HookAchButtons(buttons, scrollbar)
  for i,button in ipairs(buttons) do
    sethook(button, "OnEnter", achbtnOnEnter)
    sethook(button, "OnLeave", achbtnOnLeave)
  end
  sethook(scrollbar, "OnValueChanged", achBtnRedisplay)
end

function Overachiever.UI_GetValidCategories()
  CATEGORIES_ALL = CATEGORIES_ALL or GetCategoryList()
  return CATEGORIES_ALL
end

Overachiever.OpenToAchievement = openToAchievement;
Overachiever.GetAllAchievements = getAllAchievements;
Overachiever.BuildCriteriaLookupTab = BuildCriteriaLookupTab;
Overachiever.AddAchListToTooltip = AddAchListToTooltip;


-- SLASH COMMANDS
-------------------

local function slashHandler(msg, self, silent, func_nomsg)
  if (msg == "") then
    func_nomsg = func_nomsg or ToggleAchievementFrame
    func_nomsg();
  else
    if (strsub(msg, 1,1) == "#") then
      local id = tonumber(strsub(msg, 2))
      if (id) then
        if (GetAchievementInfo(id)) then
          if (not silent) then  chatprint(L.MSG_OPENINGTO..GetAchievementLink(id));  end
          openToAchievement(id)
        elseif (not silent) then
          chatprint(L.MSG_INVALIDID);
        end
        return;
      end
    end
    local id = Overachiever.SearchForAchievement(nil, nil, ACHINFO_NAME, msg, not silent)
    if (id) then  openToAchievement(id);  end
  end
end

local function openOptions()
  InterfaceOptionsFrame_OpenToCategory(OptionsPanel)
end

SLASH_Overachiever1 = "/oa";
SlashCmdList["Overachiever"] = function (msg, self)  slashHandler(msg, self, nil, openOptions);  end

SLASH_Overachiever_silent1 = "/oasilent";
SLASH_Overachiever_silent2 = "/oas";
SlashCmdList["Overachiever_silent"] = function(msg, self)  slashHandler(msg, self, true, openOptions);  end;

SLASH_Overachiever_silentAch1 = "/achsilent";
SLASH_Overachiever_silentAch2 = "/achs";
SlashCmdList["Overachiever_silentAch"] = function(msg, self)  slashHandler(msg, self, true);  end;

-- Replace the original slash command handler for /ach, /achieve, /achievement, and /achievements:
SlashCmdList["ACHIEVEMENTUI"] = slashHandler;


-- LOCALIZATION ASSIST
--------------------------

if (Overachiever_Debug) then

  -- Achievement and criteria data gathering:

  function Overachiever.Debug_GetAchData()
    local tab = Overachiever_Settings.Debug_AchData
    if (not tab) then  Overachiever_Settings.Debug_AchData = {};  tab = Overachiever_Settings.Debug_AchData;  end
    local _, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText
    local critString, critType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, critID
    for k,id in pairs(OVERACHIEVER_ACHID) do
      _, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText = GetAchievementInfo(id)
      tab[id] = { Name = Name, Description = Description, RewardText = RewardText }
      tab[id].Criteria = {}
      local crit = tab[id].Criteria
      for i=1,GetAchievementNumCriteria(id) do
        critString, critType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, critID = GetAchievementCriteriaInfo(id, i)
        if (not strfind(quantityString, "/")) then  quantityString = nil;  end
        crit[i] = { critString = critString, quantityString = quantityString }
      end
    end
    chatprint("Achievement/criteria data gathered. Reload the interface or log out to output to saved variables file.")
  end

  -- Zone data gathering:

  local ZoneID

  local function BuildZoneIDTable_z(connum, num, zonename, next, ...)
    num = num + 1
    ZoneID[zonename] = {}
    ZoneID[zonename].C = connum
    ZoneID[zonename].Z = num
    if (next) then
      BuildZoneIDTable_z(connum, num, next, ...)
    end
  end

  -- Intended first call: BuildZoneIDTable(0, GetMapContinents());
  local function BuildZoneIDTable(num, conname, next, ...)
    num = num + 1
    --print("BuildZoneIDTable: "..conname.." ("..num..")")
    BuildZoneIDTable_z(num, 0, GetMapZones(num))
    if (next) then
      BuildZoneIDTable(num, next, ...)
    end
  end

  -- /run Overachiever.Debug_GetExplorationData(true)
  function Overachiever.Debug_GetExplorationData(testAchMatch, saveZoneIDs)
    if (not ZoneID and (testAchMatch or saveZoneIDs)) then
      ZoneID = {}
      BuildZoneIDTable(0, GetMapContinents());
      chatprint("Zone data gathered.")
    end
    if (saveZoneIDs) then  Overachiever_Settings.Debug_ZoneData = ZoneID;  end

    local tab = {}
    local catname, id, name, trimname
    for _, category in ipairs(CATEGORIES_EXPLOREZONES) do
      catname = GetCategoryInfo(category)
      tab[catname] = {}
      for i=1,GetCategoryNumAchievements(category) do
        id, name = GetAchievementInfo(category, i)
        if (testAchMatch) then
          trimname = strsub(name,9) -- Cut off "Explore " - meant for use with English client only
          if (trimname and ZoneID[trimname]) then
            name = trimname
          else
            chatprint("Achievement name doesn't match a zone: "..name)
            name = "!! "..name
          end
        end
        tab[catname][name] = id;
      end
    end
    Overachiever_Settings.Debug_ExplorationData = tab
    chatprint("Exploration Achievement data gathered. Reload the interface or log out to output to saved variables file.")
  end

end


-- FRAME INITIALIZATION
--------------------------

Overachiever.MainFrame = CreateFrame("Frame")
Overachiever.MainFrame:Hide()
Overachiever.MainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
Overachiever.MainFrame:RegisterEvent("ADDON_LOADED")
Overachiever.MainFrame:RegisterEvent("ACHIEVEMENT_EARNED")
Overachiever.MainFrame:RegisterEvent("PLAYER_LOGOUT")
if (Overachiever_Debug) then
  Overachiever.MainFrame:RegisterEvent("CRITERIA_UPDATE")
end
Overachiever.MainFrame:SetScript("OnEvent", Overachiever.OnEvent)
Overachiever.MainFrame:SetScript("OnUpdate", AchievementUI_FirstShown_post)
