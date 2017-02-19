local Log = {}

function Log:new(dest)
  local log = {}
  entity:new({
    name='log',
    tags={'ticking'}
  })

  log.consoles = nil
  if dest then
    log.consoles = dest
  end

  function log:post(level,emitter,log)
    if params.debug.log then
      if level == 'RAW' then
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
  end

  return log
end

return Log
