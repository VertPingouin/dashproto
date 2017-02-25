Room1 = {}
--TODO subobject map
function Room1:load(parent,playerSpawn)

  local room1 = scene:new(parent,'room1')
  room1.room = tlm:new('room1',{
    luamap='graveyard',
    asset='graveyard',
    playerSpawn=playerSpawn
  })

  room1.camera = camera:new('room1',{
    w=params.nativeresx,
    h=params.nativeresy,
    target=obm:get('player').mainBody,
    boundaries=obm:get('graveyard.map').boundaries
  })

  function room1:tick(dt)
  end

  return room1
end

return Room1
