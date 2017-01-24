Target = {}

function Target:new(parent)
  local target = entity:new('target',{tags={'ticking','visible'},parent=parent,layer=6})
  target.position = vec2:new(0,0)
  target.parent = obm:get(parent)

  --we get the joy1 (child of game) to be able to read the input
  target.joystick = obm:get('joy1')

  --target state machine
  target.fsm = statemachine:new('target')
  target.fsm:addState('invisible')
  target.fsm:addState('visible')

  function target:tick(dt)
    local left_offset = self.joystick:get('tleft')*160
    local right_offset = self.joystick:get('tright')*160
    local up_offset = self.joystick:get('tup')*160
    local down_offset = self.joystick:get('tdown')*160

    if left_offset + right_offset + up_offset + down_offset ~= 0 then
      self.fsm:setState('visible')
    else
      self.fsm:setState('invisible')
    end

    self.position.x = self.parent.position.x - left_offset + right_offset
    self.position.y = self.parent.position.y - up_offset + down_offset
  end

  function target:draw()
    if self.fsm.currentState == 'visible' then
      love.graphics.setColor(255, 0, 0,255)
      love.graphics.circle("line", self.position.x, self.position.y, 10)
      love.graphics.setColor(255, 255,255,255)
    end
  end
end


return Target
