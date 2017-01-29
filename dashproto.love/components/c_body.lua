C_body = {}
function C_body:new(owner,id,p)
  local c_body = component:new(owner,id,p)
  assert(p and p.x and p.y and p.w and p.h,"c_body::new::x, y, w and h are mandatory for a body component")
  c_body.position = vec2(p.x,p.y)
  c_body.w = p.w
  c_body.h = p.h

  assert(obm:get('world'),'c_body::new::a world object (bump) is needed for a body to work')
  c_body.world = obm:get('world')
  c_body.world:add(c_body,c_body.position.x,c_body.position.y,c_body.w,c_body.h)

--TODO handle different body types
  function c_body:addVec(vector)
    -- Try to move B to 0,64. If it collides with A, "slide over it"
    local actualX, actualY, cols, len = self.world:move(self,c_body.position.x+vector.x,c_body.position.y+vector.y,self.filter)
    self.position.x = actualX
    self.position.y = actualY


  end

  function c_body:tick(dt)
    self.owner.position.x = self.position.x
    self.owner.position.y = self.position.y
  end

  function c_body:draw()
    love.graphics.rectangle('line', self.position.x, self.position.y, self.w, self.h)
  end

  function c_body:destroy()
    --we remove body from bump
    c_body.world:remove(self)
  end

  function c_body:filter(other)
    --do things here
  end

  return c_body
end
return C_body