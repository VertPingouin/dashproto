--TODO load a tilemap with collisions
--TODO make ennemies
--TODO make effects
--TODO wrap ext libs in entity or components without altering them

function love.load(arg)
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
  colm:addCollisionResponse({obf1='ennemy',obf2='ennemy',coltype='slide'})
  colm:addCollisionResponse({obf1='player',obf2='doors',coltype='cross'})

  --game entity with default scene
  game = game:new()
  game:setScene(require('scenes/mainScene'):new('game'))

end

function love.update(dt)
  evm:tick(dt)
  gameloop:tick(dt)
end

function love.draw()
  renderer:draw()
  if params.debug.fps then
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.print("Current update rate: "..tostring(math.floor(1/love.timer.getAverageDelta())), 10, 20)
  end
end
