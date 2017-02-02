Camera = {}

function Camera:new(parent)
  local camera = entity({
    name='player',
    tags={'ticking','camera'},
    parent=parent
  })

  return camera
end

return Camera
