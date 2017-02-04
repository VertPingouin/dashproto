TriggerZone = {}
function TriggerZone:new(parent,a)
  local check = acheck:new()
  check:add({
    {'x','defaultValue','number',10},
    {'y','defaultValue','number',10},
    {'w','defaultValue','number',16},
    {'h','defaultValue','number',16},
  })
  a = check:check(a)

  --we use table identifier of lua to name triggerZone with unique name
  local triggerZone = {}
  triggerZone = entity:new({
    name='col'..string.match(tostring(triggerZone),"........$"),
    tags={'ticking','visible'},
    parent=parent
  })

  triggerZone.position = vec2(a.x,a.y)

  --a triggerZone has only one body
  triggerZone:add(c_body:new(collider,'mainBody',{
    x=a.x,
    y=a.y,
    w=a.w,
    h=a.h,
    color=color:new(0,255,0,255)
  }),'mainBody')

  return triggerZone
end
return TriggerZone
