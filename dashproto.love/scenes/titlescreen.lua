TitleScreen = {}
function TitleScreen:new(parent)

  local titlescreen = scene:new(parent,'titlescreen')
  titlescreen.sprite = sprite:new('titlescreen',{assetname='title'})

  titlescreen.camera = nullcam:new('titlescreen')

  return titlescreen
end

return TitleScreen
