stds.wow = {
  globals = {
    SlashCmdList = {
      other_fields = true
    }
  },
  read_globals = {
    "CreateFrame",
    "GetLocale"
  }
}

stds.externs = {
  read_globals = {
    "LibStub"
  }
}

std = "lua51+wow+externs"
max_line_length = 120

exclude_files = {
  "lib/LibDataBroker-1-1/**/*.lua"
}
