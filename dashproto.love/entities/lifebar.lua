Lifebar = {}

function Lifebar:new(parent,a)
  local lifebar = entity:new({
    name='lifebar',
    tags={'ticking','visible','interface'},
    parent=parent,
    layer=params.maxlayer-1
  })

  local check = acheck:new()
  check:add({
    {'lifemax','defaultValue','number',3},
    {'posx','defaultValue','number',30},
    {'posy','defaultValue','number',30}
  })
  a=check:check(a)

  lifebar.lifemax = a.lifemax
  lifebar.life = a.lifemax
  lifebar.position = vec2(a.posx,a.posy)
  lifebar.picEmpty = asm:getSprite('lifebar','empty')
  lifebar.picFull = asm:getSprite('lifebar','full')

  function lifebar:setLife(n)
    if n <= self.lifemax then
      self.life = n
    else
      self.life = self.lifemax
    end
  end

  function lifebar:oDraw()
    if self.visible then
      for i=1,self.lifemax do
        if self.life >= i then
          love.graphics.draw(self.picFull.pic,self.picFull.quad, self.position.x+(i-1)*16, self.position.y)
        else
          love.graphics.draw(self.picEmpty.pic,self.picEmpty.quad, self.position.x+(i-1)*16, self.position.y)
        end
      end
    end
  end

  return lifebar
end

return Lifebar
