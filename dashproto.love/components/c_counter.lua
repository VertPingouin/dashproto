C_counter = {}

function C_counter:new(owner,id,a)
  local c_counter = component:new(owner,id,a)

  local check = acheck:new()
  check:add({
    {'time','mandatory','number'}
  })
  check:check(a)

  c_counter.time = a.time
  c_counter.counter = 0
  c_counter.running = false
  c_counter.ended = true

  function c_counter:tick(dt)
    if self.running then
      self.counter = self.counter - dt
      if self.counter < 0 then
        self.counter =0
        self.ended = true
        self.running = false
      end
    end
  end

  function c_counter:start()
    self.running=true
    self.ended=false
    self.counter = self.time
  end

  return c_counter
end
return C_counter
