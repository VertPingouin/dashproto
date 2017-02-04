Player = {}

function Player:new(parent,a)
  local check = acheck:new()
  check:add({
    {'position','mandatory','table'}
  })
  a=check:check(a)


  local player = entity:new({
    name='player',
    tags={'ticking','visible','player'},
    parent=parent,
    layer=2
  })

  player.position = a.position

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

  player:add(c_body:new(player,'mainBody',{x=player.position.x,y=player.position.y,w=32,h=32,color=color:new(0,255,0,100),family='player'}),'mainBody')

  --target
  player.target = target:new('player')

  player.color = color:new(255,255,255,100)
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

      self:moveCollide(self.movement:normalizeInplace() * 200 * dt,self.mainBody)
    else
      player.mainFSM:transition('Idle')
    end

    if self.joystick:pressed('dash') and self.cooldown == 0 then
      self.cooldown = 0.3
    end
  end

  function player:moveCollide(vector,body)
    --moves the player according to a c_body collisions
    self.position = body:moveCollide(vector)
  end

  function player:onEnterIdle()
    self.color = {r=255,g=255,b=255}
  end

  function player:onEnterMoving()
    self.color = {r=0,g=255,b=0}
  end

  function player:oDraw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 255)
    love.graphics.circle("fill", self.position.x+16, self.position.y+16, 16)
    love.graphics.setColor(255,255, 255, 255)
  end

  function player:testCol()
    self.color = color:new(255,0,0,255)
  end
  return player
end

return Player
