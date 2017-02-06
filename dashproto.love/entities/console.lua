Console = {}
local insert = table.insert
local remove = table.remove

function Console:new(a)

  local check = acheck:new()
  check:add({
    {'parent','defaultValue','string','root'},
    {'name','defaultValue','string','console'},
    {'regexpfilter','defaultValue','string','.*'},
    {'position','defaultValue','table',vec2(10,10)},
    {'nblines','defaultValue','number',20}
  })
  a = check:check(a)

  local console = entity:new({
    name=a.name,
    tags={'ticking','visible'},
    parent=a.parent,
    layer=maxlayer
  })

  console.position = a.position
  console.nblines = a.nblines
  console.lines = {}
  console.filter = a.regexpfilter

  function console:print(text)
    if string.match(text,self.filter) then
      if #self.lines == self.nblines then
        remove(self.lines,1) --remove firstline
      end
      insert(self.lines,text) --insert new line
    end
  end

  function console:oTick()
  end

  function console:oDraw()
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
