local transform;
local gameObject;

BattlePanel = {};
local this = BattlePanel;

--启动事件--
function BattlePanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;


	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function BattlePanel.InitPanel()
	logWarn("InitPanel--->>"..gameObject.name);
	this.grid = transform:Find("Grid").gameObject:GetComponent("Grid");
	this.tileMap = transform:Find("Grid/Tilemap").gameObject:GetComponent("Tilemap");
	logWarn("grid--->>"..this.grid);
	logWarn("tileMap--->>"..this.tileMap);
end

--单击事件--
function BattlePanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end

function BattlePanel.CreatTileMap()
	for x=0,7 do
		for y=0,7 do
			local num = x*8 + y;
			if (num < 32)
				--this.tileMap:SetTile()
			else

			end
		end
	end

end