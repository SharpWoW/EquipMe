config = {
  whitelist_globals: {
    ["spec/"]: {
      "it", "describe", "setup", "teardown", "before_each", "after_each",
      "pending"
    }
  }
}

make_compat = (tbl) ->
  for k, v in pairs tbl
    if type(k) == "string" and k\match "/"
      tbl[k\gsub("/", "\\")] = v

    if type(v) == "table"
      make_compat v

  return tbl

return make_compat config
