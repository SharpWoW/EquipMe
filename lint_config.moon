config = {
  whitelist_globals: {
    ["**"]: {},
    ["spec/"]: {
      "it", "describe", "setup", "teardown", "before_each", "after_each",
      "pending"
    }
  }
}

luacheckrc = setmetatable {}, __index: _G
luacheckrc.stds = {}
assert pcall setfenv assert(loadfile(".luacheckrc")), luacheckrc
setmetatable luacheckrc, nil

add_globals = (tbl using config) ->
  for k, v in pairs tbl
    if type(v) == "table"
      table.insert config.whitelist_globals["**"], k
    else
      table.insert config.whitelist_globals["**"], v

find_globals = (tbl using nil) ->
  for k, v in pairs tbl
    if k == "globals" or k == "read_globals"
      add_globals v
    elseif type(v) == "table"
      find_globals v

find_globals luacheckrc

make_compat = (tbl using nil) ->
  for k, v in pairs tbl
    if type(k) == "string" and k\match "/"
      tbl[k\gsub("/", "\\")] = v

    if type(v) == "table"
      make_compat v

  tbl

make_compat config
