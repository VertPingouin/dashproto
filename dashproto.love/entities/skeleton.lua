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
    tags={'ticking','visible','skeleton','ennemy'},
    parent=parent,
    layer=2
  })

  skeleton.position = a.position
  skeleton.speed = 20
  skeleton.movement = vec2(1,1)
  skeleton.hp = 3

  --a statemachine
  skeleton:add(c_statemachine:new(skeleton,'behavior'),'behavior')
  skeleton.behavior:addState('Agressive',{enter='onEnterAgressive',step='whileAgressive'})
  skeleton.behavior:addState('Wandering',{enter='onEnterWandering',step='whileWandering'})
  skeleton.behavior:addState('Retreating',{enter='onEnterRetreating',step='whileRetreating'})
  skeleton.behavior:addState('Dying',{enter='onEnterDying'})
  skeleton.behavior:addState('Dead',{enter='onEnterDead'})
  skeleton.behavior:addTransition('Agressive','Wandering')
  skeleton.behavior:addTransition('Wandering','Agressive')
  skeleton.behavior:addTransition('Agressive','Retreating')
  skeleton.behavior:addTransition('Retreating','Wandering',{preferred=true,ttl=.2})
  skeleton.behavior:addTransition('Retreating','Dying')
  skeleton.behavior:addTransition('Dying','Dead',{preferred=true,ttl=.9})
  skeleton.behavior:setInitialState('Wandering')

  skeleton:add(c_body:new(skeleton,'mainBody',{
    x=skeleton.position.x,
    y=skeleton.position.y,
    w=10,
    h=14,
    color=color:new(0,255,0,50),
    family='ennemy',
    offset=vec2(3,10)
  }),'mainBody')

  skeleton:add(c_body:new(skeleton,'hurtBody',{
    x=skeleton.position.x,
    y=skeleton.position.y,
    w=12,
    h=20,
    color=color:new(255,0,0,50),
    family='hurt',
    offset=vec2(2,4)
  }),'hurtBody')

  skeleton:add(c_look:new(skeleton,'evilLook',{
    target=obm:get('player'),
    offset = vec2(8,24),
    targetOffset = vec2(8,24),
    distance = 100}
  ))

  skeleton:add(c_effect:new(skeleton,'whiteflash',{
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
  ]]}))

  skeleton:add(c_sprite:new(skeleton,'mainSprite'))
  skeleton.mainSprite:add({
    name = 'skeleton_walk_down',
    pic = asm:get('skeleton'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'2-3',1,'2-1',1},
    durations = .1
  })
  skeleton.mainSprite:add({
    name = 'skeleton_walk_up',
    pic = asm:get('skeleton'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'5-6',1,'5-4',1},
    durations = .1
  })
  skeleton.mainSprite:add({
    name = 'skeleton_walk_right',
    pic = asm:get('skeleton'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'8-9',1,'8-7',1},
    durations = .1
  })
  skeleton.mainSprite:add({
    name = 'skeleton_walk_left',
    pic = asm:get('skeleton'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {'11-12',1,'11-10',1},
    durations = .1
  })
  skeleton.mainSprite:add({
    name = 'skeleton_die',
    pic = asm:get('skeleton'),
    cellsizex = 16,
    cellsizey = 24,
    frames = {3,1,'13-14',1},
    durations = .3
  })
  skeleton.mainSprite:setAnimation('skeleton_walk_down')

  function skeleton:onEnterWandering()
    self.speed = 20
  end

  function skeleton:onEnterAgressive()
    self.speed = 70
  end

  function skeleton:whileWandering(dt)
    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,self.mainBody)
    if col>0 then self.movement = self.movement:perpendicular() end
    self.mainSprite:setAnimation('skeleton_walk_'..cardinalDir(self.movement:normalizeInplace()))
    local dice = math.random(0, 50)
    if dice == 1 then self:rerollDirection() end
    if self.evilLook:see() then self.behavior:transition('Agressive') end
  end

  function skeleton:whileAgressive(dt)
    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,self.mainBody)
    if col>0 then self.movement = self.movement:perpendicular() end
    self.mainSprite:setAnimation('skeleton_walk_'..cardinalDir(self.movement:normalizeInplace()))
    local look = self.evilLook:see()
    if look then
      self.movement = look:normalizeInplace()
      if self.mainBody:collideName('player.mainBody') then
        self.speed = 100
        self.behavior:transition('Retreating')
      elseif self.mainBody:collideName('player.hitBox') then
        self.whiteflash:play()
        self.hp = self.hp-1
        obm:get('camera'):shake(.1,1)
        self.speed = 100
        self.behavior:transition('Retreating')
      end
    else
      self.behavior:transition('Wandering')
    end
  end

  function skeleton:onEnterDying()
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
    else
      self.behavior:transition('Wandering')
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

  skeleton:rerollDirection()
  return skeleton
end

return Skeleton
