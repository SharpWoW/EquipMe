--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local lua_sformat = string.format
local lua_gsub = string.gsub
local type = type
local tinsert = table.insert

local utils = {
  colors = {
    WHITE = "FFFFFF",
    NAVY = "001f3f",
    BLUE = "0074D9",
    AQUA = "7FDBFF",
    TEAL = "39CCCC",
    OLIVE = "3D9970",
    GREEN = "2ECC40",
    LIME = "01FF70",
    YELLOW = "FFDC00",
    ORANGE = "FF851B",
    RED = "FF4136",
    MAROON = "85144b",
    FUCHSIA = "F012BE",
    PURPLE = "B10DC9",
    BLACK = "111111",
    GRAY = "AAAAAA",
    SILVER = "DDDDDD"
  }
}

function utils.foreach(tbl, func)
  for _, v in pairs(tbl) do func(v) end
end

function utils.map(tbl, func)
  local result = {}
  for k, v in pairs(tbl) do
    result[k] = func(v)
  end
  return result
end

function utils.filter(tbl, predicate)
  local result = {}
  for k, v in pairs(tbl) do
    if predicate(v) then
      if type(k) == "number" then
        tinsert(result, v)
      else
        result[k] = v
      end
    end
  end
  return result
end

function utils.contains(tbl, value)
  for _, v in pairs(tbl) do
    if v == value then return true end
  end
  return false
end

local INTERP_PATTERN = "%%%((%a%w*)%)([-0-9%.]*[cdeEfgGiouxXsq])"
function utils.interpolate(str, data)
  if not data then
    data = str
    str = data[1]
  end

  local replacer = function(k, fmt)
    if data[k] then
      return lua_sformat("%" .. fmt, data[k])
    end
    return "%(" .. k .. ")" .. fmt
  end

  return (lua_gsub(str, INTERP_PATTERN, replacer))
end

utils.trim = strtrim
utils.split = strsplit

local function resolve_color(color)
  if type(color) ~= "string" then return nil end
  color = color:upper()
  color = utils.colors[color] or color
  return color
end

function utils.colorize(str, color)
  color = resolve_color(color)
  if not color then return str end
  return lua_sformat("|cff%s%s|r", color, tostring(str))
end

T.utils = utils
