require('functions')
vec2 = require('datamodel/vec2')
acheck = require('datamodel/acheck')
color = require('datamodel/color')
asset = require('datamodel/asset')

--system components
obm = require('modules/obm')
renderer = require('modules/renderer')
gameloop = require('modules/gameloop')
colm = require('modules/colm')
evm = require('modules/evm')
asm = require('modules/asm')

--entities
entity = require('entities/_entity')
log = require('entities/log')
game = require('entities/game')
player = require('entities/player')
skeleton = require('entities/skeleton')
target = require('entities/target')
console = require('entities/console')
collider = require('entities/collider')
triggerzone = require('entities/triggerzone')
map = require('entities/map')
tilemap = require('entities/tilemap')
camera = require('entities/camera')
tlm = require('entities/tlm')
black = require('entities/black')
lifebar = require('entities/lifebar')
nullcam = require('entities/nullcam')
nullentity = require('entities/nullentity')

--components
component = require('components/_component')
c_statemachine = require('components/c_statemachine')
c_body = require('components/c_body')
c_sprite = require('components/c_sprite')
c_look = require('components/c_look')
c_effect = require('components/c_effect')
c_rectangle = require('components/c_rectangle')
c_counter = require('components/c_counter')

--scenes
scene = require('scenes/_scene')

--libs
--pseudo-entities, can't have components
bump = require('libs/bump')
baton = require('libs/baton')
anim8 = require('libs/anim8')
