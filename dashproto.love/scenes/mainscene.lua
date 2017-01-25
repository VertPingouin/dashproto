MainScene = {}

function MainScene:new(parent)
  local mainScene = entity:new('mainScene',{tags={'visible','ticking'},parent=parent})

  mainScene.player = player:new('mainScene')

  function mainScene:tick(dt)
  end

  return mainScene
end

return MainScene
