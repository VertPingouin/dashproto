--[[
object attributes :
- layer : the layer on which object is drawn (used by the renderer)
- childrens : a liste of children objects, when parent is deleted, all childrens get deleted too
- tags : a list of strings

object special tags (can't be set via ):
- visible : renderer will call draw function of the entity
- ticking : gameloop will call tick function of the entity

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

- callByTags(tag,function)
  call a function of object if itself is true and/or its childrens if childrens is true

- get(id:string)
  get object with corresponding id. We can also get object by its path (game.enemy.zombie.kyle).

- getByTags(tag:string)
  get all objects with a certain tag

- removeTag(id,tag:string,itself:boolean,childrens:boolean)

- addTag(id,tag:string,itself:boolean,childrens:boolean)

- getVisible(layer)
  = getByTags("visible"), to be used by renderer

- getTicking(order)
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

  self.tags.visible = {}
  self.tags.ticking = {}

  for i=1,maxlayers do
    self.tags['visible'][i] = {} --special tags
  end

  for i=1,maxorders do
    self.tags['ticking'][i] = {}
  end

  self.objects = {} --objects as a plain list

  self.objects.root = {} --parent of all
end



function OBM:add(ref,id,a)
  for k,v in pairs(self.objects) do
    if k == id then
      log:post('ERROR','obm','id duplicate, cannot add '..id)
    end
  end

  assert(ref and id,'ERROR::obm::add::reference and id are mandatory.')

  local obj = {}
  obj.reference = ref

  local check = acheck:new()
  check:add({
    {'layer','defaultValue','number',1},
    {'order','defaultValue','number',1},
    {'tags','defaultValue','table',{}},
    {'parent','defaultValue','string','root'},
  })
  a = check:check(a)

  assert(a.layer <= maxlayers,'ERROR from obm : Layer number should be less or equal than '..maxlayers..'('..a.layer..')')
  assert(a.order <= maxorders,'ERROR from obm : Order number should be less or equal than '..maxorders..'('..a.order..')')

  obj.layer = a.layer
  obj.order = a.order
  obj.tags  = a.tags
  obj.parent = a.parent

  --for every tag in the taglist passed in parameter...
  for i,tag in ipairs(obj.tags) do
    --if tag is visible, do something special
    if tag == 'visible' then
      insert(self.tags['visible'][obj.layer],obj.reference) --we insert the ref in proper layer
    elseif tag == 'ticking' then
      insert(self.tags['ticking'][obj.order],obj.reference) --we insert the ref in proper order num
    else --if tag is not visible, we process it the normal way
      --if tag doesn't exist, we create a new table
      if not self.tags[tag] then  self.tags[tag] = {} end
      --then we add it to the table
      insert(self.tags[tag],ref)
    end
  end
  --we insert the object in obm objects
  self.objects[id] = obj

  if log.post then --workaround to avoid trying to pring entity log creation before it's created !
    log:post('DEBUG','obm','object '..id..' added ('..tostring(obj.reference)..')')
  end
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
  if tag == 'ticking' or tag == 'visible' then
    log:post('ERROR','obm','Cannot call a function on special tags visible or ticking')
  end

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



function OBM:getVisible(layer)
  if self:getByTags('visible')[layer] then
    return self:getByTags('visible')[layer]
  else return {} end
end



function OBM:getTicking(order)
  if self:getByTags('ticking')[order] then
    return self:getByTags('ticking')[order]
  else return {} end
end



function OBM:getId(obj)
  --get the id of an object based on its reference
  for k,v in pairs(self.objects) do
    if obj == v.reference then
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
  --log:post('DEBUG','obm','getting childs from '..id..', returning '..#result..' elements')
  return result
end

function OBM:setTag(id,bool,tag)
  if tag == 'visible' or tag == 'ticking' then
    log:post('ERROR','obm','Cannot set special tags visible or ticking')
  end
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

--TODO find a way to toggle visibility and update, might not be needed

function OBM:remove(id)
  --recursively remove childs
  local childs = self:getChildrens(id)

  for i,child in ipairs(childs) do
    self:remove(self:getId(child.reference))
  end

  --we get reference of the object to remove
  local object2remove = self:get(id)

  --we remove the object in tags
  for tag,listobjtag in pairs(self.tags) do
    if tag == 'visible' then --special tags, we need to ga a level deeper to go through the layers
      for i,layer in ipairs(listobjtag) do
        for j,obj in ipairs(layer) do
          if obj == object2remove then
            --print(obm:getId(object2remove),obj,object2remove)
            remove(layer,j)
          end
        end
      end
    elseif tag == 'ticking' then --special tags, we need to ga a level deeper to go through the orders
      for i,order in ipairs(listobjtag) do
        for j,obj in ipairs(order) do
          if obj == object2remove then
            remove(order,j)
          end
        end
      end
    else --regular tags
      for i,obj in ipairs(listobjtag) do
        if obj == object2remove then
          remove(listobjtag,i)
        end
      end
    end
  end

  --remove from self objects
  for k,v in pairs(self.objects) do
    if k == id then
      self.objects[k] = nil
    end
  end
  log:post('DEBUG','obm','object '..id..' ('..tostring(object2remove)..') is removed from obm')
end

function OBM:printChildren(node,indent)
  debug = false
  local indent = indent or 0
  if indent == 0 then
    log:post('INFO','obm','---ENTITIES---')
    log:post('INFO','obm',node)
  end
  for k,v in pairs(self:getChildrens(node)) do
    local tab = ''
    for i=0,indent do
      tab = tab..'\t'
    end
    log:post('INFO','obm',tab..self:getId(v.reference)..'\t'..tostring(v.reference))
    self:printChildren(self:getId(v.reference), indent + 1)
  end
  debug = true
end

function OBM:printVisible()
  log:post('INFO','obm','---VISIBLE---')
  --displays layer and contained objects
  for k,v in pairs(self.tags.visible) do
    if #self.tags.visible[k] > 0 then
      log:post('INFO','obm',k)
      for i,o in ipairs(v) do
        log:post('INFO','obm','\t'..self:getId(o)..'\t'..tostring(o))
      end
    end
  end
end

function OBM:printTicking()
  log:post('INFO','obm','---TICKING---')
  --displays layer and contained objects
  for k,v in pairs(self.tags.ticking) do
    if #self.tags.ticking[k] > 0 then
      log:post('INFO','obm',k)
      for i,o in ipairs(v) do
        log:post('INFO','obm','\t'..self:getId(o)..'\t'..tostring(o))
      end
    end
  end
end

return OBM
