repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")



local Service = {}
setmetatable(Service, {
    __index = function(_, key)
        local success, result = pcall(function()
            return cloneref(game:GetService(tostring(key)))
        end)
        return success and result or game:GetService(tostring(key))
    end
})


local Players = Service.Players
local LocalPlayer = Players.LocalPlayer
local Char = LocalPlayer.Character
local Workspace = Service.Workspace
local LocalUserId = LocalPlayer.UserId
local HttpService = Service.HttpService
local ReplicatedStorage = Service.ReplicatedStorage
local RunService = Service.RunService
local VirtualUser = Service.VirtualUser
local VirtualInputManager = Service.VirtualInputManager
local UserInputService = Service.UserInputService
local TeleportService = Service.TeleportService
local GuiService = Service.GuiService
local TweenService = Service.TweenService
local Weapon = {"Sword","Combat","Fruit",""}

LocalPlayer.PlayerScripts.Effects.Disabled = true

Config = Config or {
    ["Get Weapon"] = {"Sword"},
    ["Fast Attack"] = true,
    ["Auto Shadow"] = true,
    ["Skill Z"] = true
}

local Ex_Function = {}

local SaveFolder = "Rogue piece"
local SaveFile = SaveFolder .. "/Config.json"

---------------------------------------------------------------------------------------------------------------

local Func = {}
Func.__index = Func

local SetFunc = setmetatable({}, Func)

local interactduplicated = false

for i,v in next,getconnections(LocalPlayer.Idled) do
	v:Disable()
end

function Func:ClickGui(path)
    if interactduplicated then return end
    interactduplicated = true
    xpcall(function()
        if typeof(path) ~= "Instance" or not path:IsA("GuiObject") then
            interactduplicated = false
            return
        end
        repeat
            task.wait()
            GuiService.SelectedObject = path
        until GuiService.SelectedObject == path or not path:IsDescendantOf(game)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        repeat
            task.wait()
            GuiService.SelectedObject = nil
        until GuiService.SelectedObject == nil
        interactduplicated = false
    end, function(err)
        warn("ClickGui Error:", err)
        interactduplicated = false
    end)
end

--[[local ClickGui = function(path)
    if interactduplicated then return end
    interactduplicated = true
    xpcall(function()
        if typeof(path) ~= "Instance" or not path:IsA("GuiObject") then
            interactduplicated = false
            return
        end
        repeat
            task.wait()
            GuiService.SelectedObject = path
        until GuiService.SelectedObject == path or not path:IsDescendantOf(game)
        task.wait(0.03)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        task.wait(0.01)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        task.wait(0.01)
        repeat
            task.wait()
            GuiService.SelectedObject = nil
        until GuiService.SelectedObject == nil
        interactduplicated = false
    end, function(err)
        warn("ClickGui Error:", err)
        interactduplicated = false
    end)
end]]

function SendKey(Key)
    VirtualInputManager:SendKeyEvent(true, Key, false, game)
    VirtualInputManager:SendKeyEvent(false, Key, false, game)
end 

function TP(cf)
    local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if Root and cf then
        Root.CFrame = cf
    end
end

function A()
   ReplicatedStorage.Remotes.Serverside:FireServer("Server","Sword","M1s","Solemn Lament",1)
end

function Z()
   ReplicatedStorage.Remotes.Serverside:FireServer("Server","Sword","Skill1","Solemn Lament")
end

function X()
   ReplicatedStorage.Remotes.Serverside:FireServer("Server","Sword","Skill2","Solemn Lament")
end

function C()
   ReplicatedStorage.Remotes.Serverside:FireServer("Server","Sword","Skill3","Solemn Lament")
end

function V()
   ReplicatedStorage.Remotes.Serverside:FireServer("Server","Sword","Skill4","Solemn Lament")
end

task.spawn(function()
	while task.wait() do
        if LocalPlayer.Character then
            for i,v in next, {"Sword","Defense"} do 
                LocalPlayer.PlayerGui.Button.Stats_Frame["{}"].Event:FireServer(v,"10000")
                task.wait()
            end
        end
	end 
end)

function Boss_InfoX()
    local rawData = require(game.ReplicatedStorage.Modules.MetaData.Boss_Info)
    local CheckBoss = {}
    for name, data in pairs(rawData) do
        table.insert(CheckBoss, {
            Name = name,
            Gems = data.Gems,
            Material = data.Material[1][1],
            MaterialNumber = data.Material[1][2],
            Color = data.Color,
            Index = data.Index
        })
    end
    table.sort(CheckBoss, function(a,b) return a.Index < b.Index end)
    return CheckBoss
end

BossList = {}
for i,v in next, require(game.ReplicatedStorage.Modules.MetaData.Boss_Info) do 
    table.insert(BossList, i)
end

local function EncodeCFrame(cf)
    local x, y, z = cf.Position.X, cf.Position.Y, cf.Position.Z
    local rx, ry, rz = cf:ToOrientation()
    return {X = x, Y = y, Z = z, RX = rx, RY = ry, RZ = rz}
end

MobList = {}
for i,v in next, workspace.Main.Characters:GetChildren() do 
    if v:IsA("Folder") then 
        for i1,v1 in next, v:GetChildren() do 
            if v1:IsA("Folder") then 
                table.insert(MobList,v1.Name)
            end 
        end 
    end 
end 

local function DecodeCFrame(t)
    if typeof(t) == "table" and t.X and t.Y and t.Z and t.RX and t.RY and t.RZ then
        return CFrame.new(t.X, t.Y, t.Z) * CFrame.Angles(t.RX, t.RY, t.RZ)
    end
    return nil
end

function LoadSettings()
    if not (readfile and writefile and isfile and isfolder and makefolder) then
        return warn("Executor Not Support Save System")
    end
    if not isfolder(SaveFolder) then
        makefolder(SaveFolder)
    end
    if not isfile(SaveFile) then
        SaveSettings()
        return
    end

    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(SaveFile))
    end)
    if success and type(data) == "table" then
        for k, v in next, data do
            if k == "Save Position" then
                Config[k] = DecodeCFrame(v) or v
            else
                Config[k] = v
            end
        end
    else
        warn("Failed to load config file")
    end
end

function SaveSettings()
    if not (readfile and writefile and isfile and isfolder and makefolder) then
        return warn("Executor Not Support Save System")
    end
    local saveData = {}
    for k, v in next, Config do
        if typeof(v) == "CFrame" then
            saveData[k] = EncodeCFrame(v)
        else
            saveData[k] = v
        end
    end
    local success, encoded = pcall(function()
        return HttpService:JSONEncode(saveData)
    end)
    if success and encoded then
        if not isfile(SaveFile) or readfile(SaveFile) ~= encoded then
            writefile(SaveFile, encoded)
        end
    end
end

LoadSettings()

local function AddToggle(where, data)
    local defaultValue = Config[data.Title]
    if defaultValue == nil then
        defaultValue = data.Default or false
        Config[data.Title] = defaultValue
    end
    local toggle = where:AddToggle({
        Title = data.Title,
        Description = data.Desc or "",
        Default = defaultValue,
        Flag = data.Title
    })
    local threadRunning
    toggle:OnChanged(function(state)
        Config[data.Title] = state
        local fn = Ex_Function[data.Title]
        if fn then
            if state then
                threadRunning = task.spawn(fn)
            elseif threadRunning then
                task.cancel(threadRunning)
                threadRunning = nil
            end
        end
        if data.Callback then
            data.Callback(state)
        end
        SaveSettings()
    end)
    return toggle
end

function AddDropdown(where, data)
    data.Default = Config[data.Title] or (data.Multi and {} or {""})
    local dropdown = where:AddDropdown({
        Title = data.Title,
        Description = data.Desc or "",
        Values = data.Values or {},
        Multi = data.Multi or false,
        Default = data.Default,
        Flag = data.Title
    })
    dropdown:OnChanged(function(value)
        Config[data.Title] = value
        if data.Callback then data.Callback(value) end
        SaveSettings()
    end)
    return dropdown
end

--[[function AddSlider(where, data)
    data.Default = Config[data.Title] or 0
    local slider = where:AddSlider({
        Title = data.Title,
        Description = data.Desc or data.Description or "",
        Min = data.Min or 0,
        Max = data.Max or 100,
        Decimal = data.Decimal or 0,
        Default = data.Default,
        Flags = data.Flags or data.Title
    })
    slider:OnChanged(function(value)
        Config[data.Title] = value
        if data.Callback then data.Callback(value) end
        SaveSettings()
    end)
    return slider
end
]]

function AddSlider(where, data)
    data.Min = data.Min or 0
    data.Max = data.Max or 100
    data.Decimal = data.Decimal or 1 
    data.Default = Config[data.Title] or (data.Min or 0)
    local slider = where:AddSlider({
        Title = data.Title,
        Description = data.Desc or data.Description or "",
        Min = data.Min,
        Max = data.Max,
        Increment = data.Increment or 0.1,
        Default = data.Default,
        Flag = data.Flag or data.Title
    })
    slider:OnChanged(function(value)
        local roundedValue = tonumber(string.format("%." .. (data.Decimal or 1) .. "f", value))
        Config[data.Title] = roundedValue
        if data.Callback then data.Callback(roundedValue) end
        SaveSettings()
    end)
    return slider
end

function AddTextbox(where, data)
    data.Default = Config[data.Title] or data.Default or ""
    local textbox = where:AddInput({
        Title = data.Title,
        Description = data.Desc or "",
        Placeholder = data.Placeholder or "",
        Default = data.Default,
        Flag = data.Title
    })
    textbox:OnChanged(function(text)
        Config[data.Title] = text
        if data.Callback then data.Callback(text) end
        SaveSettings()
    end)
    return textbox
end

function SelectWeapon(Tool)
    for _, v in next, LocalPlayer.Backpack:GetChildren() do 
        if v:IsA("Tool") and v.ToolTip == Tool then
            v.Parent = LocalPlayer.Character
        end 
    end
end

task.spawn(function()
	while task.wait() do
        pcall(function()
			local w = Config["Get Weapon"]

			if typeof(w) == "string" and w ~= "" then
				SelectWeapon(w)
			elseif typeof(w) == "table" then
				for _, v in ipairs(w) do
					SelectWeapon(v)
				end
			end
		end)
	end
end)



---------------------------------------------------------------------------------------------------------------

local Library, ThemeController = loadstring(request({
    Url = "https://raw.githubusercontent.com/Baeyopll01/Xero-Hub/refs/heads/Secret4869/Xero.lua",
    Method = "GET"
}).Body)()

local ScreenGui1 = Instance.new("ScreenGui")

local ToggleButton = Instance.new("ImageButton")
local UICorner1 = Instance.new("UICorner")

ScreenGui1.Name = "WindowToggle"
ScreenGui1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui1.Parent = game:GetService("CoreGui")

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui1
ToggleButton.AnchorPoint = Vector2.new(0.5, 0)
ToggleButton.Position = UDim2.new(0.5, 0, 0, 20)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0
ToggleButton.BorderSizePixel = 0
ToggleButton.Draggable = true
ToggleButton.Image = "rbxassetid://133849838303504"
ToggleButton.AutoButtonColor = true


UICorner1.CornerRadius = UDim.new(0.25, 0)
UICorner1.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
Library:Toggle()
end)

local Window = Library:Window({
    Title = "Main",
    SubTitle = "Rogue Piece",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 400),
    MinimizeKey = Enum.KeyCode.LeftControl,
    Theme = "Snow",
    ExitCallback = function() end,
    Transparency = 0.85,
    FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
})

local Tabs = {
    _Main= Window:AddTab({Title = "Main", Icon = "gamepad-1"}),
}

local Main = Tabs._Main:AddSection({Title = "Fast Attack"})

AddToggle(Main, {
    Title = "Fast Attack",
})

local Main = Tabs._Main:AddSection({Title = "Auto Skills"})

AddToggle(Main, {
    Title = "Skill Z",
})

AddToggle(Main, {
    Title = "Skill X",
})

AddToggle(Main, {
    Title = "Skill C",
})

AddToggle(Main, {
    Title = "Skill V",
})

local Tabs = {
    _Farm = Window:AddTab({Title = "Automatic", Icon = "gamepad-2"}),
}

local Farm = Tabs._Farm:AddSection({Title = "Mob"}) 

AddDropdown(Farm, {
    Title = "Select Mob",
    Desc = "",
    Values = MobList,
    Multi = false
})

AddToggle(Farm, {
    Title = "Auto Farm Mob",
})

local Farm = Tabs._Farm:AddSection({Title = "Fully"}) 

AddToggle(Farm, {
    Title = "Auto Farm Fully",
})

AddToggle(Farm, {
    Title = "Auto Anos",
})

AddToggle(Farm, {
    Title = "Auto Sea Beast",
})

local Farm = Tabs._Farm:AddSection({Title = "Fishing"})

AddToggle(Farm, {
    Title = "Auto Fishing",
})

AddToggle(Farm, {
    Title = "Auto Open",
})

local Farm = Tabs._Farm:AddSection({Title = "Spawn Aizen"})

AddToggle(Farm, {
    Title = "Auto Spawn Aizen",
})

AddToggle(Farm, {
    Title = "Auto Exchange",
})

local Farm = Tabs._Farm:AddSection({Title = "Spawn Boss"}) 

AddDropdown(Farm, {
    Title = "Select Spawn Boss",
    Desc = "",
    Values = BossList,
    Multi = false
})

AddToggle(Farm, {
    Title = "Auto Spawn Boss",
})

local Tabs = {
    _Misc = Window:AddTab({Title = "Misc", Icon = "gamepad-2"}),
}

local Misc = Tabs._Misc:AddSection({Title = "Open Chest"}) 

AddToggle(Misc, {
    Title = "Auto Open Chest",
})

AddToggle(Misc, {
    Title = "Buy Summon Orb",
})

local Misc = Tabs._Misc:AddSection({Title = "Quest"}) 

AddToggle(Misc, {
    Title = "Garou",
})

function lv()
    local lv = LocalPlayer.Info.Level.Value 
    if lv >= 0 and lv <= 99 then 
        return "Bandit", "1", workspace.Main.Characters["Windmill Village"].Bandit
    elseif lv >= 100 then 
        return "Sorcerer's Student", "9", workspace.Main.Characters["Jujutsu Highschool"]["Sorcerer's Student"]
    end 
    return nil, nil, nil
end

-----------------------------------------------------------------------------------


-----------------------------------------------------------------------------------
for i,v in next, require(ReplicatedStorage.Modules.MetaData.Code_Info) do
    LocalPlayer.PlayerGui.Button.Setting_Frame["{}"].Event:FireServer(i)
end

local FarmingAizen = false

Ex_Function["Auto Spawn Aizen"] = function()
    while Config["Auto Spawn Aizen"] and task.wait() do 
        pcall(function()
            if workspace.Main.Characters.Huecomundo.Boss:FindFirstChild("Aizen") then 
                for i,v in next, workspace.Main.Characters.Huecomundo.Boss:GetChildren() do 
                    if v.Name == "Aizen" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif not workspace.Main.Characters.Huecomundo.Boss:FindFirstChild("Aizen") and LocalPlayer.Inventory["Hogyoku Fragment"].Value > 0 and LocalPlayer.Currencys.Gems.Value >= 1250 then 
                TP(workspace.Main.NPCs["Boss Spawn3"].HumanoidRootPart.CFrame * CFrame.new(0,0,-3))
                workspace.Main.NPCs["Boss Spawn3"]["{}"].HoldDuration = 0
                SendKey("E")
            end 
        end)
    end 
end 

Ex_Function["Fast Attack"] = function()
    while Config["Fast Attack"] and task.wait() do 
        pcall(function()
            A()
        end)
    end 
end

Ex_Function["Skill Z"] = function()
    while Config["Skill Z"] and task.wait() do 
        pcall(function()
            Z()
        end)
    end 
end

Ex_Function["Skill X"] = function()
    while Config["Skill X"] and task.wait() do 
        pcall(function()
            X()
        end)
    end 
end

Ex_Function["Skill C"] = function()
    while Config["Skill C"] and task.wait() do 
        pcall(function()
            C()
        end)
    end 
end

Ex_Function["Skill V"] = function()
    while Config["Skill V"] and task.wait() do 
        pcall(function()
            V()
        end)
    end 
end

Ex_Function["Auto Farm Mob"] = function()
    while Config["Auto Farm Mob"] and task.wait() do
        pcall(function()
            local FoundMob = false
            for _, v in next, workspace.Main.Characters:GetChildren() do 
                if v:IsA("Folder") then 
                    for _, v1 in next, v:GetChildren() do 
                        if v1.Name == Config["Select Mob"] then 
                            for _, v2 in next, v1:GetChildren() do 
                                if v2:IsA("Model") and v2:FindFirstChild("Humanoid") and v2.Humanoid.Health > 0 then 
                                    FoundMob = true
                                    TP(v2.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0) * CFrame.Angles(math.rad(-90), 0, 0))
                                    task.wait(0.000001)
                                end
                            end
                        end
                    end
                end
            end
            if not FoundMob then
                for _, v in next, workspace.Main.Characters:GetChildren() do 
                    if v:IsA("Folder") then 
                        for _, v1 in next, v:GetChildren() do 
                            if v1.Name == Config["Select Mob"] then 
                                for _, v2 in next, v1:GetChildren() do 
                                    if v2:IsA("Part") then 
                                        TP(v2.CFrame * CFrame.new(0, 15, 0))
                                    end
                                end
                            end 
                        end 
                    end
                end
            end
        end)
    end
end

Ex_Function["Auto Spawn Boss"] = function()
    while Config["Auto Spawn Boss"] and task.wait() do
        pcall(function()
            local Throne = workspace.Main.Characters:FindFirstChild("Throne Isle")
            local NPCs = workspace.Main.NPCs
            local BossName = Config["Select Spawn Boss"]
            if not Throne or not NPCs then return end

            local SpawnVal = Throne:FindFirstChild("Spawn")
            local BossFolder = Throne:FindFirstChild("Boss")

            if SpawnVal and SpawnVal.Value and BossFolder then
                for _, v in next, BossFolder:GetChildren() do
                    if v.Name == BossName and v:FindFirstChild("Humanoid") 
                        and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end
                end

            elseif SpawnVal and not SpawnVal.Value 
                and not LocalPlayer.PlayerGui.Button["Boss Spawn"].Visible then

                local BossNPC = NPCs:FindFirstChild("Boss Spawn1")
                if BossNPC and BossNPC:FindFirstChild("HumanoidRootPart") then
                    TP(BossNPC.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3))
                    local Interact = BossNPC:FindFirstChild("{}")
                    if Interact then
                        Interact.HoldDuration = 0
                    end
                    SendKey("E")
                    task.wait(0.5)
                end

            elseif LocalPlayer.PlayerGui:FindFirstChild("Button") 
                and LocalPlayer.PlayerGui.Button:FindFirstChild("Boss Spawn") 
                and LocalPlayer.PlayerGui.Button["Boss Spawn"].Visible then

                local BossSpawnGui = LocalPlayer.PlayerGui.Button["Boss Spawn"]

                if BossSpawnGui.Selection.Value ~= BossName then
                    local SelectFrame = BossSpawnGui.Frame:FindFirstChild(BossName)
                    if SelectFrame and SelectFrame:FindFirstChild("Button") then
                        Func:ClickGui(SelectFrame.Button)
                        task.wait(0.2)
                    end

                elseif BossSpawnGui:FindFirstChild("Spawn") and BossSpawnGui.Spawn:FindFirstChild("Button") then
                    Func:ClickGui(BossSpawnGui.Spawn.Button)
                    task.wait(0.3)
                end

            end

            if LocalPlayer.Inventory["Summon Orb"].Value < 50 then
                LocalPlayer.PlayerGui.Button["Shop Item"].Visible = true
                    repeat 
                        Func:ClickGui(LocalPlayer.PlayerGui.Button["Shop Item"].Gems["Summon Orb"].Buy.Button)
                    until LocalPlayer.Inventory["Summon Orb"].Value >= 50
                LocalPlayer.PlayerGui.Button["Shop Item"].Visible = false
            end

        end)
    end
end


Ex_Function["Auto Exchange"] = function()
    while Config["Auto Exchange"] and task.wait() do 
        if LocalPlayer.PlayerGui.Button.Exchange_Frame.Visible then 
            Func:ClickGui(LocalPlayer.PlayerGui.Button.Exchange_Frame.Material_Frame["Boss Token"].Button)
        elseif LocalPlayer.Inventory["Boss Token"].Value >= 5 then
            TP(workspace.Main.NPCs.Exchange.HumanoidRootPart.CFrame * CFrame.new(0,0,-3))
            workspace.Main.NPCs.Exchange["{}"].HoldDuration = 0
            SendKey("E")
        elseif LocalPlayer.Inventory["Boss Token"].Value < 5 and LocalPlayer.PlayerGui.Button.Exchange_Frame.Visible then
            Func:ClickGui(LocalPlayer.PlayerGui.Button.Exchange_Frame.Close)
        end 
    end 
end  


Ex_Function["Auto Anos"] = function()
    while Config["Auto Anos"] and task.wait() do
        pcall(function()
           if workspace.Main.Characters["Abyss Hill [Upper]"].Boss:FindFirstChild("Anos") then
                for i, v in next, workspace.Main.Characters["Abyss Hill [Upper]"].Boss:GetChildren() do
                    if v.Name == "Anos" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0) * CFrame.Angles(math.rad(-90), 0, 0))
                    end
                end
            elseif workspace.Main.Characters["Throne Isle"].Boss:FindFirstChild("Todoroki") then
                for i,v in next, workspace.Main.Characters["Throne Isle"].Boss:GetChildren() do
                    if v.Name == "Todoroki" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0) * CFrame.Angles(math.rad(-90), 0, 0))
                    end
                end
            --[[elseif LocalPlayer.Inventory["Kaneki's Blood"].Value >= 1 then
                TP(workspace.Main.NPCs["Boss Spawn4"].HumanoidRootPart.CFrame * CFrame.new(0,0,7))
                workspace.Main.NPCs["Boss Spawn4"]["{}"].HoldDuration = 0
                SendKey("E")
            elseif LocalPlayer.Inventory["Summon Orb"].Value < 50 and LocalPlayer.Currencys.Gems.Value >= 1000 then
                    LocalPlayer.PlayerGui.Button["Shop Item"].Visible = true
                    repeat 
                        Func:ClickGui(LocalPlayer.PlayerGui.Button["Shop Item"].Gems["Summon Orb"].Buy.Button)
                    until LocalPlayer.Inventory["Summon Orb"].Value >= 50
                    LocalPlayer.PlayerGui.Button["Shop Item"].Visible = false
            elseif LocalPlayer.Inventory["Boss Token"].Value >= 25 and LocalPlayer.Inventory["Summon Orb"].Value >= 50 and LocalPlayer.Currencys.Gems.Value >= 2500 and LocalPlayer.Inventory["Muzan's Blood"].Value >= 5 then
                LocalPlayer.PlayerGui.Button.Craft.Visible = true
                Func:ClickGui(LocalPlayer.PlayerGui.Button.Craft.Craft_Frame.Scroll["Kaneki's Blood"].Craft.Button)
                task.wait(0.2)
                LocalPlayer.PlayerGui.Button.Craft.Visible = false
            ]]
            elseif not workspace.Main.Characters["Abyss Hill [Upper]"].Boss:FindFirstChild("Todoroki") then
                local Throne = workspace.Main.Characters:FindFirstChild("Throne Isle")
                if Throne then
                    local SpawnVal = Throne:FindFirstChild("Spawn")
                    local BossFolder = Throne:FindFirstChild("Boss")
                    local BossName = "Todoroki"

                    if SpawnVal and not SpawnVal.Value and not LocalPlayer.PlayerGui.Button["Boss Spawn"].Visible then
                        local npc = workspace.Main.NPCs:FindFirstChild("Boss Spawn1")
                        if npc and npc:FindFirstChild("HumanoidRootPart") then
                            TP(npc.HumanoidRootPart.CFrame * CFrame.new(0,0,-3))
                            if npc:FindFirstChild("{}") then npc["{}"].HoldDuration = 0 end
                            SendKey("E")
                            task.wait(0.5)  
                        end
                    else 
                        local BS = LocalPlayer.PlayerGui.Button:FindFirstChild("Boss Spawn")
                        if BS and BS.Visible then
                            if BS.Selection.Value ~= BossName then
                                local btn = BS.Frame:FindFirstChild(BossName)
                                if btn and btn:FindFirstChild("Button") then
                                    Func:ClickGui(btn.Button)
                                    task.wait(0.2)
                                end
                            elseif BS:FindFirstChild("Spawn") and BS.Spawn:FindFirstChild("Button") then
                                Func:ClickGui(BS.Spawn.Button)
                                task.wait(0.3)
                            end
                        end
                    end
                end
            elseif LocalPlayer.Inventory["Summon Orb"].Value < 100 then
                if LocalPlayer.Currencys.Gems.Value >= 1000 then
                    LocalPlayer.PlayerGui.Button["Shop Item"].Visible = true
                    Func:ClickGui(LocalPlayer.PlayerGui.Button["Shop Item"].Gem["Summon Orb"].Buy.Button)
                    task.wait()
                else
                    LocalPlayer.PlayerGui.Button["Shop Item"].Visible = false
                end
            end
        end)
    end
end




Ex_Function["Garou"] = function()
    while Config["Garou"] and task.wait() do 
        ReplicatedStorage.Remotes.Serverside:FireServer("Server","Combat","M1s","Suiryu",1)
    end 
end  


Ex_Function["Auto Open"] = function()
    while Config["Auto Open"] and task.wait() do 
        pcall(function()
            if LocalPlayer.Inventory["Rare Chest"].Value >= 1 then
                LocalPlayer.PlayerGui.Button.Storage_Frame.Visible = true
                SetFunc:ClickGui(LocalPlayer.PlayerGui.Button.Storage_Frame.Material_Frame["Rare Chest"].Button)
            end
            if LocalPlayer.PlayerGui.Button.Confirm.Visible then
                SetFunc:ClickGui(LocalPlayer.PlayerGui.Button.Confirm.Accept.Button)
            end
        end)
    end 
end  

Ex_Function["Auto Fishing"] = function()
    while Config["Auto Fishing"] and task.wait() do 
        pcall(function()
            if not LocalPlayer.PlayerGui.HUD:FindFirstChild("Fishing Bar").Visible then
                ReplicatedStorage.Remotes.Serverside:FireServer("Server", "Misc", "Fishing", true)
                task.wait(1)
            elseif LocalPlayer.PlayerGui.HUD.Fishing:FindFirstChild("Button") then
                LocalPlayer.PlayerGui.HUD.Fishing.Button.Size = UDim2.new(1111, 1111, 1111, 1111)
                SetFunc:ClickGui(LocalPlayer.PlayerGui.HUD.Fishing.Button)
            end
        end)
    end 
end

Ex_Function["Buy Summon Orb"] = function()
    while Config["Buy Summon Orb"] and task.wait() do 
        pcall(function()
            LocalPlayer.PlayerGui.Button["Shop Item"].Visible = true
            if LocalPlayer.Inventory["Summon Orb"].Value <= 499 and LocalPlayer.Currencys.Money.Value >= 42500 then
                Func:ClickGui(LocalPlayer.PlayerGui.Button["Shop Item"].Money["Summon Orb"].Buy.Button)
                task.wait()
            elseif not Config["Buy Summon Orb"] then
                LocalPlayer.PlayerGui.Button["Shop Item"].Visible = false
            else
                LocalPlayer.PlayerGui.Button["Shop Item"].Visible = false
            end
        end)
    end 
end

Ex_Function["Auto Sea Beast"] = function()
    while Config["Auto Sea Beast"] and task.wait() do 
        pcall(function()
           if workspace.Main.Characters["Abyss Hill"].Boss:FindFirstChild("Abyssal Beast") then 
                for i,v in next, workspace.Main.Characters["Abyss Hill"].Boss:GetChildren() do 
                    if v.Name == "Abyssal Beast" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif LocalPlayer.Inventory["Core of Abyssal"].Value >= 1 then
                LocalPlayer.PlayerGui.Button.Storage_Frame.Visible = true
                Func:ClickGui(LocalPlayer.PlayerGui.Button.Storage_Frame.Material_Frame["Core of Abyssal"].Button)
                if LocalPlayer.PlayerGui.Button:FindFirstChild("Confirm") then
                   SetFunc:ClickGui(LocalPlayer.PlayerGui.Button.Confirm.Accept.Button)
                end
            end
        end)
    end 
end

Ex_Function["Auto Farm Fully"] = function()
    while Config["Auto Farm Fully"] and task.wait() do 
        pcall(function ()
            local VisibleQuest = LocalPlayer.PlayerGui.HUD.Bar.List:FindFirstChild("Quest")
            local Mon, Quest, Folder = lv()
            local npc = workspace.Main.NPCs.Quests:FindFirstChild(Quest)
            if  workspace.Main.Characters["Jujutsu Highschool"].Boss:FindFirstChild("Yuta") then
                for i,v in next, workspace.Main.Characters["Jujutsu Highschool"].Boss:GetChildren() do 
                    if v.Name == "Yuta" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif workspace.Main.Characters["Throne Isle"].Boss:FindFirstChild("Gojo") then
                for i,v in next, workspace.Main.Characters["Throne Isle"].Boss:GetChildren() do 
                    if v.Name == "Gojo" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif workspace.Main.Characters.Huecomundo.Boss:FindFirstChild("Aizen") then 
                for i,v in next, workspace.Main.Characters.Huecomundo.Boss:GetChildren() do 
                    if v.Name == "Aizen" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif workspace.Main.Characters["Rogue Town"].Boss:FindFirstChild("Sung Jin Woo") then
                for i,v in next, workspace.Main.Characters["Rogue Town"].Boss:GetChildren() do 
                    if v.Name == "Sung Jin Woo" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif workspace.Main.Characters["Rogue Town"].Boss:FindFirstChild("Silver Fang") then
                for i,v in next, workspace.Main.Characters["Rogue Town"].Boss:GetChildren() do 
                    if v.Name == "Silver Fang" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end   
            elseif workspace.Main.Characters["Forge Isle"].Boss:FindFirstChild("Tanjiro") then 
                for i,v in next, workspace.Main.Characters["Forge Isle"].Boss:GetChildren() do 
                    if v.Name == "Tanjiro" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif workspace.Main.Characters["Abyss Hill"].Boss:FindFirstChild("Abyssal Beast") then 
                for i,v in next, workspace.Main.Characters["Abyss Hill"].Boss:GetChildren() do 
                    if v.Name == "Abyssal Beast" and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                    end 
                end 
            elseif not workspace.Main.Characters["Forge Isle"].Boss:FindFirstChild("Tanjiro") and workspace.Server["Slayer's Trainee"].Value >= 50 then 
                TP(workspace.Main.NPCs["Boss Spawn2"].HumanoidRootPart.CFrame * CFrame.new(0,0,-3))
                workspace.Main.NPCs["Boss Spawn2"]["{}"].HoldDuration = 0
                SendKey("E")
            elseif VisibleQuest then
                for i,v in next, Folder:GetChildren() do 
                    if v.Name == Mon and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then 
                        TP(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0) * CFrame.Angles(math.rad(-90),0,0))
                        task.wait(0.001)
                    end 
                end 
            elseif not VisibleQuest then
                TP(npc.HumanoidRootPart.CFrame * CFrame.new(0,0,-7))
                if npc:FindFirstChild("{}") then npc["{}"].HoldDuration = 0 end
                SendKey("E")
            end
            if not workspace.Main.Characters["Forge Isle"].Boss:FindFirstChild("Tanjiro") and not workspace.Main.Characters["Abyss Hill"].Boss:FindFirstChild("Abyssal Beast") and not workspace.Main.Characters["Jujutsu Highschool"].Boss:FindFirstChild("Yuta") and not workspace.Main.Characters["Throne Isle"].Boss:FindFirstChild("Gojo") and not workspace.Main.Characters.Huecomundo.Boss:FindFirstChild("Aizen") and not workspace.Main.Characters["Rogue Town"].Boss:FindFirstChild("Sung Jin Woo") and not workspace.Main.Characters["Rogue Town"].Boss:FindFirstChild("Silver Fang")  and not Folder:FindFirstChild(Mon) then
                for i,v in next, Folder:GetChildren() do 
                    if v:IsA("Part") then 
                        TP(v.CFrame )
                    end
                end
            end
        end)
    end 
end

task.spawn(function()
	while task.wait() do
		pcall(function()
			if Config["Auto Spawn Boss"] or Config["Auto Spawn Aizen"] or Config["Auto Farm Fully"] or Config["Auto Anos"] then
				if LocalPlayer.Character:WaitForChild("Humanoid").Sit then
					LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
				end
				if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
					local BodyVelocity = Instance.new("BodyVelocity")
					BodyVelocity.Name = "BodyVelocity1"
					BodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
					BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
					BodyVelocity.Velocity = Vector3.new(0, 0, 0)
				end
				for i, v in pairs(LocalPlayer.Character:GetChildren()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
				LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
			else
				if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
					LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy()
				end
			end
		end)
	end 
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            if LocalPlayer.PlayerGui.Button.Invite:FindFirstChild("Accept") and LocalPlayer.PlayerGui.Button.Invite.Accept.Visible then
                Func:ClickGui(LocalPlayer.PlayerGui.Button.Invite.Accept.Button)
                task.wait(1)
            end
        end)
    end
end)

task.defer(function()
	for k, v in pairs(Config) do
		if v == true and Ex_Function[k] then
			task.spawn(Ex_Function[k])
		end
	end
end)
