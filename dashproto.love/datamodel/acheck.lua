--normalized way to check args, raise errors and clean arguments table
--[[
'mandatory' : if mandatory then raise error if omitted
'defaultValue' : if value is passed, ok, if nil, default value is used
'nullable' : if value is nil, let it be
]]--


local insert = table.insert

ACheck = {}

function ACheck:new()

  local acheck = {}
  acheck.arglist = {}

  function acheck:add(argtable)
    for i,arg in ipairs(argtable) do


      --we check mandatory values are present
      --check if name, argtype and type are present
      assert(arg[1] and arg[2] and arg[3],'ERROR::args::Name, arg type and type are required.')
      --check argtype is valid
      assert(arg[2]=='mandatory' or arg[2]=='defaultValue' or arg[2]=='nullable'
        ,'ERROR::acheck::add::arg Type must be mandatory,defaultValue or nullable')
      --check type is valid
      assert(arg[3]=='string' or arg[3]=='number' or arg[3]=='table'
        or arg[3]=='boolean','ERROR::acheck::add::Type must be a lua type')
      --check if argtype is default value that a default value is present
      if arg[2] == 'defaultValue' then
        assert(arg[4],'ERROR::acheck::add::Default value is needed.')
      end

      acheck.arglist[arg[1]] = {argtype = arg[2],type = arg[3],default=arg[4]}

    end
  end

  function acheck:check(a)
    a = a or {}

    for k,arg in pairs(self.arglist) do
      if arg.argtype == 'mandatory' then
        assert(a[k],'ERRROR::args::check::'..k..'is mandatory')
        assert(type(a[k]) == arg.type,'ERROR::args::check::Invalid type for '..k..', '..arg.type..' expected, got '..type(a[k]))
      elseif arg.argtype == 'defaultValue' then
        if not a[k] then
          a[k] = arg.default
        end
        print(k,a[k])
        assert(type(a[k]) == arg.type,'ERROR::args::check::Invalid type for '..k..', '..arg.type..' expected, got '..type(a[k]))
      end


    end
    return a
  end
  return acheck
end

return ACheck
