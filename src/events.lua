--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

function T:PLAYER_ENTERING_WORLD()
  self:LogTrace("PLAYER_ENTERING_WORLD")
end

function T:PLAYER_REGEN_DISABLED()
  self:LogTrace("PLAYER_REGEN_DISABLED")
end

function T:PLAYER_REGEN_ENABLED()
  self:LogTrace("PLAYER_REGEN_ENABLED")
end

function T:InitializeEvents()
  self:RegisterEvent("PLAYER_ENTERING_WORLD")
  self:RegisterEvent("PLAYER_REGEN_DISABLED")
  self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

T:AddInitializer("InitializeEvents")
