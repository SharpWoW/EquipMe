--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local i18n = T.i18n

-- Blizzard/CurseForge/WoWAce shows esMX as "Latin American Spanish" while the official name is Mexican Spanish
local L = i18n:register("esMX", "Español (México)", "Spanish (Latin American Spanish)")

--@localization(locale="esMX", format="lua_additive_table", handle-subnamespaces="concat", namespace-delimiter=".")
