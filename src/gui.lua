--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local NAME, T = ...

local L = T.I18n

local DIALOG_PREFIX = NAME:upper() .. "_DIALOG_"

local gui = {}

local function get_or_create_dialog(name, tbl)
  local id = DIALOG_PREFIX .. name
  tbl.id = id
  if StaticPopupDialogs[id] then return StaticPopupDialogs[id] end
  StaticPopupDialogs[id] = tbl
  return tbl
end

local function show_dialog(dialog)
  return StaticPopup_Show(dialog.id)
end

function gui:ShowReloadDialog(message)
  message = message or L"RELOAD_PROMPT"

  local dialog = get_or_create_dialog("RELOAD_PROMPT", {
    button1 = L"RELOAD_UI",
    button2 = CANCEL,
    OnAccept = function() C_UI.Reload() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true
  })

  dialog.text = message

  show_dialog(dialog)
end

T.gui = gui
