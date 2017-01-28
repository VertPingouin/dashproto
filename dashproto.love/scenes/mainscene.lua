MainScene = {}

function MainScene:new(parent)
  local mainScene = scene:new(parent,'mainScene')
  mainScene.player = player:new('mainScene')
  mainScene.collider = collider:new('mainScene',500,100,200,200)
  mainScene.collider = collider:new('mainScene',400,500,200,200)

  function mainScene:tick(dt)
  end

  return mainScene
end

return MainScene
