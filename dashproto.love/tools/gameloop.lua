local GameLoop = {}

function GameLoop:load()
end

function GameLoop:tick(dt)
  --a function that will make every ticking entity tick
  for i,ticking in ipairs(obm:getTicking()) do
    ticking:tick(dt)
  end
end

return GameLoop
