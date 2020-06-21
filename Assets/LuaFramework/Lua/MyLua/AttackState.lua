require "MyLua/BaseState"
require "MyLua/Chess"
require "MyLua/GameControl"
require "MyLua/GameRes"

AttackState = {}
AttackState.time = 99999

function AttackState:New(stateName, fsm)
	-- body
	local state = BaseState:New(stateName, fsm)
	state.time = 99999
	return state
end

function AttackState:OnUpdate(chess)
	-- body
	if (chess.enemy ~= nil) then
		if (self.time > chess.chessData.rate and chess.enemy.nowHp > 0) then
			--攻击
			chess.enemy:Injure(chess.chessData.damage + (chess.chessLevel - 1)*chess.chessData.grow_damage)
			self.time = 0

			if (chess.gameobject.transform.position.x > chess.enemy.gameobject.transform.position.x) then
				--目标在棋子的左边
				chess.gameobject:GetComponent(SpriteRenderer).flipX = false
			else
				--目标在棋子的右边
				chess.gameobject:GetComponent(SpriteRenderer).flipX = true
			end
			chess.animator:Play("Attack")
		end
	end
	self.time = self.time + 0.1

	if (chess.enemy ~= nil or chess.enemy.nowHp <= 0) then
		self.fsm:Switch(BaseState.stateName["FindTarget"])
	end
end
