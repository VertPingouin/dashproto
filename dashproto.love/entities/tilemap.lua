--reads tlm files and create large sprites based on tiles to be displayed ingame
local insert = table.insert

TileMap = {}

function TileMap:new(parent,a)
  local check = acheck:new()
  check:add({
    {'luamap','mandatory','table'},
    {'position','defaultValue','table',vec2(0,0)},
    {'layername','mandatory','string'},
    {'layer','mandatory','number'},
    {'asset','mandatory','string'}
  })
  a=check:check(a)

  local tilemap = entity:new({
    name=parent..'.'..a.layername,
    parent=parent,
    tags={'ticking','visible'},
    layer = a.layer
  })

  tilemap.width = a.luamap.width
  tilemap.height = a.luamap.height
  tilemap.tilewidth = a.luamap.tilewidth
  tilemap.tileheight = a.luamap.tileheight
  tilemap.position = a.position
  tilemap.image = asm:get(a.asset)
  tilemap.quads = asm:quads(a.asset)
  tilemap.pic = love.graphics.newCanvas(tilemap.width*tilemap.tilewidth, tilemap.height*tilemap.tileheight)

  for i,layer in ipairs(a.luamap.layers) do
    if layer.type == 'tilelayer' and layer.name == a.layername then
      love.graphics.setCanvas(tilemap.pic)
      for j,cell in ipairs(layer.data) do
        if cell ~= 0 then
          local x = (j-1) - math.floor((j-1)/tilemap.width) * tilemap.width
          local y = math.floor((j-1)/tilemap.width)
          love.graphics.draw(tilemap.image,tilemap.quads[cell],x*tilemap.tilewidth,y*tilemap.tileheight)
        end
      end
      love.graphics.setCanvas()
    end
  end

  function tilemap:oDraw()
    love.graphics.draw(self.pic, self.position.x, self.position.y)
  end

  return tilemap
end

return TileMap
