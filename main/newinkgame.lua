
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer

-- Services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

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
_G.CollectBandage = false
_G.CollectFlashbang = false
_G.CollectGrenade = false
_G.AntiFling = false
_G.AntiBanana = false
_G.AutoDalgona = false
_G.HideSeekESP = false
_G.GlassBridgeVision = false
_G.AutoMingle = false
_G.AutoSkip = false
_G.NoCooldownProximity = false
_G.Float = false
_G.NoClip = false

local Loading = false
local Loading1 = false
local CooldownProximity = nil
local FloatConnection = nil
local NoClipConnection = nil

-- Create Main Window
local Window = WindUI:CreateWindow({
    Title = "ZZZ Hub - Ink Game v2",
    Icon = "zap",
    Author = "Enhanced Squid Game Automation",
    Folder = "ZZZHub_InkGameV2",
    Size = UDim2.fromOffset(600, 450),
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
    Title = "Enhanced",
    Color = Color3.fromHex("#315dff")
})

-- Create Sections and Tabs
local Tabs = {
    Main = Window:Section({ Title = "Main Games", Opened = true }),
    HideSeek = Window:Section({ Title = "Hide & Seek", Opened = true }),
    Player = Window:Section({ Title = "Player", Opened = true }),
    Other = Window:Section({ Title = "Other Games", Opened = true }),
    Settings = Window:Section({ Title = "Settings", Opened = true })
}

local TabHandles = {
    MainGames = Tabs.Main:Tab({ Title = "Red Light Green Light", Icon = "gamepad-2" }),
    Dalgona = Tabs.Main:Tab({ Title = "Dalgona & Tug", Icon = "cookie" }),
    HideSeekESP = Tabs.HideSeek:Tab({ Title = "ESP Features", Icon = "eye" }),
    HideSeekTeleport = Tabs.HideSeek:Tab({ Title = "Teleportation", Icon = "move" }),
    Movement = Tabs.Player:Tab({ Title = "Movement", Icon = "user" }),
    Utilities = Tabs.Player:Tab({ Title = "Utilities", Icon = "settings" }),
    OtherGames = Tabs.Other:Tab({ Title = "Mini Games", Icon = "puzzle" }),
    Configuration = Tabs.Settings:Tab({ Title = "Configuration", Icon = "sliders" })
}

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

function PartLagDe(g)
    for i, v in pairs(_G.PartLag) do
        if g.Name:find(v) then
            g:Destroy()
        end
    end
end

-- Setup Jump and Speed
UserInputService.JumpRequest:connect(function()
    if _G.InfiniteJump == true then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").WalkSpeed = _G.AutoSpeed and _G.Speed or 16
    character:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if _G.AutoSpeed == true then
            character.Humanoid.WalkSpeed = _G.Speed or 50
        end
    end)
end)

-- Main Games Tab - Red Light Green Light
TabHandles.MainGames:Button({
    Title = "Teleport to Finish",
    Desc = "Instantly teleport to the finish line",
    Icon = "zap",
    Callback = function()
        if Workspace:FindFirstChild("RedLightGreenLight") and Workspace.RedLightGreenLight:FindFirstChild("sand") and Workspace.RedLightGreenLight.sand:FindFirstChild("crossedover") then
            local pos = Workspace.RedLightGreenLight.sand.crossedover.Position + Vector3.new(0, 5, 0)
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
            WindUI:Notify({
                Title = "Teleported",
                Content = "Moved to finish line!",
                Icon = "check",
                Duration = 2
            })
        end
    end
})

TabHandles.MainGames:Button({
    Title = "Help Player to End",
    Desc = "Carry a player to the finish line",
    Icon = "hand-helping",
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

TabHandles.MainGames:Toggle({
    Title = "Auto Help Player",
    Desc = "Automatically help players reach the end",
    Value = false,
    Callback = function(value)
        _G.AutoHelpPlayer = value
        while _G.AutoHelpPlayer do
            pcall(function()
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local carryPrompt = v.Character.HumanoidRootPart:FindFirstChild("CarryPrompt")
                        if carryPrompt and carryPrompt.Enabled and not v.Character:FindFirstChild("SafeRedLightGreenLight") then
                            Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                            wait(0.3)
                            repeat 
                                fireproximityprompt(carryPrompt)
                                task.wait(0.1)
                            until not carryPrompt.Enabled or not carryPrompt.Parent
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
            end)
            task.wait(2)
        end
    end
})

TabHandles.MainGames:Toggle({
    Title = "Auto Troll Player",
    Desc = "Automatically troll players",
    Value = false,
    Callback = function(value)
        _G.AutoTrollPlayer = value
        while _G.AutoTrollPlayer do
            pcall(function()
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
            end)
            task.wait()
        end
    end
})

-- Dalgona & Tug Tab
TabHandles.Dalgona:Button({
    Title = "Complete Dalgona",
    Desc = "Instantly complete the cookie cutting game",
    Icon = "cookie",
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
                                    WindUI:Notify({
                                        Title = "Dalgona Complete",
                                        Content = "Cookie cutting completed!",
                                        Icon = "check",
                                        Duration = 3
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
})

TabHandles.Dalgona:Toggle({
    Title = "Auto Complete Dalgona",
    Desc = "Automatically complete cookie cutting",
    Value = false,
    Callback = function(value)
        _G.AutoDalgona = value
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
    end
})

TabHandles.Dalgona:Toggle({
    Title = "Auto Tug of War",
    Desc = "Automatically win tug of war",
    Value = false,
    Callback = function(value)
        _G.TugOfWar = value
        while _G.TugOfWar do
            pcall(function()
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TemporaryReachedBindable"):FireServer({GameQTE = true})
            end)
            task.wait(0.1)
        end
    end
})

-- Hide & Seek ESP Tab
TabHandles.HideSeekESP:Toggle({
    Title = "ESP Door Exit",
    Desc = "Show exit doors with ESP",
    Value = false,
    Callback = function(value)
        _G.DoorExit = value
        if value then
            task.spawn(function()
                while _G.DoorExit do
            pcall(function()
                if Workspace:FindFirstChild("HideAndSeekMap") then
                    for i, v in pairs(Workspace:FindFirstChild("HideAndSeekMap"):GetChildren()) do
                        if v.Name == "NEWFIXEDDOORS" then
                            for k, m in pairs(v:GetChildren()) do
                                if m.Name:find("Floor") and m:FindFirstChild("EXITDOORS") then
                                    for _, a in pairs(m:FindFirstChild("EXITDOORS"):GetChildren()) do
                                        if a:IsA("Model") and a:FindFirstChild("DoorRoot") then
                                            -- Clean existing ESP
                                            for _, z in pairs(a.DoorRoot:GetChildren()) do
                                                if z.Name:find("Esp_") then
                                                    z:Destroy()
                                                end
                                            end
                                            
                                            -- Add highlight if enabled
                                            if _G.EspHighlight and not a.DoorRoot:FindFirstChild("Esp_Highlight") then
                                                local Highlight = Instance.new("Highlight")
                                                Highlight.Name = "Esp_Highlight"
                                                Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                                Highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                                                Highlight.FillTransparency = 0.5
                                                Highlight.OutlineTransparency = 0
                                                Highlight.Adornee = a
                                                Highlight.Parent = a.DoorRoot
                                            end
                                            
                                            -- Add GUI ESP if enabled
                                            if _G.EspGui and not a.DoorRoot:FindFirstChild("Esp_Gui") then
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
            task.wait(1)
        end
            end)
        else
            -- Clean up all door ESP when disabled
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
        end
    end
})

TabHandles.HideSeekESP:Toggle({
    Title = "ESP Keys",
    Desc = "Show dropped keys with ESP",
    Value = false,
    Callback = function(value)
        _G.DoorKey = value
        if value then
            task.spawn(function()
                while _G.DoorKey do
                    pcall(function()
                        for _, a in pairs(Workspace.Effects:GetChildren()) do
                            if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                                -- Clean existing ESP
                                for _, z in pairs(a.Handle:GetChildren()) do
                                    if z.Name:find("Esp_") then
                                        z:Destroy()
                                    end
                                end
                                
                                if _G.EspHighlight and not a.Handle:FindFirstChild("Esp_Highlight") then
                                    local Highlight = Instance.new("Highlight")
                                    Highlight.Name = "Esp_Highlight"
                                    Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                                    Highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                                    Highlight.FillTransparency = 0.3
                                    Highlight.OutlineTransparency = 0
                                    Highlight.Adornee = a
                                    Highlight.Parent = a.Handle
                                end
                                
                                if _G.EspGui and not a.Handle:FindFirstChild("Esp_Gui") then
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
                    task.wait(1)
                end
            end)
        else
            -- Clean up all key ESP when disabled
            for _, a in pairs(Workspace.Effects:GetChildren()) do
                if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                    for _, z in pairs(a.Handle:GetChildren()) do
                        if z.Name:find("Esp_") then
                            z:Destroy()
                        end
                    end
                end
            end
        end
    end
})

TabHandles.HideSeekESP:Toggle({
    Title = "ESP Player Hide",
    Desc = "Highlight players who are hiding",
    Value = false,
    Callback = function(value)
        _G.HidePlayer = value
        if value then
            task.spawn(function()
                while _G.HidePlayer do
                    pcall(function()
                        for i, v in pairs(game.Players:GetChildren()) do
                            if v ~= Player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                                if v:GetAttribute("IsHider") then
                                    -- Clean existing ESP first
                                    for _, z in pairs(v.Character.Head:GetChildren()) do
                                        if z.Name:find("Esp_") then
                                            z:Destroy()
                                        end
                                    end
                                    
                                    if _G.EspHighlight and not v.Character.Head:FindFirstChild("Esp_Highlight") then
                                        local Highlight = Instance.new("Highlight")
                                        Highlight.Name = "Esp_Highlight"
                                        Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                        Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                                        Highlight.FillTransparency = 0.5
                                        Highlight.OutlineTransparency = 0
                                        Highlight.Adornee = v.Character
                                        Highlight.Parent = v.Character.Head
                                    end
                                    
                                    if _G.EspGui and not v.Character.Head:FindFirstChild("Esp_Gui") then
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
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        else
            -- Clean up all player ESP when disabled
            for i, v in pairs(game.Players:GetChildren()) do
                if v ~= Player and v.Character and v.Character:FindFirstChild("Head") then
                    for _, z in pairs(v.Character.Head:GetChildren()) do
                        if z.Name:find("Esp_") then
                            z:Destroy()
                        end
                    end
                end
            end
        end
    end
})

-- Hide & Seek Teleport Tab
TabHandles.HideSeekTeleport:Button({
    Title = "Teleport to All Keys",
    Desc = "Collect all keys automatically",
    Icon = "key",
    Callback = function()
        if Player:GetAttribute("IsHider") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local OldCFrame = Player.Character.HumanoidRootPart.CFrame
            for _, a in pairs(Workspace.Effects:GetChildren()) do
                if a.Name:find("DroppedKey") and a:FindFirstChild("Handle") then
                    Player.Character.HumanoidRootPart.CFrame = a.Handle.CFrame
                    wait(0.5)
                end
            end
            Player.Character.HumanoidRootPart.CFrame = OldCFrame
            WindUI:Notify({
                Title = "Keys Collected",
                Content = "All keys have been collected!",
                Icon = "check",
                Duration = 3
            })
        end
    end
})

TabHandles.HideSeekTeleport:Button({
    Title = "Teleport Player Hide",
    Desc = "Teleport to a hiding player",
    Icon = "eye",
    Callback = function()
        for i, v in pairs(game.Players:GetChildren()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
                if v:GetAttribute("IsHider") and v.Character.Humanoid.Health > 0 then
                    Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                    WindUI:Notify({
                        Title = "Teleported",
                        Content = "Teleported to " .. v.Name,
                        Icon = "move",
                        Duration = 2
                    })
                    break
                end
            end
        end
    end
})

-- Player Movement Tab
TabHandles.Movement:Slider({
    Title = "Walk Speed",
    Desc = "Adjust your movement speed",
    Value = { Min = 16, Max = 1000, Default = 50 },
    Callback = function(val)
        _G.Speed = val
        if _G.AutoSpeed and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = val
        end
    end
})

TabHandles.Movement:Toggle({
    Title = "Auto Speed",
    Desc = "Maintain custom walk speed",
    Value = false,
    Callback = function(value)
        _G.AutoSpeed = value
        if value and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = _G.Speed or 50
        elseif Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
    end
})

TabHandles.Movement:Toggle({
    Title = "Infinite Jump",
    Desc = "Jump infinitely in the air",
    Value = false,
    Callback = function(value)
        _G.InfiniteJump = value
    end
})

-- Float Feature
TabHandles.Movement:Toggle({
    Title = "Float",
    Desc = "Float above the ground",
    Value = false,
    Callback = function(value)
        _G.Float = value
        if value then
            FloatConnection = RunService.Heartbeat:Connect(function()
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = Player.Character.HumanoidRootPart
                    local bodyVelocity = rootPart:FindFirstChild("FloatVelocity")
                    
                    if not bodyVelocity then
                        bodyVelocity = Instance.new("BodyVelocity")
                        bodyVelocity.Name = "FloatVelocity"
                        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        bodyVelocity.Parent = rootPart
                    end
                end
            end)
            WindUI:Notify({
                Title = "Float",
                Content = "Float mode activated",
                Icon = "move",
                Duration = 2
            })
        else
            if FloatConnection then
                FloatConnection:Disconnect()
                FloatConnection = nil
            end
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local bodyVelocity = Player.Character.HumanoidRootPart:FindFirstChild("FloatVelocity")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            end
            WindUI:Notify({
                Title = "Float",
                Content = "Float mode deactivated",
                Icon = "move",
                Duration = 2
            })
        end
    end
})

-- NoClip Feature
TabHandles.Movement:Toggle({
    Title = "NoClip",
    Desc = "Walk through walls and objects",
    Value = false,
    Callback = function(value)
        _G.NoClip = value
        if value then
            NoClipConnection = RunService.Stepped:Connect(function()
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            WindUI:Notify({
                Title = "NoClip",
                Content = "NoClip activated - Walk through walls",
                Icon = "move",
                Duration = 2
            })
        else
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end
            if Player.Character then
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            WindUI:Notify({
                Title = "NoClip",
                Content = "NoClip deactivated",
                Icon = "move",
                Duration = 2
            })
        end
    end
})

-- Player Utilities Tab
TabHandles.Utilities:Toggle({
    Title = "Auto Skip",
    Desc = "Automatically skip dialogues",
    Value = false,
    Callback = function(value)
        _G.AutoSkip = value
        if value then
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
    end
})

TabHandles.Utilities:Toggle({
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
            if CooldownProximity then
                CooldownProximity:Disconnect()
            end
            CooldownProximity = Workspace.DescendantAdded:Connect(function(Cooldown)
                if _G.NoCooldownProximity and Cooldown:IsA("ProximityPrompt") then
                    Cooldown.HoldDuration = 0
                end
            end)
        else
            if CooldownProximity then
                CooldownProximity:Disconnect()
                CooldownProximity = nil
            end
        end
    end
})

TabHandles.Utilities:Toggle({
    Title = "Anti Lag",
    Desc = "Improve game performance",
    Value = false,
    Callback = function(value)
        _G.AntiLag = value
        if value then
            local Terrain = Workspace:FindFirstChildOfClass("Terrain")
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
            end
            game.Lighting.GlobalShadows = false
            game.Lighting.FogEnd = 9e9
            game.Lighting.FogStart = 9e9
            
            task.spawn(function()
                while _G.AntiLag do
                    pcall(function()
                        for i, v in pairs(Workspace:FindFirstChild("Effects"):GetChildren()) do
                            PartLagDe(v)
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

TabHandles.Utilities:Toggle({
    Title = "Anti Fling",
    Desc = "Prevent other players from flinging you",
    Value = false,
    Callback = function(value)
        _G.AntiFling = value
        while _G.AntiFling do
            pcall(function()
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.Anchored = true
                    Player.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    Player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    Player.Character.HumanoidRootPart.Anchored = false
                end
            end)
            task.wait(0.1)
        end
    end
})

-- Other Games Tab
TabHandles.OtherGames:Button({
    Title = "Complete Jump Rope",
    Desc = "Teleport to jump rope completion",
    Icon = "activity",
    Callback = function()
        pcall(function()
            if Workspace:FindFirstChild("JumpRope") and Workspace.JumpRope:FindFirstChild("Important") then
                local model = Workspace.JumpRope.Important:FindFirstChild("Model")
                if model and model:FindFirstChild("LEGS") then
                    local pos = model.LEGS.Position
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                    WindUI:Notify({
                        Title = "Jump Rope",
                        Content = "Completed jump rope challenge!",
                        Icon = "check",
                        Duration = 3
                    })
                end
            end
        end)
    end
})

TabHandles.OtherGames:Button({
    Title = "Glass Bridge Vision",
    Desc = "Reveal safe glass panels",
    Icon = "eye",
    Callback = function()
        pcall(function()
            if Workspace:FindFirstChild("GlassBridge") then
                local GlassHolder = Workspace.GlassBridge:FindFirstChild("GlassHolder")
                if GlassHolder then
                    for i, v in pairs(GlassHolder:GetChildren()) do
                        for k, j in pairs(v:GetChildren()) do
                            if j:IsA("Model") and j.PrimaryPart then
                                local isSafe = not j.PrimaryPart:GetAttribute("exploitingisevil")
                                local Color = isSafe and Color3.fromRGB(28, 235, 87) or Color3.fromRGB(248, 87, 87)
                                j.PrimaryPart.Color = Color
                                j.PrimaryPart.Transparency = 0
                                j.PrimaryPart.Material = Enum.Material.Neon
                            end
                        end
                    end
                    WindUI:Notify({
                        Title = "Glass Bridge",
                        Content = "Glass panels revealed!",
                        Icon = "eye",
                        Duration = 3
                    })
                end
            end
        end)
    end
})

TabHandles.OtherGames:Button({
    Title = "Complete Glass Bridge",
    Desc = "Teleport to the end of glass bridge",
    Icon = "zap",
    Callback = function()
        pcall(function()
            if Workspace:FindFirstChild("GlassBridge") and Workspace.GlassBridge:FindFirstChild("End") and Workspace.GlassBridge.End.PrimaryPart then
                local pos = Workspace.GlassBridge.End.PrimaryPart.Position + Vector3.new(0, 8, 0)
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos, pos + Vector3.new(0, 0, -1))
                WindUI:Notify({
                    Title = "Glass Bridge",
                    Content = "Teleported to the end!",
                    Icon = "check",
                    Duration = 3
                })
            end
        end)
    end
})

TabHandles.OtherGames:Toggle({
    Title = "Auto Mingle",
    Desc = "Automatically complete the mingle game",
    Value = false,
    Callback = function(value)
        _G.AutoMingle = value
        while _G.AutoMingle do
            pcall(function()
                for i, v in ipairs(Player.Character:GetChildren()) do
                    if v.Name == "RemoteForQTE" then
                        v:FireServer()
                    end
                end
            end)
            task.wait(0.1)
        end
    end
})

-- Settings Tab
TabHandles.Configuration:Toggle({
    Title = "ESP Highlight",
    Desc = "Enable highlight ESP effects",
    Value = false,
    Callback = function(value)
        _G.EspHighlight = value
    end
})

TabHandles.Configuration:Toggle({
    Title = "ESP GUI",
    Desc = "Enable GUI ESP labels",
    Value = false,
    Callback = function(value)
        _G.EspGui = value
    end
})

TabHandles.Configuration:Toggle({
    Title = "ESP Names",
    Desc = "Show names in ESP",
    Value = false,
    Callback = function(value)
        _G.EspName = value
    end
})

TabHandles.Configuration:Toggle({
    Title = "ESP Distance",
    Desc = "Show distances in ESP",
    Value = false,
    Callback = function(value)
        _G.EspDistance = value
    end
})

TabHandles.Configuration:Colorpicker({
    Title = "ESP Color",
    Desc = "Set ESP color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        _G.EspGuiTextColor = color
    end
})

TabHandles.Configuration:Button({
    Title = "Reload Script",
    Desc = "Restart the script",
    Icon = "refresh-cw",
    Callback = function()
        WindUI:Notify({
            Title = "Reloading",
            Content = "Script is reloading...",
            Duration = 3
        })
        wait(1)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/main/newinkgame.lua"))()
    end
})

-- Final notification
WindUI:Notify({
    Title = "ZZZ Hub Loaded",
    Content = "Ink Game ",
    Icon = "zap",
    Duration = 5
})
