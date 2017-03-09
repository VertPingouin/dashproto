GameOverScreen = {}
function GameOverScreen:new(parent)

  local gameoverscreen = scene:new(parent,'gameoverscreen')

  gameoverscreen.camera=nullcam:new('gameoverscreen')
  gameoverscreen:add(c_sprite:new('gameoverscreen','pic'))
  gameoverscreen.pic:add({
    name = 'pic',
    pic = asm:get('gameover'),
    cellsizex = 256,
    cellsizey = 240,
    frames = {1,1},
    durations = 1
  })
  gameoverscreen.pic:setAnimation('pic')

  return gameoverscreen
end

return GameOverScreen
