Collider = {}
function Collider:new(parent,a)
  local check = acheck
  check:add({
    {'x',0,'number'},
    {'y',0,'number'},
    {'w',0,'number'},
    {'h',0,'number'}
  })
  check:check(a)

  --we use table identifier of lua to name collider with unique name
  local collider = {}
  collider = entity:new({
    name='col'..string.match(tostring(collider),"........$"),
    tags={'ticking','visible'},
    parent=parent
  })

  collider.position = vec2(a.x,a.y)

  --a collider has only one body
  collider:add(c_body:new(collider,'mainBody',{x=a.x,y=a.y,w=a.w,h=a.h}),'mainBody')

  return collider
end
return Collider
