--basic game entity that ticks and draws
Entity = {}

function Entity:new(name,p)
  local entity = {}

  entity.name = name or 'noname'
  entity.components = {}

  --we add our entity to object manager
  obm:add(entity,entity.name,p)

  --adding index function so we can access component by entity.componentname instead of entity.components.componentname
  local mt = {__index = function(table,key) return table.components[key] end }
  setmetatable(entity,mt)

  --overrideable methodes
  function entity:oTick(dt) end
  function entity:oDraw() end

  --add a component
  function entity:add(component)
    self.components[component.id] = component
  end

  --the entity ticking method, make every component tick
  function entity:tick(dt)
    self:oTick(dt)
    for i,component in pairs(self.components) do
      component:tick(dt)
    end
  end

  --the entity drawing method, make every component draw
  function entity:draw()
    self:oDraw()

    for i,component in pairs(self.components) do
      component:draw()
    end
  end

  --when entity is destroyed, we destroy its component and we remove if from obm (will remove children too)
  function entity:destroy()
    for i,component in pairs(self.components) do
      component:destroy()
    end
    obm:remove(self.name)
  end

  return entity
end

return Entity
