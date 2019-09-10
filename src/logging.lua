--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...
local utils = T.utils
local colorize = utils.colorize
local L = T.i18n:get()

local print = print
local select = select
local sprintf = string.format

local NAME_COLOR = utils.colors.BLUE
local MSG_FORMAT = sprintf("%s %s%%s%s %%s", colorize(NAME, NAME_COLOR), colorize("[", "GRAY"), colorize("]", "GRAY"))

local logging = {
  levels = {
    DEBUG = 0,
    INFO = 1,
    WARN = 2,
    ERROR = 3
  },
  level_names = {}
}

logging.level = logging.levels.INFO

local COLORS = {
  NAME = NAME_COLOR,
  LEVELS = {
    [logging.levels.DEBUG] = utils.colors.GREEN,
    [logging.levels.INFO] = utils.colors.WHITE,
    [logging.levels.WARN] = utils.colors.YELLOW,
    [logging.levels.ERROR] = utils.colors.RED
  }
}

local FORMATS = {}

local function format(message, ...)
  if select("#", ...) < 1 then return message end
  return sprintf(message, ...)
end

function logging:log(level, message, ...)
  if level < self.level then return end
  local localized, found = L:try_get(message)
  if found then
    message = localized
  end
  local formatted = format(message, ...)
  local level_format = FORMATS[level]
  local msg = sprintf(level_format, formatted)
  print(msg)
end

for level_name, level in pairs(logging.levels) do
  logging.level_names[level] = level_name
  logging[level_name:lower()] = function(self, message, ...)
    self:log(level, message, ...)
  end
  local color = COLORS.LEVELS[level]
  FORMATS[level] = sprintf(MSG_FORMAT, colorize(level_name, color), "%s")
end

T.logging = logging
