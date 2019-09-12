--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local options = {
  name = "EquipMe",
  type = "group",
  args = {
    show = {
      name = "Show options window",
      desc = "Opens the GUI interface for configuring",
      type = "execute",
      guiHidden = true,
      func = function() T:OpenOptions() end
    },
    general = {
      name = "General options",
      type = "group",
      args = {
        log_level = {
          name = "Log level",
          desc = "Sets the minimum log level that will print",
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
  options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

  LibStub("AceConfig-3.0"):RegisterOptionsTable(NAME, options)
  acd = LibStub("AceConfigDialog-3.0")
  acd:AddToBlizOptions(NAME, NAME, nil, "general")
  acd:AddToBlizOptions(NAME, "Profiles", NAME, "profiles")
end


function T:OpenOptions()
  if not acd then return end
  acd:Open(NAME)
end

T:AddInitializer("InitializeOptions")
