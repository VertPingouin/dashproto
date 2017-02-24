C_effect = {}
function C_effect:new(owner,id,a)
  local c_effect = component:new(owner,id,a)

  local check = acheck:new()
  check:add({
    {'shader','mandatory','string'},
    {'duration','mandatory','number'},
    {'fadein','defaultValue','number',0},
    {'fadeout','defaultValue','number',0}
  })
  check:check(a)

  c_effect.shader = love.graphics.newShader(a.shader)
  c_effect.fadein = a.fadein
  c_effect.fadeout = a.fadeout

  c_effect.duration = a.duration
  c_effect.amount = 0
  c_effect.counter = 0
  c_effect.phase = 0

  function c_effect:tick(dt)
    self.counter = self.counter + dt
    if self.phase == 1 then
      self.amount = self.counter / self.fadein
      if self.counter > self.fadein then
        self.phase = 2
        self.counter = 0
      end
    elseif self.phase == 2  then
      --if duration is negative, then effect is permanent
      if self.duration >= 0 then
        self.amount = 1
        if self.counter > self.duration then
          self.phase = 3
          self.counter = 0
        end
      end
    elseif self.phase == 3 then
      self.amount = 1-self.counter / self.fadeout
      if self.counter > self.fadeout then
        self.phase = 0
        self.counter = 0
        self.amount = 0
      end
    else
      self.amount = 0
      self.counter = 0
    end
  end

  function c_effect:draw()
    self.shader:send("amount",self.amount)
    love.graphics.setShader(self.shader)
  end

  function c_effect:play()
    self.counter = 0
    self.phase = 1
  end

  return c_effect
end

return C_effect
