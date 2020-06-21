require "MyLua/BaseState"
require "MyLua/Chess"
require "MyLua/GameControl"

FindTargetState = {}

function FindTargetState:New(stateName, fsm)
	-- body
	local state = BaseState:New(stateName, fsm)
	return state
end

function FindTargetState:OnUpdate(chess)
	-- body
	local chessList = {}
	if (chess.gameobject.transform.parent.name == "Player") 
	then
		--在敌方内找目标，采用在GameCtrl里建一个目标表，从里面获得chessList
		chessList = GameControl.enemys
	else
		chessList = GameControl.players
	end
	if (#chessList > 0) then
		--找到距离最近的敌人
		chess.enemy = self:FindMinDistanceEnemy(chessList, chess)
		--计算路径
		chess.astar = Astar:New(chess.chessData.rang)
	end

	if(chess.enemy ~= nil and chess.enemy.nowHp > 0) then
		self.fsm:Switch(BaseState.stateName["FindPathToTarget"])
	end
end

function FindTargetState:FindMinDistanceEnemy(chessList, chess)
	-- body
	local targerPos = nil
	local myPos = chess.grid:CellToWorld(chess.chessMapPos)
	local enemy = nil
	local distance = 99999
	for i=1, #chessList do
		targerPos = chess.grid:CellToWorld(chessList[i].chessMapPos)
		local dis = Mathf:Abs(targerPos.x - myPos.x) + Mathf:Abs(targerPos.y - myPos.y)
		if (dis < distance) then
			enemy = chessList[i]
			distance = dis
		end
	end
	return enemy
end