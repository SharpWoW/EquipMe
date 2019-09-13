--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local DB_NAME = NAME .. "DB"

local defaults = {
  global = {
    i18n = {
      code = GetLocale()
    }
  },
  profile = {
    logging = {
      level = T.logging.levels.INFO
    }
  }
}

function T:InitializeDb()
  self:LogDebug("Initializing DB")
  self.db = LibStub("AceDB-3.0"):New(DB_NAME, defaults, true)
  self:LogDebug("DB initialized")
end
