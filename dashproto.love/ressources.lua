asm:add(asset:newSpritesheet(require('assets/spritesheets/s_player')),'player')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_skeleton')),'skeleton')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_redskeleton')),'redskeleton')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_graveyard')),'graveyard')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_whip')),'whip')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_title')),'title')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_gameover')),'gameover')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_lifebar')),'lifebar')
asm:add(asset:newSpritesheet(require('assets/spritesheets/s_redbone')),'redbone')

--sounds
local sounds = love.filesystem.getDirectoryItems('sounds')
for i,sound in ipairs(sounds) do
  sound = split(sound,'.')
  if sound[2] and sound[2] == 'wav' then
    soundm:add('sounds/'..sound[1]..'.'..sound[2],sound[1])
    --log:post('resload','sound loaded : '..'sounds/'..sound[1]..'.'..sound[2])
  end
end
