MainScene = {}

function MainScene:new(parent)
  local mainScene = scene:new(parent,'mainScene')
  mainScene.player = player:new('mainScene')
  mainScene.collider = collider:new('mainScene',{x=500,y=100,w=200,h=200})
  mainScene.collider = collider:new('mainScene',{x=400,y=500,w=200,h=200})

  function mainScene:tick(dt)
  end

  return mainScene
end

return MainScene
