MainScene = {}

function MainScene:new(parent)
  local mainScene = scene:new(parent,'mainScene')
  mainScene.map = map:new('mainScene','mainSceneMap',{luamap=require('maps/test'),position=vec2(0,0)})
  mainScene.bg = tilemap:new('mainScene','bg',{luamap=require('maps/test'),asset='graveyard',position=vec2(0,0),layer=1})
  mainScene.l1 = tilemap:new('mainScene','l1',{luamap=require('maps/test'),asset='graveyard',position=vec2(0,0),layer=2})
  mainScene.l2 = tilemap:new('mainScene','l2',{luamap=require('maps/test'),asset='graveyard',position=vec2(0,0),layer=2})

  mainScene.map2 = map:new('mainScene','mainSceneMap2',{luamap=require('maps/test'),position=vec2(32*16,0)})

  mainScene.player = player:new('mainScene',{position=mainScene.map:getSpawn('player')[1]})
  local skellyspawn = mainScene.map:getSpawn('skeleton')
  for i,pos in ipairs(skellyspawn) do
    local name = 'skeleton'..i
    mainScene[name] = skeleton:new('mainScene',{position=pos,name=name})
  end

  mainScene.camera = camera:new('mainScene',{w=params.nativeresx,h=params.nativeresy,target=mainScene.player.mainBody,boundaries=mainScene.map.boundaries})
  function mainScene:tick(dt)
  end

  return mainScene
end

return MainScene
