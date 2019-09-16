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

_G.strtrim = function(str)
  if not str then return nil end
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

_G.strsplit = function(str)
  local result = {}
  for token in string.gmatch(str, "%S+") do
    result[#result + 1] = token
  end
  return result
end

function loader.load(file)
  return assert(loadfile("src/" .. file))(_G.EquipMe_NAME, _G.EquipMe)
end

return loader
