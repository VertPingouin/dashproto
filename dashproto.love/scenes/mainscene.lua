MainScene = {}

function MainScene:new(parent)
  local mainScene = entity:new('mainScene',{tags={'visible','ticking'},parent=parent})

  mainScene.player = player:new(self,1,1)
  mainScene.control = control:new(self,1,1)


  function mainScene:tick(dt)
    local newmove = self.control:getAxis(1)
    self.player:setMovement(newmove.x,newmove.y)
  end

  return mainScene
end

return MainScene
