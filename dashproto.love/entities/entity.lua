--basic game entity that ticks and draws

Entity = {}

function Entity:new(name,p)
  local entity = {}
  entity.name = name or 'noname'
  entity.components = {}

  --we add our entity to object manager
  obm:add(entity,entity.name,p)

  function entity:oTick(dt) end
  function entity:oDraw() end

  function entity:add(component,id)
    self.components[id] = component
  end

  function entity:tick(dt)
    for i,component in ipairs(self.components) do
      component.tick(dt)
    end

    self:oTick(dt)
  end

  function entity:draw()
    for i,component in ipairs(self.components) do
      component.draw()
    end

    self:oDraw()
  end

  function entity:destroy()
    obm:remove(self.name)
  end

  return entity
end

return Entity
