Target = {}

function Target:new(parent)
  local target = entity:new('target',{tags={'ticking','visible'},parent=parent,layer=6})
  target.position = vec2(0,0)
  target.parent = obm:get(parent)

  --we get the joy1 (child of game) to be able to read the input
  target.joystick = obm:get('joy1')

  --target state machine
  target:add(c_statemachine:new(target,'mainFSM'),'mainFSM')
  target.components.mainFSM:addState('invisible')
  target.components.mainFSM:addState('visible')

  function target:tick(dt)
    local left = self.joystick:get('tleft')
    local right = self.joystick:get('tright')
    local up = self.joystick:get('tup')
    local down = self.joystick:get('tdown')

    local offset = vec2(right-left,down-up)

    if offset:len() > 0 and target.components.mainFSM.currentState == 'invisible' then
      target.components.mainFSM:setState('visible')
    elseif offset:len() == 0 and target.components.mainFSM.currentState == 'visible' then
      target.components.mainFSM:setState('invisible')
    end

    self.position = self.parent.position + offset * 160
  end

  function target:draw()
    if target.components.mainFSM.currentState == 'visible' then
      love.graphics.setColor(255, 0, 0,255)
      love.graphics.circle("line", self.position.x, self.position.y, 10)
      love.graphics.setColor(255, 255,255,255)
    end
  end

  return target
end


return Target
