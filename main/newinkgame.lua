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
        local DalgonaClientModule = game.ReplicatedStorage.Modules.Games.DalgonaClient
        for i, v in pairs(getreg()) do
            if typeof(v) == "function" and islclosure(v) then
                if getinfo(v).nups == 73 then
                    setupvalue(v, 31, 9e9)
                end
            end
        end
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

local espDoorExit = TabHandles.TugWar:Toggle({
    Title = "ESP Door Exit",
    Desc = "Highlight door exits",
    Value = false,
    Callback = function(Value) 
        _G.DoorExit = Value
        if _G.DoorExit == false then
            if workspace:FindFirstChild("HideAndSeekMap") then
                for i, v in pairs(workspace:FindFirstChild("HideAndSeekMap"):GetChildren()) do
                    if v.Name == "NEWFIXEDDOORS" then
                        for k, m in pairs(v:GetChildren()) do
                            if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                                for _, a in pairs(m:FindFirstChild("EXITDOORS"):GetChildren()) do
                                    if a:IsA("Model") and a:FindFirstChild("DoorRoot") then
                                        for _, z in pairs(a:FindFirstChild("DoorRoot"):GetChildren()) do
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
        end
        while _G.DoorExit do
            if workspace:FindFirstChild("HideAndSeekMap") then
                for i, v in pairs(workspace:FindFirstChild("HideAndSeekMap"):GetChildren()) do
                    if v.Name == "NEWFIXEDDOORS" then
                        for k, m in pairs(v:GetChildren()) do
                            if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                                for _, a in pairs(m:FindFirstChild("EXITDOORS"):GetChildren()) do
                                    if a:IsA("Model") and a:FindFirstChild("DoorRoot") then
                                        if a.DoorRoot:FindFirstChild("Esp_Highlight") then
                                            a.DoorRoot:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(255, 255, 255)
                                            a.DoorRoot:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(255, 255, 255)
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

local flySpeedSlider = TabHandles.Player:Slider({
    Title = "Fly Speed",
    Desc = "Set your flying speed",
    Value = { Min = 20, Max = 500, Default = 50 },
    Callback = function(value)
        _G.SetSpeedFly = value
    end
})

local flyToggle = TabHandles.Player:Toggle({
    Title = "Fly",
    Desc = "Enable flying",
    Value = false,
    Callback = function(Value) 
        _G.StartFly = Value
        while _G.StartFly do
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyGyro") == nil then
                local bg = Instance.new("BodyGyro", game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
                bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.P = 9e4
                bg.CFrame = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
            end
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") == nil then
                local bv = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            end
            local MoveflyPE = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector()
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
                game.Players.LocalPlayer.Character.HumanoidRootPart.BodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
                game.Players.LocalPlayer.Character.HumanoidRootPart.BodyGyro.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.Position + game.Workspace.CurrentCamera.CFrame.LookVector)
                game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity = Vector3.new()
                if MoveflyPE.X > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (MoveflyPE.X * _G.SetSpeedFly)
                end
                if MoveflyPE.X < 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (MoveflyPE.X * _G.SetSpeedFly)
                end
                if MoveflyPE.Z > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (MoveflyPE.Z * _G.SetSpeedFly)
                end
                if MoveflyPE.Z < 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (MoveflyPE.Z * _G.SetSpeedFly)
                end
            end
            task.wait()
        end
        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
                game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyGyro"):Destroy()
            end
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
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
