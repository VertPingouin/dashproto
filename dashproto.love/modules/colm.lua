COLM = {}

function COLM:load()
  self.collisions = {}
end

function COLM:add(a)
  local check = acheck:new()
  check:add({
    {'obf1','mandatory','string'},
    {'obf2','mandatory','string'},
    {'coltype','defaultValue','string','cross'},
  })
  --TODO enum args support in acheck
  a = check:check(a)
    assert(a.coltype == 'slide' or a.coltype == 'cross' or a.coltype == 'bounce' or a.coltype == 'touch',
'ERROR::colm::add::coltype must be cross,slide,bounce or touch.'..a.coltype..' given.')
  if not colm.collisions[a.obf1] then
    colm.collisions[a.obf1] = {}
  end
  colm.collisions[a.obf1][a.obf2] = a.coltype
end

function COLM:getColType(obf1,obf2)
  if colm.collisions[obf1] then
    if colm.collisions[obf1][obf2] then
      return colm.collisions[obf1][obf2]
    end
  elseif colm.collisions[obf2] then
    if colm.collisions[obf2][obf1] then
      return colm.collisions[obf2][obf1]
    end
  else
    return 'cross'
  end
end

return COLM
