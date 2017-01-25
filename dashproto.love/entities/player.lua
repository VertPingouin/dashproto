Player = {}

function Player:new(parent)
  local player = entity:new('player',{tags={'ticking','visible'},parent=parent,layer=5})

  player.position = vec2(500,200)

  player.movement = vec2(0,0)

  --we get the joy1 (child of game) to be able to read the input
  player.joystick = obm:get('joy1')

  --a statemachine
  player.fsm = statemachine:new('player')
  player.fsm:addState('Idle',{enter='onEnterIdle'})
  player.fsm:addState('Moving',{enter='onEnterMoving'})
  player.fsm:addTransition('Idle','Moving')
  player.fsm:addTransition('Moving','Idle')
  player.fsm:setInitialState('Idle')

  --target
  player.target = target:new('player')

  player.color = {r=255,g=255,b=255}
  player.cooldown = 0

  function player:tick(dt)
    if self.cooldown > 0 then
      self.cooldown= self.cooldown - dt
    elseif self.cooldown < 0 then
      self.cooldown = 0
    end

    local left = self.joystick:get('left')
    local right = self.joystick:get('right')
    local up = self.joystick:get('up')
    local down = self.joystick:get('down')

    if left+right+up+down ~= 0 then
      self.fsm:transition('Moving')
      self.movement.x = -left+right
      self.movement.y = -up+down
      self.position = self.position + self.movement:normalizeInplace() * dt * 200
    else
      self.fsm:transition('Idle')
    end

    if self.joystick:pressed('dash') and self.cooldown == 0 then
      self.position = self.target.position
      self.cooldown = 0.3
    end
  end

  function player:onEnterIdle()
    self.color = {r=255,g=255,b=255}
  end

  function player:onEnterMoving()
    self.color = {r=0,g=0,b=255}
  end

  function player:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 255)
    love.graphics.circle("fill", self.position.x, self.position.y, 30)
    love.graphics.setColor(255,255, 255, 255)
  end

  return player
end

return Player
