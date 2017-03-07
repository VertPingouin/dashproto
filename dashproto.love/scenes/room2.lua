Room2 = {}

function Room2:new(parent,playerSpawn)

  local room2 = scene:new(parent,'room2')

  function room2:oLoad()
    room2.room = tlm:new('room2',{
      luamap='land',
      asset='graveyard',
      playerSpawn=playerSpawn
    })

    room2.camera = camera:new('room2',{
      w=params.nativeresx,
      h=params.nativeresy,
      target=obm:get('player').mainBody,
      boundaries=obm:get('land.map').boundaries
    })
  end

  function room2:tick(dt)
  end

  return room2
end

return Room2
