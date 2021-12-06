-- backgorund frame (show on combat) (PLAYER_REGEN_DISABLED)
  --for each enemy
    --bar frame
      --icon changes color for threat
      --name
      --health bar

--customizations
  -- color of icon
  -- color of bar
  -- height of bar
  -- health bar / percent / numbers
  -- clickthrough
  -- target?
  -- show always or combat only

--create background for addon
if not backgroundFrame then
  local backingFrame = CreateFrame("Frame", "backgroundFrame", UIParent, "DialogBoxFrame")
  backingFrame:SetPoint("CENTER")
  backingFrame:SetWidth(128)
  backingFrame:SetHeight(256)
  backingFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    edgeSize = 16,
    insets = {left = 4, right = 4, top = 4, bottom = 4}
  })
  backingFrame:SetBackdropColor(0, 0, 0, 25)

  backingFrame:SetMovable(true)
  backingFrame:SetClampedToScreen(true)
  backingFrame:SetScript("OnMouseDown", function (self, button)
    if button == "LeftButton" then
      self:StartMoving()
    end
  end)
  backingFrame:SetScript("OnMouseUp", function(self, button)
    self:StopMovingOrSizing()
  end)

  --backingFrame:Show()
end

--attempt to create bars for enemies
function CreateUnitBar()

end

-- event parsing
local eventFrame = CreateFrame("Frame", "EventFrame")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("UNIT_THREAT_LIST_UPDATE") -- fires on threat update for mob
EventFrame:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE") -- fires when aggro order changes
EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

function eventParse(self, event, arg1)
  if (event == "ADDON_LOADED") then
    print("Aggro List V1.0 loaded successfully.")
    EventFrame:UnregisterEvent("ADDON_LOADED")
  elseif (event == "PLAYER_REGEN_DISABLED") then
    backgroundFrame:Show()
    print("AGGROLIST -- IN COMBAT")
  elseif (event == "PLAYER_REGEN_ENABLED") then
    backgroundFrame:Hide()
    print("AGGROLIST -- LEAVING COMBAT")
  end
end

EventFrame:SetScript("OnEvent", eventParse)

-- slash commands
SLASH_AGGROLIST1 = "/alist"

function SlashCmdList.AGGROLIST(cmd, editbox)
  local request, arg = strsplit(' ', cmd)
  request = request.lower(request)
  if request == "show" then
    backgroundFrame:Show()
  else
    backgroundFrame:Show();
  end
end
