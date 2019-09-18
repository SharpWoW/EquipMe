--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local L = T.I18n

local function translator(path)
  return function()
    local key = "OPTIONS_" .. path
    return L[key]
  end
end

local acd

function T:InitializeOptions()
  self:LogDebug("Initializing options...")

  local options = {
    name = NAME,
    type = "group",
    args = {
      show = {
        name = translator "SHOW_NAME",
        desc = translator "SHOW_DESC",
        type = "execute",
        guiHidden = true,
        func = function() T:OpenOptions() end
      },
      general = {
        name = translator "GENERAL_NAME",
        type = "group",
        args = {
          loglevel = {
            name = translator "GENERAL_LOGLEVEL_NAME",
            desc = translator "GENERAL_LOGLEVEL_DESC",
            type = "select",
            values = function() return T.logging.level_names end,
            get = function() return T.db.profile.logging.level end,
            set = function(_, value)
              T.db.profile.logging.level = value
              T:Log(value, L { "OPTIONS_GENERAL_LOGLEVEL_SET", level = T.logging.level_names[value] })
            end,
            style = "dropdown"
          }
        }
      },
      i18n = {
        name = translator "I18N_NAME",
        desc = translator "I18N_DESC",
        type = "group",
        args = {
          language = {
            name = translator "I18N_LANGUAGE_NAME",
            desc = translator "I18N_LANGUAGE_DESC",
            type = "select",
            values = function()
              local codes = L:GetCodes()
              local result = {}
              for _, code in pairs(codes) do
                local name = L:Get(code).name
                result[code] = name
              end
              return result
            end,
            get = function()
              return L:GetCurrentCode()
            end,
            set = function(_, value)
              L:Set(value)
              T.gui:ShowReloadDialog(L"OPTIONS_I18N_LANGUAGE_RELOAD")
            end,
            style = "dropdown"
          }
        }
      },
      profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    }
  }

  local ac = LibStub("AceConfig-3.0")
  ac:RegisterOptionsTable(NAME, options)
  acd = LibStub("AceConfigDialog-3.0")
  acd:AddToBlizOptions(NAME, NAME, nil, "general")
  acd:AddToBlizOptions(NAME, L"OPTIONS_I18N_NAME", NAME, "i18n")
  acd:AddToBlizOptions(NAME, L"OPTIONS_PROFILES_NAME", NAME, "profiles")

  self:LogDebug("Options initialized!")
end

function T:OpenOptions()
  if not acd then return end
  self:LogDebug("Opening options")
  acd:Open(NAME)
end
