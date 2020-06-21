require "MyLua/BaseState"
require "MyLua/Chess"
require "MyLua/GameControl"
require "MyLua/GameRes"

FindPathToTargetState = {}

function FindPathToTargetState:New(stateName, fsm)
	-- body
	local state = BaseState:New(stateName, fsm)
	return state
end

function FindPathToTargetState:OnUpdate(chess)
	-- body
	chess.path = {}
	chess.astar:SetStartAndEnd(chess.astar.map[chess.chessMapPos.x][chess.chessMapPos.y], chess.astar.map[chess.enemy.chessMapPos.x][chess.enemy.chessMapPos.y])
	if (chess.astar:FindPath) then
		chess.nextStep = chess.astar.map[chess.enemy.chessMapPos.x][chess.enemy.chessMapPos.y].parent
		while (chess.nextStep ~= nil) do
			table.insert(chess.path, chess.nextStep)
			chess.nextStep = chess.nextStep.parent
		end
	else
		--找不到路
	end

	if (#chess.path >= chess.chessData.rang) then
		--如果步数大于2 则移动一步   2为攻击范围 表示可以攻击自身以及自身周围一格的位置
		--取倒数第二位  路径的倒数第一是自己现在的位置，倒数第二是下一步的位置
		chess.nextStep = chess.path[#chess.path - 1]
		if (not GameRes.map[chess.nextStep.x][chess.nextStep.y].hasChess) then
			chess.gameobject.transform.position = 0 --待补充
			GameRes.map[chess.nextStep.x][chess.nextStep.y]:SetHasChess(true)
			GameRes.map[chess.chessMapPos.x][chess.chessMapPos.x]:SetHasChess(false)
			chess.chessMapPos = Vector3Int:New() --待补充
			chess.animator:Play("Walk")
		end
	end

	--移动完后判断距离
	if (#chess.path < chess.chessData.rang) then
		self.fsm:Switch(BaseState.stateName["Attack"])
	else
		self.fsm:Switch(BaseState.stateName["FindTarget"])
	end
end