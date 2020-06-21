
MainMenuCtrl = {};
local this = MainMenuCtrl;

local mainmenu;
local transform;
local gameObject;

--构建函数--
function MainMenuCtrl.New()
	logWarn("MainMenuCtrl.New--->>");
	return this;
end

function MainMenuCtrl.Awake()
	logWarn("MainMenuCtrl.Awake--->>");
	panelMgr:CreatePanel('MainMenu', this.OnCreate);
end

--启动事件--
function MainMenuCtrl.OnCreate(obj)
	gameObject = obj;
	transform = obj.transform;

	mainmenu = gameObject:GetComponent('LuaBehaviour');
	mainmenu:AddClick(MainMenuPanel.btnStart, this.StartGame);
	mainmenu:AddClick(MainMenuPanel.btnQuit, this.QuitGame);

	logWarn("Start lua--->>"..gameObject.name);
end

--单击事件--
function MainMenuCtrl.StartGame(go)
	print("StartGame");
	this.Close();
	panelMgr:CreatePanel('Battle', this.OnCreate);
end

function MainMenuCtrl.QuitGame(go)
	print("EndGame");
end

--关闭事件--
function MainMenuCtrl.Close()
	panelMgr:ClosePanel("MainMenu");
end