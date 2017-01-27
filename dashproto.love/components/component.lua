Component = {}

function Component:new(owner,id)
  local component = {owner=owner,id=id}

  function component:tick(dt)
  end

  function component:draw()
  end

  return component
end
return Component
