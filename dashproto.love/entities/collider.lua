--TODO maybe collider is not useful ?
Collider = {}
function Collider:new(parent,a)
  local check = acheck:new()
  check:add({
    {'x','defaultValue','number',10},
    {'y','defaultValue','number',10},
    {'w','defaultValue','number',16},
    {'h','defaultValue','number',16},
  })
  a = check:check(a)

  --we use table identifier of lua to name collider with unique name
  local collider = {}
  collider = entity:new({
    name='col'..string.match(tostring(collider),"........$"),
    tags={'ticking','visible'},
    parent=parent
  })

  collider.position = vec2(a.x,a.y)

  --a collider has only one body
  collider:add(c_body:new(collider,'mainBody',{
    x=a.x,
    y=a.y,
    w=a.w,
    h=a.h,
    color=color:new(0,255,0,255)
  }),'mainBody')

  return collider
end
return Collider
