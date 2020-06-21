Point = {}
Point.x = nil
Point.y = nil
Point.F = nil
Point.G = nil
Point.H = nil
Point.canThrought = nil
Point.hasChess = nil
Point.parent = nil

function Point:New(o, x, y, canThrought)
	-- body
	local p = o or {}
	setmetatable(p, self)
	self.__index = self

	--初始化
	self.x = x or 0
	self.y = y or 0
	self.canThrought = canThrought or false

	return p
end

function Point:Copy(point)
	-- body
	local p = {}
	setmetatable(p, self)
	self.__index = self

	self.x = point.x
	self.y = point.y
	self.canThrought = point.canThrought
	self.hasChess = point.hasChess

	return p
end

function Point:SetParent(point, g)
	-- body
	self.parent = point
	self.G = g
	self.F = self.G + self.H
end

function Point:SetCanThrought( flag )
	-- body
	self.canThrought = flag
end

function Point:SetHasChess( flag )
	-- body
	self.hasChess = flag
end

function Point:ThisPointCanThrought()
	-- body
	if (self.canThrought and self.hasChess)
	then
		return true
	else
		return false
	end
end