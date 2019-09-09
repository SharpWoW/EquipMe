--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local trim = T.utils.trim
local split = T.utils.split

local log = T.logging

local slash_aliases = { NAME:lower() }
local commands = {}

local function register(aliases, callback)
  if type(aliases) ~= 'table' then aliases = {aliases} end
  for _, alias in pairs(aliases) do
    commands[alias] = callback
  end
end

register('help', function()
  log:info('TODO: Put help here')
end)

register('hello', function(_, name)
  log:info('Hello to yourself, %s!', name or 'Unknown')
end)

register('echo', function(msg)
  log:info(msg)
end)

register('ab', function(_, a, b)
  log:info("AB test: %s %s", a, b)
end)

for i, alias in ipairs(slash_aliases) do
  _G['SLASH_' .. NAME:upper() .. i] = '/' .. alias
end

SlashCmdList[NAME:upper()] = function(msg, _)
  msg = trim(msg)
  local args = split(msg)

  if #args < 1 then
    return commands['help']('')
  end

  local pattern = '^' .. args[1]
  table.remove(args, 1)

  local matches = {}
  for k, _ in pairs(commands) do
    if k:match(pattern) then matches[#matches + 1] = k end
  end

  if #matches == 0 then
    return log:error('No command found that matches "%s"', args[1])
  end

  if #matches == 1 then
    return commands[matches[1]](msg, unpack(args))
  end

  matches = table.concat(matches, ', ')
  log:error('Multiple commands match "%s": %s', args[1], matches)
end
