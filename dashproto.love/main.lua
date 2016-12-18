function love.load(arg)
  require('requirement')

  obm:load()
  renderer:load()

  log = log:new()
  game = game:new()
  game:setScene(require('scenes/mainscene'):new(game))

  gameloop:load()
end

function love.update(dt)
  gameloop:tick(dt)
end

function love.draw()
  renderer:draw()
end
