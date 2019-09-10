--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local icon = LibStub:GetLibrary("LibDBIcon-1.0")

local broker = {}

local data = {
  label = NAME,
  icon = "Interface\\AddOns\\EquipMe\\images\\logo_broker.tga",
  tocname = NAME
}

local obj = ldb:NewDataObject("Broker_" .. NAME, data)

function broker:init()
  icon:Register(NAME, obj, nil)
end

function broker:set_minimap(enabled)
  if enabled then
    icon:Show(NAME)
  else
    icon:Hide(NAME)
  end
end

T.broker = broker
