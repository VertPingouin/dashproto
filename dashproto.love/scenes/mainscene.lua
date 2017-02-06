MainScene = {}

function MainScene:new(parent)
  local mainScene = scene:new(parent,'mainScene')
  mainScene.map = map:new('mainScene','mainSceneMap',{luamap=require('maps/test'),position=vec2(0,0)})
  mainScene.player = player:new('mainScene',{position=mainScene.map:getSpawn('player')})
  mainScene.camera = camera:new('mainScene',{w=resx,h=resy,target=mainScene.player.mainBody,boundaries=mainScene.map.boundaries})
  function mainScene:tick(dt)
  end

  return mainScene
end

return MainScene
