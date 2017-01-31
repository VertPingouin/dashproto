MainScene = {}

function MainScene:new(parent)
  local mainScene = scene:new(parent,'mainScene')
  mainScene.map = map:new('mainScene','mainSceneMap',{luamap=require('maps/test')})
  mainScene.player = player:new('mainScene',{position=mainScene.map:getSpawn('player')})

  function mainScene:tick(dt)
  end

  return mainScene
end

return MainScene
