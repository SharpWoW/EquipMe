--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local combat_queue = T.combat_queue

function T:PLAYER_ENTERING_WORLD()
  self:LogTrace("PLAYER_ENTERING_WORLD")
end

function T:PLAYER_REGEN_DISABLED()
  self:LogTrace("PLAYER_REGEN_DISABLED")
  self.is_in_combat = true
end

function T:PLAYER_REGEN_ENABLED()
  self:LogTrace("PLAYER_REGEN_ENABLED")
  self.is_in_combat = false
  combat_queue:Process()
end

local function log_register_event(addon, event)
  addon:LogDebug("Registering for event %s", event)
  addon:RegisterEvent(event)
end

function T:InitializeEvents()
  self:LogDebug("Initializing events...")
  log_register_event(self, "PLAYER_ENTERING_WORLD")
  log_register_event(self, "PLAYER_REGEN_DISABLED")
  log_register_event(self, "PLAYER_REGEN_ENABLED")
  self:LogDebug("Events initialized!")
end
