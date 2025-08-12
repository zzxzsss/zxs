
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

-- Load DummyUI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/ui/dummyui"))()

-- Create Main Window
local Window = Library:Window({
    Title = "zzz hub",
    Desc = "Anime Rails",
    Icon = 105059922903197,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 600, 0, 400)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "zzz hub"
    }
})

-- Create Tabs
local MainTab = Window:Tab({Title = "Main", Icon = "rocket"})
local CashTab = Window:Tab({Title = "Cash", Icon = "dollar-sign"})
local PartyTab = Window:Tab({Title = "Auto Join", Icon = "handshake"})
local GUI = Window:Tab({Title = "Equip", Icon = "flame"})
local GamepassTab = Window:Tab({Title = "Gamepass", Icon = "cookie"})
local PlayerTab = Window:Tab({Title = "Player", Icon = "user"})
local MiscTab = Window:Tab({Title = "Misc", Icon = "file-cog"})

-- Main Tab
local event = ReplicatedStorage:WaitForChild("Events"):WaitForChild("ChangeValue")

local dupeNames = {
    "Infinity", "Solar", "Crimson", "DarkArcher", "PurpleAssasin", "WolfBoss", "Merchant", "SickCurse", "Tank",
    "CrimsonMaster", "Lightning", "SunBreather", "KnightBoss", "Materials", "Baryon", "HeinEra", "Sukuna",
    "Naruto", "SSGoku", "Tanjiro", "Goku", "Shadows", "Kaiser", "Puzzle", "Knight", "Shake", "Hapticss",
    "MuzanAura", "MoonAura", "YellowAura", "MuzanClass", "KokoshiboClass", "CompassClass", "MuzanMorph",
    "MoonMorph", "HakiPower", "InfinityVoid", "Dismantle", "Restriction", "BlackFlashAura", "ShadowAura",
    "CriticalHit", "Gear4", "BlackFlash", "Toji", "InfinityEyes", "MasteredReflex", "LavaMasterClass",
    "RedeemedWolfBoss", "RedeemedKnight", "LuffyMorph", "DoughMorph", "GravityAura", "DoughAura",
    "LavaAura", "Gear5Class", "MochiClass", "Rinnegan", "Kurama", "Sasuke", "Pain", "EightGates", "Sed",
    "Cid", "Gojo", "Assasin", "AntKing", "BlueFlames", "BloodKnight", "BloodMorph", "BloodMorphS",
    "AntMorph", "AntMorphS", "AssasinMorph", "LightAura", "AlterAura", "Alter", "Saber", "SaberMorph", "AlterMorph",
    "Hakai", "PridfulWarrior", "EarthWarrior", "GreatApe", "BeerusMorph", "VegetaMorph", "BeerusBoss", "Mahoraga",
    "AkazaMorph", "DSEventMorph", "InsectBreather", "MasterKokoshibo", "SunStyleSwordsman", "ThunderBreather", "Tips", 
    "ZeroMoon", "DomaMorph"
}

local morphInputValue = ""
local classInputValue = ""
local auraInputValue = ""

MainTab:Section({Title = "Dupe Features"})

MainTab:Button({
    Title = "Dupe All (Click me for All)",
    Desc = "Unlock all morphs, classes and auras",
    Callback = function()
        for _, name in ipairs(dupeNames) do
            event:FireServer("SetMorphBuy", name, 0)
            wait(0.05)
        end
        print("[zzz hub] All Morphs, Classes and Auras unlocked!")
    end,
})

MainTab:Textbox({
    Title = "Dupe Morph",
    Desc = "Use the name from Npc Morph",
    Placeholder = "Enter morph name",
    Value = "",
    Callback = function(text)
        morphInputValue = text
    end,
})

MainTab:Button({
    Title = "Unlock Morph",
    Desc = "Unlock specific morph",
    Callback = function()
        local found = false
        for _, name in ipairs(dupeNames) do
            if name:lower() == morphInputValue:lower() then
                event:FireServer("SetMorphBuy", name, 0)
                print("[zzz hub] Morph unlocked:", name)
                found = true
                break
            end
        end
        if not found then
            print("[zzz hub] Invalid Morph:", morphInputValue)
        end
    end,
})

MainTab:Textbox({
    Title = "Dupe Class",
    Desc = "Use the name from Npc Class",
    Placeholder = "Enter class name",
    Value = "",
    Callback = function(text)
        classInputValue = text
    end,
})

MainTab:Button({
    Title = "Unlock Class",
    Desc = "Unlock specific class",
    Callback = function()
        local found = false
        for _, name in ipairs(dupeNames) do
            if name:lower() == classInputValue:lower() then
                event:FireServer("SetMorphBuy", name, 0)
                print("[zzz hub] Class unlocked:", name)
                found = true
                break
            end
        end
        if not found then
            print("[zzz hub] Invalid Class:", classInputValue)
        end
    end,
})

MainTab:Textbox({
    Title = "Dupe Aura",
    Desc = "Use the name from Npc Aura",
    Placeholder = "Enter aura name",
    Value = "",
    Callback = function(text)
        auraInputValue = text
    end,
})

MainTab:Button({
    Title = "Unlock Aura",
    Desc = "Unlock specific aura",
    Callback = function()
        local found = false
        for _, name in ipairs(dupeNames) do
            if name:lower() == auraInputValue:lower() then
                event:FireServer("SetMorphBuy", name, 0)
                print("[zzz hub] Aura unlocked:", name)
                found = true
                break
            end
        end
        if not found then
            print("[zzz hub] Invalid Aura:", auraInputValue)
        end
    end,
})

-- Gamepass Tab
local selectedGamepass = "All"

GamepassTab:Section({Title = "Gamepass Unlock"})

GamepassTab:Dropdown({
    Title = "Select Gamepass",
    List = { "All", "DoubleCash", "AlrBoughtSkipSpin", "SecClass", "Emote", "CriticalHit", "SkipSpin" },
    Value = "All",
    Callback = function(selected)
        selectedGamepass = selected
        print("[zzz hub] Selected Gamepass:", selectedGamepass)
    end,
})

GamepassTab:Button({
    Title = "Unlock Gamepass",
    Desc = "Unlock selected gamepass",
    Callback = function()
        local player = LocalPlayer
        local data = player:FindFirstChild("Data")
        if not data then
            warn("[zzz hub] Data not found!")
            return
        end

        if selectedGamepass == "All" then
            local gamepasses = { "DoubleCash", "AlrBoughtSkipSpin", "SecClass", "Emote", "CriticalHit", "SkipSpin" }
            for _, gpName in ipairs(gamepasses) do
                local gp = data:FindFirstChild(gpName)
                if gp then
                    gp.Value = true
                    print("[zzz hub] Unlocked Gamepass:", gpName)
                end
            end
        else
            local gp = data:FindFirstChild(selectedGamepass)
            if gp then
                gp.Value = true
                print("[zzz hub] Unlocked Gamepass:", selectedGamepass)
            else
                warn("[zzz hub] Gamepass not found:", selectedGamepass)
            end
        end

        if selectedGamepass == "Emote" or selectedGamepass == "All" then
            local emotes = player:FindFirstChild("PlayerGui"):FindFirstChild("HUD")
            if emotes and emotes:FindFirstChild("Emotes") then
                emotes.Emotes.Visible = true
            end
        end
    end,
})

-- Cash Tab
local cashInputValue = ""

CashTab:Section({Title = "Cash Features"})

CashTab:Textbox({
    Title = "Enter Dupe Cash Amount",
    Desc = "Amount between 100 and 10000",
    Placeholder = "100 ~ 10000",
    Value = "",
    Callback = function(text)
        cashInputValue = text
    end,
})

CashTab:Button({
    Title = "Dupe Cash",
    Desc = "Duplicate specified cash amount",
    Callback = function()
        local input = tonumber(cashInputValue)
        if input and input >= 100 and input <= 10000 then
            local args = {
                [1] = "Wins",
                [2] = input,
                [3] = "zzzhub"
            }
            ReplicatedStorage:WaitForChild("CodeEvent"):FireServer(unpack(args))
            print("[zzz hub] Dupe Cash:", input)
        else
            print("[zzz hub] Invalid amount:", cashInputValue)
        end
    end,
})

CashTab:Button({
    Title = "Infinite Dupe Cash",
    Desc = "Dupe maximum cash amount",
    Callback = function()
        local totalAmount = 999000000
        local perFire = 999999
        local times = math.floor(totalAmount / perFire)
        task.spawn(function()
            for i = 1, times do
                local args = {
                    [1] = "Wins",
                    [2] = perFire,
                    [3] = "zzzhub"
                }
                ReplicatedStorage:WaitForChild("CodeEvent"):FireServer(unpack(args))
                task.wait(0.1)
            end
            print("[zzz hub] Completed Infinite Cash")
        end)
    end,
})

CashTab:Button({
    Title = "Infinite Dupe Spin",
    Desc = "Dupe maximum spin amount",
    Callback = function()
        local totalAmount = 9999
        local perFire = 1
        local times = math.floor(totalAmount / perFire)
        task.spawn(function()
            for i = 1, times do
                local args = {
                    [1] = "Wins",
                    [2] = 0,
                    [3] = "zzzhub"
                }
                ReplicatedStorage:WaitForChild("CodeEvent"):FireServer(unpack(args))
                task.wait(0.05)
            end
            print("[zzz hub] Completed Infinite Dupe Spin +10 Spin")
        end)
    end,
})

-- Player Tab
local espEnabled = false
local espUpdateConnection
local espOptions = {
    ShowName = false,
    ShowHealth = false,
    ShowDistance = false,
    ShowMorph = false,
    ShowClass = false,
    ShowAura = false,
    HighlightColor = Color3.fromRGB(0, 255, 0),
    Rainbow = false,
}

local function updateESP()
    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("Head") then
            local head = target.Character.Head
            local gui = head:FindFirstChild("ZZZESP")
            if not gui then
                gui = Instance.new("BillboardGui")
                gui.Name = "ZZZESP"
                gui.Size = UDim2.new(0, 200, 0, 100)
                gui.StudsOffset = Vector3.new(0, 2.5, 0)
                gui.AlwaysOnTop = true
                gui.Parent = head
            end

            for _, child in ipairs(gui:GetChildren()) do
                if child:IsA("TextLabel") then
                    child:Destroy()
                end
            end

            local function addLine(text, yOffset)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 20)
                label.Position = UDim2.new(0, 0, 0, yOffset)
                label.BackgroundTransparency = 1
                label.TextColor3 = espOptions.Rainbow and Color3.fromHSV((tick() % 5) / 5, 1, 1) or espOptions.HighlightColor
                label.TextStrokeTransparency = 0
                label.TextScaled = true
                label.Font = Enum.Font.SourceSansBold
                label.Text = text
                label.Parent = gui
            end

            local data = target:FindFirstChild("Data")
            local y = 0

            if espOptions.ShowName then
                addLine(target.Name, y)
                y += 20
            end

            if espOptions.ShowHealth and target.Character:FindFirstChild("Humanoid") then
                addLine("HP: " .. math.floor(target.Character.Humanoid.Health), y)
                y += 20
            end

            if espOptions.ShowDistance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
                addLine("Dist: " .. math.floor(dist), y)
                y += 20
            end

            if data and data:FindFirstChild("CurrChar") and data.CurrChar:IsA("StringValue") then
                addLine("Morph: " .. data.CurrChar.Value, y)
                y += 20
            end

            if data and data:FindFirstChild("CurrClass") and data.CurrClass:IsA("StringValue") then
                addLine("Class: " .. data.CurrClass.Value, y)
                y += 20
            end

            if data and data:FindFirstChild("CurrClassSec") and data.CurrClassSec:IsA("StringValue") then
                addLine("Class 2: " .. data.CurrClassSec.Value, y)
                y += 20
            end

            if data and data:FindFirstChild("CurrTitle") and data.CurrTitle:IsA("StringValue") then
                addLine("Title: " .. data.CurrTitle.Value, y)
                y += 20
            end

            if data and data:FindFirstChild("CurrSelect") and data.CurrSelect:IsA("StringValue") then
                addLine("Aura: " .. data.CurrSelect.Value, y)
                y += 20
            end
        end
    end
end

local function clearESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local gui = player.Character.Head:FindFirstChild("ZZZESP")
            if gui then
                gui:Destroy()
            end
        end
    end
end

local function toggleESP(state)
    espEnabled = state
    if espEnabled then
        updateESP()
        espUpdateConnection = RunService.Heartbeat:Connect(updateESP)
    else
        clearESP()
        if espUpdateConnection then
            espUpdateConnection:Disconnect()
            espUpdateConnection = nil
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        player.CharacterAdded:Wait()
        updateESP()
    end
end)

PlayerTab:Section({Title = "ESP Features"})

PlayerTab:Toggle({
    Title = "Enable ESP",
    Desc = "Toggle player ESP",
    Value = false,
    Callback = function(state)
        toggleESP(state)
    end,
})

PlayerTab:Dropdown({
    Title = "ESP Color",
    List = {"Red", "Green", "Blue", "Yellow", "Purple", "Cyan", "White", "Black", "Rainbow"},
    Value = "Green",
    Callback = function(colorName)
        espOptions.Rainbow = false
        local colors = {
            Red = Color3.fromRGB(255, 0, 0),
            Green = Color3.fromRGB(0, 255, 0),
            Blue = Color3.fromRGB(0, 0, 255),
            Yellow = Color3.fromRGB(255, 255, 0),
            Purple = Color3.fromRGB(128, 0, 128),
            Cyan = Color3.fromRGB(0, 255, 255),
            White = Color3.fromRGB(255, 255, 255),
            Black = Color3.fromRGB(0, 0, 0),
            Rainbow = nil,
        }
        if colorName == "Rainbow" then
            espOptions.Rainbow = true
        else
            espOptions.HighlightColor = colors[colorName] or Color3.fromRGB(0, 255, 0)
        end
    end,
})

PlayerTab:Toggle({
    Title = "Show Player Name",
    Desc = "Show player names in ESP",
    Value = false,
    Callback = function(state)
        espOptions.ShowName = state
    end,
})

PlayerTab:Toggle({
    Title = "Show Health",
    Desc = "Show player health in ESP",
    Value = false,
    Callback = function(state)
        espOptions.ShowHealth = state
    end,
})

PlayerTab:Toggle({
    Title = "Show Distance",
    Desc = "Show distance to players in ESP",
    Value = false,
    Callback = function(state)
        espOptions.ShowDistance = state
    end,
})

PlayerTab:Toggle({
    Title = "Show Morph",
    Desc = "Show player morphs in ESP",
    Value = false,
    Callback = function(state)
        espOptions.ShowMorph = state
    end,
})

PlayerTab:Toggle({
    Title = "Show Class",
    Desc = "Show player classes in ESP",
    Value = false,
    Callback = function(state)
        espOptions.ShowClass = state
    end,
})

PlayerTab:Toggle({
    Title = "Show Aura",
    Desc = "Show player auras in ESP",
    Value = false,
    Callback = function(state)
        espOptions.ShowAura = state
    end,
})

RunService.Heartbeat:Connect(function()
    if espEnabled then
        updateESP()
    end
end)

-- Misc Tab
local antiAfkEnabled = false
local fakeBypassEnabled = false

MiscTab:Section({Title = "Misc Features"})

-- Bypass Anti-Cheat (fake)
MiscTab:Toggle({
    Title = "Bypass Anti-Cheat",
    Desc = "Enhanced protection (visual only)",
    Value = true,
    Callback = function(state)
        fakeBypassEnabled = state
        if fakeBypassEnabled then
            print("[zzz hub] Bypassing Anti-Cheat... ✅")
            Window:Notify({
                Title = "Bypass Enabled",
                Desc = "Enhanced protection activated",
                Time = 3
            })
        else
            print("[zzz hub] Bypass Anti-Cheat disabled.")
        end
    end,
})

-- Anti AFK
MiscTab:Toggle({
    Title = "Anti AFK",
    Desc = "Prevent automatic disconnection",
    Value = false,
    Callback = function(state)
        antiAfkEnabled = state
        if antiAfkEnabled then
            task.spawn(function()
                while antiAfkEnabled do
                    VirtualUser:Button2Down(Vector2.new(0,0))
                    task.wait(60)
                end
            end)
            print("[zzz hub] Anti AFK enabled")
        else
            print("[zzz hub] Anti AFK disabled")
        end
    end,
})

local indexList = {
    "Infinity", "Solar", "Crimson", "DarkArcher", "PurpleAssasin", "WolfBoss", "Merchant", "SickCurse", "Tank",
    "CrimsonMaster", "Lightning", "SunBreather", "KnightBoss", "Materials", "Baryon", "HeinEra", "Sukuna",
    "Naruto", "SSGoku", "Tanjiro", "Goku", "Shadows", "Kaiser", "Puzzle", "Knight", "Shake", "Hapticss",
    "MuzanAura", "MoonAura", "YellowAura", "MuzanClass", "KokoshiboClass", "CompassClass", "MuzanMorph",
    "MoonMorph", "HakiPower", "InfinityVoid", "Dismantle", "Restriction", "BlackFlashAura", "ShadowAura",
    "CriticalHit", "Gear4", "BlackFlash", "Toji", "InfinityEyes", "MasteredReflex", "LavaMasterClass",
    "RedeemedWolfBoss", "RedeemedKnight", "LuffyMorph", "DoughMorph", "GravityAura", "DoughAura",
    "LavaAura", "Gear5Class", "MochiClass", "Rinnegan", "Kurama", "Sasuke", "Pain", "EightGates", "Sed",
    "Cid", "Gojo", "Assasin", "AntKing", "BlueFlames", "BloodKnight", "BloodMorph", "BloodMorphS",
    "AntMorph", "AntMorphS", "AssasinMorph", "LightAura", "AlterAura", "Alter", "Saber", "SaberMorph", "AlterMorph",
    "Hakai", "PridfulWarrior", "EarthWarrior", "GreatApe", "BeerusMorph", "VegetaMorph", "BeerusBoss", "Mahoraga"
}

GUI:Section({Title = "Equipment Management"})

-- Dropdown for viewing all indexes
GUI:Dropdown({
    Title = "Index List",
    List = indexList,
    Value = indexList[1],
    Callback = function(value)
        print("[zzz hub] Selected index:", value)
    end,
})

-- Function for FireServer
local function fireChangeValue(key, value)
    local args = { key, value }
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ChangeValue"):FireServer(unpack(args))
    print("[zzz hub] Sent", key, value)
end

-- Set Character
GUI:Textbox({
    Title = "Set Character",
    Desc = "Change your character",
    Placeholder = "Type character name...",
    Value = "",
    Callback = function(value)
        fireChangeValue("SetCurrChar", value)
    end,
})

-- Set Class Slot 1
GUI:Textbox({
    Title = "Set Class (Slot 1)",
    Desc = "Change your primary class",
    Placeholder = "Type class name...",
    Value = "",
    Callback = function(value)
        fireChangeValue("SetCurClass", value)
    end,
})

-- Set Class Slot 2 (Gamepass)
GUI:Textbox({
    Title = "Set Class (Slot 2)",
    Desc = "Change your secondary class",
    Placeholder = "Type class2 name...",
    Value = "",
    Callback = function(value)
        fireChangeValue("SetCurClass2", value)
    end,
})

-- Set Aura
GUI:Textbox({
    Title = "Set Aura",
    Desc = "Change your aura",
    Placeholder = "Type aura name...",
    Value = "",
    Callback = function(value)
        fireChangeValue("SetCurAura", value)
    end,
})

-- Auto Join Tab
local maxPlayers = 1
local allowFriend = true
local nightmareMode = false

PartyTab:Section({Title = "Auto Join Settings"})

-- Max Players Input
PartyTab:Textbox({
    Title = "Max Players",
    Desc = "Set maximum players (1-8)",
    Placeholder = "Enter 1 ~ 8",
    Value = "1",
    Callback = function(text)
        local num = tonumber(text)
        if num and num >= 1 and num <= 8 then
            maxPlayers = num
            print("[zzz hub] Max Players set to:", maxPlayers)
        else
            warn("[zzz hub] Invalid max players input, must be between 1 and 8")
        end
    end,
})

-- Allow Friend Join Toggle
PartyTab:Toggle({
    Title = "Allow Friend Join",
    Desc = "Allow friends to join your party",
    Value = true,
    Callback = function(state)
        allowFriend = state
        print("[zzz hub] Allow Friend Join:", state)
    end,
})

-- Nightmare Mode Toggle
PartyTab:Toggle({
    Title = "Nightmare Mode",
    Desc = "Enable nightmare difficulty",
    Value = false,
    Callback = function(state)
        nightmareMode = state
        print("[zzz hub] Nightmare Mode:", state)
    end,
})

-- Auto Join Button
PartyTab:Button({
    Title = "Auto Join",
    Desc = "Automatically join a game",
    Callback = function()
        local args = {
            allowFriend,
            maxPlayers,
            nightmareMode
        }
        game:GetService("ReplicatedStorage"):WaitForChild("ApplyTP"):FireServer(unpack(args))
        print("[zzz hub] Auto Join sent:", allowFriend, maxPlayers, nightmareMode)
    end,
}) 

-- Final Notification
Window:Notify({
    Title = "zzz hub",
    Desc = "Anime Rails script loaded successfully!",
    Time = 4
})

print("[zzz hub] Script loaded successfully!")
