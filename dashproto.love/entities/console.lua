Console = {}
local insert = table.insert
local remove = table.remove

function Console:new(parent,name,regexpfilter,vposition,nblines)
  local console = entity:new(name,{tags={'ticking','visible'},parent=parent,layer=maxlayers})
  console.position = vposition
  console.nblines = nblines
  console.lines = {}
  console.filter = regexpfilter

  function console:print(text)
    if string.match(text,self.filter) then
      if #self.lines == nblines then
        remove(self.lines,1) --remove firstline
      end
      insert(self.lines,text) --insert new line
    end
  end

  function console:tick()
  end

  function console:draw()
    love.graphics.setColor(255, 0, 0, 150)
    love.graphics.print(self.name,self.position.x,self.position.y,0,2)
    love.graphics.setColor(255, 255, 255, 150)
    for i,line in ipairs(self.lines) do
      love.graphics.print(line,self.position.x,self.position.y + 16+16*i,0,1)
    end
    love.graphics.setColor(255, 255, 255, 255)
  end

  return console
end

return Console
