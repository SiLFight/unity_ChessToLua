GameLevelData = {}

GameLevelData.name = ""
GameLevelData.level = 0
GameLevelData.pos_x = 0
GameLevelData.pos_y = 0

function GameLevelData:New(name, level, pos_x, pos_y)
	-- body
	local gld = {}
	setmetatable(gld, self)
	self.__index = self
	gld.name = name
	gld.level = level
	gld.pos_x = pos_x
	gld.pos_y = pos_y
	return gld
end