--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

--[[
  USEFUL FUNCTIONS:

  EquipItemByName(itemId or "itemName" or "itemLink"[, invSlot])
]]

local _, T = ...

local combat_queue = T.combat_queue

local items = {}

function items:GetInfo(id)
  local info = { GetItemInfo(id) }

  return {
    name = info[1],
    link = info[2],
    rarity = info[3],
    level = info[4],
    min_level= info[5],
    type = info[6],
    subtype = info[7],
    stack_count = info[8],
    equip_location = info[9],
    icon = info[10],
    sellprice = info[11],
    class_id = info[12],
    subclass_id = info[13],
    bind_type = info[14],
    expac_id = info[15],
    set_id = info[16],
    is_reagent = info[17]
  }
end

function items:Equip(id, slot_id)
  if id == nil then return end

  T:LogDebug("Equipping item %s to %s", tostring(id), T.inventory.SLOTS[slot_id].localized)

  if T.is_in_combat then
    local info = self:GetInfo(id)
    local location = info.equip_location
    local queue_id = location

    if slot_id then queue_id  = queue_id .. "_" .. tostring(slot_id) end

    T:LogDebug("In combat, delaying equip until after combat (ID = %s)", queue_id)

    combat_queue.Enqueue(queue_id, function() self:Equip(id, slot_id) end)
    return
  end

  EquipItemByName(id, slot_id)
end

T.items = items
