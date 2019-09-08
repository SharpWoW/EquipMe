--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local sprintf = string.format

local MSG_FORMAT = sprintf('%s [%%s] %%s', NAME)

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

local function format(message, ...)
  if select('#', ...) < 1 then return message end
  return sprintf(message, ...)
end

function logging:log(level, message, ...)
  if level < self.level then return end
  local formatted = format(message, ...)
  local msg = sprintf(MSG_FORMAT, self.level_names[level], formatted)
  print(msg)
end

for level_name, level in pairs(logging.levels) do
  logging.level_names[level] = level_name
  logging[level_name:lower()] = function(self, message, ...)
    self:log(level, message, ...)
  end
end

T.logging = logging
