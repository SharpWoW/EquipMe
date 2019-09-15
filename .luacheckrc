stds.wow = {
  globals = {
    SlashCmdList = {
      other_fields = true
    },
    "StaticPopupDialogs"
  },
  read_globals = {
    "C_UI",
    "CANCEL",
    "CreateFrame",
    "DEFAULT_CHAT_FRAME",
    "EquipItemByName",
    "GameTooltip",
    "GetInventoryItemLink",
    "GetItemInfo",
    "GetLocale",
    "IsControlKeyDown",
    "IsShiftKeyDown",
    "SlashCmdList",
    "StaticPopup_Show",
    "strtrim",
    "wipe",
    "INVSLOT_TRINKET2",
    "INVSLOT_NECK",
    "INVSLOT_CHEST",
    "INVSLOT_LEGS",
    "INVSLOT_BODY",
    "INVSLOT_FIRST_EQUIPPED",
    "INVSLOT_SHOULDER",
    "INVSLOT_OFFHAND",
    "INVSLOT_HEAD",
    "INVSLOT_HAND",
    "INVSLOT_WAIST",
    "INVSLOT_BACK",
    "INVSLOT_AMMO",
    "INVSLOTS_EQUIPABLE_IN_COMBAT",
    "INVSLOT_RANGED",
    "INVSLOT_TABARD",
    "INVSLOT_FINGER1",
    "INVSLOT_MAINHAND",
    "INVSLOT_FINGER2",
    "INVSLOT_LAST_EQUIPPED",
    "INVSLOT_WRIST",
    "INVSLOT_FEET",
    "INVSLOT_TRINKET1"
  }
}

stds.externs = {
  read_globals = {
    "LibStub"
  }
}

std = "lua51+wow+externs"
max_line_length = 120

files = {
  ["src/**.lua"] = {
    ignore = {
      "212"
    }
  },
  ["src/locales/*.lua"] = {
    ignore = {
      "211/L",
      "631"
    }
  },
  ["src/logging.lua"] = {
    ignore = {
      "311/DEFAULT_THRESHOLD"
    }
  }
}

exclude_files = {
  "lib/LibDataBroker-1-1",
  "extern",
  "out"
}
