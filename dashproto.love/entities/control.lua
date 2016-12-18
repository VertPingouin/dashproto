Control = {}

function Control:new(parent)
  local control = entity:new('control',1,{tags={'ticking'},parent=parent})
  control.joystick = love.joystick.getJoysticks()[1]
  control.deadzone = 0.1

  function control:getAxis()
    local ax = self.joystick:getAxis(1)
    local ay = self.joystick:getAxis(2)
    if math.abs(ax) < self.deadzone then ax = 0 end
    if math.abs(ay) < self.deadzone then ay = 0 end
    return vec2:new(ax,ay)
  end

  function control:tick(dt)
  end

  return control
end

return Control
