local Renderer = {}
local insert = table.insert
local remove = table.remove

function Renderer:load()
  love.graphics.setDefaultFilter("nearest", "nearest")
end


function Renderer:draw()
  --a function that will draw visble layers by layers
  for i = 0,maxlayers do
    for j,visible in ipairs(obm:getVisible(i)) do
      visible:draw()
    end
  end
end

return Renderer
