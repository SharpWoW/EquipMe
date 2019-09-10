stds.wow = {
  globals = {
    SlashCmdList = {
      other_fields = true
    }
  },
  read_globals = {
    'CreateFrame',
    'GetLocale'
  }
}

std = 'lua51+wow'
max_line_length = 120

exclude_files = {
  'lib/LibDataBroker-1-1/**/*.lua'
}
