GameOverScreen = {}
function GameOverScreen:new(parent)

  local gameoverscreen = scene:new(parent,'gameoverscreen')

  gameoverscreen.camera=nullcam:new('gameoverscreen')
  gameoverscreen:add(c_sprite,'pic')
  gameoverscreen.pic:add(require('assets/animations/a_gameoverscreen'))
  gameoverscreen.pic:setAnimation('pic')

  return gameoverscreen
end

return GameOverScreen
