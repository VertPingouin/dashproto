Camera = {}

function Camera:new(parent)
  local camera = entity({
    name='camera',
    tags={'ticking'},
    parent=parent
  })

  return camera
end

return Camera
