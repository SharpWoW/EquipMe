--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local FALLBACK_CODE = 'enUS'

-- Create upvalues in case locale code is called from performance-critical
-- code.
local select = select
local GetLocale = _G.GetLocale
local sprintf = string.format
local setmetatable = setmetatable
local type = type
local pairs = pairs

local i18n = {
  current = nil,
  locales = {}
}

local locale_mt = {
  __index = function(locale, key)
    return locale:resolve(key)
  end,
  __newindex = function(locale, key, value)
    locale.strings[key] = value
  end,
  __call = function(locale, key, ...)
    if select('#', ...) < 1 then return locale:resolve(key) end
    return sprintf(locale:resolve(key), ...)
  end,
  __tostring = function(locale)
    return locale.code
  end
}

function i18n:register(code, name, english_name, is_default)
  local locale = {}

  locale.code = code
  locale.name = name
  locale.english_name = english_name
  locale.is_default = is_default == true
  locale.strings = {}

  if is_default then
    locale.resolve = function(tbl, key)
      if tbl.strings[key] then
        return tbl.strings[key]
      else
        return 'MISSING STRING: ' .. key
      end
    end
  else
    locale.resolve = function(tbl, key)
      if tbl.strings[key] then
        return tbl.strings[key]
      else
        return self:get_default()[key]
      end
    end
  end

  self.locales[code] = setmetatable(locale, locale_mt)
  return self.locales[code]
end

function i18n:has(code)
  return type(self.locales[code] ~= 'nil')
end

function i18n:get_default_code()
  --print('Getting default code')
  for code, locale in pairs(self.locales) do
    if locale.is_default then
      return code
    end
  end

  return FALLBACK_CODE
end

function i18n:get(code)
  if not code then
    code = GetLocale()
  end

  code = code or self:get_default_code()

  return self.locales[code]
end

function i18n:get_default()
  --print('Getting default')
  return self.locales[self:get_default_code()]
end

T.i18n = i18n
