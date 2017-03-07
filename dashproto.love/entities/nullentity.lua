NullEntity = {}

function NullEntity:new(parent,a)
  local check = acheck:new()
  check:add({
    {'name','mandatory','string'}
  })

  local nullEntity = entity:new({
    name=a.name,
    parent=parent,
    layer = params.maxlayer,
    tags={'visible','ticking'}
  })

  return nullEntity
end


return NullEntity
