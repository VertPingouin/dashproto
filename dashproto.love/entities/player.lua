Player = {}

function Player:new(parent)
  local player = entity:new({
    name='player',
    tags={'ticking','visible'},
    parent=parent,
    layer=2
  })

  player.position = vec2(100,200)

  player.movement = vec2(0,0)

  --we get the joy1 (child of game) to be able to read the input
  player.joystick = obm:get('joy1')

  --a statemachine
  player:add(c_statemachine:new(player,'mainFSM'),'mainFSM')
  player.mainFSM:addState('Idle',{enter='onEnterIdle'})
  player.mainFSM:addState('Moving',{enter='onEnterMoving'})
  player.mainFSM:addTransition('Idle','Moving')
  player.mainFSM:addTransition('Moving','Idle')
  player.mainFSM:setInitialState('Idle')

  player:add(c_body:new(player,'mainBody',{x=player.position.x,y=player.position.y,w=32,h=32}),'mainBody')

  --target
  player.target = target:new('player')

  player.color = {r=255,g=255,b=255}
  player.cooldown = 0

  --TODO make a statemachine for cooldown
  --TODO use step functions for statemachine
  function player:oTick(dt)
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
      player.mainFSM:transition('Moving')
      self.movement.x = -left+right
      self.movement.y = -up+down

      self.mainBody:addVec(self.movement:normalizeInplace() * dt * 200)
    else
      player.mainFSM:transition('Idle')
    end

    if self.joystick:pressed('dash') and self.cooldown == 0 then
      self.mainBody.position = self.target.position
      self.cooldown = 0.3
    end
  end

  function player:onEnterIdle()
    self.color = {r=255,g=255,b=255}
  end

  function player:onEnterMoving()
    self.color = {r=0,g=255,b=0}
  end

  function player:oDraw()
    --love.graphics.setColor(self.color.r, self.color.g, self.color.b, 255)
    --love.graphics.circle("fill", self.position.x, self.position.y, 30)
    --love.graphics.setColor(255,255, 255, 255)
  end

  return player
end

return Player
