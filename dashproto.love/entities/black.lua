Black = {}

function Black:new(parent,a)
  local check = acheck:new()
  check:add({
    {'name','mandatory','string'}
  })

  local black = entity:new({
    name=a.name,
    parent=parent,
    layer = params.maxlayer,
    tags={'visible','ticking'}
  })

  black:add(
    c_rectangle,'black',{
    position = vec2(-1000,-1000),
    size = vec2(3000,3000),
    color = color:new(0,0,0,255)}
  )

  black:add(c_counter,'timer',{time = .6})
  black:setVisible(false)

  function black:on(time)
    if time then
      self.timer.time = time
      self.timer:start()
    end
    self:setVisible(true)
  end

  function black:off()
    self:setVisible(false)
  end

  function black:oTick(dt)
    if self.timer.ended then
      self:off()
    end
  end

  return black
end


return Black
