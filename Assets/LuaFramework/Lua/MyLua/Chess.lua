require "MyLua/ChessData"
require "MyLua/Point"
require "MyLua/FsmMachine"
require "MyLua/FindTargetState"
require "MyLua/FindPathToTargetState"
require "MyLua/AttackState"
require "MyLua/BaseState"
require "MyLua/GameRes"

Chess = {}
Chess.gameobject = nil
Chess.chessData = ChessData:New()
Chess.animator = nil
Chess.chessLevel = 1
Chess.grid = nil
Chess.astar = nil
Chess.chessMapPos = nil
Chess.path = {} --point的list
Chess.nextStep = Point:New()
Chess.enemy = Chess:New()
Chess.nowHp = 0
Chess.hpSlider = nil
Chess.findTargetState = nil --状态
Chess.findPathToTargetState = nil --状态
Chess.attackState = nil --状态
Chess.fsm = nil   --有限状态机的管理类

function Chess:New(o, gameobject)
	-- body
	local c = o or {}
	setmetatable(c, self)
	self.__index = self

	--初始化
	c.gameobject = gameobject
	c.animator = c.gameobject:GetComponent("Animator")
	c.fsm = FsmMachine:New()
	c.findTargetState = FindTargetState:New(BaseState.stateName["FindTarget"], c.fsm)
	c.fsm:AddState(c.findTargetState)
	c.findPathToTargetState = FindPathToTargetState:New(BaseState.stateName["FindPathToTarget"], c.fsm)
	c.fsm:AddState(c.findPathToTargetState)
	c.attackState = AttackState:New(BaseState.stateName["Attack"], c.fsm)
	c.fsm:AddState(c.attackState)
	return c
end

function Chess:StartFight()
	-- body
	--判断棋子是否在棋盘上
	if (self:CheckChessIsInMap()) then
		--启动协程 StartCoroutine(ChessAi());
	else
		self.gameobject:SetActive(false)
	end
end

function Chess:StopFight()
	-- body
	--停止协程 StopAllCoroutines();
end

    IEnumerator ChessAi()
    {
        
        while (true)
        {
            yield return new WaitForSeconds(0.1f);
            fsm.Update(this);
            print(this.name + fsm.CurrentStateID);
        }
    }

function Chess:SetChessData(level)
	-- body
	self.chessLevel = level
	--this.chessData = ChessDataManager.GetChessDataManager().datas[this.name];
	self.nowHp = self.chessData.hp + self.chessData.grow_hp * (self.chessLevel - 1)
	--chessMapPos = new Vector3Int(x, y, 0);
end

function Chess:Injure(damage)
	-- body
	if(damage > self.chessData.defense) then
		self.nowHp = self.nowHp - (damage)
		self.hpSlider.value = self.nowHp / self.chessData.hp
		if (self.nowHp <= 0) then
			self:Die()
		end
	end
end

function Chess:Die()
	-- body
	self.gameobject:SetActive(false)
	GameRes.map[self.chessMapPos.x][self.chessMapPos.y]:SetHasChess(false)
end

function Chess:CheckChessIsInMap()
	-- body
	local cellPos = self.grid:WorldToCell(self.gameobject.transform.position)
	if (cellPos.x < 1 or cellPos.x >8) 
	then
		return false
	elseif (cellPos.y < 1 or cellPos.y >8)
	then
		return false
	else
		return true
	end
end