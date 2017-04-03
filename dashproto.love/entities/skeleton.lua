local pi =math.pi
Skeleton = {}

function Skeleton:new(parent,a)
  local check = acheck:new()
  check:add({
    {'position','mandatory','table'},
    {'name','mandatory','string'}
  })
  a=check:check(a)


  local skeleton = entity:new({
    name=a.name,
    tags={'ticking','visible','skeleton','ennemy','pauseable'},
    parent=parent,
    layer=2
  })
  --TODO skeletons die one hit while wandering
  skeleton.position = a.position
  skeleton.speed = 20
  skeleton.movement = vec2(1,1)
  skeleton.hp = 3

  --a statemachine
  skeleton:add(c_statemachine,'behavior')
  skeleton.behavior:addState('Agressive',{enter='onEnterAgressive',step='whileAgressive'})
  skeleton.behavior:addState('Wandering',{enter='onEnterWandering',step='whileWandering'})
  skeleton.behavior:addState('Retreating',{enter='onEnterRetreating',step='whileRetreating'})
  skeleton.behavior:addState('Dying',{enter='onEnterDying'})
  skeleton.behavior:addState('Dead',{enter='onEnterDead'})
  skeleton.behavior:addTransition('Agressive','Wandering')
  skeleton.behavior:addTransition('Wandering','Agressive')
  skeleton.behavior:addTransition('Agressive','Retreating')
  skeleton.behavior:addTransition('Wandering','Retreating')
  skeleton.behavior:addTransition('Retreating','Wandering',{preferred=true,ttl=.2})
  skeleton.behavior:addTransition('Retreating','Dying')
  skeleton.behavior:addTransition('Dying','Dead',{preferred=true,ttl=.9})
  skeleton.behavior:setInitialState('Wandering')

  skeleton:add(c_body,'mainBody',{
    x=skeleton.position.x,
    y=skeleton.position.y,
    w=10,
    h=14,
    color=color:new(0,255,0,50),
    family='ennemy',
    offset=vec2(3,10)
  })

  skeleton:add(c_body,'hurtBody',{
    x=skeleton.position.x,
    y=skeleton.position.y,
    w=12,
    h=20,
    color=color:new(255,0,0,50),
    family='hurt',
    offset=vec2(2,4)
  })

  skeleton:add(c_look,'evilLook',{
    target=obm:get('player'),
    offset = vec2(8,24),
    targetOffset = vec2(8,24),
    distance = 100}
  )

  skeleton:add(c_effect,'whiteflash',{
  duration = .1,
  fadein = 0,
  fadeout = .2,
  shader=[[
  extern number amount;
  vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
    vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    pixel.r = pixel.r + amount;
    pixel.g = pixel.g + amount;
    pixel.b = pixel.b + amount;
    return pixel;
  }
  ]]})

  skeleton:add(c_sprite,'mainSprite')
  skeleton.mainSprite:add(require('assets/animations/a_skeleton_walk_right'))
  skeleton.mainSprite:add(require('assets/animations/a_skeleton_walk_left'))
  skeleton.mainSprite:add(require('assets/animations/a_skeleton_walk_up'))
  skeleton.mainSprite:add(require('assets/animations/a_skeleton_walk_down'))
  skeleton.mainSprite:add(require('assets/animations/a_skeleton_die'))
  skeleton.mainSprite:setAnimation('skeleton_walk_down')

  function skeleton:onEnterWandering()
    self.speed = 20
  end

  function skeleton:onEnterAgressive()
    self.speed = 70
  end

  function skeleton:whileWandering(dt)
    --move skeleton along his direction
    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,self.mainBody)

    --go perpendicular if obstacle
    if col>0 then self.movement = self.movement:perpendicular() end

    --set sprite according to direction
    self.mainSprite:setAnimation('skeleton_walk_'..cardinalDir(self.movement:normalizeInplace()))

    --reroll direction
    local dice = math.random(0, 50)
    if dice == 1 then self:rerollDirection() end

    --check if skeleton is hit
    self:checkHit()

    --become agressive if player seen
    if self.evilLook:see() then self.behavior:transition('Agressive') end

    --if player is hurt then retreat
    if self.mainBody:collideName('player.mainBody') then
      self.speed = 100
      self.behavior:transition('Retreating')
    end

  end

  function skeleton:whileAgressive(dt)
    --move skeleton along his direction
    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,self.mainBody)

    --go perpendicular if obstacle
    if col>0 then self.movement = self.movement:perpendicular() end

    --set sprite according to direction
    self.mainSprite:setAnimation('skeleton_walk_'..cardinalDir(self.movement:normalizeInplace()))

    --check if skeleton is hit
    self:checkHit()

    local look = self.evilLook:see()
    --if player seen then move toward him
    if look then
      self.movement = look:normalizeInplace()
      --retreat if collision with player
      if self.mainBody:collideName('player.mainBody') then
        self.speed = 100
        self.behavior:transition('Retreating')
      end
    else
      --if player is not seen then return to wandering state
      self.behavior:transition('Wandering')
    end
  end

  function skeleton:onEnterDying()
    evm:post('sound',{'die'})
  end

  function skeleton:onEnterDead()
    self:destroy()
  end

  function skeleton:onEnterRetreating()
    if self.hp == 0 then
      self.movement = vec2(0,0)
      self.hurtBody:setActive(false)
      self.mainBody:setActive(false)
      self.mainSprite:setAnimation('skeleton_die')
      self.behavior:transition('Dying')
    end
  end

  function skeleton:whileRetreating(dt)
    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,self.mainBody)
    if col>0 then self.movement = self.movement:perpendicular() end
    self.mainSprite:setAnimation('skeleton_walk_'..cardinalDir(-self.movement:normalizeInplace()))

    local look = self.evilLook:see()
    if look then
      self.movement = -look:normalizeInplace()
    end
  end

  function skeleton:oTick(dt)
  end

  function skeleton:rerollDirection()
    self.movement:rotateInplace(math.random(0,2*pi))
  end

  function skeleton:moveCollide(vector,body)
    --moves the skeleton according to a c_body collisions
    local vec,col = body:moveCollide(vector)
    self.hurtBody.position = vec + self.hurtBody.offset
    self.position = vec
    return vec,col
  end

  function skeleton:tpCollide(vector,body)
    --moves the skeleton according to a c_body collisions
    local vec,col = body:tpCollide(vector)
    self.hurtBody.position = vec
    self.position = vec
    return vec,col
  end

  function skeleton:oDraw()
  end

  function skeleton:checkHit()
    if self.mainBody:collideName('player.hitBox') then
      self.whiteflash:play()
      self.hp = self.hp-1
      evm:post('sound',{'hit'})
      obm:get('camera'):shake(.1,1)
      self.speed = 100
      self.behavior:transition('Retreating')
    end
  end

  skeleton:rerollDirection()
  return skeleton
end

return Skeleton
