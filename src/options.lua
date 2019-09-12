--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local L = T.I18n:Get()

local function make_translator(suffix)
  return function(info)
    local key = table.concat(info, '_'):upper()
    T:LogDebug("Options key is %s", key)
    return L[key .. suffix]
  end
end

local options = {
  name = NAME,
  type = "group",
  args = {
    name = make_translator("_NAME"),
    desc = make_translator("_DESC"),
    show = {
      type = "execute",
      guiHidden = true,
      func = function() T:OpenOptions() end
    },
    general = {
      type = "group",
      args = {
        loglevel = {
          type = "select",
          values = function() return T.logging.level_names end,
          get = function() return T.db.profile.logging.level end,
          set = function(_, value)
            T.db.profile.logging.level = value
          end,
          style = "dropdown"
        }
      }
    }
  }
}

local acd

function T:InitializeOptions()
  self:LogDebug("Initializing options...")

  options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

  LibStub("AceConfig-3.0"):RegisterOptionsTable(NAME, options)
  acd = LibStub("AceConfigDialog-3.0")
  acd:AddToBlizOptions(NAME, NAME, nil, "general")
  acd:AddToBlizOptions(NAME, "Profiles", NAME, "profiles")

  self:LogDebug("Options initialized!")
end

function T:OpenOptions()
  if not acd then return end
  self:LogDebug("Opening options")
  acd:Open(NAME)
end

T:AddInitializer("InitializeOptions")
