BattleCtrl = {};
local this = BattleCtrl;

local battle;
local transform;
local gameObject;

--构建函数--
function BattleCtrl.New()
	logWarn("BattleCtrl.New--->>");
	return this;
end

function BattleCtrl.Awake()
	logWarn("BattleCtrl.Awake--->>");
	panelMgr:CreatePanel('Battle', this.OnCreate);
end

--启动事件--
function BattleCtrl.OnCreate(obj)
	gameObject = obj;
	transform = obj.transform;

	battle = gameObject:GetComponent('LuaBehaviour');

	logWarn("Start lua--->>"..gameObject.name);
end


--关闭事件--
function BattleCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.MainMenu);
end