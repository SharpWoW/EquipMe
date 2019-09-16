-- Copyright © 2019 by Adam Hellberg.
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

describe "utils", ->
  local utils
  local map
  local interpolate

  setup ->
    import load from require "spec/loader"
    load "utils.lua"
    utils = _G.EquipMe.utils
    { :map, :interpolate } = utils

  describe "map", ->
    it "should map correctly", ->
      expected = { 2, 4, 6, 8, 10 }
      source = { 1, 2, 3, 4, 5 }
      mapper = (v) -> v * 2
      actual = map source, mapper
      assert.same expected, actual

  describe "interpolate", ->
    it "should work on simple format", ->
      expected = 'Hello, World! I am 42 years old and like "cookies".'
      actual = interpolate "Hello, %(name)s! I am %(age)d years old and like %(food)q.",
        name: "World",
        age: 42,
        food: "cookies"

      assert.same expected, actual

    it "should work when passed only a table", ->
      expected = 'Goodbye, Foobar. I only made it 50 seconds before "Hogger" killed me :('
      actual = interpolate {
        "Goodbye, %(name)s. I only made it %(seconds)d seconds before %(monster)q killed me :(",
        name: "Foobar",
        seconds: 50,
        monster: "Hogger"
      }

      assert.same expected, actual

    it "should work with differently placed positionals", ->
      expected = {
        "First is first, and Second is second",
        "Second is first, and First is second"
      }
      formats = {
        "%(first)s is first, and %(second)s is second",
        "%(second)s is first, and %(first)s is second"
      }
      args = first: "First", second: "Second"
      actual = map formats, (f) -> interpolate(f, args)
      assert.same expected, actual

    it "shouldn't care about extra data", ->
      expected = "Look at my horse"
      actual = interpolate "Look at my %(thing)s", thing: "horse", something: "hello"
      assert.same expected, actual

    it "should allow repeating placeholders", ->
      expected = "Look at my horse, my horse is amazing!"
      actual = interpolate "Look at my %(thing)s, my %(thing)s is amazing!", thing: "horse"
      assert.same expected, actual
