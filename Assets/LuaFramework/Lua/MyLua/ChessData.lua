ChessData = {}
ChessData.name = ""
ChessData.hp = 0
ChessData.rang = 0
ChessData.damage = 0
ChessData.defense = 0
ChessData.rate = 0
ChessData.intro = ""
ChessData.grow_hp = 0
ChessData.grow_rang = 0
ChessData.grow_damage = 0
ChessData.grow_defense = 0
ChessData.grow_rate = 0

function ChessData:New(o)
	-- body
	local cd = o or {}
	setmetatable(cd, self)
	self.__index = self
	return cd
end