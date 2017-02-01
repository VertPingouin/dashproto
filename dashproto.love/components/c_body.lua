C_body = {}
function C_body:new(owner,id,a)
  local c_body = component:new(owner,id,a)

  local check = acheck:new()
  check:add({
    {'x','defaultValue','number',10},
    {'y','defaultValue','number',10},
    {'w','defaultValue','number',16},
    {'h','defaultValue','number',16},
    {'color','defaultValue','table',color:new(255,255,255,255)},
    {'family','mandatory','string'}
  })
  a = check:check(a)

  c_body.position = vec2(a.x,a.y)
  c_body.w = a.w
  c_body.h = a.h
  c_body.color = a.color
  c_body.family = a.family --used to know the collision response via colm
  c_body.name = obm:getId(owner)..'.'..id --used to detect particular collision 

  assert(obm:get('bumpWorld'),'c_body::new::a world object (bump) is needed for a body to work')
  c_body.world = obm:get('bumpWorld')
  c_body.world:add(c_body,c_body.position.x,c_body.position.y,c_body.w,c_body.h)

  function c_body:addVec(vector)
    local actualX, actualY, cols, len = self.world:move(self,c_body.position.x+vector.x,c_body.position.y+vector.y,self.filter)
    self.position.x = actualX
    self.position.y = actualY
  end

  function c_body:tick(dt)
    --TODO check here what collides with what

    if self.owner.position then
      self.owner.position.x = self.position.x
      self.owner.position.y = self.position.y
    end
  end

  function c_body:draw()
    if debug.boxes then
      love.graphics.setColor(
        c_body.color.r,
        c_body.color.g,
        c_body.color.b,
        c_body.color.a
      )
      love.graphics.rectangle('fill', self.position.x, self.position.y, self.w, self.h)
      love.graphics.setColor(255,255,255,255)
    end
  end

  function c_body:destroy()
    --we remove body from bump
    c_body.world:remove(self)
  end

  function c_body:filter(other)
    --interrogate colm to know the collision type
    coltype = colm:getColType(self.family,other.family)
    return coltype
  end

  return c_body
end
return C_body
