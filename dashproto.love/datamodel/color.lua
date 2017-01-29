Color = {}

function Color:new(r,g,b,a)
  assert(r and g and b and a,'Color::new::rgba values are needed (yes, all four !)')
  local color = {r=r,g=g,b=b,a=a}

  --TODO see if love.graphics.setcolor has its place here
  return color
end

return Color
