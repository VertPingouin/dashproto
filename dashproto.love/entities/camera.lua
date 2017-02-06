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
  camera:add(c_body:new(camera,'viewport',{x=0,y=0,w=a.w,h=a.h,color=color:new(0,0,255,0),family='viewport',layer=minlayer}),'viewport')

  function camera:setTarget(target)
  end

  function camera:oTick(dt)
    --center camera on object respecting the boundaries
    self.viewport.center = self.target.center
    if self.viewport.left < self.boundaries.left then
      self.viewport.left = self.boundaries.left
    end

    if self.viewport.right > self.boundaries.right then
      self.viewport.right = self.boundaries.right
    end

    if self.viewport.top < self.boundaries.top then
      self.viewport.top = self.boundaries.top
    end

    if self.viewport.bottom > self.boundaries.bottom then
      self.viewport.bottom = self.boundaries.bottom
    end

    self.position.x = self.viewport.left
    self.position.y = self.viewport.top
  end
  function camera:oDraw()
    love.graphics.push()
    love.graphics.translate(-self.position.x,-self.position.y)
  end

  return camera
end

return Camera
