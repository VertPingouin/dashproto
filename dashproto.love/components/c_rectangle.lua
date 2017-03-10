C_rectangle = {}
function C_rectangle:new(owner,id,a)
  local c_rectangle = component:new(owner,id,a)
  local check = acheck:new()
  check:add({
    {'position','mandatory','table'},
    {'size','mandatory','table'},
    {'color','defaultValue','table',color:new(255,255,255,255)}
  })
  a = check:check(a)

  c_rectangle.position = a.position
  c_rectangle.size = a.size
  c_rectangle.color = a.color

  function c_rectangle:draw()
    love.graphics.setColor(
      self.color.r,
      self.color.g,
      self.color.b,
      self.color.a
    )
    love.graphics.rectangle( 'fill',
      self.position.x,
      self.position.y,
      self.size.x,
      self.size.y
    )
    love.graphics.setColor(255,255,255,255)
  end

  return c_rectangle
end

return C_rectangle
