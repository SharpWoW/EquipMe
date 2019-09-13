--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

describe("i18n", function()
  local i18n

  setup(function()
    local loader = require "spec/loader"
    loader.load("utils.lua")
    loader.load("i18n.lua")
    i18n = _G.EquipMe.I18n

    local enUS = i18n:Register("enUS", "English (US)", "English (US)", true)
    local svSE = i18n:Register("svSE", "Svenska (Sverige)", "Swedish (Sweden)")

    enUS["hello"] = "Hello"
    svSE["hello"] = "Hallå"

    enUS["greet"] = "Hello, %(name)s!"
    svSE["greet"] = "Hallå, %(name)s!"

    enUS["test_fallback"] = "English fallback"
    enUS["test_fallback_format"] = "Some %(thing)s"
  end)

  it("gets the correct default locale", function()
    assert.same("enUS", i18n:Get().code)
  end)

  it("gets the correct specific locale", function()
    assert.same("svSE", i18n:Get("svSE").code)
  end)

  it("gets a defined string in default locale", function()
    assert.same("Hello", i18n:Get()["hello"])
  end)

  it("gets a defined string in non-default locale", function()
    assert.same("Hallå", i18n:Get("svSE")["hello"])
  end)

  it("fallbacks to correct default locale", function()
    assert.same("English fallback", i18n:Get("svSE")["test_fallback"])
  end)

  it("formats a string when called", function()
    assert.same("Hello, Foobar!", i18n:Get()("greet", { name = "Foobar" }))
  end)

  it("formats a string in non-default locale when called", function()
    assert.same("Hallå, Svensson!", i18n:Get("svSE")("greet", { name = "Svensson" }))
  end)

  it("formats a fallback string", function()
    assert.same("Some cheese", i18n:Get("svSE")("test_fallback_format", { thing = "cheese" }))
  end)

  it("notifies about missing strings", function()
    assert.same("!!!DOES_NOT_EXIST!!!", i18n:Get()["does_not_exist"])
  end)

  it("notifies about missing strings from non-default locale", function()
    local l = i18n:Get("svSE")
    assert.same("!!!DOES_NOT_EXIST!!!", l["does_not_exist"])
  end)

  it("can get strings via i18n __index", function()
    assert.same("Hello", i18n["hello"])
  end)

  it("can get strings via i18n __call", function()
    assert.same("Hello", i18n("hello"))
  end)

  it("can format strings via i18n __call", function()
    assert.same("Hello, Foobar!", i18n("greet", { name = "Foobar" }))
  end)

  it("can format if supplied only a table", function()
    assert.same("Hello, Foobar!", i18n({ "greet", name = "Foobar" }))
  end)
end)
