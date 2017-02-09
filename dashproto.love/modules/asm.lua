local ASM = {}

function ASM:load()
  self.assets = {}
end

function ASM:add(asset,id)
  self.assets[id] = asset
end

function ASM:getSprite(id,cell)
  assert(self.assets[id],'ASM::get::no sprite with id'..id)
  pic = self.assets[id].pic

  assert(self.assets[id].quads[cell],'ASM::get::no quad with id '..cell)
  quad = self.assets[id].quads[cell]

  return {pic=pic,quad=quad}
end

function ASM:get(id)
  assert(self.assets[id],'ASM::get::no sprite with id'..id)
  return self.assets[id].pic
end

function ASM:getQuad(id,quad)
  assert(self.assets[id],'ASM::get::no quad with id'..quad)
  return self.assets[id][quad]
end

--get all quads at one time, useful for icons with three layers
function ASM:quads(id)
  return self.assets[id].quads
end

return ASM
