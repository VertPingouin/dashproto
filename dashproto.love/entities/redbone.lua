RedBone = {}

function RedBone:new(parent,a)
  local unique = {}
  local redbone = entity:new({
    name = tostring(unique),
    tags={'ticking','visible','redbone','pauseable'},
    parent=parent,
    layer=2
  })

  local check = acheck:new()
  check:add({
    {'position','mandatory','table'},
    {'movement','mandatory','table'}
  })
  a=check:check(a)

  redbone:add(c_sprite,'mainSprite')
  redbone.mainSprite:add(require('assets/animations/a_redbone').redbone)
  redbone.mainSprite:setAnimation('redbone')

  redbone.position = vec2(0,0)
  redbone.movement = vec2(0,0)

  redbone.position = a.position
  redbone.movement.x = a.movement.x
  redbone.movement.y = a.movement.y

  redbone:add(c_body,'hitBox',{
    x=redbone.position.x,
    y=redbone.position.y,
    w=8,
    h=8,
    color=color:new(255,0,0,100),
    family='ennemyProjectile',
    offset=vec2(4,4)
  })

  function redbone:oTick(dt)
    self.position = self.position + self.movement*dt*200
    self.hitBox.position = self.position + self.hitBox.offset
    if
      self.hitBox:collideFamily('player') or
      self.hitBox:collideFamily('collider') or
      self.hitBox:collideName('player.hitBox')
      then
      self:destroy()
    end
  end

  function redbone:moveCollide(vector,body)
    self.position = body:moveCollide(vector)
  end


  return redbone
end


return RedBone
