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

L["AVAILABLE_COMMANDS"] = "The following commands are available:"
L["COMMAND_NOT_FOUND"] = "No command found that matches %(arg)q"
L["MULTIPLE_COMMANDS_FOUND"] = "Multiple commands match %(arg)s: %(matches)s"
L["COMMANDS_HELP_HELP"] = "Shows this help message"
L["COMMANDS_OPTIONS_HELP"] = "Configure AddOn"
L["COMMANDS_TESTLOG_HELP"] = "Tests the log system"
L["COMMANDS_SAVE_HELP"] = "Saves current equipment into a new set with name <name>"
L["COMMANDS_SAVE_MISSING_NAME"] = "You must provide a name for the set"
L["COMMANDS_LOAD_HELP"] = "Equips the previously saved equipment set <name>"
L["COMMANDS_LOAD_MISSING_NAME"] = "You must specify the name of the set to load"
L["COMMANDS_DELETE_HELP"] = "Deletes the saved set <name>"
L["COMMANDS_DELETE_MISSING_NAME"] = "You must specify the name of the set you wish to delete"

L["TEST_TRACE"] = "Testing the trace logging"
L["TEST_DEBUG"] = "Testing the debug logging"
L["TEST_INFO"] = "Testing the info logging"
L["TEST_WARN"] = "Testing the warn logging"
L["TEST_ERROR"] = "Testing the error logging"

L["INVENTORY_SET_NOT_FOUND"] = "Couldn't find set %(id)s (%(name)q)"
L["INVENTORY_SAVE_SAVED"] = "Save current equipment to set %(name)q"
L["INVENTORY_DELETE_DELETED"] = "Deleted set %(name)q"
L["INVENTORY_EQUIP_EQUIPPED"] = "Equipped %(name)q"

L["OPTIONS_SHOW_NAME"] = "Show options window"
L["OPTIONS_SHOW_DESC"] = "Opens the GUI interface for configuring"
L["OPTIONS_GENERAL_NAME"] = "General options"
L["OPTIONS_GENERAL_LOGLEVEL_NAME"] = "Log level"
L["OPTIONS_GENERAL_LOGLEVEL_DESC"] = "Sets the minimum log level that will print"
L["OPTIONS_I18N_NAME"] = "Localization"
L["OPTIONS_I18N_DESC"] = "Configure settings related to localization"
L["OPTIONS_I18N_LANGUAGE_NAME"] = "Language"
L["OPTIONS_I18N_LANGUAGE_DESC"] = "Sets the language to be used. Changing this setting requires a UI reload to take full effect."
L["OPTIONS_I18N_LANGUAGE_RELOAD"] = "The UI must be reloaded to apply language changes, do so now?"
L["OPTIONS_PROFILES_NAME"] = "Profiles"

L["RELOAD_PROMPT"] = "The UI needs to be reloaded to apply changes, do so now?"
L["RELOAD_UI"] = "Reload UI"

i18n:RegisterAlias("enGB", "enUS")
