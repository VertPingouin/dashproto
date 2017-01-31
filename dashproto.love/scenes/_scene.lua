--TODO implement scene boundaries
Scene = {}
function Scene:new(parent,name)
  local scene = entity:new({
    name=name,
    tags={'ticking'},
    parent=parent
  })

  scene.world = bump.newWorld(tilesize,name)

  function scene:tick(dt)
  end

  return scene
end
return Scene
