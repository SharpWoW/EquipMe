--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local loader = {}

_G.EquipMe = {}
_G.EquipMe_NAME = "EquipMe"

_G.GetLocale = function() return "enUS" end

function loader.load(file)
  return assert(loadfile("src/" .. file))(_G.EquipMe_NAME, _G.EquipMe)
end

return loader
