FsmMachine = {}

function FsmMachine:New()
	-- body
	local fsmMachine = setmetatable({}, self)
	self.__index = self
	fsmMachine.states = {}
	fsmMachine.curState = nil
	return fsmMachine
end

--添加状态
function FsmMachine:AddState(state)
	-- body
	self.states[state.stateName] = state
end

--初始化默认状态
function FsmMachine:AddInitState(state)
	-- body
	self.curState = state
end

--更新当前状态
function FsmMachine:Update()
	-- body
	self.curState:OnUpdate()
end

--切换状态
function FsmMachine:Switch(stateName)
	-- body
	if (self.curState.stateName ~= stateName) then
		self.curState:OnLeave()
		self.curState = self.states[stateName]
		self.curState:OnEnter()
	end
end