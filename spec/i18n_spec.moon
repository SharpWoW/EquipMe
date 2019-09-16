-- Copyright © 2019 by Adam Hellberg.
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

describe "i18n", ->
  local i18n

  setup ->
    import load from require "spec.loader"
    load "utils.lua"
    load "i18n.lua"
    { I18n: i18n } = _G.EquipMe

    with i18n\Register "enUS", "English (US)", "English (US)", true
      ["hello"] = "Hello"
      ["greet"] = "Hello, %(name)s!"
      ["test_fallback"] = "English fallback"
      ["test_fallback_format"] = "Some %(thing)s"

    with i18n\Register "svSE", "Svenska (Sverige)", "Swedish (Sweden)"
      ["hello"] = "Hallå"
      ["greet"] = "Hallå, %(name)s!"

  it "gets the correct default locale", ->
    assert.same "enUS", i18n\Get().code

  it "gets the correct specific locale", ->
    assert.same "svSE", i18n\Get("svSE").code

  it "gets a defined string in default locale", ->
    assert.same "Hello", i18n\Get()["hello"]

  it "gets a defined string in non-default locale", ->
    assert.same "Hallå", i18n\Get("svSE")["hello"]

  it "fallbacks to correct default locale", ->
    assert.same "English fallback", i18n\Get("svSE")["test_fallback"]

  it "formats a string when called", ->
    assert.same "Hello, Foobar!", i18n\Get!("greet", name: "Foobar")

  it "formats a string in non-default locale when called", ->
    assert.same "Hallå, Svensson!", i18n\Get("svSE")("greet", name: "Svensson")

  it "formats a fallback string", ->
    assert.same "Some cheese", i18n\Get("svSE")("test_fallback_format", thing: "cheese")

  it "notifies about missing strings", ->
    assert.same "!!!DOES_NOT_EXIST!!!", i18n\Get!["does_not_exist"]

  it "notifies about missing strings from non-default locale", ->
    l = i18n\Get "svSE"
    assert.same "!!!DOES_NOT_EXIST!!!", l["does_not_exist"]

  it "can get strings via i18n __index", ->
    assert.same "Hello", i18n["hello"]

  it "can get strings via i18n __call", ->
    assert.same "Hello", i18n "hello"

  it "can format strings via i18n __call", ->
    assert.same "Hello, Foobar!", i18n("greet", name: "Foobar")

  it "can format if supplied only a table", ->
    assert.same "Hello, Foobar!", i18n("greet", name: "Foobar")
