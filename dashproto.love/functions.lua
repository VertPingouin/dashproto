--copy a table (not deep copy)
function tcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

--compare two tables
function comparetables(t1, t2)
  if #t1 ~= #t2 then return false end
  for i=1,#t1 do
    if t1[i] ~= t2[i] then return false end
  end
  return true
end

--return wether or not element is in list
function isin(element, list)
  for k,v in pairs(list) do
    if v == element then return true end
  end
  return false
end

--return a table containing bits of a strig cut by a certain char
function split(str)
  local result = {} ; i = 1
  for chunk in str:gmatch("([^\\.]+)") do
    if chunk~=sep then
      result[i]=chunk
      i = i+1
    end
  end
  return result
end

--print args
function strTable(table)
  result = ''
  for k,v in pairs(table) do
    result = result..k..'='..v..', '
  end
  return result
end
