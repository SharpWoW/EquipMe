--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local colorize = T.utils.colorize
local inventory = T.inventory

local character = {}

local frames = {} -- luacheck: ignore 241

local function create_frames()
  for slot_id, info in pairs(inventory.SLOTS) do
    local parent = _G[info.frame]
    local frame = CreateFrame("Frame", nil, parent)
    frames[slot_id] = frame

    parent:HookScript("OnEnter", function(self)
      if not T:IsTraceEnabled() then return end
      local current = inventory:Get(slot_id).link
      T:LogTrace("%s: %s", self:GetName(), current or colorize("Nothing", "RED"))
    end)
  end
end

function character:Initialize()
  T:LogDebug("Initializing character module")
  create_frames()
  T:LogDebug("Character module initialized!")
end

T.character = character
