 
-- Load DummyUI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/ui/dummyui"))()

-- Create Main Window
local Window = Library:Window({
    Title = "zzz hub",
    Desc = "zzz hub legends of speed script",
    Icon = 105059922903197,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 400)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "zzz hub"
    }
})

-- Create Tabs
local MainTab = Window:Tab({Title = "Main", Icon = "star"}) do
    local AutoFarmTab = Window:Tab({Title = "Auto Farm", Icon = "zap"}) do
        local TeleportTab = Window:Tab({Title = "Teleport", Icon = "navigation"}) do
            local RaceTab = Window:Tab({Title = "Race", Icon = "trophy"}) do
                local CrystalTab = Window:Tab({Title = "Crystal", Icon = "gem"}) do
                    local MiscTab = Window:Tab({Title = "Misc", Icon = "settings"}) do
                        local CreditsTab = Window:Tab({Title = "Credits", Icon = "users"}) do
                            local HelpTab = Window:Tab({Title = "Glitch Help", Icon = "help-circle"}) do

local player = game.Players.LocalPlayer
local antiAFK = true
player.Idled:connect(function()
while wait(5) do
	if antiAFK then
		game.VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		wait(1)
		game.VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end
	end
end)

-- Main Tab
MainTab:Section({Title = "Main"})

-- Time Label
local timeLabel = MainTab:Code({
    Title = "Game Time",
    Code = "Loading..."
})

function UpdateTime()
local GameTime = math.floor(workspace.DistributedGameTime+0.5)
local Hour = math.floor(GameTime/(60^2))%24
local Minute = math.floor(GameTime/(60^1))%60
local Second = math.floor(GameTime/(60^0))%60
timeLabel:SetCode("[GameTime] : Hours : "..Hour.." Minutes : "..Minute.." Seconds : "..Second)
end

spawn(function()
 while task.wait() do
 pcall(function()
  UpdateTime()
  end)
 end
 end)

-- FPS Label
local fpsLabel = MainTab:Code({
    Title = "Client Performance",
    Code = "Loading..."
})

function UpdateClient()
local Fps = workspace:GetRealPhysicsFPS()
fpsLabel:SetCode("[Fps] : "..Fps)
end

spawn(function()
 while true do wait(.1)
 UpdateClient()
 end
 end)

-- Ping Label
local pingLabel = MainTab:Code({
    Title = "Network Status",
    Code = "Loading..."
})

function UpdateClient1()
local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
pingLabel:SetCode("[Ping] : "..Ping)
end

spawn(function()
 while true do wait(.1)
 UpdateClient1()
 end
 end)

MainTab:Button({
    Title = "Copy Discord Link",
    Desc = "Join our community discord",
    Callback = function()
        setclipboard("https://discord.com/invite/hYmREEpSwh")
        Window:Notify({
            Title = "Discord",
            Desc = "Discord link copied to clipboard!",
            Time = 3
        })
    end
})

MainTab:Button({
    Title = "Claim All Chests",
    Desc = "Teleport all chests to you",
    Callback = function()
        workspace.goldenChest.circleInner.CFrame = player.Character.HumanoidRootPart.CFrame
        workspace.enchantedChest.circleInner.CFrame = player.Character.HumanoidRootPart.CFrame
        workspace.magmaChest.circleInner.CFrame = player.Character.HumanoidRootPart.CFrame
        workspace.groupRewardsCircle.circleInner.CFrame = player.Character.HumanoidRootPart.CFrame
        wait()
        workspace.goldenChest.circleInner.CFrame = oldGoldenChestPosition
        workspace.enchantedChest.circleInner.CFrame = oldEnchantedChestPosition
        workspace.magmaChest.circleInner.CFrame = oldMagmaChestPosition
        workspace.groupRewardsCircle.circleInner.CFrame = oldGroupRewardsPosition
        Window:Notify({
            Title = "Chests",
            Desc = "All chests claimed successfully!",
            Time = 3
        })
    end
})

MainTab:Toggle({
    Title = "Auto Rebirth",
    Desc = "Automatically rebirth at max level",
    Value = false,
    Callback = function(state)
        _G.Rebirth = (state and true or false)
        wait()
        while _G.Rebirth == true do
            wait()
            game.ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
        end
    end
})

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.NoClip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false    
                    end
                end
            end
        end)
    end)
end)

MainTab:Toggle({
    Title = "No Clip",
    Desc = "Penetrate anything",
    Value = false,
    Callback = function(value)
        _G.NoClip = value
    end
})

MainTab:Button({
    Title = "Disable Trading",
    Desc = "Disable your trading",
    Callback = function()
        local args = {
            [1] = "disableTrading"
        }
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))
        Window:Notify({
            Title = "Trading",
            Desc = "Trading disabled!",
            Time = 3
        })
    end
})

MainTab:Button({
    Title = "Enable Trading",
    Desc = "Enable your trading",
    Callback = function()
        local args = {
            [1] = "enableTrading"
        }
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))
        Window:Notify({
            Title = "Trading",
            Desc = "Trading enabled!",
            Time = 3
        })
    end
})

local PLIST = {}
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    table.insert(PLIST,v.Name)
end

local TpPlayer;

MainTab:Dropdown({
    Title = "Select Player",
    List = PLIST,
    Value = "None",
    Callback = function(value)
        TpPlayer = value;
    end
})

MainTab:Button({
    Title = "Teleport To Player",
    Desc = "Teleport to selected player",
    Callback = function()
        if TpPlayer then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[TpPlayer].Character.HumanoidRootPart.CFrame * CFrame.new(0,2,1)
            Window:Notify({
                Title = "Teleport",
                Desc = "Teleported to " .. TpPlayer,
                Time = 3
            })
        end
    end
})

MainTab:Slider({
    Title = "Speed",
    Min = 0,
    Max = 5000,
    Rounding = 0,
    Value = 300,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

MainTab:Slider({
    Title = "Jump Power",
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Value = 50,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end
})

-- Auto Farm Tab
AutoFarmTab:Section({Title = "Auto Farm"})
AutoFarmTab:Section({Title = "Farm Setting"})

local locate; 
AutoFarmTab:Dropdown({
    Title = "Select Location",
    List = {"City", "Snow City", "Magma City", "Legends Highway", "Space", "Desert"},
    Value = "City",
    Callback = function(value)
        locate = value; 
    end
})

local orbs; 
AutoFarmTab:Dropdown({
    Title = "Select Orbs",
    List = {"Red Orb", "Yellow Orb", "Gem"},
    Value = "Red Orb",
    Callback = function(value)
        orbs = value;
    end
})

local setFarm;
AutoFarmTab:Dropdown({
    Title = "Select Mode",
    List = {"Super Fast", "Fast", "Medium", "Slow"},
    Value = "Medium",
    Callback = function(value)
        setFarm = value;
        if setFarm == "Super Fast" then
            setFarm = 40
        elseif setFarm == "Fast" then
            setFarm = 30 
        elseif setFarm == "Medium" then
            setFarm = 20
        elseif setFarm == "Slow" then
            setFarm = 10
        end
    end
})

AutoFarmTab:Code({
    Title = "Speed Info",
    Code = "• Super Fast Value = 40\n• Fast Value = 30\n• Medium Value = 20\n• Slow Value = 10\nNot Recommended Using Super Fast Mode\nBecause it will cause a delay / lag in the game"
})

AutoFarmTab:Toggle({
    Title = "Start Farm",
    Desc = "Auto Collect Orbs",
    Value = false,
    Callback = function(state)
        _G.Farm = (state and true or false)
        wait()
        while _G.Farm == true do
            wait()
            for i=1, setFarm do
                local A_1 = "collectOrb"
                local A_2 = orbs
                local A_3 = locate
                local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent
                Event:FireServer(A_1, A_2, A_3)
            end
        end
    end
}) 

AutoFarmTab:Toggle({
    Title = "Hoops Farm",
    Desc = "Automatically moves the ring",
    Value = false,
    Callback = function(state)
        _G.Hoops = (state and true or false)
        wait()
        while _G.Hoops == true do
            wait()
            local children = workspace.Hoops:GetChildren()
            for i, child in ipairs(children) do
                if child.Name == 'Hoop' then
                    child.Transparency = 1
                    child.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end 
    end
})

-- Race Tab
RaceTab:Section({Title = "Race"})

game.ReplicatedStorage.raceInProgress.Changed:Connect(function(state)
	if not getgenv().AutoRace then return end
	if state then
		game.ReplicatedStorage.rEvents.raceEvent:FireServer('joinRace')
		wait()
		player.PlayerGui.gameGui.raceJoinLabel.Visible = false
	end
end)

game.ReplicatedStorage.raceStarted.Changed:Connect(function(state)
	if not getgenv().AutoRace then return end
	if state then
		for i, v in pairs(workspace.raceMaps:GetChildren()) do
			local oldFinishPosition = v.finishPart.CFrame
			v.finishPart.CFrame = player.Character.HumanoidRootPart.CFrame
			wait()
			v.finishPart.CFrame = oldFinishPosition
		end
	end
end)

RaceTab:Toggle({
    Title = "Auto Finish Race",
    Desc = "Automatically join and win the race",
    Value = false,
    Callback = function(state)
        getgenv().AutoRace = state
    end
})

-- Teleport Tab
TeleportTab:Section({Title = "Teleports"})

if game.PlaceId == 3101667897 then --City
    TeleportTab:Button({
        Title = "City",
        Desc = "Teleport to City",
        Callback = function()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-9687.1923828125, 59.072853088378906, 3096.58837890625))
        end
    })

    TeleportTab:Button({
        Title = "Snow City",
        Desc = "Teleport to Snow City",
        Callback = function()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-9677.6640625, 59.072853088378906, 3783.736572265625))
        end
    })

    TeleportTab:Button({
        Title = "Magma City",
        Desc = "Teleport to Magma City",
        Callback = function()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-11053.3837890625, 217.0328369140625, 4896.10986328125))
        end
    })

    TeleportTab:Button({
        Title = "Legends Highway",
        Desc = "Teleport to Legends Highway",
        Callback = function()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-13097.8583984375, 217.0328369140625, 5904.84716796875))
        end
    })

    TeleportTab:Button({
        Title = "Space",
        Desc = "Teleport to Space",
        Callback = function()
            local ts = game:GetService("TeleportService")
            local p = game:GetService("Players").LocalPlayer
            ts:Teleport(3232996272, p)
        end
    })

    TeleportTab:Button({
        Title = "Desert",
        Desc = "Teleport to Desert",
        Callback = function()
            local ts = game:GetService("TeleportService")
            local p = game:GetService("Players").LocalPlayer
            ts:Teleport(3276265788, p)
        end
    })

elseif game.PlaceId == 3232996272 then --space
    TeleportTab:Button({
        Title = "City",
        Desc = "Teleport to City",
        Callback = function()
            local ts = game:GetService("TeleportService")
            local p = game:GetService("Players").LocalPlayer
            ts:Teleport(3101667897, p)
        end
    })

    TeleportTab:Button({
        Title = "Desert",
        Desc = "Teleport to Desert",
        Callback = function()
            local ts = game:GetService("TeleportService")
            local p = game:GetService("Players").LocalPlayer
            ts:Teleport(3276265788, p)
        end
    })

elseif game.PlaceId == 3276265788 then --desert
    TeleportTab:Button({
        Title = "City",
        Desc = "Teleport to City",
        Callback = function()
            local ts = game:GetService("TeleportService")
            local p = game:GetService("Players").LocalPlayer
            ts:Teleport(3101667897, p)
        end
    })

    TeleportTab:Button({
        Title = "Space",
        Desc = "Teleport to Space",
        Callback = function()
            local ts = game:GetService("TeleportService")
            local p = game:GetService("Players").LocalPlayer
            ts:Teleport(3232996272, p)
        end
    })
end

-- Crystal Tab
CrystalTab:Section({Title = "Crystal"})

local Crystal = {}
for i,v in pairs(game.workspace.mapCrystalsFolder:GetChildren()) do 
    table.insert(Crystal,v.Name)
end

function OpenCrystal(v) 
    local args = {
        [1] = "openCrystal",
        [2] = v
    }
    game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(unpack(args))
end

local OPENEGG
CrystalTab:Dropdown({
    Title = "Select Crystal",
    List = Crystal,
    Value = Crystal[1] or "None",
    Callback = function(value)
        OPENEGG = value
    end
})

CrystalTab:Toggle({
    Title = "Open Crystal",
    Desc = "Auto Open Crystal",
    Value = false,
    Callback = function(state)
        _G.Mm = state
        while _G.Mm do
            wait()
            OpenCrystal(OPENEGG) 
        end
    end
})

spawn(function() 
while wait() do
if _G.AutoSellAllTrails then
local rank = {}
for i,rank in pairs(game:GetService("Players").LocalPlayer.trailsFolder:GetChildren()) do
rank = rank.Name
    for i,item in pairs(game:GetService("Players").LocalPlayer.trailsFolder[rank]:GetChildren()) do
   
local args = {
    [1] = "sellTrail",
    [2] = game:GetService("Players").LocalPlayer.trailsFolder[rank]:FindFirstChild(item.Name)
}

game:GetService("ReplicatedStorage").rEvents.sellTrailEvent:FireServer(unpack(args))
    end
end
end
end
end) 

spawn(function() 
while wait() do
if _G.AutoSellAllPets then
local rank = {}
for i,rank in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
rank = rank.Name
    for i,item in pairs(game:GetService("Players").LocalPlayer.petsFolder[rank]:GetChildren()) do
    if item.Name ~= "Ultra Birdie" then
local args = {
    [1] = "sellPet",
    [2] = game:GetService("Players").LocalPlayer.petsFolder[rank]:FindFirstChild(item.Name)
}

game:GetService("ReplicatedStorage").rEvents.sellPetEvent:FireServer(unpack(args))

    end
    end
end
end
end
end) 

spawn(function() 
while wait() do
if _G.BunnyFarm then
local rank = {}
for i,rank in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
rank = rank.Name
    for i,item in pairs(game:GetService("Players").LocalPlayer.petsFolder[rank]:GetChildren()) do
    if item.Name ~= "Ultimate Overdrive Bunny" then
local args = {
    [1] = "sellPet",
    [2] = game:GetService("Players").LocalPlayer.petsFolder[rank]:FindFirstChild(item.Name)
}

game:GetService("ReplicatedStorage").rEvents.sellPetEvent:FireServer(unpack(args))

    end
    end
end
end
end
end) 

spawn(function() 
while wait() do
if _G.AutoUnique then
local rank = {}
for i,rank in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
rank = rank.Name
  if rank ~= "Unique" then
    for i,item in pairs(game:GetService("Players").LocalPlayer.petsFolder[rank]:GetChildren()) do
  
local args = {
    [1] = "sellPet",
    [2] = game:GetService("Players").LocalPlayer.petsFolder[rank]:FindFirstChild(item.Name)
}

game:GetService("ReplicatedStorage").rEvents.sellPetEvent:FireServer(unpack(args))

    end
    end
end
end
end
end) 

spawn(function() 
while wait() do
if _G.OpenBirdieEgg then
OpenCrystal("Electro Crystal") 
end
end
end) 

spawn(function() 
while wait() do
if _G.OpenVoidEgg then
OpenCrystal("Desert Crystal") 
end
end
end) 

spawn(function() 
while wait() do
if _G.OpenLegendsEgg then
OpenCrystal("Electro Legends Crystal") 
end
end
end) 

CrystalTab:Toggle({
    Title = "Auto Void Dragon [Desert]",
    Desc = "Auto Delete All Pets if not Void Dragon",
    Value = false,
    Callback = function(state)
        _G.OpenVoidEgg = state
        _G.AutoUnique = state
        _G.AutoSellAllTrails = state
    end
})

CrystalTab:Toggle({
    Title = "Auto Ultra Birdie [Best Pet Desert]",
    Desc = "Auto Delete All Pets if not Ultra Birdie",
    Value = false,
    Callback = function(state)
        _G.OpenBirdieEgg = state
        _G.AutoSellAllPets = state
        _G.AutoSellAllTrails = state
    end
})

CrystalTab:Toggle({
    Title = "Auto Ultimate Overdrive Bunny",
    Desc = "Auto Delete All Pets if not Overdrive Bunny",
    Value = false,
    Callback = function(state)
        _G.BunnyFarm = state
        _G.OpenLegendsEgg = state
    end
})

CrystalTab:Toggle({
    Title = "Auto Evolved All Pets",
    Desc = "Auto Evolved",
    Value = false,
    Callback = function(state)
        _G.Evo = (state and true or false)
        wait()
        while _G.Evo == true do
            wait()
            for i,v in pairs(game:GetService("Players").LocalPlayer.petsFolder:GetChildren()) do
                for i,v in pairs(game:GetService("Players").LocalPlayer.petsFolder[v.Name]:GetChildren()) do
                    local args = {
                        [1] = "evolvePet",
                        [2] = v.Name
                    }
                    game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer(unpack(args))
                end
            end
        end
    end
})

-- Misc Tab
MiscTab:Section({Title = "Misc"})

MiscTab:Toggle({
    Title = "Hide Popups",
    Desc = "Remove popup notifications",
    Value = false,
    Callback = function(state)
        getgenv().HidePopups = state
        if not getgenv().HidePopups then 
            player.PlayerGui.orbGui.Enabled = true 
            player.PlayerGui.gameGui.trailsNotificationsFrame.Visible = true 
            return 
        end
        player.PlayerGui.orbGui.Enabled = false
        player.PlayerGui.gameGui.trailsNotificationsFrame.Visible = false
    end
})

MiscTab:Toggle({
    Title = "Inf Jump",
    Desc = "Player jumps are unlimited",
    Value = false,
    Callback = function(v)
        _G.InfJump = v
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end)
    end
})

MiscTab:Button({
    Title = "Rejoin",
    Desc = "Rejoin current server",
    Callback = function()
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        ts:Teleport(game.PlaceId, p)
    end
})

MiscTab:Button({
    Title = "Low Server Hop",
    Desc = "Join a server with fewer players",
    Callback = function()
        local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")()
        module:Teleport(game.PlaceId);
    end
})

-- Credits Tab
CreditsTab:Section({Title = "Credits"})

CreditsTab:Button({
    Title = "Youtube Channel",
    Desc = "Copy YouTube link",
    Callback = function()
        setclipboard('https://youtube.com/@RelzBlox')
        Window:Notify({
            Title = "YouTube",
            Desc = "YouTube link copied to clipboard!",
            Time = 3
        })
    end
})

CreditsTab:Button({
    Title = "Discord",
    Desc = "Copy Discord link",
    Callback = function()
        setclipboard("https://discord.gg/25ms")
        Window:Notify({
            Title = "Discord",
            Desc = "Discord link copied to clipboard!",
            Time = 3
        })
    end
})

-- Help Tab
HelpTab:Section({Title = "Tutorial"})
HelpTab:Code({
    Title = "How to Use",
    Code = "1. Use Pet Level 1 No XP\n2. Turn on Yellow Orbs In Auto Farm Menu\n3. Don't Get About XP\n4. Don't Use Other Features Except Yellow Orbs\n5. Done"
})

HelpTab:Section({Title = "Notes"})
HelpTab:Code({
    Title = "Important Notes",
    Code = "> Make sure your Rebirth is Odd\n> The Power Pet Will Return If You Disconnect"
})

-- Close all tab blocks
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Final Notification
Window:Notify({
    Title = "Legends Of Speed",
    Desc = "Script loaded successfully with DummyUI!",
    Time = 4
})
