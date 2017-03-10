--basic component
Component = {}

function Component:new(owner,id,a)
  local component = {owner=owner,id=id}
  component.type = 'undefined'

  function component:tick(dt)
  end

  function component:draw()
  end

  function component:destroy()
  end

  return component
end
return Component
