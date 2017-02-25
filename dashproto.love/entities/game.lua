--entity game that handles scenes and switch between them

Game = {}

function Game:new()
  local game = entity:new({
    name='game',
    tags={'ticking'},
    order=1
  })

  local controls = {
    left = {'axis:leftx-', 'button:dpleft','key:left'},
    right = {'axis:leftx+', 'button:dpright','key:right'},
    up = {'axis:lefty-', 'button:dpup','key:up'},
    down = {'axis:lefty+', 'button:dpdown','key:down'},
    hit = {'button:5','key:space'}
  }

  game.joy1 = baton.new('joy1','game',controls,love.joystick.getJoysticks()[1])
  game.playerHp = 10
  game.currentScene = nil

  --unload current scene and load a new, optionally spawn the player on a certain spawnpoint
  function game:setScene(scene, playerSpawn)
    if self.currentScene then
      self.currentScene:unload()
      self.currentScene = nil
    end
    self.currentScene = require('scenes/'..scene):load('game',playerSpawn)
  end

  function game:oTick(dt)
    --if player collides a passage, goto the proper scene with proper position
    local passage = obm:get('player').mainBody:getCollideFamily('passage')
    if passage then
      self:setScene(passage.destination,passage.spawn)
    end

    --display debug infos
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
