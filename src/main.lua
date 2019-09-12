--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local L = T.I18n:Get()

_G[NAME] = T

T.initializers = {}

local embeds = {
  "AceConsole-3.0",
  "AceEvent-3.0"
}

LibStub("AceAddon-3.0"):NewAddon(T, NAME, unpack(embeds))

function T:OnInitialize()
  self:LogDebug("Initializing...")

  for _, initializer in pairs(self.initializers) do
    local init_type = type(initializer)
    if init_type == "string" then
      if self[initializer] then
        self:LogDebug('Calling initializer "%s"...', initializer)
        self[initializer](self)
        self:LogDebug('Initializer "%s" called!', initializer)
      else
        self:LogError(L"INITIALIZER_NOT_FOUND", initializer)
      end
    elseif init_type == "function" then
      initializer(self)
    else
      self:LogError(L"UNSUPPORTED_INITIALIZER_TYPE", init_type)
    end
  end

  self:LogDebug("Initialized!")
end

function T:OnEnable()
  self:LogInfo(L"ADDON_ENABLED")
end

function T:OnDisable()
  self:LogInfo(L"ADDON_DISABLED")
end

function T:AddInitializer(initializer)
  self.initializers[#self.initializers + 1] = initializer
end
