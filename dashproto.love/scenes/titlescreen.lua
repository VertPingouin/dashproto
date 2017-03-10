TitleScreen = {}
function TitleScreen:new(parent)

  local titlescreen = scene:new(parent,'titlescreen')

  titlescreen.camera=nullcam:new('titlescreen')
  titlescreen:add(c_sprite,'blink')
  titlescreen.blink:add({
    name = 'blink',
    pic = asm:get('title'),
    cellsizex = 256,
    cellsizey = 240,
    frames = {'1-2',1},
    durations = .3
  })
  titlescreen.blink:setAnimation('blink')

  return titlescreen
end

return TitleScreen
