--normalized way to check args, raise errors and clean arguments table
local insert = table.insert

ACheck = {}
ACheck.arglist = {}

function ACheck:add(argtable)
  for i,arg in ipairs(argtable) do

    --we check mandatory values are present
    assert(arg[1] and arg[2],'ERROR::args::Name and default value are needed.')

    --we check that default value and expected type are consistent
    if arg[3] then
      assert(type(arg[2])==arg[3],'ERROR::args::Inconsistent default value and expected type ('..arg[1]..')')
    end

    --we add it to checklist
    ACheck.arglist[arg[1]]= {default=arg[2],expectedType=arg[3],mandatory=arg[4] or false}
  end
end

function ACheck:check(a)
  a = a or {}

  for k,arg in pairs(self.arglist) do
    if arg.mandatory and not a[k] then
      assert(false,'ERROR::args::Argument '..k..' is mandatory.')
    end

    --if no value, we set default value
    if arg.default and not a[k] then a[k] = arg.default end

    --if type is precised, we raised error if type is incorrect
    if arg.expectedType then
      local argtype = type(a[k])
      assert(argtype == arg.expectedType,'ERROR::args::Wrong type for '..k..', expecting '
        ..arg.expectedType..', '..argtype..' received.')
    end
  end
  return a
end

return ACheck
