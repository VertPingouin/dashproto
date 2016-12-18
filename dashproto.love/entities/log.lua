local Log = {}

function Log:new()
  local log = entity:new('log',1,{tags={'ticking'}})
  function log:post(level,emitter,log)
    if level ~= 'ERROR' then
      print(level..' from '..emitter..' : '..log)
    else
      assert(1==2,level..' from '..emitter..' : '..log)
    end
  end

  return log
end

return Log
