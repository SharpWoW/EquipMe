stds.wow = {
  globals = {
    SlashCmdList = {
      other_fields = true
    }
  },
  read_globals = {
    "CreateFrame",
    "DEFAULT_CHAT_FRAME",
    "GameTooltip",
    "GetLocale",
    "IsControlKeyDown",
    "IsShiftKeyDown",
    "SlashCmdList"
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
      "211/L"
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
  "extern"
}
