local Log = {}

function Log:new()
  --local log = entity:new('log',{tags={'ticking'}})
  function log:post(level,emitter,log)
    if level == 'ERROR' then
      assert(1==2,level..' from '..emitter..' : '..log)
    elseif level == 'DEBUG' then
      if debug then
        print(level..' from '..emitter..' : '..log)
      end
    else
      print(level..' from '..emitter..' : '..log)
    end
  end

  return log
end

return Log
