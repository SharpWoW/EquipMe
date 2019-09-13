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
    "GameTooltip",
    "GetLocale",
    "IsControlKeyDown",
    "IsShiftKeyDown",
    "SlashCmdList",
    "StaticPopup_Show"
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
