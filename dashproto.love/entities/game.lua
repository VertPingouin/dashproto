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
  game.lifebar = lifebar:new('game',{posx=3,posy=3,lifemax=3})
  game.lifebar:setVisible(false)

  game.currentScene = nil
  game.paused = false
  game.black = black:new('game',{name='black'})

  game:add(c_statemachine,'state')

  game.state:addState('Title',{step='whileTitle',enter='onEnterTitle'})
  game.state:addState('Game',{step='whileGame',enter='onEnterGame'})
  game.state:addState('Gameover',{enter='onEnterGameover'})
  game.state:addTransition('Title','Game')
  game.state:addTransition('Game','Title')
  game.state:addTransition('Game','Gameover')
  game.state:addTransition('Gameover','Title',{preferred=true,ttl=2})

  game.state:setInitialState('Title')

  function game:onEnterTitle()
    self.lifebar:setVisible(false)
    self:setScene('titlescreen')
  end

  function game:whileTitle(dt)
    if self.joy1:pressed('pause') then
      evm:post('sound',{'start'})
      self:setScene('room1','player')
      self.state:transition('Game')
    end
  end
  function game:onEnterGameover()
    evm:post('soundStop',{'graveyard'})

    self.lifebar:setVisible(false)
    self:setScene('gameoverscreen')
  end

  function game:onEnterGame()
    evm:post('sound',{'graveyard'})
    self.lifebar:setVisible(true)
    self.playerHp = 3

  end

  function game:whileGame(dt)
    self.lifebar:setLife(self.playerHp)

    --if player collides a passage, goto the proper scene with proper position
    local passage = obm:get('player').mainBody:getCollideFamily('passage')
    if passage then
      self:setScene(passage.destination,passage.spawn)
    end

    if self.joy1:pressed('pause') then
      self.paused = not self.paused
      obm:callByTag('pauseable','setPause',{self.paused})
    end
    if self.playerHp == 0 then
      self.state:transition('Gameover')
    end

  end

  --unload current scene and load a new, optionally spawn the player on a certain spawnpoint
  function game:setScene(scene, playerSpawn)
    self.black:on(.5)
    if self.currentScene then
      self.currentScene:unload()
      self.currentScene = nil
    end
    self.currentScene = require('scenes/'..scene):new('game',playerSpawn)
    self.currentScene:load()
    --we need to pause every obkect because transition makes a huge framedrop on the pi
    --se we can't just pause then unpause when loaded
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
