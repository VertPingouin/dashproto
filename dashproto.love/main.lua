--TODO load a tilemap with collisions
--TODO make ennemies
--TODO make effects

function love.load(arg)
  require('requirement')

  --intitialize obm
  obm:load()

  --debug consoles
  local c1 = console:new({
    parent='root',
    name='info console',
    regexpfilter='.*',
    nblines=15,
    position=vec2(10,400)
  })

  log = log:new({c1})

  --intitialize other modules
  renderer:load()
  gameloop:load()
  colm:load()
  evm:load()
  asm:load()

  require('ressources')

  --collision responses definition
  colm:addCollisionResponse({obf1='player',obf2='collider',coltype='slide'})
  colm:addCollisionResponse({obf1='player',obf2='lava',coltype='cross'})
--colm:addCollisionResponse({obf1='viewport',obf2='boundaries',coltype='slide'})

  --events definition
  evm:addEntityEvent({
    eventstring='player.mainBody startCollision lava',
    entity='player',
    callback='testCol',
    args={255,0,0}
  })

  evm:addEntityEvent({
    eventstring='player.mainBody endCollision lava',
    entity='player',
    callback='testCol',
    args={255,0,255}
  })

  --game entity with default scene
  game = game:new()
  game:setScene(require('scenes/mainScene'):new('game'))

end

function love.update(dt)
  evm:tick(dt)
  gameloop:tick(dt)
end

function love.draw()
  renderer:draw()
end
