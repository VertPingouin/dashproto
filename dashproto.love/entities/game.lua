--entity game that handles scenes and switch between them

Game = {}

function Game:new()
  local game = entity:new('game',1,{tags={'ticking'}})

  function game:setScene(scene)
    self.currentScene = scene
  end

  return game
end

return Game
