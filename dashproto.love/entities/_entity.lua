--basic game entity that ticks and draws
Entity = {}

function Entity:new(a)
  local entity = {}

  local check = acheck:new()
  check:add({
    {'name','defaultValue','string','noname'},
  })
  a = check:check(a)

  entity.name = a.name
  entity.pause = false
  entity.visible = true
  entity.components = {}

  --needed to preserve component order
  entity.componentsSorted = {}
  entity.componentCount = 0
  entity.counter=0

  --we add our entity to object manager
  obm:add(entity,entity.name,a)

  --adding index function so we can access component by entity.componentname instead of entity.components.componentname
  local mt = {__index = function(table,key) return table.components[key] end }
  setmetatable(entity,mt)

  --overrideable methodes
  function entity:oTick(dt) end
  --overrideable function shouldn't be user to draw things but to control what happen when drawing
  --use components to draw instead
  function entity:oDraw() end
  function entity:oDestroy() end

  --add a component
  function entity:add(component)
    self.components[component.id] = component
    self.componentsSorted[self.componentCount] = component
    self.componentCount = self.componentCount + 1
  end

  function entity:setPause(isPaused)
    self.pause = isPaused
  end

  function entity:freeze(freezetime)
    self.counter = freezetime
    self:setPause(true)
    self.pause = true
  end

  function entity:setVisible(isVisible)
    self.visible = isVisible
  end

  --the entity ticking method, make every component tick
  function entity:tick(dt)
    if self.counter > 0 then
      self.counter = self.counter - dt
      if self.counter < 0 then
        self:setPause(false)
        self.pause=false
      end
    end

    if not self.pause then
      for k,component in pairs(self.componentsSorted) do
        component:tick(dt)
      end
      self:oTick(dt)
    end
  end

  --the entity drawing method, make every component draw
  function entity:draw()
    self:oDraw()
    if self.visible then
      for k,component in pairs(self.componentsSorted) do
        component:draw()
      end
    end
    love.graphics.setShader()
  end

  --when entity is destroyed, we destroy its component and we remove if from obm (will remove children too)
  function entity:destroy()
    self:oDestroy()
    for k,component in pairs(self.componentsSorted) do
      component:destroy()
    end
    obm:remove(self.name)
  end

  return entity
end

return Entity
