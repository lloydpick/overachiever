
local L = OVERACHIEVER_STRINGS

local tabs, tabselected
local LeftFrame


local function getFrameOfButton(button)
  return button:GetParent():GetParent():GetParent()
end

local function clearSelection(frame)
-- Based on AchievementFrameAchievements_ClearSelection().
  AchievementButton_ResetObjectives();
  for _, button in next, frame.buttons do
    button:Collapse();
    if ( not MouseIsOver(button) ) then
      button.highlight:Hide();
    end
    button.selected = nil;
    if ( not button.tracked:GetChecked() ) then
      button.tracked:Hide();
    end
  end

  frame.selection = nil;
end

local function selectButton(button)
-- Based on AchievementFrameAchievements_SelectButton().
  local achievements = getFrameOfButton(button);

  achievements.selection = button.id;
  achievements.selectionIndex = button.index;
  button.selected = true;
end

local function isAchievementInUI(id, checkNext)
-- Return true if the achievement should be found in the standard UI
  if (checkNext) then
    local nextID, completed = GetNextAchievement(id)
    if (nextID and completed) then
      local newID;
      while ( nextID and completed ) do
        newID, completed = GetNextAchievement(nextID);
        if ( completed ) then
          nextID = newID;
        end
      end
      id = nextID;
    end
  end
  local cat = GetAchievementCategory(id)
  for i=1,GetCategoryNumAchievements(cat) do
    if (GetAchievementInfo(cat, i) == id) then  return true;  end
  end
end

local function isPreviousAchievementInUI(id)
  id = GetPreviousAchievement(id)
  if (id) then
    if (isAchievementInUI(id)) then  return true;  end
    return isPreviousAchievementInUI(id)
  end
end

local function displayAchievement(button, frame, achievement, index, selectionID)
-- This function is based on AchievementButton_DisplayAchievement, with only a few alterations as needed.
  local id, name, points, completed, month, day, year, description, flags, icon, rewardText
  if (achievement) then
    id, name, points, completed, month, day, year, description, flags, icon, rewardText = GetAchievementInfo(achievement);
  end
  if ( not id ) then
    button:Hide();
    return;
  else
    button:Show();
  end

  button.index = index;
  button.element = true;

  if ( button.id ~= id ) then
    button.id = id;
    button.label:SetWidth(ACHIEVEMENTBUTTON_LABELWIDTH);
    button.label:SetText(name)

    if ( GetPreviousAchievement(id) ) then
      -- If this is a progressive achievement, show the total score.
      AchievementShield_SetPoints(AchievementButton_GetProgressivePoints(id), button.shield.points, AchievementPointsFont, AchievementPointsFontSmall);
    else
      AchievementShield_SetPoints(points, button.shield.points, AchievementPointsFont, AchievementPointsFontSmall);
    end
    if ( points > 0 ) then
      button.shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields]]);
    else
      button.shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields-NoPoints]]);
    end

    button.description:SetText(description);
    button.hiddenDescription:SetText(description);
    if ( button.hiddenDescription:GetWidth() > ACHIEVEMENTUI_MAXCONTENTWIDTH ) then
      button.description:SetWidth(ACHIEVEMENTUI_MAXCONTENTWIDTH);
    else
      button.description:SetWidth(0);
    end

    button.icon.texture:SetTexture(icon);
    if ( completed and not button.completed ) then
      button.completed = true;
      button.dateCompleted:SetText(string.format(SHORTDATE, day, month, year));
      button.dateCompleted:Show();
      button:Saturate();
    elseif ( completed ) then
      button.dateCompleted:SetText(string.format(SHORTDATE, day, month, year));
    else
      button.completed = nil;
      button.dateCompleted:Hide();
      button:Desaturate();
      -- Overachiever color customization:
      local RecentReminders = Overachiever.RecentReminders
      -- Make sure Overachiever.RecentReminders_Check() was called before displayAchievement(...) for this:
      if (RecentReminders and RecentReminders[id]) then
        local name = button:GetName()
        --button:SetBackdropBorderColor(.8, .5, .5)
        getglobal(name .. "Background"):SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateGreen")
        getglobal(name.."Glow"):SetVertexColor(.13, .52, .17)
      elseif (not isAchievementInUI(id)) then
        local name = button:GetName()
        --button:SetBackdropBorderColor(.8, .5, .5)
        if (isPreviousAchievementInUI(id)) then
          getglobal(name .. "Background"):SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateBlue")
          getglobal(name.."Glow"):SetVertexColor(.22, .17, .43)
        else
          getglobal(name .. "Background"):SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateRed")
          getglobal(name.."Glow"):SetVertexColor(.52, .17, .13)
        end
      end
    end

    if ( rewardText == "" ) then
      button.reward:Hide();
      button.rewardBackground:Hide();
    else
      button.reward:SetText(rewardText);
      button.reward:Show();
      button.rewardBackground:Show();
      if ( button.completed ) then
        button.rewardBackground:SetVertexColor(1, 1, 1);
      else
        button.rewardBackground:SetVertexColor(0.35, 0.35, 0.35);
      end
    end

    local tracked = GetTrackedAchievement();
    if ( tracked == id ) then
      button.check:Show();
      button.label:SetWidth(button.label:GetStringWidth() + 4);
      button.tracked:SetChecked(true);
    else
      button.check:Hide();
      button.tracked:SetChecked(false);
      button.tracked:Hide();
    end
  end

  if ( id == selectionID ) then
    frame.selection = button.id;
    frame.selectionIndex = button.index;
    button.selected = true;
    button.highlight:Show();
    local height = AchievementButton_DisplayObjectives(button, button.id, button.completed);
    if ( height == ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT ) then
      button:Collapse();
    else
      button:Expand(height);
    end
    button.tracked:Show();
  elseif ( button.selected ) then
    button.selected = nil;
    if ( not MouseIsOver(button) ) then
      button.highlight:Hide();
    end
    button:Collapse();
    button.tracked:Hide();
  end

  return id;
end

local sortList
do
  local getret
  
  local function sortList_simple(a, b)
    local aV = select(getret, GetAchievementInfo(a))
    local bV = select(getret, GetAchievementInfo(b))
    -- If values are the same, fall back to alphabetical order by name:
    if (aV == bV) then
      local aID, bID
      aID, aV = GetAchievementInfo(a)
      bID, bV = GetAchievementInfo(b)
      -- If names are the same, fall back to ID:
      if (aV == bV) then
        aV, bV = aID, bID
      end
    end
    if (type(aV) == "string") then
    -- Handle things so, e.g., "200 Daily Quests Complete" comes before "1000 Daily Quests Complete":
      local numA, textA = aV:match("([^%s]+) (.+)")
      numA = tonumber(numA)
      if (numA) then
        local numB, textB = bV:match("([^%s]+) (.+)")
        numB = tonumber(numB)
        if (numB) then
          if (numA ~= numB) then  return numA < numB;  end
          return textA < textB
        end
      end
    end
    return aV < bV
  end

  local function sortList_date(a, b)
    local aM, aD, aY = select(5, GetAchievementInfo(a))
    local bM, bD, bY = select(5, GetAchievementInfo(b))
    if (aM and bM) then  -- Both achievements are completed
      if (aY < bY) then
        return true
      elseif (aY > bY) then
        return false
      elseif (aM < bM) then
        return true
      elseif (aM > bM) then
        return false
      elseif (aD < bD) then
        return true
      elseif (aD > bD) then
        return false
      end
    elseif (aM) then  -- A is complete; B is not
      return true
    elseif (bM) then  -- B is complete; A is not
      return false
    end
    -- If dates are the same or neither is complete, fall back to alphabetical order by name:
    getret = 2
    return sortList_simple(a, b)
  end

  function sortList(list, mode)
    if (#list < 2) then
      return list
    elseif (mode == 1) then  -- Date completed
      sort(list, sortList_date)
    elseif (mode == 2) then  -- Points
      getret = 3;
      sort(list, sortList_simple)
    elseif (mode == 3) then  -- ID
      sort(list)  -- ID already given in the table, so default sort can handle this.
    else  -- Name (mode 0, default)
      getret = 2
      sort(list, sortList_simple)
    end
  end
end

local function updateAchievementsList(frame)
  local list = frame.AchList
  if (not frame.AchList_sorted) then
    sortList(list, frame.sort)
    frame.AchList_sorted = true
  end
-- This function based on AchievementFrameAchievements_Update in Blizzard_AchievementUI.lua.
  local scrollFrame = frame.scrollFrame
  local offset = HybridScrollFrame_GetOffset(scrollFrame);
  local buttons = scrollFrame.buttons;
  local numAchievements = #list
  local numButtons = #buttons;

  local selection = frame.selection;
  if ( selection ) then
    AchievementButton_ResetObjectives();
  end

  local extraHeight = scrollFrame.largeButtonHeight or ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT
  
  Overachiever.RecentReminders_Check()
  local displayedHeight, index = 0;
  for i = 1, numButtons do
    index = i + offset
    displayAchievement(buttons[i], frame, list[index], index, selection);
    displayedHeight = displayedHeight + buttons[i]:GetHeight();
  end

  local totalHeight = numAchievements * ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT;
  totalHeight = totalHeight + (extraHeight - ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT);

  HybridScrollFrame_Update(scrollFrame, numAchievements, totalHeight, displayedHeight);

  if ( selection ) then
    frame.selection = selection;
  else
    HybridScrollFrame_CollapseButton(scrollFrame);
  end
end

local function forceUpdate(frame, keepSelection, fromHook)
-- Based on AchievementFrameAchievements_ForceUpdate:
  if ( not keepSelection and frame.selection ) then
    local nextID = GetNextAchievement(frame.selection);
    local id, _, _, completed = GetAchievementInfo(frame.selection);
    if ( nextID and completed ) then
      frame.selection = nil;
    end
  end
  if (not fromHook) then
  -- Don't do these when called by forceUpdate_all because they are handled by
  -- AchievementFrameAchievements_ForceUpdate and shouldn't occur again:
    AchievementFrameAchievementsObjectives:Hide();
    AchievementFrameAchievementsObjectives.id = nil;
  end

  local buttons = frame.scrollFrame.buttons;
  for i, button in next, buttons do
    button.id = nil;
  end

  frame.AchList_sorted = nil
  if (frame:IsShown()) then  updateAchievementsList(frame);  end
end

local function forceUpdate_all()
  for k,tab in ipairs(tabs) do
    forceUpdate(tab.frame, nil, true)
  end
end

local function tabUnselect()
  tabselected = nil
  for k,tab in ipairs(tabs) do
    tab.text:SetPoint("CENTER", tab, "CENTER", 0, -3)
  end
end

local function tabOnClick(self, button)
  self.text:SetPoint("CENTER", self, "CENTER", 0, -5)
  local i, tab = 0
  repeat
    i = i + 1
    tab = getglobal("AchievementFrameTab"..i)
    if (tab and tab ~= self) then
      tab.text:SetPoint("CENTER", tab, "CENTER", 0, -3)
    end
  until (not tab)
  -- Don't play sound when this is a silentDisplay or Overachiever.OpenTab_frame call.
  if (button) then  PlaySound("igCharacterInfoTab");  end

  tabselected = self.frame
  AchievementFrame_ShowSubFrame(self.frame, LeftFrame)
  LeftFrame.label:SetText(self:GetText())
  AchievementFrameWaterMark:SetTexture(self.watermark)
  PanelTemplates_Tab_OnClick(self, AchievementFrame)
  updateAchievementsList(self.frame)
end

local function silentDisplay(button)
  tabOnClick(getFrameOfButton(button).tab)
end

local orig_compheader_OnShow
local function compheader_OnShow(...)
  -- Prevent comparison portrait from reverting to player's when you switch tabs while comparing achievements:
  if (not tabselected) then  orig_compheader_OnShow(...);  end
end

local function achbtnOnClick(self, button)
  local id = self.id
  if ( IsControlKeyDown() and (GetPreviousAchievement(id) or isAchievementInUI(id, true)) ) then
    Overachiever.UI_SelectAchievement(id, silentDisplay, self)
    return;
  end
  -- This section based on the AchievementButton_OnClick function in Blizzard_AchievementUI.lua:
  if (IsModifiedClick()) then
    if ( IsModifiedClick("CHATLINK") and ChatFrameEditBox:IsVisible() ) then
      local achievementLink = GetAchievementLink(self.id);
      if ( achievementLink ) then
        ChatEdit_InsertLink(achievementLink);
      end
    elseif ( IsModifiedClick("QUESTWATCHTOGGLE") ) then
      AchievementButton_ToggleTracking(self.id);
    end
    return;
  end

  local frame = getFrameOfButton(self)
  if ( self.selected ) then
    if ( not MouseIsOver(self) ) then
      self.highlight:Hide();
    end
    clearSelection(frame)
    HybridScrollFrame_CollapseButton(frame.scrollFrame);
    updateAchievementsList(frame);
    return;
  end
  clearSelection(frame)
  selectButton(self);
  Overachiever.RecentReminders_Check()
  displayAchievement(self, frame, self.id, self.index, self.id)
  HybridScrollFrame_ExpandButton(frame.scrollFrame, ((self.index - 1) * ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT), self:GetHeight());
  updateAchievementsList(getFrameOfButton(self))
end

local redir_btn_tinsert
local function post_AchievementButton_OnLoad(self)
  if (redir_btn_tinsert) then
    self:SetScript("OnClick", achbtnOnClick)
    tinsert(redir_btn_tinsert, self);
    -- Undo the last addition to the table normally used (we don't want our buttons listed there):
    tremove(AchievementFrameAchievements.buttons);
  end
end

local function ListFrame_OnShow(self)
  self.panel:Show()
end

local function ListFrame_OnHide(self)
  self.panel:Hide()
end


function Overachiever.BuildNewTab(name, text, watermark, helptip, loadFunc)
  local numtabs, tab = 0
  repeat
    numtabs = numtabs + 1
  until (not getglobal("AchievementFrameTab"..numtabs))
  tab = CreateFrame("Button", "AchievementFrameTab"..numtabs, AchievementFrame, "AchievementFrameTabButtonTemplate")
  tab:SetText(text)
  tab:SetPoint("LEFT", "AchievementFrameTab"..numtabs-1, "RIGHT", -5, 0)
  tab:SetID(numtabs)
  PanelTemplates_SetNumTabs(AchievementFrame, numtabs)

  local frame = CreateFrame("Frame", name, AchievementFrame)
  frame:SetWidth(504); frame:SetHeight(440)
  frame:SetPoint("TOPLEFT", AchievementFrameAchievements, "TOPLEFT", 0, 0)
  frame:SetPoint("BOTTOM", AchievementFrameAchievements, "BOTTOM")
  local frameBG = frame:CreateTexture("$parentBackground", "BACKGROUND")
  frameBG:SetTexture("Interface\\AchievementFrame\\UI-Achievement-AchievementBackground")
  frameBG:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -3)
  frameBG:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)
  local frameBGDarken = frame:CreateTexture(nil, "ARTWORK")
  frameBGDarken:SetAllPoints(frameBG)
  frameBGDarken:SetTexture(0, 0, 0, 0.75)
  local frameBorder = CreateFrame("Frame", nil, frame)
  frameBorder:SetAllPoints(frame)
  frameBorder:SetBackdrop( {
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 5, right = 5, top = 5, bottom = 5 }
  } )
  frameBorder:SetBackdropBorderColor(ACHIEVEMENTUI_GOLDBORDER_R, ACHIEVEMENTUI_GOLDBORDER_G, ACHIEVEMENTUI_GOLDBORDER_B, ACHIEVEMENTUI_GOLDBORDER_A)
  frameBorder:SetFrameLevel(frameBorder:GetFrameLevel()+1)

  local scrollframe = CreateFrame("ScrollFrame", "$parentContainer", frame, "HybridScrollFrameTemplate")
  scrollframe:SetWidth(504); scrollframe:SetHeight(440)
  scrollframe:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -3)
  scrollframe:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 5)
  local scrollbar = CreateFrame("Slider", "$parentScrollBar", scrollframe, "HybridScrollBarTemplate")
  scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 1, -16)
  scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 1, 12)
  frame.scrollFrame = scrollframe

  scrollbar.Show =
    function (self)
      frame:SetWidth(504);
      for _, button in next, frame.buttons do
        button:SetWidth(496);
      end
      getmetatable(self).__index.Show(self);
    end

  scrollbar.Hide =
    function (self)
      frame:SetWidth(527);
      for _, button in next, frame.buttons do
        button:SetWidth(519);
      end
      getmetatable(self).__index.Hide(self);
    end

  tinsert(ACHIEVEMENTFRAME_SUBFRAMES, name)

  tab.watermark, tab.loadFunc = watermark, loadFunc
  tab.frame = frame
  frame.tab = tab
  frame.helptip = helptip

  tab:SetScript("OnClick", tabOnClick)
  if (not tabs) then
    tabs = {}
    hooksecurefunc("AchievementFrameBaseTab_OnClick", tabUnselect)
    hooksecurefunc("AchievementFrameComparisonTab_OnClick", tabUnselect)
    orig_compheader_OnShow = AchievementFrameComparisonHeader:GetScript("OnShow")
    AchievementFrameComparisonHeader:SetScript("OnShow", compheader_OnShow)
    hooksecurefunc("AchievementButton_OnLoad", post_AchievementButton_OnLoad)
    hooksecurefunc("AchievementFrameAchievements_ForceUpdate", forceUpdate_all)
  end
  tabs[#(tabs)+1] = tab
  frame.AchList = {}
  frame.ForceUpdate = forceUpdate

  scrollframe.update = function() updateAchievementsList(frame) end;  -- Needed in this fashion for HybridScrollFrame_SetOffset calls.
  getglobal(name.."ContainerScrollBarBG"):Show()
  frame.buttons = {}
  redir_btn_tinsert = frame.buttons
  HybridScrollFrame_CreateButtons(scrollframe, "AchievementTemplate", 0, -2);
  redir_btn_tinsert = nil
  Overachiever.UI_HookAchButtons(frame.buttons, scrollbar)

  local panel = CreateFrame("Frame", nil, LeftFrame)
  panel:SetPoint("TOPLEFT", LeftFrame.label, "BOTTOMLEFT", 0, -6)
  panel:SetPoint("RIGHT", LeftFrame, "RIGHT")
  panel:SetPoint("BOTTOM", LeftFrame, "BOTTOM")
  panel:Hide()
  frame.panel = panel
  frame:SetScript("OnShow", ListFrame_OnShow)
  frame:SetScript("OnHide", ListFrame_OnHide)

  return frame, panel
end

function Overachiever.OpenTab_frame(frame)
  tabOnClick(frame.tab)
end


local function HelpIcon_OnEnter(self)
  self.tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIconHighlight")
  GameTooltip:SetOwner(self, "ANCHOR_NONE")
  GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 10, 0)
  GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
  GameTooltip:AddLine(self.tip:format(tabselected.tab:GetText()), 1, 1, 1)
  GameTooltip:AddLine(" ")
  GameTooltip:AddLine(tabselected.helptip, nil, nil, nil, 1)
  GameTooltip:AddLine(" ")
  GameTooltip:AddLine(L.TAB_HELP, nil, nil, nil, 1)
  GameTooltip:Show()
end

local function HelpIcon_OnLeave(self)
  self.tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIcon")
  GameTooltip:Hide()
end

local function LeftFrame_OnShow(self)
  AchievementFrameCategoriesContainer:Hide()
end

local function LeftFrame_OnHide(self)
  AchievementFrameCategoriesContainer:Show()
end

local function LeftFrame_OnEvent_CRITERIA_UPDATE()
  local frame
  for k,tab in ipairs(tabs) do
    frame = tab.frame
    if ( frame.selection ) then
      local id = AchievementFrameAchievementsObjectives.id;
      local button = AchievementFrameAchievementsObjectives:GetParent();
      AchievementFrameAchievementsObjectives.id = nil;
      AchievementButton_DisplayObjectives(button, id, button.completed);
      return;
    end
  end
end

do
  LeftFrame = CreateFrame("Frame", "Overachiever_LeftFrame", AchievementFrameCategories)
  LeftFrame:SetPoint("TOPLEFT", AchievementFrameCategories, "TOPLEFT", 9, -5)
  LeftFrame:SetPoint("TOPRIGHT", AchievementFrameCategories, "TOPRIGHT", -9, -5)
  LeftFrame:SetPoint("BOTTOM", AchievementFrameCategories, "BOTTOM", 0, 8)

  local label = LeftFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  label:SetPoint("TOPLEFT", LeftFrame, "TOPLEFT", 1, -6)
  label:SetText("Overachiever")
  LeftFrame.label = label

  local HelpIcon = CreateFrame("Frame", nil, LeftFrame)
  HelpIcon:SetWidth(32); HelpIcon:SetHeight(32)
  HelpIcon:SetPoint("LEFT", label, "RIGHT", 4, 0)
  local tex = HelpIcon:CreateTexture(nil, "BACKGROUND")
  tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIcon")
  tex:SetPoint("CENTER", HelpIcon, "CENTER", 0, 0)
  HelpIcon.tex = tex
  HelpIcon:EnableMouse(true)
  HelpIcon:SetScript("OnEnter", HelpIcon_OnEnter)
  HelpIcon:SetScript("OnLeave", HelpIcon_OnLeave)
  HelpIcon.tip = GetAddOnMetadata("Overachiever", "Title")..": %s"
  HelpIcon:SetScale(0.85)

  LeftFrame:Hide()
  LeftFrame:SetScript("OnShow", LeftFrame_OnShow)
  LeftFrame:SetScript("OnHide", LeftFrame_OnHide)

  tinsert(ACHIEVEMENTFRAME_SUBFRAMES, "Overachiever_LeftFrame")

  LeftFrame:RegisterEvent("ADDON_LOADED")
  LeftFrame:SetScript("OnEvent", function(self, event, arg1)
    if (arg1 == "Overachiever_Tabs") then
      self:UnregisterEvent("ADDON_LOADED")
      self:RegisterEvent("CRITERIA_UPDATE")
      self:SetScript("OnEvent", LeftFrame_OnEvent_CRITERIA_UPDATE)
      Overachiever_Tabs_Settings = Overachiever_Tabs_Settings or {}
      if (tabs) then
        local v = Overachiever_Tabs_Settings
        for k,tab in ipairs(tabs) do
          if (tab.loadFunc) then
            tab.loadFunc(v)
            tab.loadFunc = nil
          end
        end
      end
    end
  end)
end

-- Meta-criteria creation intercept (in addition to the base Overachiever intercept):
local function MetaCriteriaOnClick(self)
  local id = self.id
  if (id and (GetPreviousAchievement(id) or isAchievementInUI(id, true)) ) then
    Overachiever.UI_SelectAchievement(id, silentDisplay, self:GetParent():GetParent())
  end
end
local orig_AchievementButton_GetMeta = AchievementButton_GetMeta
local function new_AchievementButton_GetMeta(...)
  local frame = orig_AchievementButton_GetMeta(...)
  frame:SetScript("OnClick", MetaCriteriaOnClick)
  return frame;
end
AchievementButton_GetMeta = new_AchievementButton_GetMeta

-- Meta-criteria recolor:
local function recolor_AchievementObjectives_DisplayCriteria(objectivesFrame, id)
  if (not id or GetPreviousAchievement(id) or isAchievementInUI(id, true)) then  return;  end
  local metaCriteria, index = AchievementFrameMeta1, 1
  while (metaCriteria and metaCriteria:IsShown()) do
    if (not GetPreviousAchievement(metaCriteria.id) and not isAchievementInUI(metaCriteria.id, true)) then
      metaCriteria.label:SetTextColor(.9, .4, .4, 1)
    end
    index = index + 1
    metaCriteria = _G["AchievementFrameMeta"..index]
  end
end
hooksecurefunc("AchievementObjectives_DisplayCriteria", recolor_AchievementObjectives_DisplayCriteria)
