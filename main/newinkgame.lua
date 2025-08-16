  if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function applyEffects(character)
	local torso = character:WaitForChild("Torso", 5)
	if not torso then return end

	local nametag = torso:WaitForChild("Player_Nametag", 5)
	if not nametag then return end

	local levelText = nametag:WaitForChild("LevelText", 5)
	local displayName = nametag:WaitForChild("DisplayName", 5)
	if not levelText or not displayName then return end

	local player = Players.LocalPlayer
	local isOwner = (player.Name == "allykashindi53g")

	levelText.Text = isOwner and "[ ZZZ HUB - OWNER ]" or "[ ZZZ HUB - MEMBER ]"

	local wave = 0
	local rainbowHue = 0

	local messages = {
		"ZZZ HUB THE BEST",
		"PROTECT BY ZZZ HUB (Anti-Cheat: Active)",
		"@" .. player.Name .. " (ZZZ Hub User)"
	}
	local msgIndex = 1
	displayName.Text = messages[msgIndex]

	task.spawn(function()
		while character.Parent do
			msgIndex = (msgIndex % #messages) + 1
			displayName.Text = messages[msgIndex]
			task.wait(2)
		end
	end)

	RunService.RenderStepped:Connect(function(deltaTime)
		wave = (wave + deltaTime * 2) % (2 * math.pi)
		rainbowHue = (rainbowHue + deltaTime * 0.2) % 1

		if isOwner then
			local brightness = (math.sin(wave) + 1) / 2
			levelText.TextColor3 = Color3.new(1, brightness, brightness)
		else
			local brightness = (math.sin(wave) + 1) / 2
			levelText.TextColor3 = Color3.new(brightness, 1, brightness)
		end

		displayName.TextColor3 = Color3.fromHSV(rainbowHue, 1, 1)
	end)

	levelText:GetPropertyChangedSignal("Text"):Connect(function()
		local correctText = isOwner and "[ ZZZ HUB - OWNER ]" or "[ ZZZ HUB - MEMBER ]"
		if levelText.Text ~= correctText then
			levelText.Text = correctText
		end
	end)
end

local player = Players.LocalPlayer
if player.Character then
	applyEffects(player.Character)
end
player.CharacterAdded:Connect(applyEffects)

-- Load WindUI Library
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

function Notification(Message, Time)
	if _G.ChooseNotify == "WindUI" then
		WindUI:Notify({
			Title = "ZZZ Hub",
			Content = Message,
			Duration = Time or 5
		})
	elseif _G.ChooseNotify == "Roblox" then
		game:GetService("StarterGui"):SetCore("SendNotification",{Title = "ZZZ Hub",Text = Message,Icon = "rbxassetid://7733658504",Duration = Time or 5})
	end
	if _G.NotificationSound then
        local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://4590662766"
            sound.Volume = _G.VolumeTime or 2
            sound.PlayOnRemove = true
            sound:Destroy()
        end
    end

-- Services
game:GetService("UserInputService").JumpRequest:connect(function()
	if _G.InfiniteJump == true then
		game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
if _G.AutoSpeed == true then
	if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.Speed or 50
	end
end
end)

function CheckWall(Target)
    local Direction = (Target.Position - game.Workspace.CurrentCamera.CFrame.Position).unit * (Target.Position - game.Workspace.CurrentCamera.CFrame.Position).Magnitude
    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, game.Workspace.CurrentCamera}
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local Result = game.Workspace:Raycast(game.Workspace.CurrentCamera.CFrame.Position, Direction, RaycastParams)
    return Result == nil or Result.Instance:IsDescendantOf(Target)
end

function PartLagDe(g)
	for i, v in pairs(_G.PartLag) do
		if g.Name:find(v) then
			g:Destroy()
		end
	end
end

workspace.DescendantAdded:Connect(function(v)
	if _G.AntiLag == true then
		if v:IsA("ForceField") or v:IsA("Sparkles") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Beam") then
			v:Destroy()
		end
		if v:IsA("BasePart") then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.BackSurface = "SmoothNoOutlines"
			v.BottomSurface = "SmoothNoOutlines"
			v.FrontSurface = "SmoothNoOutlines"
			v.LeftSurface = "SmoothNoOutlines"
			v.RightSurface = "SmoothNoOutlines"
			v.TopSurface = "SmoothNoOutlines"
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		end
	end
end)

-- Create Window
local Window = WindUI:CreateWindow({
    Title = "ZZZ Hub - Ink Game",
    Icon = "zap",
    Author = "Welcome to ZZZ Hub!",
    Folder = "ZZZHub_InkGame",
    Size = UDim2.fromOffset(600, 350),
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "User Profile",
                Content = "ZZZ Hub User Profile",
                Duration = 3
            })
        end
    },
    SideBarWidth = 200,
})

Window:Tag({
    Title = "v2.2",
    Color = Color3.fromHex("#30ff6a")
})
Window:Tag({
    Title = "type",
    Color = Color3.fromHex("#315dff")
})

-- Create Sections and Tabs
local Tabs = {
    Main = Window:Section({ Title = "Main Features", Opened = true }),
    Misc = Window:Section({ Title = "Miscellaneous", Opened = true }),
    Settings = Window:Section({ Title = "Settings", Opened = true })
}

local TabHandles = {
    GreenLight = Tabs.Main:Tab({ Title = "Green Light Red Light", Icon = "traffic-light", Desc = "Auto complete and help features" }),
    Dalgona = Tabs.Main:Tab({ Title = "Dalgona", Icon = "cookie", Desc = "Complete dalgona challenges" }),
    TugWar = Tabs.Main:Tab({ Title = "Tug of War / Hide & Seek", Icon = "users", Desc = "Tug of war and hide features" }),
    JumpRope = Tabs.Main:Tab({ Title = "Jump Rope", Icon = "repeat", Desc = "Jump rope completion" }),
    GlassBridge = Tabs.Main:Tab({ Title = "Glass Bridge", Icon = "bridge", Desc = "Glass bridge features" }),
    Mingle = Tabs.Main:Tab({ Title = "Mingle", Icon = "heart", Desc = "Auto mingle features" }),
    Rebel = Tabs.Main:Tab({ Title = "Rebel", Icon = "target", Desc = "Combat features" }),
    Player = Tabs.Misc:Tab({ Title = "Player Modifications", Icon = "user", Desc = "Speed, jump, fly controls" }),
    Visual = Tabs.Misc:Tab({ Title = "Visual Features", Icon = "eye", Desc = "ESP and visual aids" }),
    Utils = Tabs.Misc:Tab({ Title = "Utilities", Icon = "tool", Desc = "Utility functions" }),
    UISettings = Tabs.Settings:Tab({ Title = "UI Settings", Icon = "settings", Desc = "Interface configuration" })
}

-- Green Light Red Light Tab
TabHandles.GreenLight:Paragraph({
    Title = "Green Light Red Light",
    Desc = "Automated completion and player assistance",
    Image = "traffic-light",
    ImageSize = 20,
    Color = Color3.fromHex("#30ff6a"),
})

TabHandles.GreenLight:Button({
    Title = "Complete Green Light Red Light",
    Icon = "check-circle",
    Callback = function()
        if workspace:FindFirstChild("RedLightGreenLight") and workspace.RedLightGreenLight:FindFirstChild("sand") and workspace.RedLightGreenLight.sand:FindFirstChild("crossedover") then
            local pos = workspace.RedLightGreenLight.sand.crossedover.Position + Vector3.new(0, 5, 0)
            player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
        end
    end
})

TabHandles.GreenLight:Button({
    Title = "Help Player To End",
    Icon = "helping-hand",
    Callback = function()
        if Loading then return end
        Loading = true
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                    player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                    wait(0.3)
                    repeat task.wait(0.1)
                        fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                    until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                    wait(0.5)
                    if workspace:FindFirstChild("RedLightGreenLight") and workspace.RedLightGreenLight:FindFirstChild("sand") and workspace.RedLightGreenLight.sand:FindFirstChild("crossedover") then
                        local pos = workspace.RedLightGreenLight.sand.crossedover.Position + Vector3.new(0, 5, 0)
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                    end
                    wait(0.4)
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                    break
                end
            end
        end
        Loading = false
    end
})

local autoHelpPlayer = TabHandles.GreenLight:Toggle({
    Title = "Auto Help Player",
    Desc = "Automatically help players reach the end",
    Value = false,
    Callback = function(Value) 
        _G.AutoHelpPlayer = Value
        while _G.AutoHelpPlayer do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                    if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                        player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        wait(0.3)
                        repeat task.wait(0.1)
                            fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                        until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                        wait(0.5)
                        if workspace:FindFirstChild("RedLightGreenLight") then
                            player.Character.HumanoidRootPart.CFrame = CFrame.new(-75, 1025, 143)
                        end
                        wait(0.4)
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                        break
                    end
                end
            end
            task.wait()
        end
    end
})

TabHandles.GreenLight:Button({
    Title = "Troll Player",
    Icon = "skull",
    Callback = function()
        if Loading1 then return end
        Loading1 = true
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                    player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                    wait(0.3)
                    repeat task.wait(0.1)
                        fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                    until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                    wait(0.5)
                    if workspace:FindFirstChild("RedLightGreenLight") then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(-84, 1023, -537)
                    end
                    wait(0.4)
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                    break
                end
            end
        end
        Loading1 = false
    end
})

local autoTrollPlayer = TabHandles.GreenLight:Toggle({
    Title = "Auto Troll Player",
    Desc = "Automatically troll players",
    Value = false,
    Callback = function(Value) 
        _G.AutoTrollPlayer = Value
        while _G.AutoTrollPlayer do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt") and v.Character.HumanoidRootPart.CarryPrompt.Enabled == true then
                    if v.Character:FindFirstChild("SafeRedLightGreenLight") == nil then
                        player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        wait(0.3)
                        repeat task.wait(0.1)
                            fireproximityprompt(v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt"))
                        until v.Character.HumanoidRootPart.CarryPrompt.Enabled == false
                        wait(0.5)
                        if workspace:FindFirstChild("RedLightGreenLight") then
                            player.Character.HumanoidRootPart.CFrame = CFrame.new(-84, 1023, -537)
                        end
                        wait(0.4)
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ClickedButton"):FireServer({tryingtoleave = true})
                        break
                    end
                end
            end
            task.wait()
        end
    end
})

-- Dalgona Tab
TabHandles.Dalgona:Paragraph({
    Title = "Dalgona Challenge",
    Desc = "Auto complete dalgona cookie challenges",
    Image = "cookie",
    ImageSize = 20,
    Color = Color3.fromHex("#ffa500"),
})

TabHandles.Dalgona:Button({
    Title = "Complete Dalgona",
    Icon = "check-circle",
    Callback = function()
        pcall(function()
            if ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Games") then
                local DalgonaClientModule = ReplicatedStorage.Modules.Games:FindFirstChild("DalgonaClient")
                if DalgonaClientModule then
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
            end
        end)
    end
})

local autoDalgona = TabHandles.Dalgona:Toggle({
    Title = "Auto Dalgona",
    Desc = "Automatically complete dalgona challenges",
    Value = false,
    Callback = function(Value) 
        _G.AutoDalgona = Value
        task.spawn(function()
            while _G.AutoDalgona do
                pcall(function()
                    if ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Games") then
                        local DalgonaClientModule = ReplicatedStorage.Modules.Games:FindFirstChild("DalgonaClient")
                        if DalgonaClientModule then
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
                    end
                end)
                task.wait(5)
            end
        end)
    end
})

-- Tug of War / Hide & Seek Tab
TabHandles.TugWar:Paragraph({
    Title = "Tug of War & Hide & Seek",
    Desc = "Auto features for tug of war and hide & seek games",
    Image = "users",
    ImageSize = 20,
    Color = Color3.fromHex("#ff4444"),
})

TabHandles.TugWar:Button({
    Title = "Teleport All Key",
    Icon = "key",
    Callback = function()
        local OldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        for _, a in pairs(workspace.Effects:GetChildren()) do
            if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                if game.Players.LocalPlayer.Character:FindFirstChild("Head") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    if game.Players.LocalPlayer:GetAttribute("IsHider") and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a:FindFirstChild("Handle").CFrame
                        wait(0.5)
                    end
                end
            end
        end
        if game.Players.LocalPlayer.Character:FindFirstChild("Head") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldCFrame
        end
    end
})

TabHandles.TugWar:Divider()

local autoTugOfWar = TabHandles.TugWar:Toggle({
    Title = "Auto Tug of War",
    Desc = "Automatically participate in tug of war",
    Value = false,
    Callback = function(Value) 
        _G.TugOfWar = Value
        while _G.TugOfWar do
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TemporaryReachedBindable"):FireServer({GameQTE = true})
            task.wait()
        end
    end
})

TabHandles.TugWar:Divider()

local autoMingle = TabHandles.TugWar:Toggle({
    Title = "Auto Mingle",
    Desc = "Automatically participate in mingle games",
    Value = false,
    Callback = function(Value) 
        _G.AutoMingle = Value
        task.spawn(function()
            while _G.AutoMingle do
                pcall(function()
                    for i, v in ipairs(player.Character:GetChildren()) do
                        if v.Name == "RemoteForQTE" then
                            v:FireServer()
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
})

-- Set ESP variables to true by default
_G.EspHighlight = true
_G.EspGui = true

local espDoorExit = TabHandles.TugWar:Toggle({
    Title = "ESP Door Exit",
    Desc = "Highlight door exits with green color",
    Value = false,
    Callback = function(Value) 
        _G.DoorExit = Value
        if not Value then
            -- Clean up existing ESP
            pcall(function()
                if workspace:FindFirstChild("HideAndSeekMap") then
                    for _, v in pairs(workspace.HideAndSeekMap:GetChildren()) do
                        if v.Name == "NEWFIXEDDOORS" then
                            for _, m in pairs(v:GetChildren()) do
                                if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                                    for _, a in pairs(m.EXITDOORS:GetChildren()) do
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
            end)
            return
        end
        
        task.spawn(function()
            while _G.DoorExit do
                pcall(function()
                    -- ESP for Exit Doors
                    if workspace:FindFirstChild("HideAndSeekMap") then
                        for _, v in pairs(workspace.HideAndSeekMap:GetChildren()) do
                            if v.Name == "NEWFIXEDDOORS" then
                                for _, m in pairs(v:GetChildren()) do
                                    if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                                        for _, a in pairs(m.EXITDOORS:GetChildren()) do
                                            if a:IsA("Model") and a:FindFirstChild("DoorRoot") then
                                                -- Add highlight
                                                if not a.DoorRoot:FindFirstChild("Esp_Highlight") then
                                                    local Highlight = Instance.new("Highlight")
                                                    Highlight.Name = "Esp_Highlight"
                                                    Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                                    Highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                                                    Highlight.FillTransparency = 0.5
                                                    Highlight.OutlineTransparency = 0
                                                    Highlight.Adornee = a
                                                    Highlight.Parent = a.DoorRoot
                                                end
                                                
                                                -- Add GUI ESP
                                                if not a.DoorRoot:FindFirstChild("Esp_Gui") then
                                                    local BillboardGui = Instance.new("BillboardGui")
                                                    BillboardGui.Name = "Esp_Gui"
                                                    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                                                    BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                                                    BillboardGui.AlwaysOnTop = true
                                                    BillboardGui.Parent = a.DoorRoot
                                                    
                                                    local TextLabel = Instance.new("TextLabel")
                                                    TextLabel.Size = UDim2.new(1, 0, 1, 0)
                                                    TextLabel.BackgroundTransparency = 1
                                                    TextLabel.Text = "EXIT DOOR"
                                                    TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                                    TextLabel.TextScaled = true
                                                    TextLabel.Font = Enum.Font.SourceSansBold
                                                    TextLabel.Parent = BillboardGui
                                                    
                                                    local UIStroke = Instance.new("UIStroke")
                                                    UIStroke.Color = Color3.new(0, 0, 0)
                                                    UIStroke.Thickness = 1.5
                                                    UIStroke.Parent = TextLabel
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    end
})

local espKeys = TabHandles.TugWar:Toggle({
    Title = "ESP Keys",
    Desc = "Highlight dropped keys with yellow color",
    Value = false,
    Callback = function(Value) 
        _G.EspKeys = Value
        if not Value then
            -- Clean up existing key ESP
            pcall(function()
                for _, a in pairs(workspace.Effects:GetChildren()) do
                    if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                        for _, child in pairs(a.Handle:GetChildren()) do
                            if child.Name:find("Esp_") then
                                child:Destroy()
                            end
                        end
                    end
                end
            end)
            return
        end
        
        task.spawn(function()
            while _G.EspKeys do
                pcall(function()
                    -- ESP for Keys
                    for _, a in pairs(workspace.Effects:GetChildren()) do
                        if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                            if not a.Handle:FindFirstChild("Esp_Highlight") then
                                local Highlight = Instance.new("Highlight")
                                Highlight.Name = "Esp_Highlight"
                                Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                                Highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                                Highlight.FillTransparency = 0.3
                                Highlight.OutlineTransparency = 0
                                Highlight.Adornee = a
                                Highlight.Parent = a.Handle
                            end
                            
                            if not a.Handle:FindFirstChild("Esp_Gui") then
                                local BillboardGui = Instance.new("BillboardGui")
                                BillboardGui.Name = "Esp_Gui"
                                BillboardGui.Size = UDim2.new(0, 150, 0, 40)
                                BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                                BillboardGui.AlwaysOnTop = true
                                BillboardGui.Parent = a.Handle
                                
                                local TextLabel = Instance.new("TextLabel")
                                TextLabel.Size = UDim2.new(1, 0, 1, 0)
                                TextLabel.BackgroundTransparency = 1
                                TextLabel.Text = "KEY"
                                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                TextLabel.TextScaled = true
                                TextLabel.Font = Enum.Font.SourceSansBold
                                TextLabel.Parent = BillboardGui
                                
                                local UIStroke = Instance.new("UIStroke")
                                UIStroke.Color = Color3.new(0, 0, 0)
                                UIStroke.Thickness = 1.5
                                UIStroke.Parent = TextLabel
                            end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    end
})

local espHiders = TabHandles.TugWar:Toggle({
    Title = "ESP Hiding Players",
    Desc = "Highlight hiding players with red color",
    Value = false,
    Callback = function(Value) 
        _G.EspHiders = Value
        if not Value then
            -- Clean up existing hider ESP
            pcall(function()
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
                        for _, child in pairs(v.Character.Head:GetChildren()) do
                            if child.Name:find("Esp_") then
                                child:Destroy()
                            end
                        end
                    end
                end
            end)
            return
        end
        
        task.spawn(function()
            while _G.EspHiders do
                pcall(function()
                    -- ESP for Hiding Players
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v ~= player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") then
                            if v:GetAttribute("IsHider") then
                                if not v.Character.Head:FindFirstChild("Esp_Highlight") then
                                    local Highlight = Instance.new("Highlight")
                                    Highlight.Name = "Esp_Highlight"
                                    Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                    Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                                    Highlight.FillTransparency = 0.5
                                    Highlight.OutlineTransparency = 0
                                    Highlight.Adornee = v.Character
                                    Highlight.Parent = v.Character.Head
                                end
                                
                                if not v.Character.Head:FindFirstChild("Esp_Gui") then
                                    local BillboardGui = Instance.new("BillboardGui")
                                    BillboardGui.Name = "Esp_Gui"
                                    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                                    BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                                    BillboardGui.AlwaysOnTop = true
                                    BillboardGui.Parent = v.Character.Head
                                    
                                    local TextLabel = Instance.new("TextLabel")
                                    TextLabel.Size = UDim2.new(1, 0, 1, 0)
                                    TextLabel.BackgroundTransparency = 1
                                    TextLabel.Text = v.Name .. " (HIDING)"
                                    TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                    TextLabel.TextScaled = true
                                    TextLabel.Font = Enum.Font.SourceSansBold
                                    TextLabel.Parent = BillboardGui
                                    
                                    local UIStroke = Instance.new("UIStroke")
                                    UIStroke.Color = Color3.new(0, 0, 0)
                                    UIStroke.Thickness = 1.5
                                    UIStroke.Parent = TextLabel
                                end
                            else
                                -- Clean ESP for non-hiders
                                for _, child in pairs(v.Character.Head:GetChildren()) do
                                    if child.Name:find("Esp_") then
                                        child:Destroy()
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    end
})

local autoCollectKeys = TabHandles.TugWar:Toggle({
    Title = "Auto Collect Keys",
    Desc = "Automatically teleport to and collect dropped keys",
    Value = false,
    Callback = function(Value) 
        _G.AutoCollectKeys = Value
        task.spawn(function()
            while _G.AutoCollectKeys do
                pcall(function()
                    if player:GetAttribute("IsHider") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local OldCFrame = player.Character.HumanoidRootPart.CFrame
                        for _, a in pairs(workspace.Effects:GetChildren()) do
                            if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                                player.Character.HumanoidRootPart.CFrame = a.Handle.CFrame
                                wait(0.5)
                            end
                        end
                        player.Character.HumanoidRootPart.CFrame = OldCFrame
                    end
                end)
                task.wait(2)
            end
        end)
    end
})

TabHandles.TugWar:Button({
    Title = "Teleport to Random Hider",
    Icon = "users",
    Callback = function()
        local hiders = {}
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v:GetAttribute("IsHider") then
                table.insert(hiders, v)
            end
        end
        
        if #hiders > 0 then
            local randomHider = hiders[math.random(1, #hiders)]
            player.Character.HumanoidRootPart.CFrame = randomHider.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
            Notification("Teleported to " .. randomHider.Name, 3)
        else
            Notification("No hiders found!", 3)
        end
    end
})

TabHandles.TugWar:Button({
    Title = "Teleport to Nearest Exit Door",
    Icon = "door-open",
    Callback = function()
        local nearestDoor = nil
        local shortestDistance = math.huge
        
        if workspace:FindFirstChild("HideAndSeekMap") then
            for _, v in pairs(workspace.HideAndSeekMap:GetChildren()) do
                if v.Name == "NEWFIXEDDOORS" then
                    for _, m in pairs(v:GetChildren()) do
                        if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                            for _, a in pairs(m.EXITDOORS:GetChildren()) do
                                if a:IsA("Model") and a:FindFirstChild("DoorRoot") and a.DoorRoot.PrimaryPart then
                                    local distance = (player.Character.HumanoidRootPart.Position - a.DoorRoot.PrimaryPart.Position).Magnitude
                                    if distance < shortestDistance then
                                        shortestDistance = distance
                                        nearestDoor = a.DoorRoot.PrimaryPart
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        if nearestDoor then
            player.Character.HumanoidRootPart.CFrame = nearestDoor.CFrame * CFrame.new(0, 0, -5)
            Notification("Teleported to nearest exit door!", 3)
        else
            Notification("No exit doors found!", 3)
        end
    end
})

-- Glass Bridge Tab
TabHandles.GlassBridge:Paragraph({
    Title = "Glass Bridge Challenge",
    Desc = "Vision and auto-completion for glass bridge",
    Image = "bridge",
    ImageSize = 20,
    Color = Color3.fromHex("#4ECDC4"),
})

local glassBridgeVision = TabHandles.GlassBridge:Toggle({
    Title = "Glass Bridge Vision",
    Desc = "Show safe vs fake glass panels",
    Value = false,
    Callback = function(Value) 
        _G.GlassBridgeVision = Value
        task.spawn(function()
            while _G.GlassBridgeVision do
                pcall(function()
                    if workspace:FindFirstChild("GlassBridge") then
                        local GlassHolder = workspace.GlassBridge:FindFirstChild("GlassHolder")
                        if GlassHolder then
                            for _, v in pairs(GlassHolder:GetChildren()) do
                                for _, j in pairs(v:GetChildren()) do
                                    if j:IsA("Model") and j.PrimaryPart then
                                        local isSafe = not j.PrimaryPart:GetAttribute("exploitingisevil")
                                        local Color = isSafe and Color3.fromRGB(28, 235, 87) or Color3.fromRGB(248, 87, 87)
                                        j.PrimaryPart.Color = Color
                                        j.PrimaryPart.Transparency = 0
                                        j.PrimaryPart.Material = Enum.Material.Neon
                                        
                                        if not j.PrimaryPart:FindFirstChild("SafetyLabel") then
                                            local BillboardGui = Instance.new("BillboardGui")
                                            BillboardGui.Name = "SafetyLabel"
                                            BillboardGui.Size = UDim2.new(0, 100, 0, 30)
                                            BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
                                            BillboardGui.AlwaysOnTop = true
                                            BillboardGui.Parent = j.PrimaryPart
                                            
                                            local TextLabel = Instance.new("TextLabel")
                                            TextLabel.Size = UDim2.new(1, 0, 1, 0)
                                            TextLabel.BackgroundTransparency = 1
                                            TextLabel.Text = isSafe and "SAFE" or "FAKE"
                                            TextLabel.TextColor3 = isSafe and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                                            TextLabel.TextScaled = true
                                            TextLabel.Font = Enum.Font.SourceSansBold
                                            TextLabel.Parent = BillboardGui
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    end
})

TabHandles.GlassBridge:Button({
    Title = "Complete Glass Bridge",
    Icon = "zap",
    Callback = function()
        pcall(function()
            if workspace:FindFirstChild("GlassBridge") and workspace.GlassBridge:FindFirstChild("End") and workspace.GlassBridge.End.PrimaryPart then
                local pos = workspace.GlassBridge.End.PrimaryPart.Position + Vector3.new(0, 8, 0)
                player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                Notification("Glass Bridge completed!", 3)
            end
        end)
    end
})

local autoGlassBridge = TabHandles.GlassBridge:Toggle({
    Title = "Auto Complete Glass Bridge",
    Desc = "Automatically complete when detected",
    Value = false,
    Callback = function(Value) 
        _G.AutoGlassBridge = Value
        task.spawn(function()
            while _G.AutoGlassBridge do
                pcall(function()
                    if workspace:FindFirstChild("GlassBridge") and workspace.GlassBridge:FindFirstChild("End") and workspace.GlassBridge.End.PrimaryPart then
                        local pos = workspace.GlassBridge.End.PrimaryPart.Position + Vector3.new(0, 8, 0)
                        if (player.Character.HumanoidRootPart.Position - pos).Magnitude > 50 then
                            player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                            Notification("Glass Bridge completed!", 3)
                        end
                    end
                end)
                task.wait(3)
            end
        end)
    end
})

-- Jump Rope Tab
TabHandles.JumpRope:Paragraph({
    Title = "Jump Rope Challenge",
    Desc = "Auto-complete jump rope mini-games",
    Image = "repeat",
    ImageSize = 20,
    Color = Color3.fromHex("#FF6B6B"),
})

TabHandles.JumpRope:Button({
    Title = "Complete Jump Rope",
    Icon = "zap",
    Callback = function()
        pcall(function()
            if workspace:FindFirstChild("JumpRope") and workspace.JumpRope:FindFirstChild("Important") then
                local model = workspace.JumpRope.Important:FindFirstChild("Model")
                if model and model:FindFirstChild("LEGS") then
                    local pos = model.LEGS.Position
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                    Notification("Jump Rope completed!", 3)
                end
            end
        end)
    end
})

local autoJumpRope = TabHandles.JumpRope:Toggle({
    Title = "Auto Jump Rope",
    Desc = "Automatically complete jump rope challenges",
    Value = false,
    Callback = function(Value) 
        _G.AutoJumpRope = Value
        task.spawn(function()
            while _G.AutoJumpRope do
                pcall(function()
                    if workspace:FindFirstChild("JumpRope") and workspace.JumpRope:FindFirstChild("Important") then
                        local model = workspace.JumpRope.Important:FindFirstChild("Model")
                        if model and model:FindFirstChild("LEGS") then
                            local pos = model.LEGS.Position
                            if (player.Character.HumanoidRootPart.Position - pos).Magnitude > 20 then
                                player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                                Notification("Jump Rope completed!", 3)
                            end
                        end
                    end
                end)
                task.wait(3)
            end
        end)
    end
})

-- Player Modifications Tab
TabHandles.Player:Paragraph({
    Title = "Player Modifications",
    Desc = "Enhance your character's abilities",
    Image = "user",
    ImageSize = 20,
    Color = Color3.fromHex("#30ff6a"),
})

local speedSlider = TabHandles.Player:Slider({
    Title = "Walk Speed",
    Desc = "Adjust your walking speed",
    Value = { Min = 16, Max = 1000, Default = 50 },
    Callback = function(value)
        _G.Speed = value
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and _G.AutoSpeed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

local autoSpeed = TabHandles.Player:Toggle({
    Title = "Auto Speed",
    Desc = "Automatically apply speed changes",
    Value = false,
    Callback = function(Value) 
        _G.AutoSpeed = Value
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.Speed or 50
        end
    end
})

local infJump = TabHandles.Player:Toggle({
    Title = "Infinite Jump",
    Desc = "Jump infinitely",
    Value = false,
    Callback = function(Value) 
        _G.InfiniteJump = Value
    end
})

local floatHeightSlider = TabHandles.Player:Slider({
    Title = "Float Height",
    Desc = "Set your floating height above ground",
    Value = { Min = 5, Max = 100, Default = 20 },
    Callback = function(value)
        _G.FloatHeight = value
    end
})

local floatToggle = TabHandles.Player:Toggle({
    Title = "Float",
    Desc = "Keep yourself floating at a set height",
    Value = false,
    Callback = function(Value) 
        _G.StartFloat = Value
        
        if Value then
            task.spawn(function()
                while _G.StartFloat and game.Players.LocalPlayer.Character do
                    local character = game.Players.LocalPlayer.Character
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    local humanoid = character:FindFirstChild("Humanoid")
                    
                    if humanoidRootPart and humanoid then
                        -- Create BodyPosition if it doesn't exist
                        local bodyPosition = humanoidRootPart:FindFirstChild("FloatBodyPosition")
                        if not bodyPosition then
                            bodyPosition = Instance.new("BodyPosition")
                            bodyPosition.Name = "FloatBodyPosition"
                            bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
                            bodyPosition.P = 10000
                            bodyPosition.D = 1000
                            bodyPosition.Parent = humanoidRootPart
                        end
                        
                        -- Set the target position (current X and Z, but elevated Y)
                        local currentPos = humanoidRootPart.Position
                        local targetHeight = currentPos.Y
                        
                        -- Raycast downward to find ground
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterDescendantsInstances = {character}
                        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                        
                        local raycastResult = workspace:Raycast(currentPos, Vector3.new(0, -1000, 0), raycastParams)
                        if raycastResult then
                            targetHeight = raycastResult.Position.Y + (_G.FloatHeight or 20)
                        end
                        
                        bodyPosition.Position = Vector3.new(currentPos.X, targetHeight, currentPos.Z)
                        
                        -- Disable fall damage
                        humanoid.PlatformStand = true
                    end
                    
                    task.wait(0.1)
                end
                
                -- Clean up when float is disabled
                if game.Players.LocalPlayer.Character then
                    local character = game.Players.LocalPlayer.Character
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    local humanoid = character:FindFirstChild("Humanoid")
                    
                    if humanoidRootPart then
                        local bodyPosition = humanoidRootPart:FindFirstChild("FloatBodyPosition")
                        if bodyPosition then
                            bodyPosition:Destroy()
                        end
                    end
                    
                    if humanoid then
                        humanoid.PlatformStand = false
                    end
                end
            end)
        else
            -- Clean up immediately when disabled
            if game.Players.LocalPlayer.Character then
                local character = game.Players.LocalPlayer.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if humanoidRootPart then
                    local bodyPosition = humanoidRootPart:FindFirstChild("FloatBodyPosition")
                    if bodyPosition then
                        bodyPosition:Destroy()
                    end
                end
                
                if humanoid then
                    humanoid.PlatformStand = false
                end
            end
        end
    end
})

local noclipToggle = TabHandles.Player:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls",
    Value = false,
    Callback = function(Value) 
        _G.NoclipCharacter = Value
        if _G.NoclipCharacter == false then
            if game.Players.LocalPlayer.Character ~= nil then
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") and v.CanCollide == false then
                        v.CanCollide = true
                    end
                end
            end
        end
        while _G.NoclipCharacter do
            if game.Players.LocalPlayer.Character ~= nil then
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
            task.wait()
        end
    end
})

-- Visual Features Tab
TabHandles.Visual:Paragraph({
    Title = "Visual Features",
    Desc = "ESP and visual enhancement tools",
    Image = "eye",
    ImageSize = 20,
    Color = Color3.fromHex("#4ECDC4"),
})

-- ESP Variables
_G.EspHighlight = false
_G.EspGui = false
_G.ColorLight = Color3.fromRGB(255, 255, 255)
local espObjects = {}

-- ESP Functions
local function CreateESP(obj, color, text)
    if not obj or espObjects[obj] then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ZZZ_ESP_Highlight"
    highlight.Adornee = obj
    highlight.FillColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ZZZ_ESP_Billboard"
    billboard.Adornee = obj
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text or obj.Name
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.Parent = billboard

    espObjects[obj] = {highlight = highlight, billboard = billboard}
end

local function RemoveESP(obj)
    if espObjects[obj] then
        if espObjects[obj].highlight then
            espObjects[obj].highlight:Destroy()
        end
        if espObjects[obj].billboard then
            espObjects[obj].billboard:Destroy()
        end
        espObjects[obj] = nil
    end
end

local function ClearAllESP()
    for obj, data in pairs(espObjects) do
        RemoveESP(obj)
    end
    espObjects = {}
end

local function UpdatePlayerESP()
    if not _G.EspHighlight then return end

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart then
                if _G.EspHighlight then
                    CreateESP(humanoidRootPart, _G.ColorLight, player.Name)
                else
                    RemoveESP(humanoidRootPart)
                end
            end
        end
    end
end

-- ESP Toggle
local espHighlight = TabHandles.Visual:Toggle({
    Title = "Player ESP",
    Desc = "Enable player ESP with highlights",
    Value = false,
    Callback = function(Value) 
        _G.EspHighlight = Value

        if Value then
            -- Start ESP
            UpdatePlayerESP()

            -- Handle new players
            game.Players.PlayerAdded:Connect(function(player)
                if _G.EspHighlight then
                    player.CharacterAdded:Connect(function(character)
                        if _G.EspHighlight then
                            task.wait(1)
                            UpdatePlayerESP()
                        end
                    end)
                end
            end)

            -- Handle existing players respawning
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    player.CharacterAdded:Connect(function(character)
                        if _G.EspHighlight then
                            task.wait(1)
                            UpdatePlayerESP()
                        end
                    end)
                end
            end

            -- Update ESP periodically
            task.spawn(function()
                while _G.EspHighlight do
                    UpdatePlayerESP()
                    task.wait(2)
                end
            end)
        else
            -- Clear all ESP
            ClearAllESP()
        end
    end
})

local espColorPicker = TabHandles.Visual:Colorpicker({
    Title = "ESP Color",
    Desc = "Choose ESP highlight color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        _G.ColorLight = color
        -- Update existing ESP colors
        if _G.EspHighlight then
            for obj, data in pairs(espObjects) do
                if data.highlight then
                    data.highlight.FillColor = color
                    data.highlight.OutlineColor = color
                end
                if data.billboard and data.billboard:FindFirstChild("TextLabel") then
                    data.billboard.TextLabel.TextColor3 = color
                end
            end
        end
    end
})

-- Clean up ESP when players leave
game.Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            RemoveESP(humanoidRootPart)
        end
    end
end)

TabHandles.Utils:Paragraph({
    Title = "Utility Functions",
    Desc = "Additional helpful features",
    Image = "tool",
    ImageSize = 20,
    Color = Color3.fromHex("#4ECDC4"),
})

local antiFling = TabHandles.Utils:Toggle({
    Title = "Anti-Fling",
    Desc = "Prevent other players from flinging you",
    Value = false,
    Callback = function(Value) 
        _G.AntiFling = Value
        task.spawn(function()
            while _G.AntiFling do
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.Anchored = true
                        player.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        player.Character.HumanoidRootPart.Anchored = false
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
})

local autoSkip = TabHandles.Utils:Toggle({
    Title = "Auto Skip Dialogues",
    Desc = "Automatically skip game dialogues",
    Value = false,
    Callback = function(Value) 
        _G.AutoSkip = Value
        task.spawn(function()
            while _G.AutoSkip do
                pcall(function()
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DialogueRemote"):FireServer("Skipped")
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TemporaryReachedBindable"):FireServer()
                end)
                task.wait(0.8)
            end
        end)
    end
})

local noCooldownProximity = TabHandles.Utils:Toggle({
    Title = "No Cooldown Proximity",
    Desc = "Remove hold duration from proximity prompts",
    Value = false,
    Callback = function(Value) 
        _G.NoCooldownProximity = Value
        if Value then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.ClassName == "ProximityPrompt" then
                    v.HoldDuration = 0
                end
            end
            
            workspace.DescendantAdded:Connect(function(descendant)
                if _G.NoCooldownProximity and descendant:IsA("ProximityPrompt") then
                    descendant.HoldDuration = 0
                end
            end)
        end
    end
})

-- UI Settings Tab
TabHandles.UISettings:Paragraph({
    Title = "Interface Configuration",
    Desc = "Customize your ZZZ Hub experience",
    Image = "settings",
    ImageSize = 20,
    Color = Color3.fromHex("#30ff6a"),
})

_G.ChooseNotify = "WindUI"
local notificationDropdown = TabHandles.UISettings:Dropdown({
    Title = "Notification Style",
    Values = { "WindUI", "Roblox" },
    Value = "WindUI",
    Callback = function(option)
        _G.ChooseNotify = option
    end
})

_G.NotificationSound = true
local notificationSound = TabHandles.UISettings:Toggle({
    Title = "Notification Sound",
    Desc = "Enable notification sounds",
    Value = true,
    Callback = function(Value) 
        _G.NotificationSound = Value 
    end
})

local volumeSlider = TabHandles.UISettings:Slider({
    Title = "Volume",
    Desc = "Notification volume level",
    Value = { Min = 1, Max = 10, Default = 2 },
    Callback = function(value)
        _G.VolumeTime = value
    end
})

-- Credits and Info
local footerSection = Window:Section({ Title = "ZZZ Hub " .. "v2.2" })
local creditsTab = footerSection:Tab({ Title = "Credits", Icon = "users", Desc = "ZZZ Hub development team" })

creditsTab:Paragraph({
    Title = "Created by ZZZ Hub Team",
    Desc = "Advanced automation and anti-cheat bypass",
    Image = "zap",
    ImageSize = 20,
    Color = "White",
    Buttons = {
        {
            Title = "Discord",
            Icon = "message-circle",
            Variant = "Primary",
            Callback = function()
                if setclipboard then
                    setclipboard("https://discord.gg/zzzhub")
                    WindUI:Notify({
                        Title = "Copied!",
                        Content = "Discord link copied to clipboard",
                        Duration = 2
                    })
                else
                    WindUI:Notify({
                        Title = "Discord",
                        Content = "https://discord.gg/zzzhub",
                        Duration = 5
                    })
                end
            end
        }
    }
})

-- Anti-lag and performance
_G.PartLag = {"FootstepEffect", "BulletHole", "GroundSmokeDIFFERENT", "ARshell", "effect debris", "effect", "DroppedMP5"}

local antiLag = TabHandles.Utils:Toggle({
    Title = "Anti Lag",
    Desc = "Improve game performance",
    Value = false,
    Callback = function(Value) 
        _G.AntiLag = Value
        if _G.AntiLag == true then
            local Terrain = workspace:FindFirstChildOfClass("Terrain")
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
            game.Lighting.GlobalShadows = false
            game.Lighting.FogEnd = 9e9
            game.Lighting.FogStart = 9e9
            for i,v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.BackSurface = "SmoothNoOutlines"
                    v.BottomSurface = "SmoothNoOutlines"
                    v.FrontSurface = "SmoothNoOutlines"
                    v.LeftSurface = "SmoothNoOutlines"
                    v.RightSurface = "SmoothNoOutlines"
                    v.TopSurface = "SmoothNoOutlines"
                elseif v:IsA("Decal") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                end
            end
            for i,v in pairs(game.Lighting:GetDescendants()) do
                if v:IsA("PostEffect") then
                    v.Enabled = false
                end
            end
            for i,v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("ForceField") or v:IsA("Sparkles") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Beam") then
                    v:Destroy()
                end
            end
        end
        while _G.AntiLag do
            for i, v in pairs(workspace:FindFirstChild("Effects"):GetChildren()) do
                if _G.AntiLag == true then
                    PartLagDe(v)
                end
            end
            task.wait()
        end
    end
})

Window:OnClose(function()
    print("ZZZ Hub closed")
end)

Window:OnDestroy(function()
    print("ZZZ Hub destroyed")
end)
