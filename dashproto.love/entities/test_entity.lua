Test_Entity = {}

function Test_Entity:new(parent,p)
  local test_entity = entity:new(p.name,{tags={'visible','ticking'},parent=parent,layer=p.layer,order=p.order})

  test_entity.position = vec2:new(p.x or 100,p.y or 100)
  test_entity.movement = vec2:new(0,0)
  test_entity.r = p.r or 0
  test_entity.g = p.g or 0
  test_entity.b = p.b or 0
  test_entity.size = p.size or 30

  function test_entity:setMovement(x,y)
    self.movement.x = x
    self.movement.y = y
  end

  function test_entity:oTick(dt)
    self.movement = vec2:new(math.random(-100, 100),math.random(-100, 100))
    self.position.x = self.position.x + self.movement.x * dt
    self.position.y = self.position.y + self.movement.y * dt
  end

  function test_entity:oDraw()
    love.graphics.setColor(self.r, self.g, self.b, 255)
    love.graphics.circle("fill", self.position.x, self.position.y, self.size)
    love.graphics.setColor(255,255,255,255)
  end

  return test_entity
end

return Test_Entity
