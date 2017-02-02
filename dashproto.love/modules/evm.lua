--[[event manager.
When an event is triggered, a function is called on every recipient having the tag passed
]]--

local EVM = {}
local insert = table.insert
local remove = table.remove

function EVM:load()
  self.events = {}
  self.queue = {}
end

function EVM:addTagEvent(a)
  --adding an event definition
  --a name, a tag on which to call callback function
  local check = acheck:new()
  check:add({
    {'eventstring','mandatory','string'},
    {'tag','mandatory','string'},
    {'callback','mandatory','string'}
  })
  a = check:check(a)
  self.events[a.eventstring] = {type='t',tag=a.tag,callback=a.callback}
  log:post('DEBUG','evm','event '..a.eventstring..' added, will call '..a.callback..' on tag '..a.tag)
end

function EVM:addEntityEvent(a)
  --adding an event definition
  --a name, a tag on which to call callback function
  local check = acheck:new()
  check:add({
    {'eventstring','mandatory','string'},
    {'entity','mandatory','string'},
    {'callback','mandatory','string'}
  })
  a = check:check(a)
  self.events[a.eventstring] = {type='e',target=a.entity,callback=a.callback}
  log:post('DEBUG','evm','event '..a.eventstring..' added, will call '..a.callback..' on entity '..a.entity)
end


function EVM:post(eventstring,a)
  --add an event to queue
  --on the next tick, callback function will be called with args on tag
  assert(self.events[eventstring],'ERROR:EVM:post::Unknown event '..eventstring)
  a = a or {}

  local event2send = self.events[eventstring]
  insert(self.queue,{event2send,a})
end

function EVM:tick(dt)
  --empty the queue and call callback function
  for i,evt in ipairs(self.queue) do
    if evt[1].type == 't' then
      obm:callByTags(evt[1].target,evt[1].callback,evt[2])
    else
      obm:callById(evt[1].target,evt[1].callback,evt[2])
    end
    remove(self.queue,i)
    log:post('DEBUG','evm','evm calls '..evt[1].callback..' on '..evt[1].target)
  end
end

return EVM
