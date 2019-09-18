--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local L = T.I18n

local map = T.utils.map

local inventory = {}

local SLOTS = {
  [INVSLOT_HEAD] = {
    id = INVSLOT_HEAD,
    name = "HEADSLOT",
    types = { "INVTYPE_HEAD" },
    frame = "CharacterHeadSlot"
  },
  [INVSLOT_NECK] = {
    id = INVSLOT_NECK,
    name = "NECKSLOT",
    types = { "INVTYPE_NECK" },
    frame = "CharacterNeckSlot"
  },
  [INVSLOT_SHOULDER] = {
    id = INVSLOT_SHOULDER,
    name = "SHOULDERSLOT",
    types = { "INVTYPE_SHOULDER" },
    frame = "CharacterShoulderSlot"
  },
  [INVSLOT_BACK] = {
    id = INVSLOT_BACK,
    name = "BACKSLOT",
    types = { "INVTYPE_CLOAK" },
    frame = "CharacterBackSlot"
  },
  [INVSLOT_CHEST] = {
    id = INVSLOT_CHEST,
    name = "CHESTSLOT",
    types = { "INVTYPE_CHEST", "INVTYPE_ROBE" },
    frame = "CharacterChestSlot"
  },
  [INVSLOT_BODY] = {
    id = INVSLOT_BODY,
    name = "BODYSLOT",
    types = { "INVTYPE_BODY" },
    frame = "CharacterShirtSlot"
  },
  [INVSLOT_TABARD] = {
    id = INVSLOT_TABARD,
    name = "TABARDSLOT",
    types = { "INVTYPE_TABARD" },
    frame = "CharacterTabardSlot"
  },
  [INVSLOT_WRIST] = {
    id = INVSLOT_WRIST,
    name = "WRISTSLOT",
    types = { "INVTYPE_WRIST" },
    frame = "CharacterWristSlot"
  },
  [INVSLOT_HAND] = {
    id = INVSLOT_HAND,
    name = "HANDSSLOT",
    types = { "INVTYPE_HAND" },
    frame = "CharacterHandsSlot"
  },
  [INVSLOT_WAIST] = {
    id = INVSLOT_WAIST,
    name = "WAISTSLOT",
    types = { "INVTYPE_WAIST" },
    frame = "CharacterWaistSlot"
  },
  [INVSLOT_LEGS] = {
    id = INVSLOT_LEGS,
    name = "LEGSSLOT",
    types = { "INVTYPE_LEGS" },
    frame = "CharacterLegsSlot"
  },
  [INVSLOT_FEET] = {
    id = INVSLOT_FEET,
    name = "FEETSLOT",
    types = { "INVTYPE_FEET" },
    frame = "CharacterFeetSlot"
  },
  [INVSLOT_FINGER1] = {
    id = INVSLOT_FINGER1,
    name = "FINGER0SLOT",
    types = { "INVTYPE_FINGER" },
    frame = "CharacterFinger0Slot"
  },
  [INVSLOT_FINGER2] = {
    id = INVSLOT_FINGER2,
    name = "FINGER1SLOT",
    types = { "INVTYPE_FINGER" },
    frame = "CharacterFinger1Slot"
  },
  [INVSLOT_TRINKET1] = {
    id = INVSLOT_TRINKET1,
    name = "TRINKET0SLOT",
    types = { "INVTYPE_TRINKET" },
    frame = "CharacterTrinket0Slot"
  },
  [INVSLOT_TRINKET2] = {
    id = INVSLOT_TRINKET2,
    name = "TRINKET1SLOT",
    types = { "INVTYPE_TRINKET" },
    frame = "CharacterTrinket1Slot"
  },
  [INVSLOT_MAINHAND] = {
    id = INVSLOT_MAINHAND,
    name = "MAINHANDSLOT",
    types = { "INVTYPE_WEAPON", "INVTYPE_WEAPONMAINHAND", "INVTYPE_2HWEAPON" },
    frame = "CharacterMainHandSlot"
  },
  [INVSLOT_OFFHAND] = {
    id = INVSLOT_OFFHAND,
    name = "OFFHANDSLOT",
    types = { "INVTYPE_WEAPONOFFHAND", "INVTYPE_SHIELD" },
    frame = "CharacterSecondaryHandSlot"
  },
  [INVSLOT_RANGED] = {
    id = INVSLOT_RANGED,
    name = "RANGEDSLOT",
    types = { "INVTYPE_RANGED", "INVTYPE_RELIC" },
    frame = "CharacterRangedSlot"
  },
  [INVSLOT_AMMO] = {
    id = INVSLOT_AMMO,
    name = "AMMOSLOT",
    types = { "INVTYPE_AMMO" },
    frame = "CharacterAmmoSlot"
  }
}

for _, slot in pairs(SLOTS) do
  slot.localized = _G[slot.name]
end

inventory.SLOTS = SLOTS

function inventory:Get(slot_id)
  if slot_id then
    local item_id = GetInventoryItemID("player", slot_id)
    local item_link = GetInventoryItemLink("player", slot_id)
    return {
      id = item_id,
      link = item_link
    }
  end

  return map(SLOTS, function(slot) return self:Get(slot.id) end)
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
