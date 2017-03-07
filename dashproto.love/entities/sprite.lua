Sprite = {}

function Sprite:new(parent,a)
  local check = acheck:new()
  check:add({
    {'assetname','mandatory','string'},
    {'layer','defaultValue','number',2}
  })

  local sprite = entity:new({
    name=a.assetname,
    parent=parent,
    layer = a.layer,
    tags={'visible'}
  })

  sprite.sprite = asm:get(a.assetname)

  function sprite:oDraw()
    love.graphics.draw(self.sprite,0,0)
  end

  return sprite
end

return Sprite
