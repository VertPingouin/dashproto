--TODO wrap ext libs in entity or components without altering them
--TODO make transition between maps
--TODO make lifebar
--TODO make spawning skeletons with trigger zone
--TODO make red skeletons that throw bones

function love.load(arg)
  if love.joystick.getJoysticks()[1] then
    local joyguid = love.joystick.getJoysticks()[1]:getGUID()
    love.joystick.setGamepadMapping(joyguid,'b','button',5)
    love.joystick.setGamepadMapping(joyguid,'dpleft','hat',1,'l')
    love.joystick.setGamepadMapping(joyguid,'dpdown','hat',1,'d')
    love.joystick.setGamepadMapping(joyguid,'dpright','hat',1,'r')
    love.joystick.setGamepadMapping(joyguid,'dpup','hat',1,'u')
    love.joystick.setGamepadMapping(joyguid,'leftx','axis',1)
    love.joystick.setGamepadMapping(joyguid,'lefty','axis',2)
    --love.joystick.setGamepadMapping(joyguid,'lefty','axis',1)
  end
  min_dt = 1/params.maxfps
  next_time = love.timer.getTime()
  require('requirement')

  --intitialize obm
  obm:load()

  --debug consoles
  if params.debug.console then
    local c1 = console:new({
      parent='root',
      name='info console',
      regexpfilter='.*',
      nblines=15,
      position=vec2(10,400)
    })

    log = log:new({c1})
  else
    log = log:new()
  end

  --intitialize other modules
  renderer:load()
  gameloop:load()
  colm:load()
  evm:load()
  asm:load()

  require('ressources')

  --collision responses definition
  colm:addCollisionResponse({obf1='player',obf2='collider',coltype='slide'})
  colm:addCollisionResponse({obf1='ennemy',obf2='collider',coltype='slide'})
  --colm:addCollisionResponse({obf1='ennemy',obf2='ennemy',coltype='slide'})
  colm:addCollisionResponse({obf1='player',obf2='doors',coltype='cross'})
  --game entity with default scene
  game = game:new()
  game:setScene(require('scenes/mainScene'):new('game'))

end

function love.update(dt)
  --compute draw sleep time
  next_time = next_time + min_dt

  evm:tick(dt)
  gameloop:tick(dt)
end

function love.draw()
  renderer:draw()
  if params.debug.fps then
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.print("Current update rate: "..tostring(math.floor(1/love.timer.getAverageDelta())), 10, 20)
  end

  --wait a certain time to comply FPS cap
  local cur_time = love.timer.getTime()
  if next_time <= cur_time then
     next_time = cur_time
     return
  end
  love.timer.sleep(next_time - cur_time)
end
