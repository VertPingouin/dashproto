--basic game entity that ticks and draws

Entity = {}

function Entity:new(name,layer,p)
  local entity = {}
  entity.name = name or 'noname'
  entity.layer = layer

  --we add our entity to object manager
  obm:add(entity,entity.name,p)

  --if a layer was passed, we add entity to the renderer
  if entity.layer then
    renderer:add(entity,entity.layer)
  end

  function entity:tick(dt)
    --this is made to be overriden
  end

  function entity:draw()
    --this is made to be overriden
  end

  function entity:destroy()
    gameloop:remove(self)
    renderer:remove(self)
  end

  return entity
end

return Entity
