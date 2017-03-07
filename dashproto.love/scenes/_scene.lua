Scene = {}
function Scene:new(parent,name)
  local scene = entity:new({
    name=name,
    tags={'ticking','visible'},
    parent=parent,
    layer = minlayer
  })

  scene.world = bump.newWorld(tilesize,name)
  scene.loaded = false

  function scene:oLoad() end

  function scene:load()
    self.oLoad() --load the scene
    scene.loaded = true --scene is loaded
    obm:callByTag('pauseable','setPause',{false}) --unpause scene
  end

  function scene:unload()
    obm:callByTag('pauseable','setPause',{true}) --pause scene
    self:destroy() --we destroy scene
  end

  return scene
end
return Scene
