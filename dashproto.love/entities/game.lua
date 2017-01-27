--entity game that handles scenes and switch between them

Game = {}

function Game:new()
  local game = entity:new('game',{tags={'ticking'},order=2})

  --TODO see if one axis is possible
  local controls = {
    left = {'axis:leftx-', 'button:dpleft','key:left'},
    right = {'axis:leftx+', 'button:dpright','key:right'},
    up = {'axis:lefty-', 'button:dpup','key:up'},
    down = {'axis:lefty+', 'button:dpdown','key:down'},
    tleft = {'axis:rightx-','key:q'},
    tright = {'axis:rightx+','key:d'},
    tup = {'axis:righty-','key:z'},
    tdown = {'axis:righty+','key:s'},
    dash = {'button:rightshoulder'}
  }

  game.joy1 = baton.new('joy1','game',controls,love.joystick.getJoysticks()[1])

  function game:setScene(scene)
    self.currentScene = scene
  end

  function game:tick(dt)
    function love.keypressed(key,unicode)
      if key == 'f1' then
        obm:printChildren('root')
      elseif key == 'f2' then
        obm:printVisible()
      elseif key == 'f3' then
        obm:printTicking()
      elseif key == 'escape' then
        love.event.quit()
      end
    end
  end

  return game
end

return Game
