MainScene = {}

function MainScene:new(parent)
  local mainScene = entity:new('mainScene',{tags={'visible','ticking'},parent=parent})

  mainScene.player = player:new(self,1,1)

  function mainScene:tick(dt)
  end

  return mainScene
end

return MainScene
