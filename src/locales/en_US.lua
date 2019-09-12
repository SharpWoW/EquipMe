--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local i18n = T.I18n

local L = i18n:Register("enUS", "English (US)", "English (US)", true)

L["hello"] = "Hello, World!"

i18n:RegisterAlias("enGB", "enUS")
