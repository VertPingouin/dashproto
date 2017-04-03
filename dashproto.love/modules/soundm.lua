local SoundM = {}

function SoundM:load()
  obm:add(self,'soundm',{})
  self.sounds = {}
end

function SoundM:add(sound,id)
  self.sounds[id] = love.audio.newSource(sound,"static")
end

function SoundM:addLoop(sound,id)
  local loop = love.audio.newSource(sound,"static")
  loop:setLooping(true)
  self.sounds[id] = loop
end

function SoundM:stop(id)
  self.sounds[id]:stop()
end

function SoundM:play(id,p)
  p = p or {}
  local volume = p.volume or 100
  local pitchmin = p.pitchmin or 100
  local pitchmax = p.pitchmax or 100

  self.sounds[id]:setPitch(math.random(pitchmin,pitchmax)/100)
  self.sounds[id]:setVolume(volume)
  self.sounds[id]:play()
end

return SoundM
