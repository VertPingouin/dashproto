local pi =math.pi
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
  player.direction = vec2(0,1)
  player.move = false
  player.speed = 1
  player.flicker = true

  --we get the joy1 (child of game) to be able to read the input
  player.joystick = obm:get('joy1')

  --a statemachine
  player:add(c_statemachine:new(player,'action'),'action')

  player.action:addState('Idle',{enter='onEnterIdle',step='whileIdle'})
  player.action:addState('Moving',{enter='onEnterMoving',step='whileMoving'})
  player.action:addState('Hurting',{enter='onEnterHurting',step='whileHurting'})
  player.action:addState('Hitting',{enter='onEnterHitting',step='whileHitting',exit='onExitHitting'})

  player.action:addTransition('Idle','Moving')
  player.action:addTransition('Idle','Hitting')
  player.action:addTransition('Idle','Hurting')

  player.action:addTransition('Moving','Idle')
  player.action:addTransition('Hitting','Idle',{preferred=true,ttl=.2})
  player.action:addTransition('Hurting','Idle',{preferred=true,ttl=.3})

  player.action:addTransition('Moving','Hitting')
  player.action:addTransition('Hitting','Hurting')
  player.action:addTransition('Moving','Hurting')

  player.action:setInitialState('Idle')

  player:add(c_statemachine:new(player,'state'),'state')
  player.state:addState('Vulnerable')
  player.state:addState('Invulnerable')
  player.state:addTransition('Vulnerable','Invulnerable',{preferred=true})
  player.state:addTransition('Invulnerable','Vulnerable',{preferred=true,ttl=1})

  player:add(c_body:new(player,'mainBody',{
    x=player.position.x,
    y=player.position.y,
    w=10,
    h=14,
    color=color:new(0,255,0,100),
    family='player',
    offset=vec2(3,10)
  }),'mainBody')

  player:add(c_body:new(player,'hitBox',{
    x=player.position.x,
    y=player.position.y,
    w=16,
    h=16,
    color=color:new(255,0,0,100),
    family='hitBox',
    offset=vec2(0,0)
  }),'hitBox')

  player.hitBox:setActive(false)

  player:add(c_effect:new(player,'redflash',{
  duration = 0,
  fadein = 0,
  fadeout = .1,
  shader=[[
  extern number amount;
  vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    pixel.r = pixel.r + amount;
    pixel.g = pixel.g;
    pixel.b = pixel.b;
    return pixel;
  }
  ]]}))

  player:add(c_sprite:new(player,'whip'))
  player.whip:add({
    name = 'whip_down',
    pic = asm:get('whip'),
    cellsizex = 16,
    cellsizey = 16,
    frames = {'1-2',1},
    durations = .1
  })

  player.whip.visible = false

  player.whip:add({
    name = 'whip_up',
    pic = asm:get('whip'),
    cellsizex = 16,
    cellsizey = 16,
    frames = {'3-4',1},
    durations = .1
  })

  player.whip:add({
    name = 'whip_right',
    pic = asm:get('whip'),
    cellsizex = 16,
    cellsizey = 16,
    frames = {'5-6',1},
    durations = .1
  })

  player.whip:add({
    name = 'whip_left',
    pic = asm:get('whip'),
    cellsizex = 16,
    cellsizey = 16,
    frames = {'7-8',1},
    durations = .1
  })

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
  player.mainSprite:add({
    name = 'player_hurt_down',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {13,1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_hurt_up',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {14,1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_hurt_right',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {15,1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_hurt_left',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {16,1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_hit_down',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {17,1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_hit_up',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {18,1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_hit_right',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {19,1},
    durations = .1
  })
  player.mainSprite:add({
    name = 'player_hit_left',
    pic = asm:get('player'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {20,1},
    durations = .1
  })

  player.mainSprite:setAnimation('player_walk_down')
  player.whip:setAnimation('whip_down')

  function player:oTick(dt)
  end

  function player:setDirection()
    local r = self.joystick:get('right')
    local l =self.joystick:get('left')
    local d = self.joystick:get('down')
    local u = self.joystick:get('up')

    if u+d+l+r ~= 0 then
      self.direction.x = self.joystick:get('right')-self.joystick:get('left')
      self.direction.y = self.joystick:get('down')-self.joystick:get('up')
      self.move = true
    else
      self.move = false
    end
  end

  --idle state
  function player:whileIdle(dt)
    self:setDirection()
    if self.mainBody:collideFamily('ennemy') and self.state.currentState == 'Vulnerable' then
      self.hurtdir = self.mainBody:collideFamily('ennemy')
      self.action:transition('Hurting')
    end
    self.hurtdir = self.mainBody:collideFamily('ennemy')
    if self.move then self.action:transition('Moving') end
    if self.joystick:pressed('hit') then self.action:transition('Hitting') end
  end

  function player:onEnterIdle()
    self.mainSprite:setAnimation('player_walk_'..cardinalDirSimple(self.direction))
    self.mainSprite:gotoFrame(1)
    self.mainSprite:pause()
    self.speed = 0
  end

  --moving state
  function player:onEnterMoving()
    self.speed = 100
  end

  function player:whileMoving(dt)
    self:setDirection()
    self:moveCollide(self.direction:normalizeInplace() * self.speed * dt,self.mainBody)
    if self.mainBody:collideFamily('ennemy') and self.state.currentState == 'Vulnerable' then
      self.hurtdir = self.mainBody:collideFamily('ennemy')
      self.action:transition('Hurting')
    end
    if self.joystick:pressed('hit') then self.action:transition('Hitting') end
    if not self.move then self.action:transition('Idle')
    else self.mainSprite:setAnimation('player_walk_'..cardinalDirSimple(self.direction)) end
  end

  --hitting state
  function player:onEnterHitting()
    self.hitBox.position = self.position + self.hitBox.offset
    self.whip:gotoFrame(1)
    self.hitBox:setActive(true)
    self.hitBox.active = true
    self.whip.visible = true

    local direction = cardinalDirSimple(self.direction)
    self.whip:setAnimation('whip_'..direction)
    if direction == 'down' then
      self.whip.offset = vec2(0,24)
      self.hitBox:tpCollide(self.position + vec2(0,24))
    elseif direction == 'up' then
      self.whip.offset = vec2(0,-16)
      self.hitBox:tpCollide(self.position + vec2(0,-16))
    elseif direction == 'right' then
      self.whip.offset = vec2(16,8)
      self.hitBox:tpCollide(self.position + vec2(16,8))
    elseif direction == 'left' then
      self.whip.offset = vec2(-16,8)
      self.hitBox:tpCollide(self.position + vec2(-16,8))
    end
  end

  function player:whileHitting(dt)
    self.mainSprite:setAnimation('player_hit_'..cardinalDirSimple(self.direction))
  end

  function player:onExitHitting()
    self.whip.visible = false
    self.hitBox:setActive(false)
    self.whip.offset = vec2(0,24)
  end

  --hurting state
  function player:onEnterHurting()
    self.redflash:play()
    self.state:transition('Invulnerable')
  end

  function player:whileHurting(dt)
    self.mainSprite:setAnimation('player_hurt_'..cardinalDirSimple(self.direction))
    self:moveCollide(-self.hurtdir:normalizeInplace() *30* dt,self.mainBody)
    if not self.mainBody:collideFamily('ennemy') then
      self.action:transition('Idle')
    end
  end
  -------------

  function player:moveCollide(vector,body)
    --moves the player according to a c_body collisions
    self.position = body:moveCollide(vector)
  end

  function player:tpCollide(vector,body)
    --moves the player according to a c_body collisions
    self.position = body:tpCollide(vector)
  end

  function player:oDraw()
    if self.state.currentState == 'Invulnerable' then
      self.flicker = not self.flicker
      self.visible = self.flicker
    else
      self.visible = true
    end
  end

  player.action:initialize('Idle')
  player.state:initialize('Vulnerable')
  return player
end

return Player
