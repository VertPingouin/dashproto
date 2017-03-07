NullCam = {}

function NullCam:new(parent)
  local nullcam = entity:new({
    name='nullcam',
    tags={'visible'},
    parent=parent
  })

  function nullcam:oDraw()
    love.graphics.push()
  end

  return nullcam
end

return NullCam
