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

  player:add(c_body:new(player,'mainBody',{
    x=player.position.x,
    y=player.position.y,
    w=10,
    h=14,
    color=color:new(0,255,0,0),
    family='player',
    offset=vec2(3,10)
  }),'mainBody')

  player:add(c_sprite:new(player,'mainSprite'))
  player.mainSprite:add({
    name = 'player_walk_down',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'2-3',1,'2-1',1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_walk_up',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'5-6',1,'5-4',1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_walk_right',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'8-9',1,'8-7',1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_walk_left',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'11-12',1,'11-10',1},
    durations = .1
  })

  player.mainSprite:setAnimation('player_walk_down')

  player.color = color:new(255,255,255,100)
  player.cooldown = 0

  --TODO make a statemachine for cooldown
  --TODO use step functions for statemachine
  function player:oTick(dt)
    local left = self.joystick:get('left')
    local right = self.joystick:get('right')
    local up = self.joystick:get('up')
    local down = self.joystick:get('down')

    if left+right+up+down ~= 0 then
      player.mainFSM:transition('Moving')
      self.movement.x = -left+right
      self.movement.y = -up+down
      if self.movement.x == 0 then
        if self.movement.y > 0 then
          self.mainSprite:setAnimation('player_walk_down')
        else
          self.mainSprite:setAnimation('player_walk_up')
        end
      else
        if self.movement.x > 0 then
          self.mainSprite:setAnimation('player_walk_right')
        else
          self.mainSprite:setAnimation('player_walk_left')
        end
      end

      self:moveCollide(self.movement:normalizeInplace() * 75 * dt,self.mainBody)
    else
      player.mainFSM:transition('Idle')
    end
  end

  function player:moveCollide(vector,body)
    --moves the player according to a c_body collisions
    self.position = body:moveCollide(vector)
  end

  function player:tpCollide(vector,body)
    --moves the player according to a c_body collisions
    self.position = body:tpCollide(vector)
  end

  function player:onEnterIdle()
    self.mainSprite:gotoFrame(1)
    self.mainSprite:pause()
  end

  function player:onEnterMoving()
    self.mainSprite:resume()
  end

  function player:oDraw()
  end

  player.mainFSM:initialize('Idle')
  return player
end

return Player
