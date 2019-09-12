--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local colorize = T.utils.colorize
local trim = T.utils.trim

local commands = {}

local function register(aliases, handler, description)
  if type(aliases) ~= "table" then aliases = {aliases} end
  for _, alias in pairs(aliases) do
    commands[alias:lower()] = {
      handler = handler,
      description = description
    }
  end
end

register("help", function()
  T:LogInfo("The following commands are available:")
  local slash = "/" .. NAME:lower()
  for k, command in pairs(commands) do
    local full = colorize(("%s %s"):format(slash, k), "GREEN")
    if command.description then
      T:LogInfo("%s - %s", full, command.description)
    else
      T:LogInfo(full)
    end
  end
end, "Shows this help message")

register("options", function(input)
  LibStub("AceConfigCmd-3.0").HandleCommand(T, NAME:lower() .. " options", NAME, input)
end, "Configure AddOn")

register("testlog", function()
  T:LogTrace("Testing the trace logging")
  T:LogDebug("Testing the debug logging")
  T:LogInfo("Testing the info logging")
  T:LogWarn("Testing the warn logging")
  T:LogError("Testing the error logging")
end, "Tests the log system")

function T:InitializeCommands()
  self:RegisterChatCommand(NAME:lower(), "ChatCommand")
end

function T:ChatCommand(input)
  input = trim(input) or ""

  local arg, next = self:GetArgs(input, 1)

  if arg then
    local pattern = "^" .. arg:lower()
    local matches = {}
    for k, _ in pairs(commands) do
      if k:match(pattern) then matches[#matches + 1] = k end
    end

    if #matches == 0 then
      return T:LogError('No command found that matches "%s"', arg)
    end

    if #matches == 1 then
      local rest = input:sub(next)
      return commands[matches[1]].handler(rest)
    end

    matches = table.concat(matches, ", ")
    T:LogInfo('Multiple commands match "%s": %s', arg, matches)
  else
    commands["help"].handler("")
  end
end

T:AddInitializer("InitializeCommands")
