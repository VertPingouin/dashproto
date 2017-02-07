local ASM = {}

function ASM:load()
  self.assets = {}
end

function ASM:add(asset,id)
  self.assets[id] = asset
end

function ASM:getSprite(id,cell,celly)
  assert(self.assets[id],'ASM::get::no sprite with id'..id)
  pic = self.assets[id].pic

  if celly then
    assert(self.assets[id].quads[celly][cell],'ASM::get::no quad with coordinates '..cell..'/'..celly)
    quad = self.assets[id].quads[celly][cell]
  else
    assert(self.assets[id].quads[cell],'ASM::get::no quad with id '..id)
    quad = self.assets[id].quads[cell]
  end
  return {pic=pic,quad=quad}
end

--get all quads at one time, useful for icons with three layers
function ASM:quads(id)
  return self.assets[id].quads
end

return ASM
