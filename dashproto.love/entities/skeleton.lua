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

  skeleton.movement = vec2(0,0)

  --a statemachine
  skeleton:add(c_statemachine:new(skeleton,'mainFSM'),'mainFSM')
  skeleton.mainFSM:addState('Idle',{enter='onEnterIdle'})
  skeleton.mainFSM:addState('Moving',{enter='onEnterMoving'})
  skeleton.mainFSM:addTransition('Idle','Moving')
  skeleton.mainFSM:addTransition('Moving','Idle')
  skeleton.mainFSM:setInitialState('Idle')

  skeleton:add(c_body:new(skeleton,'mainBody',{
    x=skeleton.position.x,
    y=skeleton.position.y,
    w=10,
    h=14,
    color=color:new(0,255,0,50),
    family='ennemy',
    offset=vec2(3,10)
  }),'mainBody')

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

  function skeleton:oTick(dt)
    local dice = math.random(50)
    if dice == 1 then
      self:rerollDirection()
    end

    if self.movement.x ~= 0 or self.movement.y ~= 0 then
      skeleton.mainFSM:transition('Moving')
      if self.movement.x == 0 then
        if self.movement.y > 0 then
          self.mainSprite:setAnimation('skeleton_walk_down')
        else
          self.mainSprite:setAnimation('skeleton_walk_up')
        end
      else
        if self.movement.x > 0 then
          self.mainSprite:setAnimation('skeleton_walk_right')
        else
          self.mainSprite:setAnimation('skeleton_walk_left')
        end
      end

      local vec,col = self:moveCollide(self.movement:normalizeInplace() * 20 * dt,self.mainBody)
      if col>0 then self:rerollDirection() end
    else
      skeleton.mainFSM:transition('Idle')
    end
  end

  function skeleton:rerollDirection()
    self.movement.x = math.random(-1,1)
    self.movement.y = math.random(-1,1)
  end

  function skeleton:moveCollide(vector,body)
    --moves the skeleton according to a c_body collisions
    local vec,col = body:moveCollide(vector)
    self.position = vec
    return vec,col
  end

  function skeleton:tpCollide(vector,body)
    --moves the skeleton according to a c_body collisions
    local vec,col = body:tpCollide(vector)
    self.position = vec
    return vec,col
  end

  function skeleton:onEnterIdle()
    self.mainSprite:gotoFrame(1)
    self.mainSprite:pause()
  end

  function skeleton:onEnterMoving()
    self.mainSprite:resume()
  end

  function skeleton:oDraw()
  end

  return skeleton
end

return Skeleton
