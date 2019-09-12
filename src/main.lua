--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

_G[NAME] = T

T.initializers = {}

local embeds = {
  "AceConsole-3.0",
  "AceEvent-3.0"
}

LibStub("AceAddon-3.0"):NewAddon(T, NAME, unpack(embeds))

function T:OnInitialize()
  self:LogInfo("Initializing...")

  for _, initializer in pairs(self.initializers) do
    local init_type = type(initializer)
    if init_type == "string" then
      if self[initializer] then
        self:LogDebug("Calling initializer: %s", initializer)
        self[initializer](self)
      else
        self:LogError("Initializer %s was not found", initializer)
      end
    elseif init_type == "function" then
      initializer(self)
    else
      self:LogError("Unsupported initializer type: %s", init_type)
    end
  end

  self:LogInfo("Initialized!")
end

function T:OnEnable()
  self:LogInfo("Enabled!")
end

function T:OnDisable()
  self:LogInfo("Disabled!")
end

function T:AddInitializer(initializer)
  self.initializers[#self.initializers + 1] = initializer
end
