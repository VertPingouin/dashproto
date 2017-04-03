--TODO rename thi to clock to avoid duplicates names
C_clock = {}

function C_clock:new(owner,id,a)
  local c_clock = component:new(owner,id,a)

  local check = acheck:new()
  check:add({
    {'time','mandatory','number'}
  })
  check:check(a)

  c_clock.time = a.time
  c_clock.counter = 0
  c_clock.running = false
  c_clock.ended = true

  function c_clock:tick(dt)
    if self.running then
      self.counter = self.counter - dt
      if self.counter < 0 then
        self.counter =0
        self.ended = true
        self.running = false
      end
    end
  end

  function c_clock:start()
    self.running=true
    self.ended=false
    self.counter = self.time
  end

  return c_clock
end
return C_clock
