local Renderer = {}
local insert = table.insert
local remove = table.remove

function Renderer:load()
  love.graphics.setDefaultFilter("nearest", "nearest")
end


function Renderer:draw()
  --a function that will make every ticking entity tick
  for i = 0,obm.maxlayer do
    for j,visible in ipairs(obm:getVisible(i)) do
      visible:draw(dt)
    end
  end
end

return Renderer
