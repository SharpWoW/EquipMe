--[[
  Copyright © 2019 by Adam Hellberg.

  This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. If a copy of the MPL was not distributed with this
  file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

local _, T = ...

local combat_queue = {}

local queue = {}

function combat_queue:Enqueue(id, action)
  -- Anonymous action is being queue, assign it to the end of queue
  if action == nil then
    action = id
    id = #queue + 1
  end

  queue[id] = action

  T:LogDebug("Action with id %s was added to combat queue", tostring(id))

  return id
end

function combat_queue:Process()
  T:LogDebug("Processing combat queue...")
  for id, action in pairs(queue) do
    T:LogTrace("Running post-combat action %s", tostring(id))
    action(T)
  end
  wipe(queue)
  T:LogDebug("Combat queue processed!")
end

function combat_queue:Remove(id)
  T:LogDebug("Action with id %s is being removed from combat queue", tostring(id))
  local action = queue[id]
  if type(id) == "number" then
    table.remove(queue, id)
  else
    queue[id] = nil
  end
  return action
end

T.combat_queue = combat_queue
