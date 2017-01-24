--[[
statemachine class

params for addState :

  enter : name of a owner's function to launch when entering state
  step : name of a owner's function to execute every step while state is present
  exit : name of a owner's function to launch when exiting state
  flag : a text flag

params for addTransition
  prefered (bool) : this transition will be performed when using nextState function,
  if many are prefered then only the first on defined will be chosen

  ttl (number) : if defined, the state will auto transition to the destination of transition
  after ttl seconds. If multiple auto transition are found for the same state, only the first
  defined will be chosen.
]]

--TODO create a way to return to previous state

function newstate(p)
  local state = {
    enter = p.enter,
    exit = p.exit,
    step = p.step,
    name = p.name,
    flag = p.flag
  }
  return state
end

StateMachine = {}


function StateMachine:new(parent,p)
  local statemachine = entity:new('FSM'..obm:getId( obm:get(parent)),{tags={'ticking'},parent=parent})
  p = p or {}
  statemachine.noSaveLoad = p.noSaveLoad or false
  statemachine.states = {}
  statemachine.transitions = {}
  statemachine.initialState = nil
  statemachine.finalState = nil
  statemachine.owner = obm:get(parent)
  statemachine.isEnded = false
  statemachine.isInit = false --TODO is this working ?
  statemachine.savestates = {} --successives states saved

  --logging and shit
  function statemachine:debug(m)
    log:post('DEBUG',statemachine.name,m)
  end

  --execute step function on owner (exectued every loop)
  function statemachine:step(dt)
    if not self.currentState then log:post('ERROR',statemachine.name,'At least one state is needed') end
    if self.states[self.currentState].step then
      self.owner[self.states[self.currentState].step](self.owner,dt)
    end
  end

  --execute enter function on owner
  function statemachine:enter()
    if self.states[self.currentState].enter then
      self.owner[self.states[self.currentState].enter](self.owner)
    end
  end

  --execute exit function on owner
  function statemachine:exit()
    if self.states[self.currentState].exit then
      self.owner[self.states[self.currentState].exit](self.owner)
    end
  end

  function statemachine:tick(dt)
    --execute owner's step function for this state
    self:step(dt)

    --check if we should autotransition to next state
    local t = statemachine:getAutoTransitionFrom(self.currentState) or nil
    if t then t.counter = t.counter - dt
      if t.counter < 0 then
        t.counter = t.ttl
        statemachine:transition(t.to)
      end
    end
  end

  function statemachine:addState(statename,params)
    local p = params or {}
    self.states[statename] = newstate({enter=p.enter,exit=p.exit,step=p.step,flag=p.flag})
    if not self.currentState then self:setInitialState(statename) end --if no state is current, set this one as current state
  end

  function statemachine:addTransition(statename1,statename2,params)
    --we add the transition information
    local p = params or {}
    table.insert(self.transitions, {
      from = statename1,
      to = statename2,
      ttl = p.ttl,
      counter = p.ttl,
      prefered = p.prefered})
  end

  --set the initial state
  function statemachine:setInitialState(statename)
    self.initialState = statename
    self.currentState = self.initialState
    self.previousState = initialState
    self.isInit = true
  end

  --set the final state
  function statemachine:setFinalState(statename)
    self.finalState = statename
  end

  --can we transition to statename
  function statemachine:canTransition(statename)
    for k,t in pairs(self.transitions) do
      if t.from == self.currentState and t.to == statename then
        return true
      end
    end
    return false
  end

  --get an prefered next state
  function statemachine:getPreferedNextState(statename)
    for k,t in pairs(self.transitions) do
      if t.from == statename and t.prefered and not t.ttl then
        return t.to
      end
    end
    return false
  end

  --get an autotransition from a certain state
  function statemachine:getAutoTransitionFrom(statename)
    for k,t in pairs(self.transitions) do
      if t.from == statename and t.ttl then
        return t
      end
    end
    return false
  end

  --force machine initialization
  function statemachine:initialize()
    self:exit()
    self.currentState = self.initialState
    self:log("initialized")
    self:enter()

  end

  --terminate Sarah Connor
  function statemachine:terminate()
    self:exit()
    self.currentState = self.finalState
    self.isEnded = true
    self:log("terminated")
    self:enter()
  end

  --next state until stopflag
  function statemachine:nextState(stopFlag)
    if self.states[self.currentState].flag ~= nvl(stopFlag,'   ') then
      local ns = statemachine:getPreferedNextState(self.currentState)
      if ns then
        statemachine:transition(ns)
        return false
      else
        log:post('DEBUG',statemachine.name,"Can't transition. No next prefered state")
        return true
      end
    else
      log:post('DEBUG',statemachine.name,"Can't transition. Destination flag is reached")
      return true
    end
  end

  --add a savestate in savestates queue
  function statemachine:saveState()
    if not self.noSaveLoad then
      table.insert(self.savestates,self.currentState)
      log:post('DEBUG',statemachine.name," state "..self.currentState.." saved")
    end
  end

  --load the last savestate and pop it from queue
  function statemachine:loadState()
    if not self.noSaveLoad then
      self:exit()
      self.currentState = self.savestates[#self.savestates]
      --we reset all counters
      for i,t in ipairs(self.transitions) do
        if t.ttl then t.counter = t.ttl end
      end
      table.remove(self.savestates,#self.savestates)
      log:post('DEBUG',statemachine.name,"state "..self.currentState.." loaded")
      self:enter()
    end
  end

  --force a certain state if state machine is juste used as a state enum
  function statemachine:setState(state)
    self:exit()
    self.currentState = state
    log:post('DEBUG',statemachine.name,"state "..self.currentState.." forced")
    self:enter()
  end

  --try to transition to new state
  function statemachine:transition(state)
    if self:canTransition(state) then
      --if there is an exit function to execute on the owner on current state,
      --we execute it before changing state
      self:exit()

      --we change the state
      self.previousState = self.currentState
      self.currentState = state

      --we change isEnded and isInit flags, will something use it one day ?
      if self.currentState == self.finalState then
        self.isEnded = true
      else
        self.isEnded = false
      end

      if self.currentState == self.initialState then
        self.isInit = true
      else
        self.isInit = false
      end

      log:post('DEBUG',statemachine.name,"Transition from "..self.previousState.." to "..self.currentState.." done")
      --if there is an enter function to execute on the owner on new state, we execute it
      self:enter()
    else
      log:post('DEBUG',statemachine.name,"can't transition from "..self.currentState.." to "..state)
      return false
    end
  end

  function statemachine:getCurrentFlag()
    return self.states[self.currentState].flag
  end

  return statemachine
end

return StateMachine
