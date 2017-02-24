--entity game that handles scenes and switch between them

Game = {}

function Game:new()
  local game = entity:new({
    name='game',
    tags={'ticking'},
    order=2
  })

  local controls = {
    left = {'axis:leftx-', 'button:dpleft','key:left'},
    right = {'axis:leftx+', 'button:dpright','key:right'},
    up = {'axis:lefty-', 'button:dpup','key:up'},
    down = {'axis:lefty+', 'button:dpdown','key:down'},
    hit = {'button:5','key:space'}
  }

  game.joy1 = baton.new('joy1','game',controls,love.joystick.getJoysticks()[1])

  function game:setScene(scene)
    self.currentScene = scene
  end

  function game:oTick(dt)
    function love.keypressed(key,unicode)
      if key == 'f1' then
        obm:printChildren('root')
      elseif key == 'f2' then
        obm:printVisible()
      elseif key == 'f3' then
        obm:printTicking()
      elseif key == 'f4' then
        evm:post('test')
      elseif key == 'escape' then
        love.event.quit()
      end
    end
  end

  return game
end

return Game
