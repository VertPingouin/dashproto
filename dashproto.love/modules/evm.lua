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
    {'callback','mandatory','string'},
    {'args','defaultValue','table',{}}
  })
  a = check:check(a)
  self.events[a.eventstring] = {type='t',tag=a.tag,callback=a.callback,args=a.args}
  log:post('DEBUG','evm','event '..a.eventstring..' added, will call '..a.callback..' on tag '..a.tag)
end

function EVM:addEntityEvent(a)
  --adding an event definition
  --a name, a tag on which to call callback function
  local check = acheck:new()
  check:add({
    {'eventstring','mandatory','string'},
    {'entity','mandatory','string'},
    {'callback','mandatory','string'},
    {'args','defaultValue','table',{}}
  })
  a = check:check(a)
  self.events[a.eventstring] = {type='e',target=a.entity,callback=a.callback,args=a.args}
  log:post('DEBUG','evm','event '..a.eventstring..' added, will call '..a.callback..' on entity '..a.entity)
end


function EVM:post(eventstring,a)
  --add an event to queue
  --on the next tick, callback function will be called with args on tag

  --if event is not handled, we don't add it to the queue
  --so we can post a shit ton of event without impacting too much the perfs
  if self.events[eventstring] then
    a = a or {}
    local event2send = self.events[eventstring]
    insert(self.queue,{event2send,a})
    log:post('DEBUG','evm','received handled event "'..eventstring..'"')
  end
  --log:post('DEBUG','evm','received non-handled event "'..eventstring..'"')
end

function EVM:tick(dt)
  --empty the queue and call callback function
  for i,evt in ipairs(self.queue) do
    if evt[1].type == 't' then
      obm:callByTags(evt[1].target,evt[1].callback,evt[1].args)
    else
      obm:callById(evt[1].target,evt[1].callback,evt[1].args)
    end
    remove(self.queue,i)
    log:post('DEBUG','evm','evm calls '..evt[1].callback..' on '..evt[1].target..' with params '..strTable(evt[1].args))
  end
end

return EVM
