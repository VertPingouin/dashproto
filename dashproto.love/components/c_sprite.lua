--a wrapper for anim8 animation, an array of animations

C_sprite = {}
function C_sprite:new(owner,id,a)
  local c_sprite = component:new(owner,id,a)
  c_sprite.animations = {}
  c_sprite.currentAnimation = nil
  c_sprite.visible = true

  local check = acheck:new()
  check:add({
    {'offset','defaultValue','table',vec2(0,0)}
  })
  a = check:check(a)

  c_sprite.offset = a.offset

  function c_sprite:add(a)
    local check = acheck:new()
    check:add({
      {'name','mandatory','string'},
      {'pic','mandatory','userdata'},
      {'cellsizex','mandatory','number'},
      {'cellsizey','mandatory','number'},
      {'frames','mandatory','table'},
      {'durations','mandatory','various'},
    })
    a = check:check(a)

    self.image = a.pic
    local g = anim8.newGrid(a.cellsizex, a.cellsizey, self.image:getWidth(), self.image:getHeight())
    self.animations[a.name] = anim8.newAnimation(g(unpack(a.frames)), a.durations, a.onLoop)
  end

  --set current animation
  function c_sprite:setAnimation(animation)
    assert(self.animations[animation],'c_sprite::play::unknown animation '..animation)
    self.currentAnimation = self.animations[animation]
    self.currentAnimation:resume()
  end

  --function from anim8
  function c_sprite:gotoFrame(frame)
    self.currentAnimation:gotoFrame(frame)
  end

  function c_sprite:pause()
    self.currentAnimation:pause()
  end

  function c_sprite:resume()
    self.currentAnimation:resume()
  end

  --components functions
  function c_sprite:tick(dt)
    self.currentAnimation:update(dt)
  end

  function c_sprite:draw()
    --TODO visible setters and getters
    if self.visible then
      self.currentAnimation:draw(
        self.image,self.owner.position.x +
        self.offset.x,self.owner.position.y + self.offset.y
      )
    end
  end

  return c_sprite
end

return C_sprite
