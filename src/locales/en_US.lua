--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local i18n = T.I18n

local L = i18n:Register("enUS", "English (US)", "English (US)", true)

L["ADDON_ENABLED"] = "Enabled!"
L["ADDON_DISABLED"] = "Disabled!"

L["INITIALIZER_NOT_FOUND"] = 'Initializer "%s" was not found'
L["UNSUPPORTED_INITIALIZER_TYPE"] = 'Unsupported initializer type: "%s"'

L["AVAILABLE_COMMANDS"] = "The following commands are available:"
L["COMMAND_NOT_FOUND"] = 'No command found that matches "%s"'
L["MULTIPLE_COMMANDS_FOUND"] = 'Multiple commands match "%s": %s'
L["COMMANDS_HELP_HELP"] = "Shows this help message"
L["COMMANDS_OPTIONS_HELP"] = "Configure AddOn"
L["COMMANDS_TESTLOG_HELP"] = "Tests the log system"

L["TEST_TRACE"] = "Testing the trace logging"
L["TEST_DEBUG"] = "Testing the debug logging"
L["TEST_INFO"] = "Testing the info logging"
L["TEST_WARN"] = "Testing the warn logging"
L["TEST_ERROR"] = "Testing the error logging"

L["OPTIONS_SHOW_NAME"] = "Show options window"
L["OPTIONS_SHOW_DESC"] = "Opens the GUI interface for configuring"
L["OPTIONS_GENERAL_NAME"] = "General options"
L["OPTIONS_GENERAL_LOGLEVEL_NAME"] = "Log level"
L["OPTIONS_GENERAL_LOGLEVEL_DESC"] = "Sets the minimum log level that will print"

i18n:RegisterAlias("enGB", "enUS")
