--TODO load a tilemap with collisions
--TODO make camera
--TODO make ennemies
--TODO make effects
--TODO demo using right stick
--TODO demo using the left stick

function love.load(arg)
  require('requirement')

  --intitialize components
  obm:load()
  renderer:load()
  gameloop:load()

  --debug consoles
  local c1 = console:new('root','info console','.*',vec2(16,16),30)
  log = log:new({c1})

  --game entity with default scene
  game = game:new()
  game:setScene(require('scenes/mainScene'):new('game'))
end

function love.update(dt)
  gameloop:tick(dt)
end

function love.draw()
  renderer:draw()
end
