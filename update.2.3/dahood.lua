
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    Translations = {
        ["en"] = {
            ["WELCOME"] = "Welcome to ZZZ Hub!",
            ["LIB_DESC"] = "Advanced automation hub for Da Hood",
            ["MAIN"] = "Main",
            ["COMBAT"] = "Combat",
            ["TELEPORTS"] = "Teleports",
            ["AIMLOCK"] = "Aimlock",
            ["FUN_STUFF"] = "Fun Stuff",
            ["AUTO_BUY"] = "Auto Buy"
        }
    }
})

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

WindUI:Popup({
    Title = gradient("ZZZ Hub", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "sparkles",
    Content = "loc:LIB_DESC",
    Buttons = {
        {
            Title = "Get Started",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() end
        }
    }
})

local Window = WindUI:CreateWindow({
    Title = "ZZZ Hub - Da Hood",
    Icon = "target",
    Author = "loc:WELCOME",
    Folder = "ZZZHub_DaHood",
    Size = UDim2.fromOffset(580, 490),
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            WindUI:Notify({
                Title = "User Profile",
                Content = "User profile clicked!",
                Duration = 3
            })
        end
    },
    SideBarWidth = 200
})

Window:Tag({
    Title = "v2.0",
    Color = Color3.fromHex("#30ff6a")
})

-- Notification
WindUI:Notify({
    Title = "ZZZ Hub Loaded!",
    Content = "Welcome to ZZZ Hub! Advanced Da Hood automation",
    Icon = "check-circle",
    Duration = 5
})

local Tabs = {
    Main = Window:Section({ Title = "loc:MAIN", Opened = true }),
    Combat = Window:Section({ Title = "loc:COMBAT", Opened = true }),
    Teleports = Window:Section({ Title = "loc:TELEPORTS", Opened = true }),
    Aimlock = Window:Section({ Title = "loc:AIMLOCK", Opened = true }),
    Fun = Window:Section({ Title = "loc:FUN_STUFF", Opened = true }),
    AutoBuy = Window:Section({ Title = "loc:AUTO_BUY", Opened = true })
}

local TabHandles = {
    Main = Tabs.Main:Tab({ Title = "Main Features", Icon = "home", Desc = "Core functionality" }),
    Combat = Tabs.Combat:Tab({ Title = "Combat", Icon = "sword", Desc = "Combat enhancements" }),
    Teleports = Tabs.Teleports:Tab({ Title = "Teleports", Icon = "map-pin", Desc = "Location teleports" }),
    Aimlock = Tabs.Aimlock:Tab({ Title = "Aimlock", Icon = "crosshair", Desc = "Targeting system" }),
    Fun = Tabs.Fun:Tab({ Title = "Fun Stuff", Icon = "smile", Desc = "Entertainment features" }),
    AutoBuy = Tabs.AutoBuy:Tab({ Title = "Auto Buy", Icon = "shopping-cart", Desc = "Automated purchases" })
}

-- Main Tab Features
TabHandles.Main:Button({
    Title = "Fly",
    Icon = "plane",
    Callback = function()
        local plr = game.Players.LocalPlayer
        local mouse = plr:GetMouse()
        localplayer = plr
    
        if workspace:FindFirstChild("Core") then
            workspace.Core:Destroy()
        end
    
        local Core = Instance.new("Part")
        Core.Name = "Core"
        Core.Size = Vector3.new(0.05, 0.05, 0.05)
    
        spawn(function()
            Core.Parent = workspace
            local Weld = Instance.new("Weld", Core)
            Weld.Part0 = Core
            Weld.Part1 = localplayer.Character.LowerTorso
            Weld.C0 = CFrame.new(0, 0, 0)
        end)
    
        workspace:WaitForChild("Core")
        local torso = workspace.Core
        flying = true
        local speed=7.5
        local keys={a=false,d=false,w=false,s=false}
        local e1
        local e2
    
        local function start()
            local pos = Instance.new("BodyPosition",torso)
            local gyro = Instance.new("BodyGyro",torso)
            pos.Name="EPIXPOS"
            pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            pos.position = torso.Position
            gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            gyro.cframe = torso.CFrame
            repeat
                wait()
                localplayer.Character.Humanoid.PlatformStand=true
                local new=gyro.cframe - gyro.cframe.p + pos.position
                if not keys.w and not keys.s and not keys.a and not keys.d then
                    speed=7.5
                end
                if keys.w then
                    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+0
                end
                if keys.s then
                    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+0
                end
                if keys.d then
                    new = new * CFrame.new(speed,0,0)
                    speed=speed+0
                end
                if keys.a then
                    new = new * CFrame.new(-speed,0,0)
                    speed=speed+0
                end
                if speed>3.2 then
                    speed=7.5
                end
                pos.position=new.p
                if keys.w then
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
                elseif keys.s then
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
                else
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                end
            until flying == false
            if gyro then gyro:Destroy() end
            if pos then pos:Destroy() end
            flying=false
            localplayer.Character.Humanoid.PlatformStand=false
            speed=7.5
        end
    
        e1=mouse.KeyDown:connect(function(key)
            if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
            if key=="w" then
                keys.w=true
            elseif key=="s" then
                keys.s=true
            elseif key=="a" then
                keys.a=true
            elseif key=="d" then
                keys.d=true
            elseif key=="x" then
                if flying==true then
                    flying=false
                else
                    flying=true
                    start()
                end
            end
        end)
    
        e2=mouse.KeyUp:connect(function(key)
            if key=="w" then
                keys.w=false
            elseif key=="s" then
                keys.s=false
            elseif key=="a" then
                keys.a=false
            elseif key=="d" then
                keys.d=false
            end
        end)
        start()
        
        WindUI:Notify({
            Title = "Fly Activated",
            Content = "Use WASD to fly, X to toggle",
            Icon = "plane",
            Duration = 3
        })
    end
})

local noclipEnabled = false
TabHandles.Main:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls",
    Value = false,
    Callback = function(Value)
        noclipEnabled = Value
        if Value then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/LegoHacker1337/legohacks/main/PhysicsServiceOnClient.lua"))()
            setfflag("HumanoidParallelRemoveNoPhysics", "False")
            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
            game:GetService('RunService'):BindToRenderStep("crash", 0 , function()
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("crash")
        end
    end    
})

TabHandles.Main:Button({
    Title = "Hide User",
    Icon = "eye-off",
    Callback = function()
        if game.Players.LocalPlayer.Character:FindFirstChild("In-gameMask") then
            game.Players.LocalPlayer.Character:FindFirstChild("In-gameMask"):FindFirstChildWhichIsA("Model"):Destroy()
            game.Players.LocalPlayer.Character:FindFirstChild("In-gameMask"):FindFirstChild('Handle'):Destroy()
        end
        WindUI:Notify({
            Title = "User Hidden",
            Content = "Mask removed successfully",
            Icon = "eye-off",
            Duration = 2
        })
    end
})

TabHandles.Main:Button({
    Title = "Korblox",
    Icon = "user",
    Callback = function()
        local ply = game.Players.LocalPlayer
        local chr = ply.Character
        chr.RightLowerLeg.MeshId = "902942093"
        chr.RightLowerLeg.Transparency = "1"
        chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
        chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
        chr.RightFoot.MeshId = "902942089"
        chr.RightFoot.Transparency = "1"
        WindUI:Notify({
            Title = "Korblox Applied",
            Content = "Korblox leg applied",
            Icon = "user",
            Duration = 2
        })
    end
})

TabHandles.Main:Button({
    Title = "Headless",
    Icon = "user-x",
    Callback = function()
        game.Players.LocalPlayer.Character.Head.Transparency = 1
        for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
            if (v:IsA("Decal")) then
                v.Transparency = 1
            end
        end
        WindUI:Notify({
            Title = "Headless Applied",
            Content = "Head made invisible",
            Icon = "user-x",
            Duration = 2
        })
    end
})

TabHandles.Main:Slider({
    Title = "Walkspeed",
    Desc = "Adjust movement speed (16 = normal)",
    Value = { Min = 16, Max = 150, Default = 16 },
    Callback = function(Value)
        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Name = 'SWAG MODE'
        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').WalkSpeed = Value
        if Value == 16 then
            game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Name = 'Humanoid'
            game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').WalkSpeed = 16
        end
    end    
})

TabHandles.Main:Button({
    Title = "Trash Talk",
    Icon = "message-circle",
    Callback = function()
        function dowait()
            wait(0.172)
        end
        local tbl_main = {"focus up son.", "All"}
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(tbl_main))
        dowait()
        local tbl_main = {"run my hours.", "All"}
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(tbl_main))
        dowait()
        local tbl_main = {"your so bad dont duck.", "All"}
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(tbl_main))
        dowait()
        local tbl_main = {"lol airshotted so bad.", "All"}
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(tbl_main))
        dowait()
        local tbl_main = {"ur bad kid run officials.", "All"}
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(tbl_main))
        WindUI:Notify({
            Title = "Trash Talk",
            Content = "Messages sent!",
            Icon = "message-circle",
            Duration = 2
        })
    end
})

TabHandles.Main:Button({
    Title = "No Display Names",
    Icon = "user-check",
    Callback = function()
        pcall(function()
            for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v.Character then
                    if v.Character:FindFirstChild("Humanoid") then
                        v.Character:FindFirstChild("Humanoid").DisplayName = v.Name 
                    end
                end
            end
        end)
        WindUI:Notify({
            Title = "Display Names",
            Content = "Display names reset to usernames",
            Icon = "user-check",
            Duration = 2
        })
    end
})

TabHandles.Main:Button({
    Title = "Rejoin",
    Icon = "refresh-cw",
    Callback = function()
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

-- Combat Tab Features
TabHandles.Combat:Button({
    Title = "Inf-Jump",
    Icon = "arrow-up",
    Callback = function()
        local player = game.Players.LocalPlayer
        local spacedown = false
        staminup = true
        game:GetService('UserInputService').InputBegan:Connect(function(key,b)
            if key.KeyCode == Enum.KeyCode.Space and not b then
                if staminup == true then
                    spacedown = true
                    while spacedown == true do
                        wait()
                        player.Character:FindFirstChildWhichIsA('Humanoid').JumpPower = 50
                        player.Character:FindFirstChildWhichIsA('Humanoid').Jump = true
                        player.Character:FindFirstChildWhichIsA('Humanoid').JumpPower = 50
                    end
                end
            end
        end)
        game:GetService('UserInputService').InputEnded:Connect(function(key,b)
            if key.KeyCode == Enum.KeyCode.Space and not b then
                if staminup == true then
                    spacedown = false
                end
            end
        end)
        WindUI:Notify({
            Title = "Infinite Jump",
            Content = "Hold space to fly!",
            Icon = "arrow-up",
            Duration = 3
        })
    end
})

local antiSlowEnabled = false
TabHandles.Combat:Toggle({
    Title = "Anti-Slow",
    Desc = "Prevent movement reduction",
    Value = false,
    Callback = function(Value)
        antiSlowEnabled = Value
        if Value then
            game:GetService('RunService'):BindToRenderStep("Anti-Slow", 0 , function()
                if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed"):Destroy() end
                if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk"):Destroy() end
                if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping"):Destroy() end
                if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false end
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("Anti-Slow")
        end
    end
})

local reachEnabled = false
TabHandles.Combat:Toggle({
    Title = "Reach",
    Desc = "Extended attack range",
    Value = false,
    Callback = function(Value)
        reachEnabled = Value
        if Value then
            game:GetService('RunService'):BindToRenderStep("Reach", 0 , function()
                local success, err = pcall(function()
                    if game.Players.LocalPlayer.Character.BodyEffects.Attacking.Value == true then
                        for i,v in pairs(game:GetService('Players'):GetChildren()) do
                            if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.LeftHand.Position).Magnitude <= 50 then
                                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                                    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild('Handle') then
                                        firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle, v.Character.UpperTorso, 0)
                                    else
                                        firetouchinterest(game.Players.LocalPlayer.Character['RightHand'], v.Character.UpperTorso, 0)
                                        firetouchinterest(game.Players.LocalPlayer.Character['LeftHand'], v.Character.UpperTorso, 0)
                                        firetouchinterest(game.Players.LocalPlayer.Character['RightFoot'], v.Character.UpperTorso, 0)
                                        firetouchinterest(game.Players.LocalPlayer.Character['LeftFoot'], v.Character.UpperTorso, 0)
                                        firetouchinterest(game.Players.LocalPlayer.Character['RightLowerLeg'], v.Character.UpperTorso, 0)
                                        firetouchinterest(game.Players.LocalPlayer.Character['LeftLowerLeg'], v.Character.UpperTorso, 0)
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("Reach")
        end
    end
})

local autoStompEnabled = false
TabHandles.Combat:Toggle({
    Title = "Auto-Stomp",
    Desc = "Automatically stomp opponents",
    Value = false,
    Callback = function(Value)
        autoStompEnabled = Value
        if Value then
            game:GetService('RunService'):BindToRenderStep("Auto-Stomp", 0 , function()
                game:GetService("ReplicatedStorage").MainEvent:FireServer("Stomp")
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("Auto-Stomp")
        end
    end
})

local antiStompEnabled = false
TabHandles.Combat:Toggle({
    Title = "Anti-Stomp",
    Desc = "Prevent being stomped",
    Value = false,
    Callback = function(Value)
        antiStompEnabled = Value
        if Value then
            game:GetService('RunService'):BindToRenderStep("Anti-Stomp", 0 , function()
                if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 then
                    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:IsA('MeshPart') or v:IsA('Part') then
                            v:Destroy()
                        end
                    end
                    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:IsA('Accessory') then
                            v.Handle:Destroy()
                        end
                    end
                end
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("Anti-Stomp")
        end
    end
})

local autoReloadEnabled = false
TabHandles.Combat:Toggle({
    Title = "Auto-Reload",
    Desc = "Automatically reload weapons",
    Value = false,
    Callback = function(Value)
        autoReloadEnabled = Value
        if Value then
            game:GetService('RunService'):BindToRenderStep("Auto-Reload", 0 , function()
                if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                            game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")) 
                            wait(1)
                        end
                    end
                end
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("Auto-Reload")
        end
    end
})

local infArmorEnabled = false
TabHandles.Combat:Toggle({
    Title = "Inf-Armor (BETA)",
    Desc = "Infinite armor system",
    Value = false,
    Callback = function(Value)
        infArmorEnabled = Value
        if Value then
            local Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game:GetService('RunService'):BindToRenderStep("Inf-Armor", 0 , function()
                local LocalPlayer = game.Players.LocalPlayer
                if LocalPlayer.Character.BodyEffects.Armor.Value == 0 then
                    function Buy()
                        LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Medium Armor] - $1000"].Head.CFrame + Vector3.new(0, 3, 0)
                        if (LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.Ignored.Shop["[Medium Armor] - $1000"].Head.Position).Magnitude <= 50 then
                            wait(.2)
                            fireclickdetector(game.Workspace.Ignored.Shop["[Medium Armor] - $1000"].ClickDetector, 4)
                            wait()
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
                        end
                        if LocalPlayer.Character.BodyEffects.Armor.Value <= 0 then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Medium Armor] - $1000"].Head.CFrame + Vector3.new(0, 3, 0)
                            if (LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.Ignored.Shop["[Medium Armor] - $1000"].Head.Position).Magnitude <= 50 then
                                wait(.2)
                                fireclickdetector(game.Workspace.Ignored.Shop["[Medium Armor] - $1000"].ClickDetector, 4)
                                wait()
                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
                            end
                        end
                    end
                    Buy()
                end
            end)
        else
            game:GetService('RunService'):UnbindFromRenderStep("Inf-Armor")
        end
    end
})

TabHandles.Combat:Button({
    Title = "No Recoil",
    Icon = "target",
    Callback = function()
        local player = game.Players.LocalPlayer
        for i,v in pairs(game:GetService('Workspace'):GetChildren()) do
            if v:IsA('Camera') then
                v:Destroy()
            end
        end
        local newcam = Instance.new('Camera')
        newcam.Parent = game:GetService('Workspace')
        newcam.Name = 'Camera'
        newcam.CameraType = 'Custom'
        newcam.CameraSubject = player.Character:FindFirstChildWhichIsA('Humanoid')
        newcam.HeadLocked = true
        newcam.HeadScale = 1
        WindUI:Notify({
            Title = "No Recoil",
            Content = "Camera recoil disabled",
            Icon = "target",
            Duration = 2
        })
    end
})

TabHandles.Combat:Button({
    Title = "Hoodshark",
    Icon = "zap",
    Callback = function() 
        loadstring(game:HttpGet('http://bin.shortbin.eu:8080/raw/n2dTcDByxD'))()
        WindUI:Notify({
            Title = "Hoodshark",
            Content = "Hoodshark script loaded",
            Icon = "zap",
            Duration = 2
        })
    end
})

-- Teleports Tab
local teleports = {
    {name = "Admin Base", pos = CFrame.new(-797.15, -39.6189, -887.957), icon = "shield"},
    {name = "Food Shop [Bank]", pos = CFrame.new(-335.141, 23.7129, -298.029), icon = "shopping-bag"},
    {name = "Food Shop [Uphill]", pos = CFrame.new(298.477, 49.3129, -615.231), icon = "shopping-bag"},
    {name = "Food Shop [Taco]", pos = CFrame.new(583.96, 51.0917, -479.596), icon = "shopping-bag"},
    {name = "Food Shop [Hamburger]", pos = CFrame.new(-279.501, 22.6801, -803.887), icon = "shopping-bag"},
    {name = "Gun Shop [Uphill]", pos = CFrame.new(481.925, 48.1008, -621.23), icon = "zap"},
    {name = "Gun Shop [Armor]", pos = CFrame.new(-580.27, 8.34504, -734.832), icon = "shield"},
    {name = "Bank", pos = CFrame.new(-438.689, 39.0127, -284.731), icon = "dollar-sign"},
    {name = "Police Station", pos = CFrame.new(-263.919, 21.8302, -112.858), icon = "shield-check"},
    {name = "Fire Department", pos = CFrame.new(-129.534, 27.842, -113.062), icon = "flame"},
    {name = "Church", pos = CFrame.new(205.53, 21.7803, -80.2361), icon = "church"},
    {name = "Casino", pos = CFrame.new(-904.457, 24.7803, -156.994), icon = "dice-6"},
    {name = "School", pos = CFrame.new(-578, 22, 337), icon = "book"}
}

for _, teleport in pairs(teleports) do
    TabHandles.Teleports:Button({
        Title = teleport.name,
        Icon = teleport.icon,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = teleport.pos
            WindUI:Notify({
                Title = "Teleported",
                Content = "Teleported to " .. teleport.name,
                Icon = "map-pin",
                Duration = 2
            })
        end
    })
end

-- Aimlock Tab
TabHandles.Aimlock:Button({
    Title = "Dimag16 Lock (Q)",
    Icon = "crosshair",
    Callback = function()
        _G.KEY = "q"
        _G.PART = "LowerTorso"
        _G.PRED = 0.037
        _G.Frame = Vector3.new(0,0.53,0)
        _G.AIR = -0.5
        _G.SHIT = 0.1
        
        local CC = game:GetService "Workspace".CurrentCamera
        local Plr
        local enabled = false
        local accomidationfactor = nil
        local mouse = game.Players.LocalPlayer:GetMouse()
        local placemarker = Instance.new("Part", game.Workspace)
        local guimain = Instance.new("Folder", game.CoreGui)
        
        getgenv().makemarker = function(Parent, Adornee, Color, Size, Size2)
            local e = Instance.new("BillboardGui", Parent)
            e.Name = "PP"
            e.Adornee = Adornee
            e.Size = UDim2.new(Size, Size2, Size, Size2)
            e.AlwaysOnTop = true
            local a = Instance.new("Frame", e)
            a.Size = UDim2.new(4, 0, 4, 0)
            a.BackgroundTransparency = 0.1
            a.BackgroundColor3 = Color
            local g = Instance.new("UICorner", a)
            g.CornerRadius = UDim.new(50, 50)
            return (e)
        end
        
        local data = game.Players:GetPlayers()
        function noob(player)
            local character
            repeat
                wait()
            until player.Character
            local handler = makemarker(guimain, player.Character:WaitForChild(_G.PART), Color3.fromRGB(255, 255, 255), 0.0, 0)
            handler.Name = player.Name
            player.CharacterAdded:connect(
                function(Char)
                    handler.Adornee = Char:WaitForChild(_G.PART)
                end
            )

            local TextLabel = Instance.new("TextLabel", handler)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0, 0, 0, -50)
            TextLabel.Size = UDim2.new(0, 100, 0, 100)
            TextLabel.Font = Enum.Font.SourceSansSemibold
            TextLabel.TextSize = 14
            TextLabel.TextColor3 = Color3.new(1, 1, 1)
            TextLabel.TextStrokeTransparency = 0
            TextLabel.Text = "Name: " .. player.Name
            TextLabel.ZIndex = 10

            spawn(
                function()
                    while wait() do
                        if player.Character then
                        end
                    end
                end
            )
        end
        
        for i = 1, #data do
            if data[i] ~= game.Players.LocalPlayer then
                noob(data[i])
            end
        end
        
        game.Players.PlayerAdded:connect(
            function(Player)
                noob(Player)
            end
        )
        
        game.Players.PlayerRemoving:Connect(
            function(player)
                guimain[player.Name]:Destroy()
            end
        )
        
        spawn(
            function()
                placemarker.Anchored = true
                placemarker.CanCollide = false
                placemarker.Size = Vector3.new(0.1, 0.1, 0.1)
                placemarker.Transparency = _G.SHIT
                makemarker(placemarker, placemarker, Color3.fromRGB(255, 255, 255), 0.20, 0)
            end
        )
        
        mouse.KeyDown:Connect(
            function(k)
                if k ~= _G.KEY then
                    return
                end
                if enabled then
                    enabled = false
                    TextLabel.TextColor3 = Color3.fromRGB(255, 20, 75)
                    TextLabel.Text = "------"
                else
                    enabled = true
                    Plr = getClosestPlayerToCursor()
                    TextLabel.TextColor3 = Color3.fromRGB(12, 255, 0)
                    TextLabel.Text = Plr.Character.Humanoid.DisplayName
                end
            end)
        
        function getClosestPlayerToCursor()
            local closestPlayer
            local shortestDistance = math.huge

            for i, v in pairs(game.Players:GetPlayers()) do
                if
                    v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
                        v.Character.Humanoid.Health ~= 0 and
                        v.Character:FindFirstChild(_G.PART)
                 then
                    local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                    if magnitude < shortestDistance then
                        closestPlayer = v
                        shortestDistance = magnitude
                    end
                end
            end
            return closestPlayer
        end
        
        game:GetService "RunService".Stepped:connect(
            function()
                if enabled and Plr.Character and Plr.Character:FindFirstChild(_G.PART) then
                    placemarker.CFrame =
                        CFrame.new(Plr.Character[_G.PART].Position + _G.Frame + (Plr.Character[_G.PART].Velocity * accomidationfactor))
                else
                    placemarker.CFrame = CFrame.new(0, 9999, 0)
                end
            end
        )
        
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall =
            newcclosure(
            function(...)
                local args = {...}
                if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
                    args[3] = Plr.Character[_G.PART].Position+ _G.Frame + (Plr.Character[_G.PART].Velocity * accomidationfactor)
                    return old(unpack(args))
                end
                return old(...)
            end
        )
        
        while wait() do
            local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
            local Value = tostring(ping)
            local pingValue = Value:split(" ")
            local PingNumber = pingValue[1]
            
            accomidationfactor = PingNumber / 1000 + _G.PRED
        end
        
        WindUI:Notify({
            Title = "Aimlock Activated",
            Content = "Press Q to lock onto target",
            Icon = "crosshair",
            Duration = 3
        })
    end
})

-- Fun Stuff Tab
TabHandles.Fun:Button({
    Title = "Animation Gamepass",
    Icon = "play",
    Callback = function()
        local Folder = Instance.new('Folder', game:GetService("Workspace"))
        local AnimationPack = game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.AnimationPack
        local ScrollingFrame = AnimationPack.ScrollingFrame
        local CloseButton = AnimationPack.CloseButton

        AnimationPack.Visible = true

        local LeanAnimation = Instance.new("Animation", Folder)
        LeanAnimation.Name = "LeanAnimation"
        LeanAnimation.AnimationId = "rbxassetid://3152375249"
        local Lean = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(LeanAnimation)

        local LayAnimation = Instance.new("Animation", Folder)
        LayAnimation.Name = "LayAnimation"
        LayAnimation.AnimationId = "rbxassetid://3152378852"
        local Lay = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(LayAnimation)

        local Dance1Animation = Instance.new("Animation", Folder)
        Dance1Animation.Name = "Dance1Animation"
        Dance1Animation.AnimationId = "rbxassetid://3189773368"
        local Dance1 = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(Dance1Animation)

        local Dance2Animation = Instance.new("Animation", Folder)
        Dance2Animation.Name = "Dance2Animation"
        Dance2Animation.AnimationId = "rbxassetid://3189776546"
        local Dance2 = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(Dance2Animation)

        local GreetAnimation = Instance.new("Animation", Folder)
        GreetAnimation.Name = "GreetAnimation"
        GreetAnimation.AnimationId = "rbxassetid://3189777795"
        local Greet = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(GreetAnimation)

        local PrayingAnimation = Instance.new("Animation", Folder)
        PrayingAnimation.Name = "PrayingAnimation"
        PrayingAnimation.AnimationId = "rbxassetid://3487719500"
        local Praying = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(PrayingAnimation)

        for i,v in pairs(ScrollingFrame:GetChildren()) do
            if v.Name == "TextButton" then
                if v.Text == "Lean" then
                    v.Name = "LeanButton"
                end
            end
        end

        for i,v in pairs(ScrollingFrame:GetChildren()) do
            if v.Name == "TextButton" then
                if v.Text == "Lay" then
                    v.Name = "LayButton"
                end
            end
        end

        for i,v in pairs(ScrollingFrame:GetChildren()) do
            if v.Name == "TextButton" then
                if v.Text == "Dance1" then
                    v.Name = "Dance1Button"
                end
            end
        end

        for i,v in pairs(ScrollingFrame:GetChildren()) do
            if v.Name == "TextButton" then
                if v.Text == "Dance2" then
                    v.Name = "Dance2Button"
                end
            end
        end

        for i,v in pairs(ScrollingFrame:GetChildren()) do
            if v.Name == "TextButton" then
                if v.Text == "Greet" then
                    v.Name = "GreetButton"
                end
            end
        end

        for i,v in pairs(ScrollingFrame:GetChildren()) do
            if v.Name == "TextButton" then
                if v.Text == "Praying" then
                    v.Name = "PrayingButton"
                end
            end
        end

        function Stop()
            Lay:Stop()
            Lean:Stop()
            Dance1:Stop()
            Dance2:Stop()
            Greet:Stop()
            Praying:Stop()
        end

        local LeanTextButton = ScrollingFrame.LeanButton
        local LayTextButton = ScrollingFrame.LayButton
        local Dance1TextButton = ScrollingFrame.Dance1Button
        local Dance2TextButton = ScrollingFrame.Dance2Button
        local GreetTextButton = ScrollingFrame.GreetButton
        local PrayingTextButton = ScrollingFrame.PrayingButton

        AnimationPack.MouseButton1Click:Connect(function()
            if ScrollingFrame.Visible == false then
                ScrollingFrame.Visible = true
                CloseButton.Visible = true
            end
        end)
        CloseButton.MouseButton1Click:Connect(function()
            if ScrollingFrame.Visible == true then
                ScrollingFrame.Visible = false
                CloseButton.Visible = false
            end
        end)
        LeanTextButton.MouseButton1Click:Connect(function()
            Stop()
            Lean:Play()
        end)
        LayTextButton.MouseButton1Click:Connect(function()
            Stop()
            Lay:Play()
        end)
        Dance1TextButton.MouseButton1Click:Connect(function()
            Stop()
            Dance1:Play()
        end)
        Dance2TextButton.MouseButton1Click:Connect(function()
            Stop()
            Dance2:Play()
        end)
        GreetTextButton.MouseButton1Click:Connect(function()
            Stop()
            Greet:Play()
        end)
        PrayingTextButton.MouseButton1Click:Connect(function()
            Stop()
            Praying:Play()
        end)

        game:GetService("Players").LocalPlayer.Character.Humanoid.Running:Connect(function()
            Stop()
        end)
        
        WindUI:Notify({
            Title = "Animation Pack",
            Content = "Animation gamepass activated",
            Icon = "play",
            Duration = 2
        })
    end
})

-- Auto Buy Tab
TabHandles.AutoBuy:Paragraph({
    Title = "Auto Purchase System",
    Desc = "Automatically buy items from shops",
    Image = "shopping-cart",
    ImageSize = 20,
    Color = Color3.fromHex("#30ff6a")
})

for i,v in pairs(game:GetService("Workspace").Ignored.Shop:GetChildren()) do
    TabHandles.AutoBuy:Button({
        Title = v.Name,
        Icon = "shopping-bag",
        Callback = function()
            local Pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            local Teleport = v:FindFirstChild("Head")
            if Teleport then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Teleport.CFrame
                local CD = v:FindFirstChild("ClickDetector")
                if CD then
                    wait(0.75)
                    fireclickdetector(CD)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
                    WindUI:Notify({
                        Title = "Purchase Complete",
                        Content = "Bought: " .. v.Name,
                        Icon = "shopping-bag",
                        Duration = 2
                    })
                end
            end
        end
    })
end

Window:OnClose(function()
    print("ZZZ Hub closed")
end)

Window:OnDestroy(function()
    print("ZZZ Hub destroyed")
end)
