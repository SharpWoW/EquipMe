-- Copyright © 2019 by Adam Hellberg.
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

export EquipMe = {}
export EquipMe_NAME = "EquipMe"

export GetLocale = -> "enUS"

export strtrim = (str using nil) ->
  if not str then return nil
  (str:gsub("^%s*(.-)%s*$", "%1"))

export strsplit = (str using nil) ->
  [token for token in string.gmatch str, "%S+"]

load = (file using EquipMe, EquipMe_NAME) ->
  assert(loadfile("src/" .. file))(EquipMe_NAME, EquipMe)

{ :load }
