--TODO use anim8 for grid
local Asset = {}

function Asset:newSpritesheet(a)
  local check = acheck:new()
  check:add({
    {'pic','mandatory','userdata'},
    {'cellsizex','mandatory','number'},
    {'cellsizey','mandatory','number'},
    {'nbcellx','mandatory','number'},
    {'nbcelly','mandatory','number'},
    {'cellnames','defaultValue','table',{}},
  })

  local a = check:check(a)

  local asset = {}
  asset.quads = {}
  asset.pic = a.pic

  local width = a.pic:getWidth()
  local height = a.pic:getHeight()

  assert(width == a.cellsizex * a.nbcellx, 'Asset::new::Inconsitent nbcellx and cellsizex regarding pic size.' )
  assert(height == a.cellsizey * a.nbcelly, 'Asset::new::Inconsitent nbcelly and cellsizey regarding pic size.' )
  assert((a.nbcellx * a.nbcelly == #a.cellnames) or (#a.cellnames == 0),'Asset:new::Incorrect cell names number.')

  local i = 0
  if #a.cellnames ~= 0 then
    for y=1,a.nbcelly do
      for x=1,a.nbcellx do
        i = x+(y-1)*a.nbcellx --index
        asset.quads[a.cellnames[i]] = love.graphics.newQuad(
          (x-1)*a.cellsizex,
          (y-1)*a.cellsizey,
          a.cellsizex,
          a.cellsizey,
          width,
          height)
      end
    end
  else
    for y=1,a.nbcelly do
      for x=1,a.nbcellx do
        i = x+(y-1)*a.nbcellx --index
        asset.quads[i] = love.graphics.newQuad(
          (x-1)*a.cellsizex,
          (y-1)*a.cellsizey,
          a.cellsizex,
          a.cellsizey,
          width,
          height)
      end
    end
  end

  return asset
end

return Asset
