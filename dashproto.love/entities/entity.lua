--basic game entity that ticks and draws

Entity = {}

function Entity:new(name,p)
  local entity = {}
  entity.name = name or 'noname'

  --we add our entity to object manager
  obm:add(entity,entity.name,p)


  function entity:tick(dt)
    --this is made to be overriden
  end

  function entity:draw()
    --this is made to be overriden
  end

  function entity:destroy()
    obm:remove(self.name)
  end

  return entity
end

return Entity
