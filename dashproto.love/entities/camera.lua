Camera = {}

function Camera:new(parent,a)
  local camera = entity:new({
    name='camera',
    tags={'ticking','visible'},
    parent=parent
  })

  local check = acheck:new()
  check:add({
    {'w','mandatory','number'},
    {'h','mandatory','number'},
    {'target','mandatory','table'},
    {'boundaries','mandatory','table'}
  })
  a=check:check(a)

  camera.target = a.target
  camera.boundaries = a.boundaries
  camera.position = vec2(0,0)
  camera:add(c_body:new(camera,'viewport',{x=0,y=0,w=a.w,h=a.h,color=color:new(0,255,0,40),family='viewport',layer=minlayer}),'viewport')

  function camera:setTarget(target)
  end

  function camera:oTick(dt)
    --center camera on object respecting the boundaries
    --TODO camera follow might be done simpler
    local targetcenter = self.target:getCenter()

    local left = targetcenter.x - self.viewport.w / 2
    if left > self.boundaries.position.x then
      self.position.x = left
      self.viewport.position.x = left
    else
      targetcenter.x = self.boundaries.position.x
      self.viewport.position.x =  self.boundaries.position.x
    end

    local top = targetcenter.y - self.viewport.h / 2
    if top > self.boundaries.position.y then
      self.position.y = top
      self.viewport.position.y = top
    else
      targetcenter.y = self.boundaries.position.y
      self.viewport.position.y =  self.boundaries.position.y
    end
  end

  function camera:oDraw()
    love.graphics.push()
    love.graphics.translate(-self.viewport.position.x,-self.viewport.position.y)
  end


  return camera
end

return Camera
