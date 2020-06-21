require "MyLua/GameRes"
require "MyLua/Point"
require "MyLua/Tools"

Astar = {}
Astar.openList = {}
Astar.closeList = {}
Astar.start_point = nil
Astar.end_point = nil
Astar.attackRang = 0
Astar.isInRang = 0
Astar.map = {}

function Astar:New(attackRang)
	-- body
	local a = {}
	setmetatable(a, self)
	self.__index = self

	self.attackRang = attackRang
	self.isInRang = false
	for i=1,GameRes.mapW do
		self.map[i] = {}
		for j=1, GameRes.mapH do
			self.map[i][j] = Point:Copy(GameRes.map[i][j])
		end
	end
end

function Astar:SetStartAndEnd(start_point, end_point)
	-- body
	self.start_point = start_point
	self.end_point = end_point
end

function Astar:FindPath()
	-- body
	self.openList = {}
	self.closeList = {}

	--先把起点加入开放列表
	table.insert(self.openList, self.start_point)
	self:GetF(self.start_point)
	while(#self.openList > 0) do
		--只要开放列表还存在元素就继续
		--选出open集合中F值最小的点
		local point = self:GetMinFOfList(self.openList)
		--判断该点到目标是否在攻击范围内
		if(point.H < self.attackRang)
		then
			self.isInRang = true;
		end
		Tools:RemoveTableByValue(self.openList, point)
		table.insert(self.closeList, point)
		--获取open集合中F值最小的点周围的点
		local surroundPoints = self:GetSurroundPoint(point.x, point.y);
		--在周围点中把已经在关闭列表的点删除
		for k,v in pairs(self.closeList) do
			if (Tools:TableContainsValue(surroundPoints, v)) then
				Tools:RemoveTableByValue(surroundPoints, v)
			end
		end
		--遍历周围的点
		for k,v in pairs(surroundPoints) do
			--周围点已经在开放列表中
			if (Tools:TableContainsValue(self.openList, v)) then
				--重新计算G,如果比原来的G更小,就更改这个点的父亲
				local newG = 1 + point.G
				if (newG < v.G) then
					v:SetParent(point, newG)
				end
			else
				--设置父亲和F并加入开放列表
				v.parent = point
				self:GetF(v)
				table.insert(self.openList, v)
			end
		end

		--只要出现终点就结束
		if (Tools:TableContainsValue(self.openList, end_point)) then
			return true
		end
	end
	return false
end

function Astar:GetSurroundPoint(x, y)
	-- body

	local surroundPoints = {}
	if (y % 2 == 0 or y == 0) then
		--偶数行 map[x-1,y-1]  map[x,y-1] map[x-1,y]  map[x+1,y] map[x-1,y+1]  map[x,y+1]  
		if (x - 1 > 0 and y - 1 > 0) then
			if (self.map[x-1][y-1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x-1][y-1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x-1][y-1])
			end
		end
		if (y - 1 > 0) then
			if(self.map[x][y-1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x][y-1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x][y-1])
			end
		end
		if (x - 1 > 0) then
			if(self.map[x-1][y]:ThisPointCanThrought() or Tools:PointEquals(self.map[x-1][y], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x-1][y])
			end
		end
		if (x - 1 > 0 and y + 1 <= GameRes.mapH) then
			if(self.map[x-1][y+1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x-1][y+1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x-1][y+1])
			end
		end
		if (x + 1 <= GameRes.mapW) then
			if(self.map[x+1][y]:ThisPointCanThrought() or Tools:PointEquals(self.map[x+1][y], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x+1][y])
			end	
		end
		if (y + 1 <= GameRes.mapH) then
			if(self.map[x][y+1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x][y+1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x][y+1])
			end	
		end
	else
		--奇数行 map[x,y-1]  map[x+1,y-1]   map[x-1,y]  map[x+1,y] map[x,y+1]  map[x+1,y+1]
		if (y - 1 > 0) then
			if(self.map[x][y-1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x][y-1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x][y-1])
			end
		end
		if (x + 1 <= GameRes.mapW and y - 1 > 0) then
				if(self.map[x+1][y-1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x+1][y-1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x+1][y-1])
			end	
		end
		if (x - 1 > 0) then
			if(self.map[x-1][y]:ThisPointCanThrought() or Tools:PointEquals(self.map[x-1][y], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x-1][y])
			end
		end
		if (x + 1 <= GameRes.mapW) then
			if(self.map[x+1][y]:ThisPointCanThrought() or Tools:PointEquals(self.map[x+1][y], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x+1][y])
			end	
		end
		if (y + 1 <= GameRes.mapH) then
			if(self.map[x][y+1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x][y+1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x][y+1])
			end	
		end
		if (x + 1 <= GameRes.mapW and y + 1 <= GameRes.mapH) then
			if(self.map[x+1][y+1]:ThisPointCanThrought() or Tools:PointEquals(self.map[x+1][y+1], self.end_point) or self.isInRang) then
				table.insert(surroundPoints, self.map[x+1][y+1])
			end	
		end
	end
	return surroundPoints
end

function Astar:GetMinFOfList(pointList)
	-- body
	local point = 0
	local min = -100
	for k,v in pairs(pointList) do
		if (min > v.F) then
			min = p.F
			point = p
		end
	end
	return point
end

function Astar:GetF(point)
	-- body
	local g = 0
	local h = Mathf:Abs(self.end_point.x - point.x) + Mathf:Abs(self.end_point.y - point.y)
	if (point.parent ~= nil) then
		g = 1 + point.parent.G
	end
	local f = h + g
	point.H = h
	point.G = g
	point.F = f
end

