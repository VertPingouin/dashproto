C_body = {}
function C_body:new(owner,id,a)
  local c_body = component:new(owner,id,a)

  local check = acheck:new()
  check:add({
    {'x','defaultValue','number',10},
    {'y','defaultValue','number',10},
    {'w','defaultValue','number',16},
    {'h','defaultValue','number',16},
    {'color','defaultValue','table',color:new(255,255,255,255)},
    {'family','mandatory','string'},
    {'offset','defaultValue','table',vec2(0,0)}
  })
  a = check:check(a)

  c_body.position = vec2(a.x,a.y) + a.offset
  c_body.w = a.w
  c_body.h = a.h
  c_body.color = a.color
  c_body.family = a.family --used to know the collision response via colm
  c_body.name = obm:getId(owner)..'.'..id --used to detect particular collision
  c_body.contactsBody = {} --collision list
  c_body.contactsFamily = {}
  c_body.offset = a.offset


  assert(obm:get('bumpWorld'),'c_body::new::a world object (bump) is needed for a body to work')
  c_body.world = obm:get('bumpWorld')
  c_body.world:add(c_body,c_body.position.x,c_body.position.y,c_body.w,c_body.h)

  --metamethods for accessing center, left, top right etc...
  local mt = {__index =
  function(table,index)
    if index == 'center' then
      return vec2(table.position.x + table.w / 2,table.position.y + table.h/2)
    elseif index == 'left' then
      return table.position.x
    elseif index == 'right' then
      return table.position.x + table.w
    elseif index == 'top' then
      return table.position.y
    elseif index == 'bottom' then
      return table.position.y + table.h
    elseif index == 'topleft' then
      return vec2(table.left,table.top)
    elseif index == 'topright' then
      return vec2(table.right,table.top)
    elseif index == 'bottomleft' then
      return vec2(table.left,table.bottom)
    elseif index == 'bottomright' then
      return vec2(table.right,table.bottom)
    else return rawget(table,index) end
  end,
  __newindex =
  function(table,index,value)
    if index == 'center' then
      table.position.x = value.x - table.w / 2
      table.position.y = value.y - table.h / 2
    elseif index == 'left' then
      table.position.x = value
    elseif index == 'right' then
      table.position.x = value - table.w
    elseif index == 'top' then
      table.position.y = value
    elseif index == 'bottom' then
      table.position.y = value - table.h
    elseif index == 'topleft' then
      table.left = value.x
      table.top = value.y
    elseif index == 'topright' then
      table.right = value.x
      table.top = value.y
    elseif index == 'bottomleft' then
      table.left = value.x
      table.bottom = value.y
    elseif index == 'bottomright' then
      table.right = value.x
      table.bottom = value.y
    else return rawset(table,index,value) end
  end
}
  setmetatable(c_body,mt)

  --TODO add offset
  function c_body:moveCollide(vector)
    --we try to move the body and return new coordinates
    local actualX, actualY, cols, len = self.world:move(
    self,
    self.position.x+vector.x,
    self.position.y+vector.y,
    self.filter)
    --we update body position
    self.position = vec2(actualX,actualY)
    --we return body position
    return vec2(actualX,actualY) - self.offset
  end

  function c_body:tpCollide(vector)
    --we try to move the body and return new coordinates
    local actualX, actualY, cols, len = self.world:move(
      self,
      vector.x,
      vector.y,
      self.filter
    )
    --we update body position
    self.position = vec2(actualX,actualY)
    --we return body position
    return vec2(actualX,actualY) - self.offset
  end

  function c_body:tick(dt)
    --TODO This is really dirty, might be done quicker
    --check entering or leaving collsion
    local actualX, actualY, cols, len = self.world:check(self,self.position.x,self.position.y,self.filter)

    --initializing new body and family table
    --we check with what body name and family self is in contact with
    local colbodytable = {}
    local colfamilytable = {}

    for i,col in ipairs(cols) do
      colbodytable[col.other.name] = true
    end

    for i,col in ipairs(cols) do
      colfamilytable[col.other.family] = true
    end

    --we check what body and family are new in table
    --and what body and family are not anymore
    --we send events accordingly
    for k,v in pairs(colbodytable) do
      if not self.contactsBody[k] then
        self.contactsBody[k] = true
        evm:post(self.name..' startCollision '..k)
      end
    end

    for k,v in pairs(colfamilytable) do
      if not self.contactsFamily[k] then
        self.contactsFamily[k] = true
        evm:post(self.name..' startCollision '..k)
      end
    end

    for k,v in pairs(self.contactsBody) do
      if not colbodytable[k] then
        self.contactsBody[k] = nil
        evm:post(self.name..' endCollision '..k)
      end
    end

    for k,v in pairs(self.contactsFamily) do
      if not colfamilytable[k] then
        self.contactsFamily[k] = nil
        evm:post(self.name..' endCollision '..k)
      end
    end
  end

  function c_body:draw()
    if debug.boxes then
      love.graphics.setColor(
        c_body.color.r,
        c_body.color.g,
        c_body.color.b,
        c_body.color.a
      )
      love.graphics.rectangle('fill', self.position.x, self.position.y, self.w, self.h)
      love.graphics.setColor(255,255,255,255)
    end
  end

  function c_body:destroy()
    --we remove body from bump
    c_body.world:remove(self)
  end

  function c_body:filter(other)
    --interrogate colm to know the collision type
    coltype = colm:getCollisionResponse(self.family,other.family)
    return coltype
  end

  return c_body
end
return C_body
