local Log = {}

function Log:new(dest)
  local log = {}
  entity:new('log',{tags={'ticking'}})

  log.consoles = nil
  if dest then
    log.consoles = dest
  end

  function log:post(level,emitter,log)
    if level == 'ERROR' then
      assert(1==2,level..' from '..emitter..' : '..log)
    elseif level == 'RAW' then
      if not self.consoles then
        print(log)
      else
        for i,console in ipairs(self.consoles) do console:print(log) end
      end
    else
      if not self.consoles then
        print(level..' from '..emitter..' : '..log)
      else
        for i,console in ipairs(self.consoles) do console:print(level..' '..emitter..' : '..log) end
      end
    end
  end

  return log
end

return Log
