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
    tags={'ticking','visible','player','pauseable'},
    parent=parent,
    layer=2
  })

  player.game = obm:get('game')
  player.position = a.position
  player.direction = vec2(0,1)
  player.move = false
  player.speed = 1
  player.flicker = true

  --we get the joy1 (child of game) to be able to read the input
  player.joystick = obm:get('joy1')

  --a statemachine
  player:add(c_statemachine,'action')

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

  --another state machine for invulnerability when hit
  player:add(c_statemachine,'state')
  player.state:addState('Vulnerable')
  player.state:addState('Invulnerable')
  player.state:addTransition('Vulnerable','Invulnerable',{preferred=true})
  player.state:addTransition('Invulnerable','Vulnerable',{preferred=true,ttl=1})

  --adding a body for colliding with scene
  player:add(c_body,'mainBody',{
    x=player.position.x,
    y=player.position.y,
    w=10,
    h=14,
    color=color:new(0,255,0,100),
    family='player',
    offset=vec2(3,10)
  })

  --adding a body to detect collisions between whip and ennemies
  player:add(c_body,'hitBox',{
    x=player.position.x,
    y=player.position.y,
    w=16,
    h=16,
    color=color:new(255,0,0,100),
    family='hitBox',
    offset=vec2(0,0)
  })

  --don't activate whip hitbox now
  player.hitBox:setActive(false)

  --create a redflash effect when player is hurt
  player:add(c_effect,'redflash',{
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
  ]]})

  --create a sprite for the whip
  --whip is not visible now
  player:add(c_sprite,'whip')
  player.whip.visible = false

  --add animations for the whip
  local a_whip = require('assets/animations/a_whip')
  player.whip:add(a_whip.right)
  player.whip:add(a_whip.left)
  player.whip:add(a_whip.down)
  player.whip:add(a_whip.up)

  --create sprite for the player
  player:add(c_sprite,'mainSprite')

  --create animations for main sprite
  local a_player = require('assets/animations/a_player')

  player.mainSprite:add(a_player.walk_right)
  player.mainSprite:add(a_player.walk_left)
  player.mainSprite:add(a_player.walk_down)
  player.mainSprite:add(a_player.walk_up)

  player.mainSprite:add(a_player.hit_right)
  player.mainSprite:add(a_player.hit_left)
  player.mainSprite:add(a_player.hit_down)
  player.mainSprite:add(a_player.hit_up)

  player.mainSprite:add(a_player.hurt_right)
  player.mainSprite:add(a_player.hurt_left)
  player.mainSprite:add(a_player.hurt_down)
  player.mainSprite:add(a_player.hurt_up)

  --initialize animations
  player.mainSprite:setAnimation('walk_down')
  player.whip:setAnimation('down')


  function player:hurt()
    self.hurtdir = vec2(0,0)
    self.action:transition('Hurting')
  end

  --get direction from controls, direction set is never 0,0 to get the last direction faced
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

  function player:checkEnnemyCollision()
    --if we collide an ennemy
    if self.mainBody:collideFamily('ennemy') and self.state.currentState == 'Vulnerable' then
      --we compute get the vector between the two collideables
      self.hurtdir = self.mainBody:collideFamily('ennemy')
      --we transition to proper status
      self.action:transition('Hurting')
    end
  end

  --idle state
  function player:onEnterIdle()
    --set fixed sprite
    self.mainSprite:setAnimation('walk_'..cardinalDirSimple(self.direction))
    self.mainSprite:gotoFrame(1)
    self.mainSprite:pause()
  end

  function player:whileIdle(dt)
    --deccelerate
    self.speed = self.speed *.8
    self:moveCollide(self.direction:normalizeInplace() * self.speed * dt,self.mainBody)

    --set direction from controls
    self:setDirection()
    self:checkEnnemyCollision()

    --if we have a movement vector, we enter moving state
    if self.move then self.action:transition('Moving') end

    --if attack is pressed we enter the hitting state
    if self.joystick:pressed('hit') then self.action:transition('Hitting') end
  end

  --moving state
  function player:onEnterMoving()
    --define moving speed
    self.speed = 110
  end

  function player:whileMoving(dt)
    --set direction from controls
    self:setDirection()

    --move the player
    self:moveCollide(self.direction:normalizeInplace() * self.speed * dt,self.mainBody)

    --if we collide an ennemy while moving
    self:checkEnnemyCollision()
    if self.joystick:pressed('hit') then self.action:transition('Hitting') end
    if not self.move then self.action:transition('Idle')
    else self.mainSprite:setAnimation('walk_'..cardinalDirSimple(self.direction)) end
  end

  --hitting state
  function player:onEnterHitting()
    evm:post('whipSound')

    --move and active the hitbox and whip sprite
    self.hitBox.position = self.position + self.hitBox.offset
    self.whip:gotoFrame(1)
    self.hitBox:setActive(true)
    self.hitBox.active = true
    self.whip.visible = true

    --set whip animation and whip hitbox offset related to player's direction
    local direction = cardinalDirSimple(self.direction)
    self.whip:setAnimation(direction)
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
    self:checkEnnemyCollision()
    --deccelerate
    self.speed = 0
    --animate player
    self.mainSprite:setAnimation('hit_'..cardinalDirSimple(self.direction))
  end

  function player:onExitHitting()
    --deactivate whip
    self.whip.visible = false
    self.hitBox:setActive(false)
    self.whip.offset = vec2(0,24)
  end

  --hurting state
  function player:onEnterHurting()
    evm:post('hurtSound')
    self.game.playerHp = self.game.playerHp -1
    log:post('RAW','player','hp='..tostring(self.game.playerHp))
    --effect red flash
    self.redflash:play()
    --shake camera
    obm:get('camera'):shake(.2,1)
    --make player Invulnerable for a while
    self.state:transition('Invulnerable')
  end

  function player:whileHurting(dt)
    --whange animation
    self.mainSprite:setAnimation('hurt_'..cardinalDirSimple(self.direction))
    --eject player until it doesn't collide with ennemy anymore
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
    --make player licker when invulnerable
    if self.state.currentState == 'Invulnerable' then
      self.flicker = not self.flicker
      self.visible = self.flicker
    else
      self.visible = true
    end
  end

  --initialize statemachines
  player.action:initialize('Idle')
  player.state:initialize('Vulnerable')
  return player
end

return Player
