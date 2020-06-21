require "MyLua/Point"

GameRes = {}
GameRes.mapW = 8
GameRes.mapH = 8
GameRes.map = {}
GameRes.canDeployChess = false
GameRes.player_tank_level = 1
GameRes.player_dps_level = 1
GameRes.player_master_level = 1
GameRes.player_healer_level = 1
GameRes.game_level = 1
GameRes.player_money = 0

function GameRes:Init()
	-- body
	for i=1,self.mapW do
		self.map[i] = {}
		for j=1, self.mapH do
			self.map[i][j] = Point:New(nil, i, j, true)
		end
	end
end