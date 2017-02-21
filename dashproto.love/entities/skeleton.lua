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

  --a statemachine
  skeleton:add(c_statemachine:new(skeleton,'behavior'),'behavior')
  skeleton.behavior:addState('Agressive',{enter='onEnterAgressive',step='whileAgressive'})
  skeleton.behavior:addState('Wandering',{enter='onEnterWandering',step='whileWandering'})
  skeleton.behavior:addState('Retreating',{enter='onEnterRetreating',step='whileRetreating'})
  skeleton.behavior:addTransition('Agressive','Wandering')
  skeleton.behavior:addTransition('Wandering','Agressive')
  skeleton.behavior:addTransition('Agressive','Retreating')
  skeleton.behavior:addTransition('Retreating','Wandering',{preferred=true,ttl=.8})
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
    pixel.g = pixel.g+ amount;
    pixel.b = pixel.b+ amount;
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

  skeleton.mainSprite:setAnimation('skeleton_walk_down')

  function skeleton:onEnterWandering()
    self.speed = 20
  end

  function skeleton:onEnterAgressive()
    self.speed = 30
  end

  function skeleton:whileWandering()
    local dice = math.random(0, 50)
    if dice == 1 then self:rerollDirection() end
    if self.evilLook:see() then self.behavior:transition('Agressive') end
  end

  function skeleton:whileAgressive()
    local look = self.evilLook:see()
    if look then
      self.movement = look:normalizeInplace()
      if self.mainBody:collideName('player.mainBody') then
        self.speed = 20
        self.behavior:transition('Retreating')
      elseif self.mainBody:collideName('player.hitBox') then
        self.whiteflash:play()
        self.speed = 40
        self.behavior:transition('Retreating')
      end
    else
      self.behavior:transition('Wandering')
    end
  end

  function skeleton:onEnterRetreating()
  end

  function skeleton:whileRetreating()
    local look = self.evilLook:see()
    if look then
      self.movement = -look:normalizeInplace()
    else
      self.behavior:transition('Wandering')
    end
  end

  function skeleton:oTick(dt)
    local angle = 0
    if self.behavior.currentState == 'Retreating' then
      angle = self.movement:normalizeInplace():angleTo(vec2(0,1))
    else
      angle = self.movement:normalizeInplace():angleTo(vec2(0,-1))
    end

    if (angle < 0) then angle = angle + 2 * pi end

    if angle > 7*pi/4 or angle <= pi/4 then
      self.mainSprite:setAnimation('skeleton_walk_up')
    elseif pi/4 < angle and angle <= 3*pi/4 then
      self.mainSprite:setAnimation('skeleton_walk_right')
    elseif 3*pi/4 < angle and angle <= 5*pi/4 then
      self.mainSprite:setAnimation('skeleton_walk_down')
    elseif 5*pi/4 < angle and angle <= 7*pi/4 then
      self.mainSprite:setAnimation('skeleton_walk_left')
    end

    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,
      self.mainBody)
    if col>0 then self.movement = self.movement:perpendicular() end
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
