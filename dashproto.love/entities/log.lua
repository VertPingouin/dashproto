local Log = {}

function Log:new(dest)
  local log = {}
  entity:new('log',{tags={'ticking'}})

  log.console = nil
  if dest then
    log.console = obm:get(dest)
  end

  function log:post(level,emitter,log)
    if level == 'ERROR' then
      assert(1==2,level..' from '..emitter..' : '..log)
    elseif level == 'DEBUG' then
      if debug then
        if not self.console then
          print(level..' from '..emitter..' : '..log)
        else
          self.console:print(level..' from '..emitter..' : '..log)
        end
      end
    elseif level == 'RAW' then
      if not self.console then
        print(log)
      else
        self.console:print(log)
      end
    else
      if not self.console then
        print(level..' from '..emitter..' : '..log)
      else
        self.console:print(level..' from '..emitter..' : '..log)
      end
    end
  end

  return log
end

return Log
