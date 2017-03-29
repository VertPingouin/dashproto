local pi = math.pi

--concatenate two tables
tcon = function(t1, t2)
  local result = {}
  for _,v in ipairs(t1) do
      table.insert(result, v)
  end
  for _,v in ipairs(t2) do
      table.insert(result, v)
  end

  return result
end

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


--
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

--TODO This need to be elsewhere
function blockView(item)
  if item.family == 'collider' then
    return true
  end
  return
end

--oracle like nvl
function nvl(object, value)
  if not object then
    return value
  else
    return object
  end
end

--return 4 directions based on one angle
function cardinalDir(vec)
  local angle = 0
  angle = vec:normalizeInplace():angleTo(vec2(0,-1))
  if (angle < 0) then angle = angle + 2 * pi end

  if angle >= 7*pi/4 or angle < pi/4 then
    return 'up'
  elseif pi/4 <= angle and angle < 3*pi/4 then
    return 'right'
  elseif 3*pi/4 <= angle and angle < 5*pi/4 then
    return 'down'
  elseif 5*pi/4 <= angle and angle < 7*pi/4 then
    return 'left'
  end
end

--return 4 directions based on one vector
function cardinalDirSimple(vec)
  if vec.x == 0 then
    if vec.y > 0 then
      return 'down'
    else
      return 'up'
    end
  else
    if vec.x > 0 then
      return 'right'
    else
      return 'left'
    end
  end
end
