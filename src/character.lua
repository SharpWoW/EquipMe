--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local ICON_PLACE_IN_BAG_NAME = "inv_misc_bag_08"
local ICON_PLACE_IN_BAG_ID = 133633

local foreach = T.utils.foreach
local colorize = T.utils.colorize
local items = T.items
local inventory = T.inventory
local bags = T.bags

local tinsert = table.insert

local character = {}

local frames = {} -- luacheck: ignore 241

local slot_frame
local slot_buttons

local BUTTON_COUNT = 16

local hide_slot_frame

local function create_button(parent, texture)
  local button = CreateFrame("Button", nil, parent)
  button:SetHeight(32)
  button:SetWidth(32)
  button.icon = button:CreateTexture(nil, "BORDER")
  button.icon:SetAllPoints(button)
  button.icon:SetTexture(texture or ICON_PLACE_IN_BAG_ID)
  return button
end

local function create_buttons(parent)
  slot_buttons = {}
  for i = 1, BUTTON_COUNT do
    local button = create_button(parent, ICON_PLACE_IN_BAG_ID)
    if i == 1 then
      button:SetPoint("TOPLEFT", parent, "TOPLEFT")
    else
      button:SetPoint("LEFT", slot_buttons[i - 1], "RIGHT")
    end
    slot_buttons[i] = button
  end
end

local function init_item_button(button, info, slot_id)
  button.icon:SetTexture(info.icon)
  button:SetScript("OnClick", function()
    items:Equip(info.link, slot_id)
    hide_slot_frame()
  end)
  button:Show()
end

local function init_pib_button(button, slot_id)
  button.icon:SetTexture(ICON_PLACE_IN_BAG_ID)
  button:SetScript("OnClick", function()
    inventory:Unequip(slot_id)
    hide_slot_frame()
  end)
  button:Show()
end

local function init_buttons(parent, slot_id)
  if not slot_buttons then
    create_buttons(parent)
  end

  foreach(slot_buttons, function(b) b:Hide() end)

  local valid = bags:GetForSlot(slot_id)
  for i, info in ipairs(valid) do
    init_item_button(slot_buttons[i], info, slot_id)
  end

  init_pib_button(slot_buttons[#valid + 1], slot_id)
end

local function create_frame(parent)
  slot_frame = CreateFrame("Frame", nil, parent)
  slot_frame:SetHeight(128)
  slot_frame:SetWidth(300)
  slot_frame:SetPoint("TOPLEFT", parent, "TOPRIGHT")
  slot_frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"
  })

  slot_frame:SetScript("OnLeave", function(self) self:Hide() end)
  slot_frame:Hide()

  hide_slot_frame = function() slot_frame:Hide() end
end

local function init_frame(parent, slot_id)
  if not slot_frame then create_frame(parent) end

  slot_frame:SetParent(parent)
  slot_frame:ClearAllPoints()
  slot_frame:SetPoint("TOPLEFT", parent, "TOPRIGHT")
  init_buttons(slot_frame, slot_id)

  return slot_frame
end

local function hook_frames()
  for slot_id, info in pairs(inventory.SLOTS) do
    local parent = _G[info.frame]

    parent:HookScript("OnEnter", function(self)
      local current = inventory:Get(slot_id).link
      T:LogTrace("%s: %s", self:GetName(), current or colorize("Nothing", "RED"))
      init_frame(self, slot_id):Show()
    end)

    parent:HookScript("OnLeave", function()

    end)
  end
end

function character:Initialize()
  T:LogDebug("Initializing character module")

  CharacterFrame:HookScript("OnShow", function()
    hook_frames()
  end)

  T:LogDebug("Character module initialized!")
end

T.character = character
