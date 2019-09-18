--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local L = T.I18n

_G[NAME] = T

local embeds = {
  "AceConsole-3.0",
  "AceEvent-3.0"
}

LibStub("AceAddon-3.0"):NewAddon(T, NAME, unpack(embeds))

function T:OnInitialize()
  self:LogDebug("Initializing...")

  self:InitializeDb()
  L:Initialize()
  self:InitializeOptions()
  self:InitializeEvents()
  self:InitializeCommands()
  self:InitializeBroker()
  self.character:Initialize()

  self:LogDebug("Initialized!")
end

function T:OnEnable()
  self:LogInfo(L"ADDON_ENABLED")
end

function T:OnDisable()
  self:LogInfo(L"ADDON_DISABLED")
end
