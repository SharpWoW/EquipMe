--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local L = T.I18n:Register("svSE", "Svenska (Sverige)", "Swedish (Sweden)")

-- svSE is not supported by the WoW client or WowAce, so we have to put the translations in this file manually

L["ADDON_ENABLED"] = "Aktiverad!"
L["ADDON_DISABLED"] = "Avaktiverad!"

L["AVAILABLE_COMMANDS"] = "Följande kommandon är tillgängliga:"
L["COMMAND_NOT_FOUND"] = "Hittade inget kommando som matchar %(arg)q"
L["MULTIPLE_COMMANDS_FOUND"] = "Flera kommandon matchar %(arg)q: %(matches)s"
L["COMMANDS_HELP_HELP"] = "Visar det här hjälpmeddelandet"
L["COMMANDS_OPTIONS_HELP"] = "Konfigurera tillägg"
L["COMMANDS_TESTLOG_HELP"] = "Testar loggsystemet"
L["COMMANDS_SAVE_HELP"] = "Sparar nuvarande utrustning till en ny uppsättning med namn <namn>"
L["COMMANDS_SAVE_MISSING_NAME"] = "Du måste ange ett namn för uppsättningen"
L["COMMANDS_LOAD_HELP"] = "Klär på tidigare sparad uppsättning vid namn <namn>"
L["COMMANDS_LOAD_MISSING_NAME"] = "Du måste ange namnet på uppsättningen som ska laddas"
L["COMMANDS_DELETE_HELP"] = "Tar bort den sparade uppsättningen vid namn <namn>"
L["COMMANDS_DELETE_MISSING_NAME"] = "Du måste ange namnet på den uppsättning du vill ta bort"

L["TEST_TRACE"] = "Testar trace-loggning"
L["TEST_DEBUG"] = "Testar debug-loggning"
L["TEST_INFO"] = "Testar info-loggning"
L["TEST_WARN"] = "Testar warn-loggning"
L["TEST_ERROR"] = "Testar error-loggning"

L["INVENTORY_SET_NOT_FOUND"] = "Kunde inte hitta uppsättning %(id)s (%(name)q)"
L["INVENTORY_SAVE_SAVED"] = "Sparade nuvarande utrustning till uppsättning %(name)q"
L["INVENTORY_DELETE_DELETED"] = "Tog bort uppsättning %(name)q"
L["INVENTORY_EQUIP_EQUIPPED"] = "Klädde på %(name)q"

L["OPTIONS_SHOW_NAME"] = "Visa konfigurationsfönster"
L["OPTIONS_SHOW_DESC"] = "Öppnar ett grafiskt gränssnitt för konfiguration av tillägget"
L["OPTIONS_GENERAL_NAME"] = "Generella inställningar"
L["OPTIONS_GENERAL_LOGLEVEL_NAME"] = "Loggnivå"
L["OPTIONS_GENERAL_LOGLEVEL_DESC"] = "Sätter minsta loggnivå som kommer skrivas ut"
L["OPTIONS_I18N_NAME"] = "Lokalisering"
L["OPTIONS_I18N_DESC"] = "Konfigurera inställningar relaterat till lokalisering"
L["OPTIONS_I18N_LANGUAGE_NAME"] = "Språk"
L["OPTIONS_I18N_LANGUAGE_DESC"] = "Ändra det språk som visas. För att slutföra ändring av språk krävs en omladdning av gränssnittet."
L["OPTIONS_I18N_LANGUAGE_RELOAD"] = "Gränssnittet måste laddas om för att slutföra språkändringar, gör detta nu?"
L["OPTIONS_PROFILES_NAME"] = "Profiler"

L["RELOAD_PROMPT"] = "Gränssnittet måste laddas om för att applicera ändringar, gör detta nu?"
L["RELOAD_UI"] = "Ladda om UI"
