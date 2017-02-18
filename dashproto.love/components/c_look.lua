C_look = {}
function C_look:new(owner,id,a)
  local c_look = component:new(owner,id,a)

  local check = acheck:new()
  check:add({
    {'target','mandatory','table'},
    {'distance','defaultValue','number','-1'},
    {'offset','defaultValue','table',vec2(0,0)},
    {'targetOffset','defaultValue','table',vec2(0,0)}
  })
  a = check:check(a)

  c_look.target = a.target
  c_look.offset = a.offset
  c_look.targetOffset = a.targetOffset
  c_look.distance = a.distance
  c_look.world = obm:get('bumpWorld')

  assert(a.target.position,'c_look::new::target should have a position')

  function c_look:see()
    local A = vec2(self.owner.position.x + self.offset.x,self.owner.position.y + self.offset.y)
    local B = vec2(self.target.position.x + self.targetOffset.x,self.target.position.y + self.targetOffset.y)
    local items, len = self.world:querySegment(
      A.x,
      A.y,
      B.x,
      B.y,
    blockView)

    local d = A:dist(B)
    if len ==0 and d < self.distance then
      return B-A
    end
    return false
  end

  function c_look:draw()
    if params.debug.look then
      if self:see() then
        love.graphics.setColor(255, 100, 100, 50)
        love.graphics.line(
          self.owner.position.x + self.offset.x,
          self.owner.position.y + self.offset.y,
          self.target.position.x + self.targetOffset.x,
          self.target.position.y + self.targetOffset.y
        )
        love.graphics.setColor(255,255,255,255)
      end
    end
  end

  return c_look
end

return C_look
