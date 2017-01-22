--entity game that handles scenes and switch between them

Game = {}

function Game:new()
  local game = entity:new('game',{tags={'ticking'}})

  function game:setScene(scene)
    self.currentScene = scene
  end

  function game:tick(dt)
  end

  return game
end

return Game
