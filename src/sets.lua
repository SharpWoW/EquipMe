--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local L = T.I18n

local inventory = T.inventory

local sets = {}

function sets:ToId(name)
  return tostring(name):lower()
end

function sets:GetAll()
  return T.db.profile.sets
end

function sets:Get(name)
  local id = self:ToId(name)
  return T.db.profile.sets[id]
end

function sets:Save(name)
  local id = self:ToId(name)
  local equipped = inventory:Get()
  local set = {
    id = id,
    name = name,
    equipped = equipped
  }
  T.db.profile.sets[id] = set
  T:LogInfo(L { "INVENTORY_SAVE_SAVED", id = id, name = name })
end

function sets:Load(name)
  local id = self:ToId(name)
  local set = T.db.profile.sets[id]

  if not set then
    T:LogError(L { "INVENTORY_SET_NOT_FOUND", id = id, name = name })
    return
  end

  inventory:Equip(set)
end

function sets:Delete(name)
  local id = self:ToId(name)

  if not T.db.profile.sets[id] then
    T:LogError(L { "INVENTORY_SET_NOT_FOUND", id = id, name = name })
    return
  end

  T.db.profile.sets[id] = nil
  T:LogInfo(L { "INVENTORY_DELETE_DELETED", id = id, name = name })
end

T.sets = sets
