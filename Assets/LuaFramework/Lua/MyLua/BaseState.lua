BaseState = {}
BaseState.stateName = {}
BaseState.stateName["NullStateID"] = "NullStateID"
BaseState.stateName["FindTarget"] = "FindTarget"
BaseState.stateName["FindPathToTarget"] = "FindPathToTarget"
BaseState.stateName["Attack"] = "Attack"
BaseState.stateName["Die"] = "Die"

function BaseState:New(stateName, fsm)
	-- body
	local state = {}
	state = setmetatable(state, self)
	state.stateName = stateName
	state.fsm = fsm
	return state
end

--进入状态
function BaseState:OnEnter()
end

--更新状态
function BaseState:OnUpdate(chess)
end

--离开状态
function BaseState:OnLeave()
end