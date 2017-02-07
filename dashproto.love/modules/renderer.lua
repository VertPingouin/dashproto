local Renderer = {}
local insert = table.insert
local remove = table.remove

function Renderer:load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  Renderer.canvas = love.graphics.newCanvas(params.nativeresx,params.nativeresy)
end


function Renderer:draw()
  --a function that will draw visble layers by layers
  love.graphics.setCanvas(Renderer.canvas)
  love.graphics.clear()
  for i = params.minlayer,params.maxlayer do
    for j,visible in ipairs(obm:getVisible(i)) do
      visible:draw()
    end
    if i == params.maxlayer-1 then --all layer but the last are scaled on canvas
      love.graphics.setCanvas()
      love.graphics.draw(Renderer.canvas,0,0,0,params.multx,params.multy)
    elseif i == params.maxlayer-2 then --all layers but the two lasts are influenced by camera
      love.graphics.pop()
    end
  end

end

return Renderer
