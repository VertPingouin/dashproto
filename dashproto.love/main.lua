--TODO load a tilemap with collisions
--TODO make camera
--TODO make ennemies
--TODO make effects
--TODO demo using right stick
--TODO demo using the left stick

function love.load(arg)
  require('requirement')

  --intitialize obm
  obm:load()

  --debug consoles
  local c1 = console:new({
    parent='root',
    name='info console',
    regexpfilter='.*',
    vposition=vec2(16,16),
    nblines=15,
    position=vec2(10,480)
  })

  log = log:new({c1})

  --intitialize other modules
  renderer:load()
  gameloop:load()
  colm:load()
  evm:load()

  --collision responses definition
  colm:addCollisionResponse({obf1='player',obf2='collider',coltype='slide'})
  colm:addCollisionResponse({obf1='player',obf2='trigger',coltype='cross'})

  --events definition
  evm:addEntityEvent({eventstring='test',entity='player',callback='testCol'})

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
