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
    hit = {'button:5','key:space'},
    pause = {'button:start','key:p'},
    f1 = {'key:f1'},
    f2 = {'key:f2'},
    f3 = {'key:f3'},
    escape = {'key:escape'}
  }

  game.joy1 = baton.new('joy1','game',controls,love.joystick.getJoysticks()[1])
  game.playerHp = 10
  game.currentScene = nil
  game.paused = false
  game.black = black:new('game',{name='black'})

  game:add(c_statemachine:new(game,'state'),'state')

  game.state:addState('Title',{step='whileTitle',enter='onEnterTitle'})
  game.state:addState('Game',{step='whileGame',enter='onEnterGame'})
  game.state:addTransition('Title','Game')
  game.state:addTransition('Game','Title')

  game.state:setInitialState('Title')

  function game:onEnterTitle()
    self:setScene(require('scenes/titlescreen'))
  end

  function game:whileTitle(dt)
    if self.joy1:pressed('pause') then
      self:setScene('room1','player')
      self.state:transition('Game')
    end
  end

  function game:onEnterGame()
  end

  function game:whileGame(dt)
    --if player collides a passage, goto the proper scene with proper position
    local passage = obm:get('player').mainBody:getCollideFamily('passage')
    if passage then
      self:setScene(passage.destination,passage.spawn)
    end

    if self.joy1:pressed('pause') then
      self.paused = not self.paused
      obm:callByTag('pauseable','setPause',{self.paused})
    end
  end

  --unload current scene and load a new, optionally spawn the player on a certain spawnpoint
  --TODO intermediate scene to help load unload on the pi
  function game:setScene(scene, playerSpawn)
    self.black:on(.5)
    if self.currentScene then
      self.currentScene:unload()
      self.currentScene = nil
    end
    self.currentScene = require('scenes/'..scene):new('game',playerSpawn)
    self.currentScene:load()
    obm:callByTag('pauseable','freeze',{.5})
  end

  function game:oTick(dt)
    if self.joy1:pressed('f1') then
      obm:printChildren('root')
    elseif self.joy1:pressed('f2') then
      obm:printVisible()
    elseif self.joy1:pressed('f3') then
      obm:printTicking()
    elseif self.joy1:pressed('escape') then
      love.event.quit()
    end
  end

  return game
end

return Game
