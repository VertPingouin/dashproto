--entity game that handles scenes and switch between them

Game = {}

function Game:new()
  local game = entity:new('game',{tags={'ticking'},order=2})

  local controls = {
    left = {'axis:leftx-', 'button:dpleft'},
    right = {'axis:leftx+', 'button:dpright'},
    up = {'axis:lefty-', 'button:dpup'},
    down = {'axis:lefty+', 'button:dpdown'},
    shoot = {'key:x', 'button:a'}
  }

  game.joy1 = baton.new('joy1','game',controls,love.joystick.getJoysticks()[1])

  function game:setScene(scene)
    self.currentScene = scene
  end

  function game:tick(dt)
  end

  return game
end

return Game
