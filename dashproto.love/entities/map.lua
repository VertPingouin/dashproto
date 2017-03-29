--read the objects layers from a tlm. Has bodies for triggerzones and colliders
local insert = table.insert

Map = {}

function Map:new(parent,a)
  local check = acheck:new()
  check:add({
    {'luamap','mandatory','table'},
    {'position','defaultValue','table',vec2(0,0)},
  })
  a=check:check(a)

  local map = entity:new({
    name=parent..'.map',
    parent=parent,
    tags={'ticking','visible'},
    layer = params.maxlayer-2
  })

  map.spawn = {}
  map.position = a.position

  --a rectangle representing map boundaries
  map:add(c_body,'boundaries',{x=map.position.x,y=map.position.y,w=a.luamap.tilewidth * a.luamap.width,h=a.luamap.tileheight * a.luamap.height,color=color:new(0,255,0,0),family='boundaries'})
  --go through all layers and do things
  for i,layer in ipairs(a.luamap.layers) do
    if layer.type == 'objectgroup' then
      --special layers
      if string.sub(layer.name,1,2) == 's_' then
        --special layer collidrs, create bodies from family collider
        if layer.name == 's_colliders' then
          for j,object in ipairs(layer.objects) do
            assert(object.shape == 'rectangle','ERROR::map::new::layer colliders should only have rectangles in it')
            map:add(c_body,'collider'..j,{
              x=object.x+map.position.x,
              y=object.y+map.position.y,
              w=object.width,
              h=object.height,
              color=color:new(200,100,200,150),
              family='collider'
            })
          end
        --special layer spawn, create a list of position on the map where objects can spawn
        elseif layer.name == 's_spawn' then
          for j,object in ipairs(layer.objects) do
            assert(object.shape == 'rectangle','ERROR::map::new::layer spawn should only have rectangles in it')
            assert(object.name,'ERROR::map::new::all rectangles must be named in layer spawn')
            if not map.spawn[object.properties.type] then map.spawn[object.properties.type] = {} end
            table.insert(map.spawn[object.properties.type],{pos=vec2(object.x,object.y),name=object.name})
          end
        end
      --trigger zone, create bodies from family t_family
      elseif string.sub(layer.name,1,2) == 't_' then
        local family = string.sub(layer.name,3)
        for j,object in ipairs(layer.objects) do
          assert(object.shape == 'rectangle','ERROR::map::new::layer trigger should only have rectangles in it')
          assert(object.name,'ERROR::map::new::all rectangles must be named in layer trigger')
          --TODO check trigger layer name unicity
          map:add(c_body,object.name,{
            x=object.x+map.position.x,
            y=object.y+map.position.y,
            w=object.width,
            h=object.height,
            color=color:new(200,0,0,150),
            family=family
          })
          --if triggerzone has special properties, we add them to the body
          for key,property in pairs(object.properties) do
            map[object.name][key] = property
          end
        end
      end
    end
  end

  --gets a spawn point
  function map:getSpawn(name)
    return self.spawn[name] or {}
  end

  return map
end

return Map
