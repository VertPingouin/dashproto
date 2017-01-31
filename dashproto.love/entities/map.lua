--TODO write tilemap load and display
local insert = table.insert

Map = {}

function Map:new(parent,name,a)
  local check = acheck:new()
  check:add({
    {'luamap','mandatory','table'},
    {'position','defaultValue','table',vec2(0,0)}
  })
  a=check:check(a)

  local map = entity:new({
    name=name,
    parent=parent,
    tags={'ticking','visible'}
  })

  map.spawn = {}
  map.position = a.position


  --go through all layers and do things
  for i,layer in ipairs(a.luamap.layers) do
    --colliders layer
    if layer.type == 'objectgroup' and layer.name == 'colliders' then
      for j,object in ipairs(layer.objects) do
        assert(object.shape == 'rectangle','ERROR::map::new::layer colliders should only have rectangles in it')
        map:add(c_body:new(map,'collider'..j,{
          x=object.x+map.position.x,
          y=object.y+map.position.y,
          w=object.width,
          h=object.height,
          color=color:new(0,255,0,255)
        }),'collider'..j)
      end
    --spawn points layer
    elseif layer.type == 'objectgroup' and layer.name == 'spawn' then
      for j,object in ipairs(layer.objects) do
        assert(object.shape == 'rectangle','ERROR::map::new::layer spawn should only have rectangles in it')
        assert(object.name,'ERROR::map::new::all rectangles must be named in layer spawn')
        map.spawn[object.name] = vec2(object.x,object.y)
      end
    end
  end


  --gets a spawn point
  function map:getSpawn(name)
    assert(self.spawn[name],'ERROR::map::getSpawn::No spawn point for '..name)
    return self.spawn[name]
  end

  return map
end

return Map
