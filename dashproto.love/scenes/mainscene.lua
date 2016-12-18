MainScene = {}

function MainScene:new(parent)
  local mainScene = entity:new('mainScene',1,{tags={'visible','ticking'},parent=parent})

  mainScene.player = player:new(self)
  mainScene.control = control:new(self)

  function mainScene:tick(dt)
    local newmove = self.control:getAxis()
    self.player:setMovement(newmove.x,newmove.y)
  end

  return mainScene
end

return MainScene
