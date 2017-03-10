TitleScreen = {}
function TitleScreen:new(parent)

  local titlescreen = scene:new(parent,'titlescreen')

  titlescreen.camera=nullcam:new('titlescreen')
  titlescreen:add(c_sprite,'blink')
  titlescreen.blink:add(require('assets/animations/a_titlescreen'))
  titlescreen.blink:setAnimation('blink')

  return titlescreen
end

return TitleScreen
