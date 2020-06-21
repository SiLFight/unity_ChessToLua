local transform;
local gameObject;

MainMenuPanel = {};
local this = MainMenuPanel;

--启动事件--
function MainMenuPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function MainMenuPanel.InitPanel()
	this.btnStart = transform:Find("btnStart").gameObject;
	this.btnQuit = transform:Find("btnQuit").gameObject;
end

--单击事件--
function MainMenuPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end

