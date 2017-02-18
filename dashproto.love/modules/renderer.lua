local Renderer = {}
local insert = table.insert
local remove = table.remove

function Renderer:load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setMode(params.resx,params.resy,{vsync=true})
  love.graphics.setLineStyle('rough')
  Renderer.canvas = love.graphics.newCanvas(params.nativeresx,params.nativeresy)
end


function Renderer:draw()
  --a function that will draw visble layers by layers

  --all layers from min layer to maxlayer are drawn on an upscaled canvas
  love.graphics.setCanvas(Renderer.canvas)
  love.graphics.clear()

  for i = params.minlayer,params.maxlayer do
    local visible = obm:getVisible(i)
    --order visibles in a given layer by y coordinate

    --we create a liste to iter through by ypos key
    local visibleSorted = {}

    --wi insert visible in subtables with ypos as key
    for j,v in ipairs(visible) do
      local vpos=0
      if v.position.y then
        vpos = v.position.y
      end
      if not visibleSorted[vpos] then visibleSorted[vpos] = {} end
      insert(visibleSorted[vpos],v)
    end

    --we iter through table
    for j,vs in spairs(visibleSorted) do
      --we iter through subtable
      for k,vss in ipairs(vs) do
        vss:draw()
      end
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
