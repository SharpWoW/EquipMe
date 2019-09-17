--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local L = T.I18n

local inventory = {}

local SLOTS = {
  [INVSLOT_HEAD] = {
    id = INVSLOT_HEAD,
    name = "HEADSLOT",
    types = { "INVTYPE_HEAD" }
  },
  [INVSLOT_NECK] = {
    id = INVSLOT_NECK,
    name = "NECKSLOT",
    types = { "INVTYPE_NECK" }
  },
  [INVSLOT_SHOULDER] = {
    id = INVSLOT_SHOULDER,
    name = "SHOULDERSLOT",
    types = { "INVTYPE_SHOULDER" }
  },
  [INVSLOT_BACK] = {
    id = INVSLOT_BACK,
    name = "BACKSLOT",
    types = { "INVTYPE_CLOAK" }
  },
  [INVSLOT_CHEST] = {
    id = INVSLOT_CHEST,
    name = "CHESTSLOT",
    types = { "INVTYPE_CHEST", "INVTYPE_ROBE" }
  },
  [INVSLOT_BODY] = {
    id = INVSLOT_BODY,
    name = "BODYSLOT",
    types = { "INVTYPE_BODY" }
  },
  [INVSLOT_TABARD] = {
    id = INVSLOT_TABARD,
    name = "TABARDSLOT",
    types = { "INVTYPE_TABARD" }
  },
  [INVSLOT_WRIST] = {
    id = INVSLOT_WRIST,
    name = "WRISTSLOT",
    types = { "INVTYPE_WRIST" }
  },
  [INVSLOT_HAND] = {
    id = INVSLOT_HAND,
    name = "HANDSSLOT",
    types = { "INVTYPE_HAND" }
  },
  [INVSLOT_WAIST] = {
    id = INVSLOT_WAIST,
    name = "WAISTSLOT",
    types = { "INVTYPE_WAIST" }
  },
  [INVSLOT_LEGS] = {
    id = INVSLOT_LEGS,
    name = "LEGSSLOT",
    types = { "INVTYPE_LEGS" }
  },
  [INVSLOT_FEET] = {
    id = INVSLOT_FEET,
    name = "FEETSLOT",
    types = { "INVTYPE_FEET" }
  },
  [INVSLOT_FINGER1] = {
    id = INVSLOT_FINGER1,
    name = "FINGER0SLOT",
    types = { "INVTYPE_FINGER" }
  },
  [INVSLOT_FINGER2] = {
    id = INVSLOT_FINGER2,
    name = "FINGER1SLOT",
    types = { "INVTYPE_FINGER" }
  },
  [INVSLOT_TRINKET1] = {
    id = INVSLOT_TRINKET1,
    name = "TRINKET0SLOT",
    types = { "INVTYPE_TRINKET" }
  },
  [INVSLOT_TRINKET2] = {
    id = INVSLOT_TRINKET2,
    name = "TRINKET1SLOT",
    types = { "INVTYPE_TRINKET" }
  },
  [INVSLOT_MAINHAND] = {
    id = INVSLOT_MAINHAND,
    name = "MAINHANDSLOT",
    types = { "INVTYPE_WEAPON", "INVTYPE_WEAPONMAINHAND", "INVTYPE_2HWEAPON" }
  },
  [INVSLOT_OFFHAND] = {
    id = INVSLOT_OFFHAND,
    name = "OFFHANDSLOT",
    types = { "INVTYPE_WEAPONOFFHAND", "INVTYPE_SHIELD" }
  },
  [INVSLOT_RANGED] = {
    id = INVSLOT_RANGED,
    name = "RANGEDSLOT",
    types = { "INVTYPE_RANGED", "INVTYPE_RELIC" }
  },
  [INVSLOT_AMMO] = {
    id = INVSLOT_AMMO,
    name = "AMMOSLOT",
    types = { "INVTYPE_AMMO" }
  }
}

for _, slot in pairs(SLOTS) do
  slot.localized = _G[slot.name]
end

inventory.SLOTS = SLOTS

local function to_id(name) return name:lower() end

function inventory:GetEquipped()
  local equipped = {}

  for _, slot in pairs(SLOTS) do
    local item_link = GetInventoryItemLink("player", slot.id)
    equipped[slot.id] = {
      link = GetInventoryItemLink("player", slot.id)
    }
  end

  return equipped
end

function inventory:Save(name)
  local id = to_id(name)
  local equipped = self:GetEquipped()
  local set = {
    id = id,
    name = name,
    equipped = equipped
  }
  T.db.profile.sets[id] = set
  T:LogInfo(L { "INVENTORY_SAVE_SAVED", id = id, name = name })
end

function inventory:Load(name)
  local id = to_id(name)
  local set = T.db.profile.sets[id]

  if not set then
    T:LogError(L { "INVENTORY_SET_NOT_FOUND", id = id, name = name })
    return
  end

  self:Equip(set)
end

function inventory:Delete(name)
  local id = to_id(name)

  if not T.db.profile.sets[id] then
    T:LogError(L { "INVENTORY_SET_NOT_FOUND", id = id, name = name })
    return
  end

  T.db.profile.sets[id] = nil
  T:LogInfo(L { "INVENTORY_DELETE_DELETED", id = id, name = name })
end

function inventory:Equip(set)
  T:LogDebug("Equipping set %s (%q)", set.id, set.name)
  for slot_id, item in pairs(set.equipped) do
    T.items:Equip(item.link, slot_id)
  end

  if T.is_in_combat then
    T:LogInfo(L { "INVENTORY_EQUIP_IN_COMBAT", name = set.name })
  else
    T:LogInfo(L { "INVENTORY_EQUIP_EQUIPPED", name = set.name })
  end
end

T.inventory = inventory
