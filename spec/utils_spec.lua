--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

describe("utils", function()
  local utils
  local map
  local interpolate

  setup(function()
    local loader = require "spec/loader"
    loader.load("utils.lua")
    utils = _G.EquipMe.utils
    map = utils.map
    interpolate = utils.interpolate
  end)

  describe("map", function()
    it("should map correctly", function()
      local expected = { 2, 4, 6, 8, 10 }
      local source = { 1, 2, 3, 4, 5 }
      local mapper = function(v) return v * 2 end
      local actual = map(source, mapper)
      assert.same(expected, actual)
    end)
  end)

  describe("interpolate", function()
    it("should work on simple format", function()
      local expected = 'Hello, World! I am 42 years old and like "cookies".'
      local actual = interpolate("Hello, %(name)s! I am %(age)d years old and like %(food)q.", {
        name = "World",
        age = 42,
        food = "cookies"
      })

      assert.same(expected, actual)
    end)

    it("should work when passed only a table", function()
      local expected = 'Goodbye, Foobar. I only made it 50 seconds before "Hogger" killed me :('
      local actual = interpolate {
        "Goodbye, %(name)s. I only made it %(seconds)d seconds before %(monster)q killed me :(",
        name = "Foobar",
        seconds = 50,
        monster = "Hogger"
      }

      assert.same(expected, actual)
    end)

    it("should work with differently placed positionals", function()
      local expected = {
        "First is first, and Second is second",
        "Second is first, and First is second"
      }
      local formats = {
        "%(first)s is first, and %(second)s is second",
        "%(second)s is first, and %(first)s is second"
      }
      local args = { first = "First", second = "Second" }
      local actual = map(formats, function(f) return interpolate(f, args) end)
      assert.same(expected, actual)
    end)

    it("shouldn't care about extra data", function()
      local expected = "Look at my horse"
      local actual = interpolate { "Look at my %(thing)s", thing = "horse", something = "hello" }
      assert.same(expected, actual)
    end)

    it("should allow repeating placeholders", function()
      local expected = "Look at my horse, my horse is amazing!"
      local actual = interpolate { "Look at my %(thing)s, my %(thing)s is amazing!", thing = "horse" }
      assert.same(expected, actual)
    end)
  end)
end)
