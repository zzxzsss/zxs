 local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer

-- Services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Global Variables
_G.InfiniteJump = false
_G.AutoSpeed = false
_G.Speed = 50
_G.AutoHelpPlayer = false
_G.AutoTrollPlayer = false
_G.TugOfWar = false
_G.DoorExit = false
_G.AntiLag = false
_G.PartLag = {"FootstepEffect", "BulletHole", "GroundSmokeDIFFERENT", "ARshell", "effect debris", "effect", "DroppedMP5"}
_G.EspHighlight = false
_G.EspGui = false
_G.EspGuiTextSize = 7
_G.EspGuiTextColor = Color3.new(255, 255, 255)
_G.EspName = false
_G.EspDistance = false
_G.ChooseNotify = "Obsidian"
_G.NotificationSound = true
_G.VolumeTime = 2
_G.JobIdJoin = "Nah"
_G.CollectBandage = false
_G.CollectFlashbang = false
_G.CollectGrenade = false
_G.AntiFling = false
_G.AntiBanana = false


local Loading = false
local Loading1 = false
local CooldownProximity = nil

-- Create Main Window
local Window = Library:Window({
    Title = "zzz hub",
    Desc = "by ktro ",
    Icon = 105059922903197,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 450)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "Close"
    }
})

-- Utility Functions
function CheckWall(Target)
    local Direction = (Target.Position - Workspace.CurrentCamera.Position).unit * (Target.Position - Workspace.CurrentCamera.Position).Magnitude
    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterDescendantsInstances = {Player.Character, Workspace.CurrentCamera}
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local Result = Workspace:Raycast(Workspace.CurrentCamera.Position, Direction, RaycastParams)
    return Result == nil or Result.Instance:IsDescendantOf(Target)
end

function HasTool(tool)
	for _, v in pairs(Player.Character:GetChildren()) do
		if v:IsA("Tool") and v.Name == tool then
			return true
		end
	end
	for _, v in pairs(Player.Backpack:GetChildren()) do
		if v:IsA("Tool") and v.Name == tool then
			return true
		end
	end
	return false
end

-- Setup Jump and Speed
UserInputService.JumpRequest:connect(function()
	if _G.InfiniteJump == true then
		Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

Player.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
if _G.AutoSpeed == true then
	if Player.Character:FindFirstChild("Humanoid") then
		Player.Character.Humanoid.WalkSpeed = _G.Speed or 50
	end
end
end)

-- Main Games Tab
local MainTab = Window:Tab({Title = "Main Games", Icon = "gamepad-2"}) do
    MainTab:Section({Title = "Red Light, Green Light"})

    MainTab:Button({
        Title = "Teleport to Finish",
        Desc = "Instantly teleport to the finish line",
        Callback = function()
            if Workspace:FindFirstChild("RedLightGreenLight") and Workspace.RedLightGreenLight:FindFirstChild("sand") and Workspace.RedLightGreenLight.sand:FindFirstChild("crossedover") then
                local pos = Workspace.RedLightGreenLight.sand.crossedover.Position + Vector3.new(0, 5, 0)
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
            end
        end
    })

    MainTab:Button({
        Title = "Help Player to End",
        Desc = "Carry a player to the finish line",
        Callback = function()
            if Loading then return end
            Loading = true
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                    if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                        Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        wait(0.3)
                        repeat task.wait(0.1)
                            fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                        until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                        wait(0.5)
                        if Workspace:FindFirstChild("RedLightGreenLight") and Workspace.RedLightGreenLight:FindFirstChild("sand") and Workspace.RedLightGreenLight.sand:FindFirstChild("crossedover") then
                            local pos = Workspace.RedLightGreenLight.sand.crossedover.Position + Vector3.new(0, 5, 0)
                            Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                        end
                        wait(0.4)
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                        break
                    end
                end
            end
            Loading = false
        end
    })

    MainTab:Toggle({
        Title = "Auto Help Player",
        Desc = "Automatically help players reach the end",
        Value = false,
        Callback = function(value)
            _G.AutoHelpPlayer = value
            while _G.AutoHelpPlayer do
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                        if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                            Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                            wait(0.3)
                            repeat task.wait(0.1)
                                fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                            until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                            wait(0.5)
                            if Workspace:FindFirstChild("RedLightGreenLight") then
                                Player.Character.HumanoidRootPart.CFrame = CFrame.new(-75, 1025, 143)
                            end
                            wait(0.4)
                            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                            break
                        end
                    end
                end
                task.wait()
            end
        end
    })
    
    MainTab:Button({
        Title = "Troll Player",
        Desc = "Troll a player to the finish line",
        Callback = function()
            if Loading1 then return end
            Loading1 = true
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                    if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                        Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        wait(0.3)
                        repeat task.wait(0.1)
                            fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                        until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                        wait(0.5)
                        if Workspace:FindFirstChild("RedLightGreenLight") then
                            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-84, 1023, -537)
                        end
                        wait(0.4)
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                        break
                    end
                end
            end
            Loading1 = false
        end
    })

    MainTab:Toggle({
        Title = "Auto Troll Player",
        Desc = "Automatically troll players",
        Value = false,
        Callback = function(value)
            _G.AutoTrollPlayer = value
            while _G.AutoTrollPlayer do
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                        if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                            Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                            wait(0.3)
                            repeat task.wait(0.1)
                                fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                            until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                            wait(0.5)
                            if Workspace:FindFirstChild("RedLightGreenLight") then
                                Player.Character.HumanoidRootPart.CFrame = CFrame.new(-84, 1023, -537)
                            end
                            wait(0.4)
                            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                            break
                        end
                    end
                end
                task.wait()
            end
        end
    })

    MainTab:Section({Title = "Dalgona Cookie"})

    MainTab:Button({
        Title = "Complete Dalgona",
        Desc = "Instantly complete the cookie cutting game",
        Callback = function()
            local DalgonaClientModule = Workspace:WaitForChild("ReplicatedStorage").Modules.Games.DalgonaClient
            for i, v in pairs(getreg()) do
                if typeof(v) == "function" and islclosure(v) then
                    if getfenv(v).script == DalgonaClientModule then
                        if getinfo(v).nups == 73 then
                            setupvalue(v, 31, 9e9)
                        end
                    end
                end
            end
        end
    })

    MainTab:Section({Title = "Tug of War"})

    MainTab:Toggle({
        Title = "Auto Tug of War",
        Desc = "Automatically win tug of war",
        Value = false,
        Callback = function(value)
            _G.TugOfWar = value
            while _G.TugOfWar do
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TemporaryReachedBindable"):FireServer({GameQTE = true})
                task.wait()
            end
        end
    })
end

-- Hide & Seek Tab
local HideSeekTab = Window:Tab({Title = "Hide & Seek", Icon = "eye"}) do
    HideSeekTab:Section({Title = "ESP Features"})

    HideSeekTab:Toggle({
        Title = "ESP Door Exit",
        Desc = "Show exit doors with ESP",
        Value = false,
        Callback = function(value)
            _G.DoorExit = value
            while _G.DoorExit do
                if Workspace:FindFirstChild("HideAndSeekMap") then
                    for i, v in pairs(Workspace:FindFirstChild("HideAndSeekMap"):GetChildren()) do
                        if v.Name == "NEWFIXEDDOORS" then
                            for k, m in pairs(v:GetChildren()) do
                                if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                                    for _, a in pairs(m:FindFirstChild("EXITDOORS"):GetChildren()) do
                                        if a:IsA("Model") and a:FindFirstChild("DoorRoot") then
                                            for _, z in pairs(a.DoorRoot:GetChildren()) do
                                                if z.Name:find("Esp_") then
                                                    z:Destroy()
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if _G.DoorExit then
                    if Workspace:FindFirstChild("HideAndSeekMap") then
                        for i, v in pairs(Workspace:FindFirstChild("HideAndSeekMap"):GetChildren()) do
                            if v.Name == "NEWFIXEDDOORS" then
                                for k, m in pairs(v:GetChildren()) do
                                    if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                                        for _, a in pairs(m:FindFirstChild("EXITDOORS"):GetChildren()) do
                                            if a:IsA("Model") and a:FindFirstChild("DoorRoot") then
                                                if a.DoorRoot:FindFirstChild("Esp_Highlight") then
                                                    a.DoorRoot:FindFirstChild("Esp_Highlight").FillColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                                                    a.DoorRoot:FindFirstChild("Esp_Highlight").OutlineColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                                                end
                                                if _G.EspHighlight == true and a.DoorRoot:FindFirstChild("Esp_Highlight") == nil then
                                                    local Highlight = Instance.new("Highlight")
                                                    Highlight.Name = "Esp_Highlight"
                                                    Highlight.FillColor = Color3.fromRGB(255, 255, 255)
                                                    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                                    Highlight.FillTransparency = 0.5
                                                    Highlight.OutlineTransparency = 0
                                                    Highlight.Adornee = a
                                                    Highlight.Parent = a.DoorRoot
                                                elseif _G.EspHighlight == false and a.DoorRoot:FindFirstChild("Esp_Highlight") then
                                                    a.DoorRoot:FindFirstChild("Esp_Highlight"):Destroy()
                                                end
                                                if a.DoorRoot:FindFirstChild("Esp_Gui") and a.DoorRoot["Esp_Gui"]:FindFirstChild("TextLabel") then
                                                    a.DoorRoot["Esp_Gui"]:FindFirstChild("TextLabel").Text =
                                                        (_G.EspName == true and "Door Exit" or "")..
                                                        (_G.EspDistance == true and "\nDistance ("..string.format("%.1f", (Player.Character.HumanoidRootPart.Position - a.DoorRoot.Position).Magnitude).."m)" or "")
                                                    a.DoorRoot["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
                                                    a.DoorRoot["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
                                                end
                                                if _G.EspGui == true and a.DoorRoot:FindFirstChild("Esp_Gui") == nil then
                                                    local GuiPlayerEsp = Instance.new("BillboardGui", a.DoorRoot)
                                                    GuiPlayerEsp.Adornee = a.DoorRoot
                                                    GuiPlayerEsp.Name = "Esp_Gui"
                                                    GuiPlayerEsp.Size = UDim2.new(0, 100, 0, 150)
                                                    GuiPlayerEsp.AlwaysOnTop = true
                                                    GuiPlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
                                                    local GuiPlayerEspText = Instance.new("TextLabel", GuiPlayerEsp)
                                                    GuiPlayerEspText.BackgroundTransparency = 1
                                                    GuiPlayerEspText.Font = Enum.Font.Code
                                                    GuiPlayerEspText.Size = UDim2.new(0, 100, 0, 100)
                                                    GuiPlayerEspText.TextSize = 15
                                                    GuiPlayerEspText.TextColor3 = Color3.new(0,0,0)
                                                    GuiPlayerEspText.TextStrokeTransparency = 0.5
                                                    GuiPlayerEspText.Text = ""
                                                    local UIStroke = Instance.new("UIStroke")
                                                    UIStroke.Color = Color3.new(0, 0, 0)
                                                    UIStroke.Thickness = 1.5
                                                    UIStroke.Parent = GuiPlayerEspText
                                                elseif _G.EspGui == false and a.DoorRoot:FindFirstChild("Esp_Gui") then
                                                    a.DoorRoot:FindFirstChild("Esp_Gui"):Destroy()
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                task.wait()
            end
        end
    })

    HideSeekTab:Toggle({
        Title = "ESP Keys",
        Desc = "Show dropped keys with ESP",
        Value = false,
        Callback = function(value)
            _G.DoorKey = value
            while _G.DoorKey do
                for _, a in pairs(Workspace.Effects:GetChildren()) do
                    if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                        if a.Handle:FindFirstChild("Esp_Highlight") then
                            a.Handle:FindFirstChild("Esp_Highlight").FillColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                            a.Handle:FindFirstChild("Esp_Highlight").OutlineColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                        end
                        if _G.EspHighlight == true and a.Handle:FindFirstChild("Esp_Highlight") == nil then
                            local Highlight = Instance.new("Highlight")
                            Highlight.Name = "Esp_Highlight"
                            Highlight.FillColor = Color3.fromRGB(255, 255, 255)
                            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            Highlight.FillTransparency = 0.5
                            Highlight.OutlineTransparency = 0
                            Highlight.Adornee = a
                            Highlight.Parent = a.Handle
                        elseif _G.EspHighlight == false and a.Handle:FindFirstChild("Esp_Highlight") then
                            a.Handle:FindFirstChild("Esp_Highlight"):Destroy()
                        end
                        if a.Handle:FindFirstChild("Esp_Gui") and a.Handle["Esp_Gui"]:FindFirstChild("TextLabel") then
                            a.Handle["Esp_Gui"]:FindFirstChild("TextLabel").Text =
                                (_G.EspName == true and "Key" or "")..
                                (_G.EspDistance == true and "\nDistance ("..string.format("%.1f", (Player.Character.HumanoidRootPart.Position - a.Handle.Position).Magnitude).."m)" or "")
                            a.Handle["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
                            a.Handle["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
                        end
                        if _G.EspGui == true and a.Handle:FindFirstChild("Esp_Gui") == nil then
                            local GuiPlayerEsp = Instance.new("BillboardGui", a.Handle)
                            GuiPlayerEsp.Adornee = a.Handle
                            GuiPlayerEsp.Name = "Esp_Gui"
                            GuiPlayerEsp.Size = UDim2.new(0, 100, 0, 150)
                            GuiPlayerEsp.AlwaysOnTop = true
                            GuiPlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
                            local GuiPlayerEspText = Instance.new("TextLabel", GuiPlayerEsp)
                            GuiPlayerEspText.BackgroundTransparency = 1
                            GuiPlayerEspText.Font = Enum.Font.Code
                            GuiPlayerEspText.Size = UDim2.new(0, 100, 0, 100)
                            GuiPlayerEspText.TextSize = 15
                            GuiPlayerEspText.TextColor3 = Color3.new(0,0,0)
                            GuiPlayerEspText.TextStrokeTransparency = 0.5
                            GuiPlayerEspText.Text = ""
                            local UIStroke = Instance.new("UIStroke")
                            UIStroke.Color = Color3.new(0, 0, 0)
                            UIStroke.Thickness = 1.5
                            UIStroke.Parent = GuiPlayerEspText
                        elseif _G.EspGui == false and a.Handle:FindFirstChild("Esp_Gui") then
                            a.Handle:FindFirstChild("Esp_Gui"):Destroy()
                        end
                    end
                end
                task.wait()
            end
        end
    })

    HideSeekTab:Section({Title = "Teleportation"})

    HideSeekTab:Button({
        Title = "Teleport to All Keys",
        Desc = "Collect all keys automatically",
        Callback = function()
            local OldCFrame = Player.Character.HumanoidRootPart.CFrame
            for _, a in pairs(Workspace.Effects:GetChildren()) do
                if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                    if Player.Character:FindFirstChild("Head") and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") then
                        if Player:GetAttribute("IsHider") and Player.Character.Humanoid.Health > 0 then
                            Player.Character.HumanoidRootPart.CFrame = a:FindFirstChild("Handle").CFrame
                            wait(0.5)
                        end
                    end
                end
            end
            if Player.Character:FindFirstChild("Head") and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = OldCFrame
            end
        end
    })

    HideSeekTab:Toggle({
        Title = "ESP Player Hide",
        Desc = "Highlight players who are hiding",
        Value = false,
        Callback = function(value)
            _G.HidePlayer = value
            while _G.HidePlayer do
                for i, v in pairs(game.Players:GetChildren()) do
                    if v ~= Player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                        if not v:GetAttribute("IsHider") then
                            for i, n in pairs(v.Character:FindFirstChild("Head"):GetChildren()) do
                                if n.Name:find("Esp_") then
                                    n:Destroy()
                                end
                            end
                        end
                        if v:GetAttribute("IsHider") then
                            if v.Character.Head:FindFirstChild("Esp_Highlight") then
                                v.Character.Head:FindFirstChild("Esp_Highlight").FillColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                                v.Character.Head:FindFirstChild("Esp_Highlight").OutlineColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                            end
                            if _G.EspHighlight == true and v.Character.Head:FindFirstChild("Esp_Highlight") == nil then
                                local Highlight = Instance.new("Highlight")
                                Highlight.Name = "Esp_Highlight"
                                Highlight.FillColor = Color3.fromRGB(255, 255, 255)
                                Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                Highlight.FillTransparency = 0.5
                                Highlight.OutlineTransparency = 0
                                Highlight.Adornee = v.Character
                                Highlight.Parent = v.Character.Head
                            elseif _G.EspHighlight == false and v.Character.Head:FindFirstChild("Esp_Highlight") then
                                v.Character.Head:FindFirstChild("Esp_Highlight"):Destroy()
                            end
                            if v.Character.Head:FindFirstChild("Esp_Gui") and v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel") then
                                v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").Text =
                                    v.Name.." (Hide)"..
                                    (_G.EspDistance == true and "\nDistance ("..string.format("%.1f", (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude).."m)" or "")..
                                    (_G.EspHealth == true and "\nHealth ("..string.format("%.0f", v.Humanoid.Health)..")" or "")
                                v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
                                v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
                            end
                            if _G.EspGui == true and v.Character.Head:FindFirstChild("Esp_Gui") == nil then
                                local GuiPlayerEsp = Instance.new("BillboardGui", v.Character.Head)
                                GuiPlayerEsp.Adornee = v.Character.Head
                                GuiPlayerEsp.Name = "Esp_Gui"
                                GuiPlayerEsp.Size = UDim2.new(0, 100, 0, 150)
                                GuiPlayerEsp.AlwaysOnTop = true
                                GuiPlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
                                local GuiPlayerEspText = Instance.new("TextLabel", GuiPlayerEsp)
                                GuiPlayerEspText.BackgroundTransparency = 1
                                GuiPlayerEspText.Font = Enum.Font.Code
                                GuiPlayerEspText.Size = UDim2.new(0, 100, 0, 100)
                                GuiPlayerEspText.TextSize = 15
                                GuiPlayerEspText.TextColor3 = Color3.new(0,0,0)
                                GuiPlayerEspText.TextStrokeTransparency = 0.5
                                GuiPlayerEspText.Text = ""
                                local UIStroke = Instance.new("UIStroke")
                                UIStroke.Color = Color3.new(0, 0, 0)
                                UIStroke.Thickness = 1.5
                                UIStroke.Parent = GuiPlayerEspText
                            elseif _G.EspGui == false and v.Character.Head:FindFirstChild("Esp_Gui") then
                                v.Character.Head:FindFirstChild("Esp_Gui"):Destroy()
                            end
                        end
                    end
                end
                task.wait()
            end
        end
    })

    HideSeekTab:Toggle({
        Title = "ESP Player Seek",
        Desc = "Highlight players who are seeking",
        Value = false,
        Callback = function(value)
            _G.SeekPlayer = value
            while _G.SeekPlayer do
                for i, v in pairs(game.Players:GetChildren()) do
                    if v ~= Player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                        if not v:GetAttribute("IsHunter") then
                            for i, n in pairs(v.Character:FindFirstChild("Head"):GetChildren()) do
                                if n.Name:find("Esp_") then
                                    n:Destroy()
                                end
                            end
                        end
                        if v:GetAttribute("IsHunter") then
                            if v.Character:FindFirstChild("Esp_Highlight1") then
                                v.Character:FindFirstChild("Esp_Highlight1").FillColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                                v.Character:FindFirstChild("Esp_Highlight1").OutlineColor = _G.EspGuiTextColor or Color3.fromRGB(255, 255, 255)
                            end
                            if _G.EspHighlight == true and v.Character:FindFirstChild("Esp_Highlight1") == nil then
                                local Highlight = Instance.new("Highlight")
                                Highlight.Name = "Esp_Highlight1"
                                Highlight.FillColor = Color3.fromRGB(255, 255, 255)
                                Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                Highlight.FillTransparency = 0.5
                                Highlight.OutlineTransparency = 0
                                Highlight.Adornee = v.Character
                                Highlight.Parent = v.Character.Head
                            elseif _G.EspHighlight == false and v.Character:FindFirstChild("Esp_Highlight1") then
                                v.Character:FindFirstChild("Esp_Highlight1"):Destroy()
                            end
                            if v.Character.Head:FindFirstChild("Esp_Gui1") and v.Character.Head["Esp_Gui1"]:FindFirstChild("TextLabel") then
                                v.Character.Head["Esp_Gui1"]:FindFirstChild("TextLabel").Text =
                                    v.Name.." (Seek)"..
                                    (_G.EspDistance == true and "\nDistance ("..string.format("%.1f", (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude).."m)" or "")
                                v.Character.Head["Esp_Gui1"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
                                v.Character.Head["Esp_Gui1"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
                            end
                            if _G.EspGui == true and v.Character.Head:FindFirstChild("Esp_Gui1") == nil then
                                local GuiPlayerEsp = Instance.new("BillboardGui", v.Character.Head)
                                GuiPlayerEsp.Adornee = v.Character.Head
                                GuiPlayerEsp.Name = "Esp_Gui1"
                                GuiPlayerEsp.Size = UDim2.new(0, 100, 0, 150)
                                GuiPlayerEsp.AlwaysOnTop = true
                                GuiPlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
                                local GuiPlayerEspText = Instance.new("TextLabel", GuiPlayerEsp)
                                GuiPlayerEspText.BackgroundTransparency = 1
                                GuiPlayerEspText.Font = Enum.Font.Code
                                GuiPlayerEspText.Size = UDim2.new(0, 100, 0, 100)
                                GuiPlayerEspText.TextSize = 15
                                GuiPlayerEspText.TextColor3 = Color3.new(0,0,0)
                                GuiPlayerEspText.TextStrokeTransparency = 0.5
                                GuiPlayerEspText.Text = ""
                                local UIStroke = Instance.new("UIStroke")
                                UIStroke.Color = Color3.new(0, 0, 0)
                                UIStroke.Thickness = 1.5
                                UIStroke.Parent = GuiPlayerEspText
                            elseif _G.EspGui == false and v.Character.Head:FindFirstChild("Esp_Gui1") then
                                v.Character.Head:FindFirstChild("Esp_Gui1"):Destroy()
                            end
                        end
                    end
                end
                task.wait()
            end
        end
    })

    HideSeekTab:Toggle({
        Title = "Auto Teleport Hide",
        Desc = "Automatically teleport to hiding players",
        Value = false,
        Callback = function(value)
            _G.AutoTeleportHide = value
            while _G.AutoTeleportHide do
                for i, v in pairs(game.Players:GetChildren()) do
                    if v ~= Player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                        if v:GetAttribute("IsHider") and v.Character.Humanoid.Health > 0 then
                            if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.MoveDirection.Magnitude > 0 then
                                Player.Character.HumanoidRootPart.CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, -7)
                            else
                                Player.Character.HumanoidRootPart.CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame
                            end
                            break
                        end
                    end
                end
                task.wait()
            end
        end
    })

    HideSeekTab:Button({
        Title = "Teleport Player Hide",
        Desc = "Teleport to a hiding player",
        Callback = function()
            for i, v in pairs(game.Players:GetChildren()) do
                if v ~= Player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                    if v:GetAttribute("IsHider") and v.Character.Humanoid.Health > 0 then
                        Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        break
                    end
                end
            end
        end
    })
end

-- Other Games Tab
local OtherTab = Window:Tab({Title = "Other Games", Icon = "puzzle"}) do
    OtherTab:Section({Title = "Jump Rope"})

    OtherTab:Button({
        Title = "Complete Jump Rope",
        Desc = "Teleport to jump rope completion",
        Callback = function()
            if Workspace:WaitForChild("JumpRope") then
                local pos = Workspace.JumpRope.Important.Model.LEGS.Position
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
            end
        end
    })

    OtherTab:Section({Title = "Glass Bridge"})

    OtherTab:Button({
        Title = "Glass Bridge Vision",
        Desc = "Reveal safe glass panels",
        Callback = function()
            local GlassHolder = Workspace:WaitForChild("GlassBridge"):WaitForChild("GlassHolder")
            for i, v in pairs(GlassHolder:GetChildren()) do
                for k, j in pairs(v:GetChildren()) do
                    if j:IsA("Model") and j.PrimaryPart then
                        local Color = j.PrimaryPart:GetAttribute("exploitingisevil") and Color3.fromRGB(248, 87, 87) or Color3.fromRGB(28, 235, 87)
                        j.PrimaryPart.Color = Color
                        j.PrimaryPart.Transparency = 0
                        j.PrimaryPart.Material = Enum.Material.Neon
                    end
                end
            end
        end
    })

    OtherTab:Button({
        Title = "Complete Glass Bridge",
        Desc = "Teleport to the end of glass bridge",
        Callback = function()
            if Workspace:WaitForChild("GlassBridge") then
                local pos = Workspace.GlassBridge.End.PrimaryPart.Position + Vector3.new(0, 8, 0)
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
            end
        end
    })

    OtherTab:Section({Title = "Mingle"})

    OtherTab:Toggle({
        Title = "Auto Mingle",
        Desc = "Automatically complete the mingle game",
        Value = false,
        Callback = function(value)
            _G.AutoMingle = value
            while _G.AutoMingle do
                for i, v in ipairs(Player.Character:GetChildren()) do
                    if v.Name == "RemoteForQTE" then
                        v:FireServer()
                    end
                end
                task.wait()
            end
        end
    })
end

-- Player Tab
local PlayerTab = Window:Tab({Title = "Player", Icon = "user"}) do
    PlayerTab:Section({Title = "Movement"})

    PlayerTab:Slider({
        Title = "Walk Speed",
        Min = 16,
        Max = 1000,
        Rounding = 0,
        Value = 50,
        Callback = function(val)
            _G.Speed = val
            if _G.AutoSpeed and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = val
            end
        end
    })

    PlayerTab:Toggle({
        Title = "Auto Speed",
        Desc = "Maintain custom walk speed",
        Value = false,
        Callback = function(value)
            _G.AutoSpeed = value
            if value and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = _G.Speed or 50
            end
        end
    })

    PlayerTab:Toggle({
        Title = "Infinite Jump",
        Desc = "Jump infinitely in the air",
        Value = false,
        Callback = function(value)
            _G.InfiniteJump = value
        end
    })

    PlayerTab:Section({Title = "Utilities"})

    PlayerTab:Toggle({
        Title = "Auto Skip",
        Desc = "Automatically skip dialogues",
        Value = false,
        Callback = function(value)
            _G.AutoSkip = value
            while _G.AutoSkip do
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DialogueRemote"):FireServer("Skipped")
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TemporaryReachedBindable"):FireServer()
                task.wait(0.8)
            end
        end
    })

    PlayerTab:Toggle({
        Title = "No Cooldown Proximity",
        Desc = "Remove hold duration from proximity prompts",
        Value = false,
        Callback = function(value)
            _G.NoCooldownProximity = value
            if value then
                for i, v in pairs(Workspace:GetDescendants()) do
                    if v.ClassName == "ProximityPrompt" then
                        v.HoldDuration = 0
                    end
                end
            end
            if not value and CooldownProximity then
                CooldownProximity:Disconnect()
                CooldownProximity = nil
            end
            CooldownProximity = Workspace.DescendantAdded:Connect(function(Cooldown)
                if _G.NoCooldownProximity == true then
                    if Cooldown:IsA("ProximityPrompt") then
                        Cooldown.HoldDuration = 0
                    end
                end
            end)
        end
    })

    PlayerTab:Toggle({
        Title = "Anti Lag",
        Desc = "Improve game performance",
        Value = false,
        Callback = function(value)
            _G.AntiLag = value
            if value then
                local Terrain = Workspace:FindFirstChildOfClass("Terrain")
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
                game.Lighting.GlobalShadows = false
                game.Lighting.FogEnd = 9e9
                game.Lighting.FogStart = 9e9
            end
            while _G.AntiLag do
                for i, v in pairs(Workspace:FindFirstChild("Effects"):GetChildren()) do
                    if _G.AntiLag == true then
                        PartLagDe(v)
                    end
                end
                task.wait()
            end
        end
    })
end

-- Settings Tab
local SettingsTab = Window:Tab({Title = "Settings", Icon = "settings"}) do
    SettingsTab:Section({Title = "Configuration"})

    SettingsTab:Button({
        Title = "Reload Script",
        Desc = "Restart the script",
        Callback = function()
            Window:Notify({
                Title = "Reloading",
                Desc = "Script is reloading...",
                Time = 3
            })
            wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/InkGame.lua"))()
        end
    })

    SettingsTab:Section({Title = "UI Settings"})

    SettingsTab:Dropdown({
        Title = "Notification Side",
        Values = {"Left", "Right"},
        Default = "Right",
        Callback = function(Value)
            Library:SetNotifySide(Value)
        end
    })

    SettingsTab:Dropdown({
        Title = "Notification Choose",
        Values = {"Obsidian", "Roblox"},
        Default = "Obsidian",
        Callback = function(Value)
            _G.ChooseNotify = Value
        end
    })

    SettingsTab:Toggle({
        Title = "Notification Sound",
        Default = true,
        Callback = function(Value)
            _G.NotificationSound = Value
        end
    })

    SettingsTab:Slider({
        Title = "Volume Notification",
        Min = 2,
        Max = 10,
        Rounding = 1,
        Value = 2,
        Callback = function(Value)
            _G.VolumeTime = Value
        end
    })

    SettingsTab:Toggle({
        Title = "Open Keybind Menu",
        Default = false,
        Callback = function(Value)
            Library.KeybindFrame.Visible = Value
        end
    })

    SettingsTab:Toggle({
        Title = "Custom Cursor",
        Default = true,
        Callback = function(Value)
            Library.ShowCustomCursor = Value
        end
    })

    SettingsTab:Keybind({
        Title = "Menu Keybind",
        Key = Enum.KeyCode.RightShift,
        Callback = function(value)
            Library.Config.Keybind = value
        end
    })

    SettingsTab:Button({
        Title = "Copy Discord Link",
        Callback = function()
            local discordLink = "https://discord.gg/yourdiscord"
            if setclipboard then
                setclipboard(discordLink)
                Window:Notify({Title = "Copied", Desc = "Discord link copied to clipboard!", Time = 3})
            else
                Window:Notify({Title = "Discord Link", Desc = discordLink, Time = 10})
            end
        end
    })

    SettingsTab:Button({
        Title = "Unload Script",
        Callback = function()
            Library:Unload()
        end
    })

    SettingsTab:Section({Title = "Credits"})
    SettingsTab:Label("ktro - Python / Dex / Script")
    SettingsTab:Label("tsb - Script / Dex")
    SettingsTab:Label("nigger - Script / Dex")
    SettingsTab:Label("zzz hub Hub (zzz) - Script / Dex")

    SettingsTab:Section({Title = "Information"})
    SettingsTab:Label("Country [ "..game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(Player).." ]")
    SettingsTab:Label("Executor [ "..identifyexecutor().." ]")
    SettingsTab:Label("Job ID [ "..game.JobId.." ]")

    SettingsTab:Button({
        Title = "Copy JobId",
        Callback = function()
            if setclipboard then
                setclipboard(tostring(game.JobId))
                Window:Notify({Title = "Copied", Desc = "Job ID copied to clipboard!", Time = 3})
            else
                Window:Notify({Title = "Job ID", Desc = tostring(game.JobId), Time = 10})
            end
        end
    })

    SettingsTab:Input({
        Title = "Join Job ID",
        Placeholder = "Enter Job ID",
        Callback = function(Value)
            _G.JobIdJoin = Value
        end
    })

    SettingsTab:Button({
        Title = "Join Job",
        Callback = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _G.JobIdJoin, Player)
        end
    })

    SettingsTab:Button({
        Title = "Copy Join Job Command",
        Callback = function()
            if setclipboard then
                setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "'..game.JobId..'", Player)')
                Window:Notify({Title = "Copied", Desc = "Join command copied to clipboard!", Time = 3})
            else
                Window:Notify({Title = "Join Command", Desc = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "'..game.JobId..'", Player)', Time = 10})
            end
        end
    })
end

-- Other Tab Functions
local function PartLagDe(g)
	for i, v in pairs(_G.PartLag) do
		if g.Name:find(v) then
			g:Destroy()
		end
	end
end

-- Final Notification
Window:Notify({
    Title = "Ink Game Hub Loaded",
    Desc = "Press Left Control to toggle UI",
    Time = 5
})
