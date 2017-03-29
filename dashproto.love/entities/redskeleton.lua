local pi =math.pi
RedSkeleton = {}

function RedSkeleton:new(parent,a)
  local check = acheck:new()
  check:add({
    {'position','mandatory','table'},
    {'name','mandatory','string'}
  })
  a=check:check(a)


  local redskeleton = entity:new({
    name=a.name,
    tags={'ticking','visible','redskeleton','ennemy','pauseable'},
    parent=parent,
    layer=2
  })

  redskeleton.position = a.position
  redskeleton.speed = 20
  redskeleton.movement = vec2(1,1)
  redskeleton.hp = 1
  redskeleton.delay = 0
  redskeleton.parent = obm:getParent(redskeleton.name).name

  --a statemachine
  redskeleton:add(c_statemachine,'behavior')
  redskeleton.behavior:addState('Fleeing',{enter='onEnterFleeing',step='whileFleeing'})
  redskeleton.behavior:addState('Throwing',{enter='onEnterThrowing', step='whileThrowing'})
  redskeleton.behavior:addState('Wandering',{enter='onEnterWandering',step='whileWandering'})
  redskeleton.behavior:addState('Retreating',{enter='onEnterRetreating',step='whileRetreating'})
  redskeleton.behavior:addState('Dying',{enter='onEnterDying'})
  redskeleton.behavior:addState('Dead',{enter='onEnterDead'})
  redskeleton.behavior:addTransition('Wandering','Throwing')
  redskeleton.behavior:addTransition('Fleeing','Throwing')
  redskeleton.behavior:addTransition('Throwing','Wandering',{preferred=true,ttl=.6})
  redskeleton.behavior:addTransition('Fleeing','Wandering')
  redskeleton.behavior:addTransition('Wandering','Fleeing')
  redskeleton.behavior:addTransition('Fleeing','Dying')
  redskeleton.behavior:addTransition('Throwing','Dying')
  redskeleton.behavior:addTransition('Dying','Dead',{preferred=true,ttl=.9})
  redskeleton.behavior:setInitialState('Wandering')

  redskeleton:add(c_body,'mainBody',{
    x=redskeleton.position.x,
    y=redskeleton.position.y,
    w=10,
    h=14,
    color=color:new(0,255,0,50),
    family='ennemy',
    offset=vec2(3,10)
  })

  redskeleton:add(c_body,'hurtBody',{
    x=redskeleton.position.x,
    y=redskeleton.position.y,
    w=12,
    h=20,
    color=color:new(255,0,0,50),
    family='hurt',
    offset=vec2(2,4)
  })

  redskeleton:add(c_look,'fearlook',{
    target=obm:get('player'),
    offset = vec2(8,24),
    targetOffset = vec2(8,24),
    distance = 40})

    redskeleton:add(c_look,'evillook',{
      target=obm:get('player'),
      offset = vec2(8,24),
      targetOffset = vec2(8,24),
      distance = 100})

  redskeleton:add(c_effect,'whiteflash',{
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

  redskeleton:add(c_sprite,'mainSprite')

  local a_redskeleton = require('assets/animations/a_redskeleton')
  redskeleton.mainSprite:add(a_redskeleton.walk_right)
  redskeleton.mainSprite:add(a_redskeleton.walk_left)
  redskeleton.mainSprite:add(a_redskeleton.walk_up)
  redskeleton.mainSprite:add(a_redskeleton.walk_down)
  redskeleton.mainSprite:add(a_redskeleton.die)
  redskeleton.mainSprite:add(a_redskeleton.throw_right)
  redskeleton.mainSprite:add(a_redskeleton.throw_left)
  redskeleton.mainSprite:add(a_redskeleton.throw_up)
  redskeleton.mainSprite:add(a_redskeleton.throw_down)

  redskeleton.mainSprite:setAnimation('walk_down')

  function redskeleton:onEnterWandering()
    self.speed = 20
  end

  function redskeleton:onEnterFleeing()
    self.speed = 100
  end

  function redskeleton:onEnterThrowing()
    self.speed = 0
    local look = self.evillook
    self.movement = self.evillook:see()
    self.mainSprite:setAnimation('throw_'..cardinalDir(self.movement:normalizeInplace()))
    self.delay = math.random(1,5)
    redbone:new(self.parent,{position=self.position,movement=self.movement:normalizeInplace()})
  end

  function redskeleton:whileThrowing(dt)
  end

  function redskeleton:whileWandering(dt)
    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,self.mainBody)
    if col>0 then self.movement = self.movement:perpendicular() end
    self.mainSprite:setAnimation('walk_'..cardinalDir(self.movement:normalizeInplace()))
    local dice = math.random(0, 50)
    if dice == 1 then self:rerollDirection() end
    if self.fearlook:see() then self.behavior:transition('Fleeing') end
    if self.evillook:see() and self.delay == 0 then
      self.behavior:transition('Throwing')
    end
  end

  function redskeleton:whileFleeing(dt)
    local vec,col = self:moveCollide(self.movement:normalizeInplace() * self.speed * dt,self.mainBody)
    if col>0 then self.movement = self.movement:perpendicular() end
    self.mainSprite:setAnimation('walk_'..cardinalDir(self.movement:normalizeInplace()))
    local look = self.fearlook:see()

    if look then
      self.movement = -look:normalizeInplace()
    else
      self.behavior:transition('Wandering')
    end
  end

  function redskeleton:onEnterDying()
    evm:post('sound',{'die'})
    self.whiteflash:play()
    obm:get('camera'):shake(.1,1)
    self.movement = vec2(0,0)
    self.hurtBody:setActive(false)
    self.mainBody:setActive(false)
    self.mainSprite:setAnimation('die')
  end

  function redskeleton:onEnterDead()
    self:destroy()
  end

  function redskeleton:oTick(dt)
    if self.delay > 0 then self.delay = self.delay - dt end
    if self.delay < 0 then self.delay = 0 end
    self:checkHit()
  end

  function redskeleton:rerollDirection()
    self.movement:rotateInplace(math.random(0,2*pi))
  end

  function redskeleton:moveCollide(vector,body)
    --moves the redskeleton according to a c_body collisions
    local vec,col = body:moveCollide(vector)
    self.hurtBody.position = vec + self.hurtBody.offset
    self.position = vec
    return vec,col
  end

  function redskeleton:tpCollide(vector,body)
    --moves the redskeleton according to a c_body collisions
    local vec,col = body:tpCollide(vector)
    self.hurtBody.position = vec
    self.position = vec
    return vec,col
  end

  function redskeleton:checkHit()
    if self.mainBody:collideName('player.hitBox') then
      self.behavior:transition('Dying')
    end
  end

  function redskeleton:oDraw()
  end

  redskeleton:rerollDirection()
  return redskeleton
end

return RedSkeleton
