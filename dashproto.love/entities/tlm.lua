--a wrapper that creates map and tilemaps properly affiliated to tlm object in hierarchy
--really game specific
TLM = {}

function TLM:new(parent, a)
  local check = acheck:new()
  check:add({
    {'luamap','mandatory','string'},
    {'asset','mandatory','string'},
    {'position','defaultValue','table',vec2(0,0)},
    {'playerSpawn','mandatory','string'}
  })
  a = check:check(a)

  local tlm = entity:new({
    name = a.luamap,
    tags={'map'},
    parent=parent
  })

  tlm.basepath = 'maps/'
  tlm.map = map:new(a.luamap,{luamap=require(tlm.basepath..a.luamap),position=a.position})
  tlm.l1 = tilemap:new(a.luamap,{luamap=require(tlm.basepath..a.luamap),layername = 'l1',asset=a.asset,position=a.position,layer=2})
  tlm.l2 = tilemap:new(a.luamap,{luamap=require(tlm.basepath..a.luamap),layername = 'l2',asset=a.asset,position=a.position,layer=2})
  tlm.bg = tilemap:new(a.luamap,{luamap=require(tlm.basepath..a.luamap),layername = 'bg',asset=a.asset,position=a.position,layer=params.minlayer})

  if tlm.map:getSpawn(a.playerSpawn) then
    tlm.player = player:new(a.luamap,{position=tlm.map:getSpawn(a.playerSpawn)[1]})
  end

  local skellyspawn = tlm.map:getSpawn('skeleton')
  for i,pos in ipairs(skellyspawn) do
    local name = a.luamap..'.skeleton'..i
    tlm[name] = skeleton:new(a.luamap,{position=pos+a.position,name=name})
  end
  return tlm
end

return TLM
