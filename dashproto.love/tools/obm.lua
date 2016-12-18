--[[
object attributes :
- layer : the layer on which object is drawn (used by the renderer)
- childrens : a liste of children objects, when parent is deleted, all childrens get deleted too
- tags : a list of strings

object special tags (can't be set via ):
- invisible : object will never be set visible
- visible : renderer will call draw function of the entity
- ticking : gameloop will call tick function of the entity
- persistent : entity cannot be removed during runtime
- excludeloadsave : is not affected by load and save state

functions
- add(object:table,id:string,flags:table)
  add an object associated with its id (it's name) and flags (a table of strings)

- setVisible(id,visible:boolean,itself:boolean,childrens:boolean)
  add or remove tag "visible" to object if itself is true and/or its childrens if childrens is true

- setTicking(id,ticking:boolean,itself:boolean,childrens:boolean)
  add or remove tag "visible" to object if itself is true and/or its childrens if childrens is true

- setLayer(id,layer:number,itself:boolean,childrens:boolean)
  set drawing layer for object if itself is true and/or its childrens if childrens is true

- table getParent(id:string)
  get parent of object "id"

- table getChildrens(id:string)
  get childrens of object "id"

- remove(id:string)
  remove object "id" and all of its inheritance

- call(id,function:string,itself:boolean,childrens:boolean)
  call a function of object if itself is true and/or its childrens if childrens is true

- get(id:string)
  get object with corresponding id. We can also get object by its path (game.enemy.zombie.kyle).

- getByTags(tag:string)
  get all objects with a certain tag

- removeTag(id,tag:string,itself:boolean,childrens:boolean)

- addTag(id,tag:string,itself:boolean,childrens:boolean)

- getVisible()
  = getByTags("visible"), to be used by renderer

- getTicking()
  = getByTags("ticking"), to be used by game loop
]]

local OBM = {}
local insert = table.insert
local remove = table.remove

--return wether or not element is in list
local function isin(element, list)
  for k,v in pairs(list) do
    if v == element then return true end
  end
  return false
end

--return a table containing bits of a strig cut by a certain char
local function split(str)
  local result = {} ; i = 1
  for chunk in str:gmatch("([^\\.]+)") do
    if chunk~=sep then
      result[i]=chunk
      i = i+1
    end
  end
  return result
end



function OBM:load()
  self.tags = {} --objects by tag
  self.objects = {} --objects
  self.layers = {} --objects by layer
  self.objects.root = {} --parent of all
end



function OBM:tick(dt)
end



function OBM:add(ref,id,p)
  --TODO prevent id duplicates

  local obj = {}
  obj.reference = ref

  --we set all properties to their default values
  obj.layer = 0

  --if object has a parent, we set it or we let root as parent
  if p.parent then
    obj.parent = p.parent
  else
    obj.parent = self:get('root')
  end

  --if object has a layer passed in parameters, we register it
  if p.layer then obj.layer = p.layer end

  --for every tag in the taglist passed in parameter...
  for i,tag in ipairs(p.tags) do
    --if tag doesn't exist, we create a new table
    if not self.tags[tag] then  self.tags[tag] = {} end
    --then we add it to the table
    insert(self.tags[tag],ref)
  end
  --we insert the object in obm objects
  self.objects[id] = obj
end



function OBM:get(id)
  --get object ref by its id
  if self.objects[id] then
    return self.objects[id].reference
  end

  log:post('WARNING','obm','Trying to get a non-existing object '..tostring(id))
  return nil
end



function OBM:getByTags(tag)
  --get all objects with a certain tag
  if self.tags[tag] then
    return self.tags[tag]
  end
  log:post('WARNING','obm','No objects with tag '..tostring(tag))
  return {}
end



function OBM:callByTags(tag,func,args)
  --get all objects with a certain tag and call the given func on them
  if self.tags[tag] then
    for i,obj in ipairs(self.tags[tag]) do
      if obj[func] then
        obj[func](unpack(args))
      end
    end
  end
  log:post('WARNING','obm','No objects with tag '..tostring(tag))
  return {}
end



function OBM:getVisible()
  return self:getByTags('visible')
end



function OBM:getTicking()
  return self:getByTags('ticking')
end



function OBM:getId(obj)
  --get the id of an object
  for k,v in pairs(self.objects) do
    if obj == v then
      return k
    end
  end
  log:post('WARNING','obm','Object not in object manager')
  return nil
end



function OBM:getParent(id)
  --we return parent
  if self:get(self.objects[id].parent) then
    return self:get(self.objects[id].parent)
  end

  log:post('WARNING','obm',id..' has no parent')
  return nil
end

function OBM:getChildrens(id)
  --we iterate objects in order to find every object whose parent is id
  local result = {}
  for k,v in pairs(self.objects) do
    if v.parent == id then
      insert(result,v)
    end
  end
  return result
end

function OBM:setTag(id,bool,tag)
  --we get object reference locally
  local obj = self:get(id)

  if obj then
    --if we want to set the tag...
    if bool == true then
      --if tag doesn't exist, we create it with reference inside
      if not self.tags[tag] then self.tags[tag] = {obj}
      --else, we insert in this tag list
      else insert(self.tags[tag], obj) end

    --if we want to remove tag, we remove its reference from tag list
    elseif bool == false then
      if self.tags[tag] then
        for i,o in ipairs(self.tags[tag]) do
          if o == obj then
            remove(self.tags[tag],i)
          end
        end
      else
        log:post('WARNING','obm','Object '..id..' has no tag '..tag)
      end
    end
  else
    log:post('WARNING','obm','Object '..id..' does not exist. Can\'t set tag '..tag)
  end
end

function OBM:setVisible(id,bool)
  self:setTag(id,bool,'visible')
end

function OBM:setTicking(id,bool)
  self:setTag(id,bool,'ticking')
end

function OBM:remove(id)
  --recursively remove childs
  local childs = self:getChildrens(id)

  for i,child in ipairs(childs) do
    self:remove(self:getId(child))
  end

  --we get reference of the object to remove
  local object2remove = self:get(id)

  --we remove the object in tags
  for tag,listobjtag in pairs(self.tags) do
    for i,obj in ipairs(listobjtag) do
      if obj.reference == object2remove then
        remove(listobjtag,i)
      end
    end
  end

  --remove from self objects
  for k,v in pairs(self.objects) do
    if k == id then
      self.objects[k] = nil
    end
  end
end


return OBM
