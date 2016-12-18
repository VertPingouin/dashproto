local Renderer = {}
local insert = table.insert
local remove = table.remove

function Renderer:load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  self.drawers = {}
  self.mode = nil

  for i = 1, 20 do
    self.drawers[i] = {}
  end
end

function Renderer:add(obj,layer)
  local l = layer or 1
  insert(self.drawers[l],obj)
end

function Renderer:draw()
  if self.drawers then
    for layer = 1,#self.drawers do
      for draw = 1,#self.drawers[layer] do
        local obj = self.drawers[layer][draw]
          obj:draw()
      end
    end
  end
end

function Renderer:remove(obj)
  for i,d in ipairs(self.drawers) do
    for j,o in ipairs(d) do
      if o == obj then
        table.remove(self.drawers[i],j)
      end
    end
  end
end

function Renderer:clear()
  self.drawers = {}
  for i = 1, num_of_layers do
    renderer.drawers[i] = {}
  end
end

return Renderer
