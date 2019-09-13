--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local colorize = T.utils.colorize
local trim = T.utils.trim

local L = T.I18n

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
  T:LogInfo(L"AVAILABLE_COMMANDS")
  local slash = "/" .. NAME:lower()
  for k, command in pairs(commands) do
    local full = colorize(("%s %s"):format(slash, k), "GREEN")
    if command.description then
      T:LogInfo("%s - %s", full, command.description)
    else
      T:LogInfo(full)
    end
  end
end, L"COMMANDS_HELP_HELP")

register("options", function(input)
  LibStub("AceConfigCmd-3.0").HandleCommand(T, NAME:lower() .. " options", NAME, input)
end, L"COMMANDS_OPTIONS_HELP")

register("testlog", function()
  T:LogTrace(L"TEST_TRACE")
  T:LogDebug(L"TEST_DEBUG")
  T:LogInfo(L"TEST_INFO")
  T:LogWarn(L"TEST_WARN")
  T:LogError(L"TEST_ERROR")
end, L"COMMANDS_TESTLOG_HELP")

function T:InitializeCommands()
  self:LogDebug("Initializing commands...")
  self:RegisterChatCommand(NAME:lower(), "ChatCommand")
  self:LogDebug("Commands initialized!")
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
      return T:LogError(L { "COMMAND_NOT_FOUND", arg = arg })
    end

    if #matches == 1 then
      local rest = input:sub(next)
      return commands[matches[1]].handler(rest)
    end

    matches = table.concat(matches, ", ")
    T:LogInfo(L { "MULTIPLE_COMMANDS_FOUND", arg = arg, matches = matches })
  else
    commands["help"].handler("")
  end
end
