--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...
local utils = T.utils
local colorize = utils.colorize

local select = select
local sformat = string.format

local NAME_COLOR = utils.colors.AQUA

local logging = {
  levels = {
    TRACE = -1,
    DEBUG = 0,
    INFO = 1,
    WARN = 2,
    ERROR = 3
  },
  level_names = {}
}

local DEFAULT_THRESHOLD = logging.levels.INFO

--@debug@
DEFAULT_THRESHOLD = logging.levels.DEBUG
--@end-debug@

local COLORS = {
  NAME = NAME_COLOR,
  LEVELS = {
    [logging.levels.TRACE] = utils.colors.SILVER,
    [logging.levels.DEBUG] = utils.colors.GREEN,
    [logging.levels.INFO] = utils.colors.WHITE,
    [logging.levels.WARN] = utils.colors.YELLOW,
    [logging.levels.ERROR] = utils.colors.RED
  }
}

for level_name, level in pairs(logging.levels) do
  logging.level_names[level] = level_name
end

local left_brace = colorize("[", "GRAY")
local right_brace = colorize("]", "GRAY")
local levels = logging.levels
local lcolors = COLORS.LEVELS

local FORMATS = {
  [levels.TRACE] = sformat(
    "%s%s%s %%s",
    left_brace,
    colorize("TRACE", lcolors[levels.TRACE]),
    right_brace),
  [levels.DEBUG] = sformat(
    "%s%s%s %%s",
    left_brace,
    colorize("DEBUG", lcolors[levels.DEBUG]),
    right_brace),
  [levels.INFO] = "%s",
  [levels.WARN] = sformat(
    "%s%s%s %%s",
    left_brace,
    colorize("WARN", lcolors[levels.WARN]),
    right_brace),
  [levels.ERROR] = sformat(
    "%s%s%s %%s",
    left_brace,
    colorize("ERROR", lcolors[levels.ERROR]),
    right_brace)
}

local function format(message, ...)
  if select("#", ...) < 1 then return message end
  return sformat(message, ...)
end

function T:GetLogLevel()
  local level = self.db and self.db.profile.logging.level or DEFAULT_THRESHOLD
  local name = logging.level_names[level]
  return level, name
end

function T:SetLogLevel(level)
  self.db.profile.logging.level = level
end

function T:Log(level, message, ...)
  -- Default to INFO if db hasn't been initialized yet
  local threshold = self:GetLogLevel()
  if level < threshold then return end
  local formatted = format(message, ...)
  local level_format = FORMATS[level]
  self:Printf(level_format, formatted)
end

function T:LogTrace(message, ...)
  self:Log(logging.levels.TRACE, message, ...)
end

function T:LogDebug(message, ...)
  self:Log(logging.levels.DEBUG, message, ...)
end

function T:LogInfo(message, ...)
  self:Log(logging.levels.INFO, message, ...)
end

function T:LogWarn(message, ...)
  self:Log(logging.levels.WARN, message, ...)
end

function T:LogError(message, ...)
  self:Log(logging.levels.ERROR, message, ...)
end

function T:IsTraceEnabled()
  return self:GetLogLevel() <= logging.levels.TRACE
end

function T:IsDebugEnabled()
  return self:GetLogLevel() <= logging.levels.DEBUG
end

function T:IsInfoEnabled()
  return self:GetLogLevel() <= logging.levels.INFO
end

function T:IsWarnEnabled()
  return self:GetLogLevel() <= logging.levels.WARN
end

function T:IsErrorEnabled()
  return self:GetLogLevel() <= logging.levels.ERROR
end

T.logging = logging
