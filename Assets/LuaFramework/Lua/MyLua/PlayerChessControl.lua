require "MyLua/GameRes"

PlayerChessControl = {}

PlayerChessControl.player_tank
PlayerChessControl.player_dps
PlayerChessControl.player_master
PlayerChessControl.player_healer

function PlayerChessControl:SetChess(player_tank, player_dps, player_master, player_healer)
	-- body
	self.player_tank = player_tank
	self.player_dps = player_dps
	self.player_master = player_master
	self.player_healer = player_healer
end

function PlayerChessControl:HideChess()
	-- body
	self.player_tank.gameobject:SetActive(false)
	self.player_dps.gameobject:SetActive(false)
	self.player_master.gameobject:SetActive(false)
	self.player_healer.gameobject:SetActive(false)
end

function PlayerChessControl:SetChessData()
	-- body
	self.player_tank.gameobject:SetActive(true)
	self.player_dps.gameobject:SetActive(true)
	self.player_master.gameobject:SetActive(true)
	self.player_healer.gameobject:SetActive(true)
	self.player_tank:SetChessData(GameRes.player_tank_level);
    self.player_dps:SetChessData(GameRes.player_dps_level);
    self.player_master:SetChessData(GameRes.player_master_level);
    self.player_healer:SetChessData(GameRes.player_healer_level);
end

function PlayerChessControl:StartFight()
	-- body
	self.player_tank:StartFight()
	self.player_dps:StartFight()
	self.player_master:StartFight()
	self.player_healer:StartFight()
end

function PlayerChessControl:ReSetChessPos()
	-- body
	self.player_tank.
end