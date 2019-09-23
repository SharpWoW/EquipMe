--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local map = T.utils.map
local tcontains = T.utils.contains
local items = T.items
local inventory = T.inventory

local bags = {}

local function get_data(bag_id, slot)
  local id = GetContainerItemID(bag_id, slot)
  local link = GetContainerItemLink(bag_id, slot)
  if not id or not link then return nil end
  return { id = id, link = link }
end

local function foreach_slot(func)
  for bag_id = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
    local num_slots = GetContainerNumSlots(bag_id)
    for slot = 1, num_slots do
      local result = func(bag_id, slot)
      if result ~= nil then return result end
    end
  end
end

function bags:FindFreeBagId()
  for bag_id = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
    if GetContainerNumFreeSlots(bag_id) then
      return bag_id
    end
  end

  return nil
end

function bags:FindItem(identifier)
  return foreach_slot(function(bag_id, slot)
    local info = get_data(bag_id, slot)
    if not info then return end
    if info.id == identifier or info.link == identifier then
      return info, bag_id, slot
    end
  end)
end

function bags:GetForSlot(slot_id)
  local slot_info = inventory.SLOTS[slot_id]
  local result = {}

  foreach_slot(function(bag_id, slot)
    local data = get_data(bag_id, slot)
    if data then
      T:LogTrace("(%d, %d): %s (%d)", bag_id, slot, data.link, data.id)
      local info = items:GetInfo(data.link)
      local equip_location = info.equip_location
      if tcontains(slot_info.types, equip_location) then
        result[#result + 1] = info
      end
    end
  end)

  return result
end

function bags:GetForSlots()
  return map(inventory.SLOTS, function(slot)
    return self:GetForSlot(slot.id)
  end)
end

T.bags = bags
