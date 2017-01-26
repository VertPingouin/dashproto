--TODO debug text onscreen

function love.load(arg)
  require('requirement')

  obm:load()
  renderer:load()

  console = console:new('root','Debug console',vec2(16,16),30)
  log = log:new('Debug console')

  game = game:new()
  game:setScene(require('scenes/mainScene'):new('game'))

  gameloop:load()
end

function love.update(dt)
  gameloop:tick(dt)
end

function love.draw()
  renderer:draw()
end
