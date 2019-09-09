--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local utils = {}

function utils.trim(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

function utils.split(str)
  local result = {}
  for token in string.gmatch(str, "[^%s]+") do
    result[#result + 1] = token
  end
  return result
end

T.utils = utils
