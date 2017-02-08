C_sprite = {}
function C_sprite:new(owner,id,a)
  local c_sprite = component:new(owner,id,a)
  c_sprite.animations = {}
  c_sprite.currentAnimation = nil

  function c_sprite:add(a)
    local check = acheck:new()
    check:add({
      {'name','mandatory','string'},
      {'pic','mandatory','userdata'},
      {'cellsizex','mandatory','number'},
      {'cellsizey','mandatory','number'},
      {'frames','mandatory','table'},
      {'durations','mandatory','various'}
    })
    a = check:check(a)

    self.image = a.pic
    local g = anim8.newGrid(a.cellsizex, a.cellsizey, self.image:getWidth(), self.image:getHeight())
    self.animations[a.name] = anim8.newAnimation(g(unpack(a.frames)), a.durations, a.onLoop)
  end

  function c_sprite:setAnimation(animation)
    assert(self.animations[animation],'c_sprite::play::unknown animation '..animation)
    self.currentAnimation = self.animations[animation]
    self.currentAnimation:resume()
  end

  function c_sprite:resume()
    self.currentAnimation:resume()
  end

  function c_sprite:gotoFrame(frame)
    self.currentAnimation:gotoFrame(frame)
  end

  function c_sprite:pause()
    self.currentAnimation:pause()
  end

  function c_sprite:pauseAtStart()
    self.currentAnimation:pauseAtStart()
  end

  function c_sprite:pauseAtEnd()
    self.currentAnimation:pauseAtEnd()
  end


  function c_sprite:tick(dt)
    self.currentAnimation:update(dt)
  end

  function c_sprite:draw()
    self.currentAnimation:draw(self.image,self.owner.position.x,self.owner.position.y)
  end

  return c_sprite
end

return C_sprite
