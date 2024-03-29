--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local FALLBACK_CODE = "enUS"

-- Create upvalues in case locale code is called from performance-critical
-- code.
local GetLocale = GetLocale
local interpolate = T.utils.interpolate
local setmetatable = setmetatable
local type = type
local pairs = pairs

local i18n = {
  current = nil,
  locales = {},
  aliases = {}
}

local i18n_mt = {
  __index = function(tbl, key)
    return tbl:Get()[key]
  end,
  __call = function(tbl, ...)
    return tbl:Get()(...)
  end
}

local function transform_key(key)
  if type(key) == "string" then return key:upper() end
  return key
end

local locale_mt = {
  -- L["MY_STRING"]
  __index = function(locale, key)
    return (locale:Resolve(transform_key(key)))
  end,

  -- L["MY_STRING"] = "My translation"
  __newindex = function(locale, key, value)
    locale.strings[transform_key(key)] = value
  end,

  -- L("MY_STRING")
  -- L("MY_STRING", { key = "format", foo = "args" })
  -- L { "MY_STRING", key = "format, foo = "args" }
  __call = function(locale, key, args)
    if type(key) == "table" then
      args = key
      key = args[1]
    end

    local resolved = (locale:Resolve(transform_key(key)))
    if not args then return resolved end
    return interpolate(resolved, args)
  end,

  -- tostring(L)
  -- print(L)
  __tostring = function(locale) return locale.code end
}

function i18n:Initialize()
  self.current = T.db.global.i18n.code
end

function i18n:Register(code, name, english_name, is_default)
  local locale = {}

  locale.code = code
  locale.name = name
  locale.english_name = english_name
  locale.is_default = is_default == true
  locale.strings = {}

  if is_default then
    locale.Resolve = function(tbl, key)
      key = transform_key(key)
      if tbl.strings[key] then
        return tbl.strings[key], true
      else
        return "!!!" .. key .. "!!!", false
      end
    end
  else
    locale.Resolve = function(tbl, key)
      key = transform_key(key)
      if tbl.strings[key] then
        return tbl.strings[key], true
      else
        return self:GetDefault()[key]
      end
    end
  end

  locale.HasKey = function(tbl, key)
    local _, found = tbl:Resolve(transform_key(key))
    return found
  end

  locale.TryGet = locale.Resolve

  self.locales[code] = setmetatable(locale, locale_mt)
  return self.locales[code]
end

function i18n:RegisterAlias(from, to)
  self.aliases[from] = to
end

function i18n:Has(code)
  return type(self.locales[code] ~= "nil")
end

function i18n:GetDefaultCode()
  for code, locale in pairs(self.locales) do
    if locale.is_default then
      return code
    end
  end

  return FALLBACK_CODE
end

function i18n:GetCurrentCode()
  return self:Get().code
end

function i18n:Get(code)
  if not code then
    -- Avoid infinite recursion by the __index metaevent if `current` has not
    -- been initialized yet.
    local current = rawget(self, "current")
    code = current or GetLocale()
  end

  if not self.locales[code] then code = self:GetDefaultCode() end

  return self.locales[self.aliases[code] or code]
end

function i18n:Set(code)
  self.current = code
  T.db.global.i18n.code = code
end

function i18n:GetDefault()
  return self.locales[self:GetDefaultCode()]
end

function i18n:GetCodes(include_aliases)
  local codes = {}
  for k, _ in pairs(self.locales) do
    codes[#codes + 1] = k
  end
  if include_aliases then
    for k, _ in pairs(self.aliases) do
      codes[#codes + 1] = k
    end
  end
  return codes
end

setmetatable(i18n, i18n_mt)

T.I18n = i18n
