- objects returned have every word's first letter capitalized
- local object have camelCase
- functions have camelCase
- system components are returned where required and have a load function to initialize (singleton)
- entities have a new method to create an instance
- entities are always referenced in obm
- visible elements have a draw method called by renderer and a oDraw method (overrideable draw method) calld in Draw
- ticking elements have a tick(dt) method called by gameloop and a oTick method (overrideable tick method) calld in Tick
- args for an entity are parent name (if needed), name (if not single entity), a = named arguments
- single entities or pseudo entities
  world
  game
  log
  player
  target


tilemap
  layer colliders with rectangle in it
  layer spawn point with rectangles in it and name
