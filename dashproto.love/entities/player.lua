Player = {}

function Player:new(parent)
  local player = entity:new('player',1,{tags={'visible','ticking'},parent=parent})

  player.position = vec2:new(500,200)
  player.movement = vec2:new(0,0)

  function player:setMovement(x,y)
    self.movement.x = x
    self.movement.y = y
  end

  function player:tick(dt)
    self.position.x = self.position.x + self.movement.x * dt * 200
    self.position.y = self.position.y + self.movement.y * dt * 200
  end

  function player:draw()
    love.graphics.circle("fill", self.position.x, self.position.y, 30)
  end

  return player
end

return Player
