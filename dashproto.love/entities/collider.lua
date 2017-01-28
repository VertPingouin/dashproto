Collider = {}
function Collider:new(parent,x,y,w,h)
  --we use table identifier of lua to name collider with unique name
  local collider = {}
  collider = entity:new('col'..string.match(tostring(collider),"........$"),{tags={'ticking','visible'},parent=parent})

  collider.position = vec2(x,y)

  --a collider has only one body
  collider:add(c_body:new(collider,'mainBody',{x=collider.position.x,y=collider.position.y,w=w,h=h}),'mainBody')

  return collider
end
return Collider
