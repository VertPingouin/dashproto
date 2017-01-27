local GameLoop = {}

function GameLoop:load()
end

function GameLoop:tick(dt)
  --a function that will make every ticking entity tick
  for i = 0,maxorders do
    for j,ticking in ipairs(obm:getTicking(i)) do
      ticking:tick(dt)
    end
  end
end

return GameLoop
