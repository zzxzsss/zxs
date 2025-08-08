if game.PlaceId ~= 126244816328678 then
    return
end

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/Lib"))() 
local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/ConfigManager"))()

local main = lib:Load({
    Title = '🔥 zzz Hub | Dig Games 🔥',
    ToggleButton = "rbxassetid://133520378097790",
    BindGui = Enum.KeyCode.RightControl,
})

-- Buat part transparan untuk Billboard
local part = Instance.new("Part", workspace)
part.Anchored = true
part.CanCollide = false
part.Size = Vector3.new(4,1,4)
part.Transparency = 1
part.Name = "DiscordBillboard"

-- Ambil posisi player
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

part.Position = hrp.Position + Vector3.new(0,5,0)

-- Buat BillboardGui
local bb = Instance.new("BillboardGui", part)
bb.Size = UDim2.new(0, 200, 0, 50)
bb.StudsOffset = Vector3.new(0, 6, 0)
bb.AlwaysOnTop = true

-- Teks utama
local text = Instance.new("TextLabel", bb)
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "https://discord.gg/PaRYpmJ4cG"
text.TextColor3 = Color3.fromRGB(180, 220, 255)
text.TextStrokeTransparency = 0
text.TextStrokeColor3 = Color3.new(0, 0, 0)
text.Font = Enum.Font.GothamBold
text.TextScaled = true

-- Tambahkan gambar (tanduk/icon)
local img = Instance.new("ImageLabel", bb)
img.Size = UDim2.new(0.3, 0, 0.3, 0)
img.Position = UDim2.new(0.35, 0, 1, 0)
img.BackgroundTransparency = 100
img.Image = "133520378097790" -- 🔷 ID gambar bisa diganti sesuai selera

-- Auto hilang setelah 1 detik
task.delay(10, function()
    part:Destroy()
end)

-- Notifikasi di sini yaaaaaaaaaa

local Players = game:GetService("Players")
local player = Players.LocalPlayer

lib:Notification('Script Loaded', 'Have Fun With My Script, '..player.Name..', Enjoyy To My Script', 7)

lib:Notification('Support Game', 'DIG, Steal A Brainrot', 6.5)

local UpdateTab = main:AddTab("Update")
local Section = UpdateTab:AddSection({Title = "Changelog", Description = "Recent updates", Default = false, Locked = false})

-- ✅ Buat GUI basic
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BasicGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- frame kiri atas
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0, 10, 0, 50) -- 👈 di bawah logo Roblox
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- label judul
local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1, 0, 0.5, 0)
Label.BackgroundTransparency = 1
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.Text = "📄 zzz hub n"
Label.TextSize = 14
Label.Parent = Frame

-- label status boss
local BossStatus = Instance.new("TextLabel")
BossStatus.Size = UDim2.new(1, 0, 0.5, 0)
BossStatus.Position = UDim2.new(0, 0, 0.5, 0)
BossStatus.BackgroundTransparency = 1
BossStatus.TextColor3 = Color3.fromRGB(255, 200, 0)
BossStatus.Text = "Boss Status: Checking..."
BossStatus.TextSize = 12
BossStatus.Parent = Frame

-- ✅ Status toggle
local guiVisible = true
ScreenGui.Enabled = guiVisible

Section:AddToggle("ShowBasicGUI", {
        Title = "Show Basic GUI",
        Default = true,
        Description = "Toggle basic GUI visibility",
        Callback = function(Value)
                guiVisible = Value
                ScreenGui.Enabled = guiVisible
                warn("Basic GUI visible:", guiVisible)
        end,
})

-- ✅ Boss checker
task.spawn(function()
        while true do
                if guiVisible then
                        local bossSpawns = workspace:FindFirstChild("Spawns") and workspace.Spawns:FindFirstChild("BossSpawns")
                        local foundBoss = false

                        if bossSpawns then
                                for _, boss in ipairs(bossSpawns:GetChildren()) do
                                        if boss:FindFirstChildWhichIsA("Model") or #boss:GetChildren() > 0 then
                                                foundBoss = true
                                                break
                                        end
                                end
                        end

                        if foundBoss then
                                BossStatus.Text = "Boss Status: 🟥 Spawned!"
                                BossStatus.TextColor3 = Color3.fromRGB(255, 0, 0)
                        else
                                BossStatus.Text = "Boss Status: ✅ None"
                                BossStatus.TextColor3 = Color3.fromRGB(0, 255, 0)
                        end
                end
                task.wait(1)
        end
end)

warn("✅ Basic GUI loaded & boss status enabled.")

Section:AddParagraph({
    Title = "What's New?",
    Description = "[+] Added Boss Teleport\n - Tp To Fuzzball\n - Tp To King Crab\n - Tp To Candlelight Phantom\n - Tp To Giant Spider\n - Tp To Basilisk\n - Tp To Molten Monstrosity\n - Tp To Dire Wolf\n\n- Join discord HLemon Hub"
})

Section:AddButton({
   Title = "zzz hub🍋",
   Callback = function()
      -- Ganti link di sini dengan link Discord kamu
      setclipboard("https://discord.gg/PaRYpmJ4cG")
      
      -- Tampilkan notifikasi bahwa link sudah dicopy
      lib:Notification('Copied!', 'https://discord.gg/PaRYpmJ4cG', 2)
   end,
})

local FarmTab = main:AddTab("Farm")
main:SelectTab()

local FarmSection = FarmTab:AddSection({Title = "DIG Main", Description = "Auto dig functionality", Default = false, Locked = false})

-- ✅ Enhanced Auto Dig (Fast) Script logic
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Holes = workspace:WaitForChild("World"):WaitForChild("Zones"):WaitForChild("_NoDig")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local ENABLED = false
local digCount = 0
local connections = {}
local lastShovelCheck = 0
local shovelCheckInterval = 1 -- Check every 1 second

-- ✅ Enhanced shovel list
local shovelNames = {
    "Wooden Shovel", "Bejeweled Shovel", "Training Shovel", "Toy Shovel",
    "Copper Shovel", "Rock Shovel", "Lucky Shovel", "Ruby Shovel",
    "Abyssal Shovel", "Bell Shovel", "Magnet Shovel", "Jam Shovel",
    "Candlelight Shovel", "Spore Spade", "Slayers Shovel", "Arachnid Shovel",
    "Shortcake Shovel", "Pizza Roller", "Rock Splitter", "Archaic Shovel",
    "Frigid Shovel", "Venomous Shovel", "Gold Digger", "Obsidian Shovel",
    "Prismatic Shovel", "Beast Slayer", "Solstice Shovel", "Glinted Shovel",
    "Draconic Shovel", "Monstrous Shovel", "Starfire Shovel"
}

-- ✅ Centralized shovel management to prevent conflicts
local shovelEquipInProgress = false
local lastEquipAttempt = 0
local equipCooldown = 0.5 -- Prevent rapid equip/unequip cycles

function hasShovelEquipped()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return false end
    
    -- Check if the equipped tool is a shovel
    for _, shovelName in ipairs(shovelNames) do
        if tool.Name == shovelName then
            return true, tool
        end
    end
    return false, nil
end

function getShovelFromBackpack()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, shovelName in ipairs(shovelNames) do
                if tool.Name == shovelName then
                    return tool
                end
            end
        end
    end
    return nil
end

function ensureShovelEquipped()
    -- Prevent rapid equipping attempts
    local currentTime = tick()
    if shovelEquipInProgress or (currentTime - lastEquipAttempt) < equipCooldown then
        return hasShovelEquipped()
    end
    
    local hasEquipped, equippedShovel = hasShovelEquipped()
    if hasEquipped then return true end
    
    -- Try to equip a shovel from backpack
    local availableShovel = getShovelFromBackpack()
    if availableShovel then
        shovelEquipInProgress = true
        lastEquipAttempt = currentTime
        
        pcall(function()
            Remotes:WaitForChild("Backpack_Equip"):FireServer(availableShovel)
        end)
        
        task.wait(0.2) -- Wait for equip to complete
        shovelEquipInProgress = false
        return hasShovelEquipped()
    end
    
    return false
end

function getTool()
    local hasEquipped, tool = hasShovelEquipped()
    return hasEquipped and tool or nil
end

function destroyHitbox()
    local hitbox = Holes:FindFirstChild(LocalPlayer.Name.."_Crater_Hitbox")
    if hitbox then hitbox:Destroy() end
end

function activateTool()
    if not ENABLED then return end
    
    -- Check if we have a shovel equipped (with periodic check)
    local currentTime = tick()
    if currentTime - lastShovelCheck > shovelCheckInterval then
        ensureShovelEquipped()
        lastShovelCheck = currentTime
    end
    
    local tool = getTool()
    if tool then
        destroyHitbox()
        tool:Activate()
        updateDigActivity() -- Update dig activity tracking for fast dig
    end
end

function setupEvents()
    table.insert(connections, LocalPlayer.PlayerGui.ChildAdded:Connect(function(v)
        if v.Name == "Dig" then
            local strong_bar = v.Safezone.Holder:FindFirstChild("Area_Strong")
            local player_bar = v.Safezone.Holder:FindFirstChild("PlayerBar")
            table.insert(connections, player_bar:GetPropertyChangedSignal("Position"):Connect(function()
                if ENABLED then
                    player_bar.Position = strong_bar.Position
                    digCount += 1
                    activateTool()
                end
            end))
        end
    end))

    table.insert(connections, LocalPlayer:GetAttributeChangedSignal("IsDigging"):Connect(function()
        if ENABLED then
            updateDigActivity() -- Update dig activity tracking for fast dig
            if not LocalPlayer:GetAttribute("IsDigging") then
                activateTool()
            end
        end
    end))

    table.insert(connections, LocalPlayer.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(v)
            if ENABLED and v:IsA("Tool") then
                -- Check if it's a shovel
                for _, shovelName in ipairs(shovelNames) do
                    if v.Name == shovelName then
                        task.wait(0.1)
                        activateTool()
                        break
                    end
                end
            end
        end)
    end))

    if LocalPlayer.Character then
        table.insert(connections, LocalPlayer.Character.ChildAdded:Connect(function(v)
            if ENABLED and v:IsA("Tool") then
                -- Check if it's a shovel
                for _, shovelName in ipairs(shovelNames) do
                    if v.Name == shovelName then
                        task.wait(0.1)
                        activateTool()
                        break
                    end
                end
            end
        end))
    end

    table.insert(connections, RunService.Heartbeat:Connect(function()
        if ENABLED and digCount >= 3 then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(2), 0)
                activateTool()
            end
        end
    end))
end

function cleanupEvents()
    for _, conn in ipairs(connections) do
        conn:Disconnect()
    end
    connections = {}
end

-- ✅ Enhanced Toggle
FarmSection:AddToggle("AutoDigRotate", {
    Title = "Auto Dig (Fast)",
    Default = false,
    Description = "Fast auto dig with shovel detection",
    Callback = function(Value)
        ENABLED = Value
        if Value then
            digCount = 0
            -- Ensure we have a shovel equipped when starting
            if not ensureShovelEquipped() then
                lib:Notification('No Shovel Found', 'Please get a shovel from the shop first!', 4)
                return
            end
            updateDigActivity() -- Initialize dig activity tracking for fast dig
            setupEvents()
            lib:Notification('Auto Dig Enabled', 'Fast auto dig is now active with shovel detection', 3)
        else
            cleanupEvents()
        end
    end,
})

-- ✅ Enhanced Auto Dig (Slow) Script logic
local local_player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Backpack = local_player:WaitForChild("Backpack")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local holes = workspace:FindFirstChild("World"):FindFirstChild("Zones"):FindFirstChild("_NoDig")

getgenv().enabled = false -- default off
local slowDigLastCheck = 0
local slowDigCheckInterval = 2 -- Check every 2 seconds

-- ✅ Minigame Detection System
local minigameDetectionEnabled = false
local lastDigTime = 0
local digActivityTimeout = 5 -- Timeout in seconds to detect when digging stops unexpectedly
local minigameCheckInterval = 1 -- Check every second
local wasDiggingBefore = false
local minigameConnection

-- ✅ Use centralized shovel management for slow dig
function get_tool()
    local hasEquipped, tool = hasShovelEquipped()
    return hasEquipped and tool or nil
end

function checkAndEquipShovel()
    local currentTime = tick()
    if currentTime - slowDigLastCheck > slowDigCheckInterval then
        ensureShovelEquipped()
        slowDigLastCheck = currentTime
    end
end

-- ✅ Minigame Detection Functions
function updateDigActivity()
    lastDigTime = tick()
end

function startMinigameDetection()
    if minigameConnection then
        minigameConnection:Disconnect()
    end
    
    minigameConnection = RunService.Heartbeat:Connect(function()
        if not minigameDetectionEnabled then return end
        
        local currentTime = tick()
        local isCurrentlyDigging = local_player:GetAttribute("IsDigging")
        
        -- Check if we were digging before but now we're not, and it's been too long
        if wasDiggingBefore and not isCurrentlyDigging and (currentTime - lastDigTime) > digActivityTimeout then
            -- Check if we had a shovel equipped before the dig stopped
            local hasEquipped, tool = hasShovelEquipped()
            if hasEquipped then
                -- Only re-equip if we had a shovel before - this prevents unnecessary equipping
                lib:Notification('Minigame Detection', 'Dig stopped unexpectedly, re-equipping shovel...', 3)
                ensureShovelEquipped()
                updateDigActivity() -- Reset the timer
            end
        end
        
        -- Update the tracking state
        wasDiggingBefore = isCurrentlyDigging
        
        -- Update dig activity when we're actively digging
        if isCurrentlyDigging then
            updateDigActivity()
        end
    end)
end

function stopMinigameDetection()
    if minigameConnection then
        minigameConnection:Disconnect()
        minigameConnection = nil
    end
end

local_player.Character.ChildAdded:Connect(function(v)
    if enabled and v:IsA("Tool") then
        -- Check if it's a shovel
        for _, shovelName in ipairs(shovelNames) do
            if v.Name == shovelName then
                task.wait(1)
                if holes:FindFirstChild(local_player.Name.."_Crater_Hitbox") then
                    holes[local_player.Name.."_Crater_Hitbox"]:Destroy()
                end
                v:Activate()
                break
            end
        end
    end
end)

local_player.PlayerGui.ChildAdded:Connect(function(v)
    if enabled and v.Name == "Dig" then
        updateDigActivity() -- Update dig activity when minigame starts
        local strong_bar = v:FindFirstChild("Safezone"):FindFirstChild("Holder"):FindFirstChild("Area_Strong")
        local player_bar = v:FindFirstChild("Safezone"):FindFirstChild("Holder"):FindFirstChild("PlayerBar")
        player_bar:GetPropertyChangedSignal("Position"):Connect(function()
            if not enabled then return end
            updateDigActivity() -- Update dig activity during minigame
            if math.abs(player_bar.Position.X.Scale - strong_bar.Position.X.Scale) <= 0.04 then
                checkAndEquipShovel()
                local tool = get_tool()
                if tool then
                    tool:Activate()
                    task.wait()
                end
            end
        end)
    end
end)

local_player:GetAttributeChangedSignal("IsDigging"):Connect(function()
    if not enabled then return end
    updateDigActivity() -- Update dig activity tracking
    if not local_player:GetAttribute("IsDigging") then
        if holes:FindFirstChild(local_player.Name.."_Crater_Hitbox") then
            holes[local_player.Name.."_Crater_Hitbox"]:Destroy()
        end
        checkAndEquipShovel()
        local tool = get_tool()
        if tool then
            tool:Activate()
        end
    end
end)

-- 🧰 Enhanced 3itx Toggle
FarmSection:AddToggle("AutoDigToggle", {
   Title = "Auto Dig (slow)",
   Default = false,
   Description = "Slow auto dig with shovel detection",
   Callback = function(Value)
       -- Set enabled on/off saat toggle ditekan
       getgenv().enabled = Value
       if Value then
           -- Check if we have a shovel equipped when starting
           if not ensureShovelEquipped() then
               lib:Notification('No Shovel Found', 'Please get a shovel from the shop first!', 4)
               return
           end
           updateDigActivity() -- Initialize dig activity tracking
           lib:Notification('Auto Dig Enabled', 'Slow auto dig is now active with shovel detection', 3)
       end
   end,
})

-- ✅ Minigame Detection Toggle
FarmSection:AddToggle("MinigameDetection", {
   Title = "Minigame Detection",
   Default = false,
   Description = "Auto re-equip shovel when dig stops unexpectedly (server bug protection)",
   Callback = function(Value)
       minigameDetectionEnabled = Value
       if Value then
           startMinigameDetection()
           lib:Notification('Minigame Detection Enabled', 'Will auto re-equip shovel when dig stops unexpectedly', 3)
       else
           stopMinigameDetection()
           lib:Notification('Minigame Detection Disabled', 'Minigame detection has been turned off', 3)
       end
   end,
})

-- ✅ Minigame Detection Timeout Slider
FarmSection:AddSlider("MinigameTimeout", {
   Title = "Detection Timeout (seconds)",
   Default = 5,
   Min = 2,
   Max = 15,
   Increment = 1,
   Callback = function(Value)
       digActivityTimeout = Value
       lib:Notification('Timeout Updated', 'Minigame detection timeout set to ' .. Value .. ' seconds', 2)
   end,
})

local EquipSection = FarmTab:AddSection({Title = "Equip Shovel", Description = "Auto equip shovel functionality", Default = false, Locked = false})

local STANDALONE_EQUIP_ENABLED = false
local standaloneBackpackConn

-- ✅ Standalone equip function (uses centralized management)
function equipAnyShovelStandalone()
    -- Use the centralized shovel management system
    ensureShovelEquipped()
end

-- ✅ Unequip function
function unequip()
    pcall(function()
        Remotes:WaitForChild("Backpack_Equip"):FireServer(nil)
    end)
end

-- ✅ Toggle 3itx (Updated to prevent conflicts)
EquipSection:AddToggle("AutoShovelSimple", {
    Title = "Auto Equip Shovel (Standalone)",
    Default = false,
    Description = "Automatically equip shovels from backpack (Note: Auto dig functions also include shovel equipping)",
    Callback = function(state)
        STANDALONE_EQUIP_ENABLED = state

        if STANDALONE_EQUIP_ENABLED then
            -- Check if auto dig is enabled and warn about potential conflicts
            if ENABLED or getgenv().enabled then
                lib:Notification('Warning', 'Auto dig is already enabled. This may cause conflicts. Consider using only auto dig functions.', 5)
            end
            
            equipAnyShovelStandalone()

            -- sambungkan listener
            standaloneBackpackConn = Backpack.ChildAdded:Connect(function(child)
                if STANDALONE_EQUIP_ENABLED then
                    task.wait(0.1)
                    equipAnyShovelStandalone()
                end
            end)

        else
            unequip()

            -- putuskan listener
            if standaloneBackpackConn then
                standaloneBackpackConn:Disconnect()
                standaloneBackpackConn = nil
            end
        end
    end
})

local MechanicTab = main:AddTab("Mechanic")
local CarsSection = MechanicTab:AddSection({Title = "Cars", Description = "Vehicle management", Default = false, Locked = false})

-- 🟦 List mobil
local vehicleList = {
    "ATV", "Golf Cart", "Koi Truck", "Commander", "Silver",
    "Pulse", "Rumbler", "Tracer", "DMW M3", "Elite 6x6",
    "Forklift", "The Ox", "Roadster RS", "Tornado", "McBruce 700", "Monster Silver"
}

-- 🟦 Remote references
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleSpawn = ReplicatedStorage.Remotes:FindFirstChild("Vehicle_Spawn")
local AvaRoot = workspace:WaitForChild("World"):WaitForChild("NPCs"):WaitForChild("Ava Carter"):WaitForChild("HumanoidRootPart")

if not VehicleSpawn then
    warn("Vehicle_Spawn remote tidak ditemukan!")
end

-- 🟦 Buat tombol untuk setiap mobil
local VehicleGroupButtons = CarsSection:AddGroupButton()

for _, vehicleName in ipairs(vehicleList) do
    VehicleGroupButtons:AddButton({
        Title = "Spawn: "..vehicleName,
        Callback = function()
            if VehicleSpawn then
                VehicleSpawn:FireServer(vehicleName, AvaRoot, {})
                lib:Notification('Spawn Mobil', 'Spawned: ' .. vehicleName, 3)
            else
                lib:Notification('Error', 'Remote Vehicle_Spawn tidak ditemukan!', 3)
            end
        end
    })
end

local ShopTab = main:AddTab("Shop")
local ShopSection = ShopTab:AddSection({Title = "Shovel Shop Teleport", Description = "Teleport to shovel shops", Default = false, Locked = false})

-- 📦 Service
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- 📦 Noclip function
local noclipConn
local function setNoclip(state)
    if state then
        if noclipConn then noclipConn:Disconnect() end
        noclipConn = RunService.Stepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(11) -- noclip
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
    end
end

-- 📦 Teleport dengan noclip
local function tpWithNoclip(x, y, z, name)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        setNoclip(true)
        hrp.CFrame = CFrame.new(x, y, z)
        lib:Notification('Teleport', 'Teleported to '..name, 3)
        task.delay(0.5, function()
            setNoclip(false)
        end)
    end
end

-- 📦 Data teleport
local teleports = {
    {"Bejeweled Shovel", 31.2093, 3.0318, 39.8111},
    {"Training Shovel", 2121.1235, 112.5746, -298.7560},
    {"Toy Shovel", 2119.4553, 113.6495, -298.0141},
    {"Copper Shovel", 15.2426, 61.0899, 4.8759},
    {"Rock Shovel", 2112.3464, 112.6290, -294.7606},
    {"Lucky Shovel", 2111.1553, 113.5927, -294.1081},
    {"Ruby Shovel", 1327.8562, 81.1430, 542.9059},
    {"Bell Shovel", 1329.5909, 83.6888, 541.6209},
    {"Magnet Shovel", 2853.4087, -360.5666, -883.8994},
    {"Jam Shovel", 3522.3616, 84.9355, 1528.2647},
    {"Candlelight Shovel", 17.4070, 3.7727, 146.4270},
    {"Spore Shovel", 3987.8251, 227.6757, -141.8380},
    {"Slayers Shovel", 2516.5246, 89.4888, 1301.1907},
    {"Arachnid Shovel", -822.2592, 17.3944, 1260.7221},
    {"Shortcake Shovel", 484.3059, 5.5491, -284.0187},
    {"Rock Splitter", 134.4634, 5.6453, -45.0966},
    {"Archaic Shovel", -6108.1030, 119.4773, -1907.2861},
    {"Frigid Shovel", 6523.1782, 2612.3432, -2949.0361},
    {"Venomous Shovel", 16.9659, 5.5344, 32.9641},
    {"Gold Digger", 62.6586, 5.3908, 51.6359},
    {"Obsidian Shovel", -8022.6240, 342.8148, -1791.4763},
    {"Prismatic Shovel", 5131.5590, 1113.0532, -2105.3071},
    {"Beast Slayer", 128.5010, 7.1945, 19.1139},
    {"Solstice Shovel", 5567.9575, -394.3601, -1912.5024},
    {"Glinted Shovel", -6177.6743, 1630.6092, -1842.7865},
    {"Draconic Shovel", -8571.2793, 391.2796, -2133.6345},
    {"Starline Shovel", -2.5368, -68.4143, 1.2173}
}

-- 📦 Tombol-tombol teleport
local TeleportGroupButtons = ShopSection:AddGroupButton()

for _, data in ipairs(teleports) do
    TeleportGroupButtons:AddButton({
        Title = "Teleport To "..data[1],
        Callback = function()
            tpWithNoclip(data[2], data[3], data[4], data[1])
        end
    })
end

local MerchantSection = ShopTab:AddSection({Title = "Traveling Merchant", Description = "Teleport to merchant", Default = false, Locked = false})

MerchantSection:AddButton({
   Title = "Teleport to Traveling Merchant",
   Callback = function()
      -- 🧭 Teleport to Traveling Merchant
      local player = game:GetService("Players").LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

      local merchant = workspace:FindFirstChild("World")
      if merchant then
          merchant = merchant:FindFirstChild("NPCs")
      end
      if merchant then
          merchant = merchant:FindFirstChild("Merchant Cart")
      end
      if merchant then
          merchant = merchant:FindFirstChild("Traveling Merchant")
      end

      if merchant and merchant:FindFirstChild("HumanoidRootPart") then
          humanoidRootPart.CFrame = merchant.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
          warn("✅ Teleported to Traveling Merchant!")
      else
          warn("❌ Traveling Merchant not found.")
      end
   end,
})

local MiscTab = main:AddTab("Misc/Player")
local AntiStaffSection = MiscTab:AddSection({Title = "Anti Staff", Description = "Staff detection and actions", Default = false, Locked = false})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🔷 Daftar UserId staff yang ingin diawasi
local staffList = {
    129332660, -- contoh staff
    146089324, -- tambah id lain
    556677889  -- dst
}

local notifyStaffEnabled = true
local staffAction = "Notify" -- default

-- 🔷 Fungsi untuk cek apakah player yang join adalah staff
local function handleStaff(player)
    if not notifyStaffEnabled then return end

    for _, id in ipairs(staffList) do
        if player.UserId == id then
            if staffAction == "Notify" then
                lib:Notification('⚠️ Staff Masuk Server', player.Name .. " (ID: " .. id .. ") terdeteksi sebagai staff.", 6)
            elseif staffAction == "Kick" then
                LocalPlayer:Kick("Staff terdeteksi di server: " .. player.Name)
            end
            break
        end
    end
end

-- 🔷 Toggle 3itx
AntiStaffSection:AddToggle("DeteksiStaff", {
    Title = "Anti Staff",
    Default = true, -- ✅ auto ON
    Description = "Detect staff joining server",
    Callback = function(Value)
        notifyStaffEnabled = Value

        if Value then
            -- cek semua player yang sudah ada di server
            for _, p in ipairs(Players:GetPlayers()) do
                handleStaff(p)
            end
        end
    end,
})

-- 🔷 Choose Staff Method
AntiStaffSection:AddDropdown("ChooseStaff", {
    Title = "Choose Staff Method",
    Description = "Select what to do when staff is detected",
    Options = {"Notify", "Kick"},
    Default = "Notify",
    PlaceHolder = "Select Method",
    Multiple = false,
    Callback = function(Option)
        staffAction = Option
    end,
})

-- 🔷 Listen untuk player baru
Players.PlayerAdded:Connect(handleStaff)

-- ✅ Panggil sekali supaya toggle langsung jalan tanpa tunggu klik
for _, p in ipairs(Players:GetPlayers()) do
    handleStaff(p)
end

local SettingSection = MiscTab:AddSection({Title = "Setting", Description = "General settings", Default = false, Locked = false})

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local godModeEnabled = false

local function setGodMode(enable)
    if enable then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    else
        Humanoid.MaxHealth = 100
        Humanoid.Health = 100
    end
end

-- selalu monitor Health & Died
Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    if godModeEnabled and Humanoid.Health < math.huge then
        Humanoid.Health = math.huge
    end
end)

Humanoid.Died:Connect(function()
    if godModeEnabled then
        task.wait(1)
        LocalPlayer:LoadCharacter()
    end
end)

-- saat respawn ganti Humanoid saja
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")

    if godModeEnabled then
        setGodMode(true)

        Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if godModeEnabled and Humanoid.Health < math.huge then
                Humanoid.Health = math.huge
            end
        end)

        Humanoid.Died:Connect(function()
            if godModeEnabled then
                task.wait(1)
                LocalPlayer:LoadCharacter()
            end
        end)
    end
end)

SettingSection:AddToggle("GodMode", {
    Title = "God Mode",
    Default = false,
    Description = "Enable god mode",
    Callback = function(state)
        godModeEnabled = state

        if state then
            setGodMode(true)
            lib:Notification('God Mode', 'God Mode Aktif', 3)
        else
            setGodMode(false)
            lib:Notification('God Mode', 'God Mode Nonaktif', 3)
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- update character kalau respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
end)

local noclipEnabled = false

SettingSection:AddToggle("Noclip", {
    Title = "Noclip",
    Default = false,
    Description = "Enable noclip",
    Callback = function(state)
        noclipEnabled = state

        if state then
            lib:Notification('Noclip', 'Noclip Diaktifkan.', 3)
        else
            lib:Notification('Noclip', 'Noclip Dimatikan.', 3)
            -- pastikan balik normal
            if Character then
                for _, part in ipairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

-- jalankan setiap frame
RunService.Stepped:Connect(function()
    if noclipEnabled and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
end)

getgenv().WalkSpeedEnabled = false
getgenv().JumpPowerEnabled = false

local walkSpeedValue = 16
local jumpPowerValue = 50

-- WalkSpeed Toggle
SettingSection:AddToggle("WalkSpeed", {
    Title = "WalkSpeed",
    Default = false,
    Description = "Enable custom walk speed",
    Callback = function(Value)
        getgenv().WalkSpeedEnabled = Value
    end,
})

-- WalkSpeed Slider
SettingSection:AddSlider("WalkSpeedValue", {
    Title = "WalkSpeed Value",
    Default = 16,
    Min = 16,
    Max = 200,
    Increment = 1,
    Callback = function(Value)
        walkSpeedValue = Value
    end,
})

-- JumpPower Toggle
SettingSection:AddToggle("JumpPower", {
    Title = "JumpPower",
    Default = false,
    Description = "Enable custom jump power",
    Callback = function(Value)
        getgenv().JumpPowerEnabled = Value
    end,
})

-- JumpPower Slider
SettingSection:AddSlider("JumpPowerValue", {
    Title = "JumpPower Value",
    Default = 50,
    Min = 50,
    Max = 200,
    Increment = 1,
    Callback = function(Value)
        jumpPowerValue = Value
    end,
})

-- Loop yang lebih kuat
RunService.RenderStepped:Connect(function()
    if not Character or not Humanoid or Humanoid.Parent ~= Character then
        Character = LocalPlayer.Character
        if Character then
            Humanoid = Character:FindFirstChildOfClass("Humanoid")
        end
    end

    if Humanoid then
        if getgenv().WalkSpeedEnabled then
            Humanoid.WalkSpeed = walkSpeedValue
        else
            Humanoid.WalkSpeed = 16
        end

        if getgenv().JumpPowerEnabled then
            Humanoid.JumpPower = jumpPowerValue
        else
            Humanoid.JumpPower = 50
        end
    end
end)

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

SettingSection:AddButton({
    Title = "Boost FPS",
    Callback = function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        Lighting.Brightness = 1

        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 0.5
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end

        lib:Notification('Boost FPS', 'Boost FPS diaktifkan.', 3)
    end
})

local InventoryTab = main:AddTab("Inventory")
local SellSection = InventoryTab:AddSection({Title = "Sell", Description = "Auto sell items", Default = false, Locked = false})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocky = workspace:WaitForChild("World"):WaitForChild("NPCs"):WaitForChild("Rocky")
local SellAllItems = ReplicatedStorage:WaitForChild("DialogueRemotes"):WaitForChild("SellAllItems")

getgenv().autoSell = false
getgenv().sellDelay = 3 -- default 3 detik

-- Toggle Auto Sell
SellSection:AddToggle("AutoSell", {
   Title = "Auto Sell",
   Default = false,
   Description = "Enable auto sell items",
   Callback = function(Value)
      getgenv().autoSell = Value
   end,
})

-- Slider untuk atur delay
SellSection:AddSlider("AutoSellDelay", {
   Title = "Auto Sell Delay (detik)",
   Default = 3,
   Min = 1,
   Max = 60,
   Increment = 1,
   Callback = function(Value)
      getgenv().sellDelay = Value
   end,
})

-- Loop Auto Sell
task.spawn(function()
        while task.wait(1) do
                if getgenv().autoSell then
                        SellAllItems:FireServer(Rocky)
                        task.wait(getgenv().sellDelay)
                end
        end
end)

local MagnetTab = main:AddTab("Magnets")
local MagnetSection = MagnetTab:AddSection({Title = "Equip Magnets", Description = "Equip different magnets", Default = false, Locked = false})

local player = game.Players.LocalPlayer
local playerName = player.Name

local rs = game:GetService("ReplicatedStorage")
local remotes = rs:WaitForChild("Remotes")

-- Fungsi equip magnet
local function equipMagnet(magnetName)
    local magnet = rs:WaitForChild("PlayerStats")
        :WaitForChild(playerName)
        :WaitForChild("Inventory")
        :WaitForChild("Magnets")
        :FindFirstChild(magnetName)

    if magnet then
        remotes:WaitForChild("Magnet_Equip"):FireServer(magnet)
    end
end

-- Tambahkan tombol-tombol ke Tab yang sudah ada
local MagnetButtons = MagnetSection:AddGroupButton()

MagnetButtons:AddButton({Title = "Prismatic Magnet", Callback = function() equipMagnet("Prismatic Magnet") end})
MagnetButtons:AddButton({Title = "Crimsonsteel Magnet", Callback = function() equipMagnet("Crimsonsteel Magnet") end})
MagnetButtons:AddButton({Title = "Magic Magnet", Callback = function() equipMagnet("Magic Magnet") end})
MagnetButtons:AddButton({Title = "Golden Horseshoe", Callback = function() equipMagnet("Golden Horseshoe") end})
MagnetButtons:AddButton({Title = "Legendary Magnet", Callback = function() equipMagnet("Legendary Magnet") end})
MagnetButtons:AddButton({Title = "Fossil Brush", Callback = function() equipMagnet("Fossil Brush") end})
MagnetButtons:AddButton({Title = "Fortuned Magnet", Callback = function() equipMagnet("Fortuned Magnet") end})
MagnetButtons:AddButton({Title = "Brass Magnet", Callback = function() equipMagnet("Brass Magnet") end})
MagnetButtons:AddButton({Title = "Ghost Magnet", Callback = function() equipMagnet("Ghost Magnet") end})
MagnetButtons:AddButton({Title = "Odd Mushroom", Callback = function() equipMagnet("Odd Mushroom") end})
MagnetButtons:AddButton({Title = "Green Magnet", Callback = function() equipMagnet("Green Magnet") end})
MagnetButtons:AddButton({Title = "Light Bulb", Callback = function() equipMagnet("Light Bulb") end})
MagnetButtons:AddButton({Title = "Red Magnet", Callback = function() equipMagnet("Red Magnet") end})
MagnetButtons:AddButton({Title = "Basic Magnet", Callback = function() equipMagnet("Basic Magnet") end})

local TeleportTab = main:AddTab("Teleport Bosses")
local BossSection = TeleportTab:AddSection({Title = "Boss", Description = "Teleport to boss locations", Default = false, Locked = false})

local BossButtons = BossSection:AddGroupButton()

BossButtons:AddButton({
    Title = "Teleport to King Crab",
    Callback = function()
        -- 🦀 Teleport ke King Crab
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- path fix: Workspace.Spawns.BossSpawns.King Crab
        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("King Crab")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to King Crab!")
        else
            warn("❌ King Crab not found.")
        end
    end,
})

BossButtons:AddButton({
   Title = "Teleport to Candlelight Phantom",
   Callback = function()
      -- 🧭 Teleport to Candlelight Phantom
      local player = game:GetService("Players").LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

      local boss

      -- Cari boss di seluruh Workspace
      for _, obj in ipairs(workspace:GetDescendants()) do
         if obj:IsA("Model") and obj.Name == "Candlelight Phantom" and obj:FindFirstChild("HumanoidRootPart") then
            boss = obj
            break
         end
      end

      if boss then
         humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
         warn("✅ Teleported to Candlelight Phantom!")
      else
         warn("❌ Candlelight Phantom not found.")
      end
   end,
})

BossButtons:AddButton({
    Title = "Teleport to Molten Monstrosity",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            hrp.CFrame = CFrame.new(
                -8797.094, 434.878, -1919.448,
                1, 0, 0,
                0, 1, 0,
                0, 0, 1
            )
        end
    end
})

BossButtons:AddButton({
    Title = "Teleport to Basilisk",
    Callback = function()
        -- 🐍 Teleport ke Basilisk
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- path fix: Workspace.Spawns.BossSpawns.Basilisk
        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Basilisk")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Basilisk!")
        else
            warn("❌ Basilisk not found.")
        end
    end,
})

BossButtons:AddButton({
    Title = "Teleport to Dire Wolf",
    Callback = function()
        -- 🐺 Teleport ke Dire Wolf
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- path fix: Workspace.Spawns.BossSpawns.Dire Wolf
        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Dire Wolf")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Dire Wolf!")
        else
            warn("❌ Dire Wolf not found.")
        end
    end,
})

BossButtons:AddButton({
    Title = "Teleport to Fuzzball",
    Callback = function()
        -- 🟢 Teleport ke Fuzzball
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Fuzzball")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Fuzzball!")
        else
            warn("❌ Fuzzball not found.")
        end
    end,
})

BossButtons:AddButton({
    Title = "Teleport to Giant Spider",
    Callback = function()
        -- 🕷️ Teleport ke Giant Spider
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Giant Spider")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Giant Spider!")
        else
            warn("❌ Giant Spider not found.")
        end
    end,
})

local NpcTab = main:AddTab("Teleport Npc")
local NpcSection = NpcTab:AddSection({Title = "Npc", Description = "Teleport to NPCs", Default = false, Locked = false})

local player = game.Players.LocalPlayer
local npcsFolder = workspace:WaitForChild("World"):WaitForChild("NPCs")

-- Fungsi teleport
local function teleportToNPC(npcName)
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    for _, npc in ipairs(npcsFolder:GetDescendants()) do
        if npc:IsA("Model") and npc.Name:lower():match(npcName:lower()) then
            local targetPart = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
            if targetPart then
                hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
            end
            break
        end
    end
end

-- Daftar semua NPC
local npcNames = {
    "Sydney", "Roger Star", "Ava Carter", "Berry Dust", "Cole Blood", "Cave Worker", "Carly Enzo", "Malcom Wheels",
    "Annie Rae", "Magnus", "Mushroom Azali", "Penguin Mechanic", "Banker", "Gary Bull", "Tribes Mate", "Discoshroom",
    "John", "Mark Lever", "Max", "Ethan Bands", "Jane", "Blueshroom", "Brooke Kali", "Smith", "Dani Snow", "Grant Thorn",
    "Will", "Stranded Steve", "Drawstick Liz", "Ferry Conductor", "Steve Levi", "Sam Colby", "Mushroom Researcher",
    "Tom Baker", "Penguin Customer", "Pete R.", "Arthur Dig", "Granny Glenda", "Collin", "Cindy", "Jenn Diamond",
    "Tribe Leader", "Mourning Family Member", "Young Guitarist", "Bu Ran", "Billy Joe", "Andy", "Soten Ran", "Mrs.Salty",
    "Merchant Cart.Traveling Merchant", "Rocky", "Nate", "Blueshroom Merchant", "Barry", "Kira Pale", "Kei Ran", "Hale",
    "Darren", "Jim Diamond", "Ben Bones.Ben Bones", "Andrew", "Old Blueshroom", "Jie Ran", "Silver", "O'Myers", "Erin Field",
    "Pizza Penguin", "Lexi Star", "Ninja Deciple", "Mrs.Tiki", "Purple Imp", "Albert"
}

-- Buat tombol per NPC (masing-masing sendiri)
local NPCButtons = NpcSection:AddGroupButton()
for _, npcName in ipairs(npcNames) do
    NPCButtons:AddButton({
        Title = "Teleport To NPC "..npcName,
        Callback = function()
            teleportToNPC(npcName)
        end
    })
end

local IslandTab = main:AddTab("Teleport Island")
local IslandSection = IslandTab:AddSection({Title = "Island", Description = "Teleport to islands", Default = false, Locked = false})

local IslandButtons = IslandSection:AddGroupButton()

IslandButtons:AddButton({
    Title = "Teleport to Fox Town",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- Posisi Fox Town
            hrp.CFrame = CFrame.new(2073.82324, 121.487457, -378.836548)
        end
    end
})

IslandButtons:AddButton({
    Title = "Teleport to Verdant Vale",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- CFrame Verdant Vale (posisi + rotasi)
            hrp.CFrame = CFrame.new(
                3548.83154, 82.0540695, 1330.61133,
                0.0363482684, 3.42970523e-08, 0.999339163,
                4.76747836e-16, 1, -3.43197293e-08,
                -0.999339163, 1.24746324e-09, 0.0363482684
            )
        end
    end
})

IslandButtons:AddButton({
    Title = "Teleport to Mount Cinder",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- CFrame Mount Cinder (posisi + rotasi)
            hrp.CFrame = CFrame.new(
                4576.03955, 1101.71594, -1708.38879,
                -0.978816926, -5.98474876e-08, 0.20473747,
                -5.36289306e-08, 1, 3.59220316e-08,
                -0.20473747, 2.41812401e-08, -0.978816926
            )
        end
    end
})

IslandButtons:AddButton({
    Title = "Teleport to Rooftop Woodlands",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- CFrame Rooftop Woodlands (posisi + rotasi)
            hrp.CFrame = CFrame.new(
                3895.53564, 225.724136, 375.536469,
                -0.352712542, -8.26963955e-08, -0.935731709,
                -6.85288555e-08, 1, -6.25450696e-08,
                0.935731709, 4.20641939e-08, -0.352712542
            )
        end
    end
})

-- Boss notification system

local bossesFolder = workspace.World:WaitForChild("NPCs")

local bossesToWatch = {
    ["Molten Monstrosity"] = true,
    ["A King Crab"] = true,
    ["Fuzzball"] = true,
    ["Candlelight Phantom"] = true,
    ["Giant Spider"] = true,
    ["Basilisk"] = true,
}

local function notifyBoss(name)
    lib:Notification('Boss Spawned!', name .. ' has spawned!', 5)
end

-- cek boss yang sudah ada saat join
for _,v in ipairs(bossesFolder:GetChildren()) do
    if bossesToWatch[v.Name] then
        notifyBoss(v.Name)
    end
end

-- pantau boss baru yang spawn
bossesFolder.ChildAdded:Connect(function(child)
    if bossesToWatch[child.Name] then
        notifyBoss(child.Name)
    end
end)

-- ✅ Anti Auto-Purchase System for Meteor Shower
local AntiPurchaseTab = main:AddTab("Anti Auto-Purchase")
local ProtectionSection = AntiPurchaseTab:AddSection({Title = "Protection", Description = "Prevent unwanted purchases", Default = false, Locked = false})

-- Global flag to prevent auto-purchases
getgenv().preventAutoPurchase = true

-- Block automatic dialogue responses that could trigger purchases
local function blockAutoPurchase()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local DialogueRemotes = ReplicatedStorage:FindFirstChild("DialogueRemotes")
    
    if DialogueRemotes then
        local RemoteFunc = DialogueRemotes:FindFirstChild("RemoteFunc")
        if RemoteFunc then
            -- Hook the RemoteFunc to prevent unwanted purchases
            local oldFireServer = RemoteFunc.FireServer
            RemoteFunc.FireServer = function(self, ...)
                local args = {...}
                
                -- Block meteor shower purchases if auto-purchase is disabled
                if getgenv().preventAutoPurchase then
                    local argString = tostring(args[1] or "")
                    if argString:lower():find("meteor") or argString:lower():find("shower") then
                        warn("⚠️ Blocked automatic meteor shower purchase!")
                        return
                    end
                end
                
                return oldFireServer(self, ...)
            end
        end
    end
end

-- Toggle for auto-purchase protection
ProtectionSection:AddToggle("BlockAutoPurchase", {
    Title = "Block Auto Meteor Shower Purchase",
    Default = true,
    Description = "Prevent automatic meteor shower purchases",
    Callback = function(Value)
        getgenv().preventAutoPurchase = Value
        if Value then
            blockAutoPurchase()
            lib:Notification('Protection Enabled', 'Automatic meteor shower purchases are now blocked', 3)
        else
            lib:Notification('Protection Disabled', 'Automatic meteor shower purchases are now allowed', 3)
        end
    end,
})

-- Manual meteor shower purchase button (for when users actually want it)
ProtectionSection:AddButton({
    Title = "Manual Meteor Shower Purchase",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local DialogueRemotes = ReplicatedStorage:FindFirstChild("DialogueRemotes")
        
        if DialogueRemotes then
            local RemoteFunc = DialogueRemotes:FindFirstChild("RemoteFunc")
            if RemoteFunc then
                -- Temporarily disable protection for manual purchase
                local oldProtection = getgenv().preventAutoPurchase
                getgenv().preventAutoPurchase = false
                
                -- Attempt manual purchase (you'll need to adjust this based on the actual purchase method)
                pcall(function()
                    RemoteFunc:FireServer("meteor_shower") -- Adjust this parameter as needed
                end)
                
                -- Restore protection
                getgenv().preventAutoPurchase = oldProtection
                
                lib:Notification('Manual Purchase', 'Attempted manual meteor shower purchase', 3)
            end
        end
    end,
})

-- Initialize the protection on script load
blockAutoPurchase()

-- ✅ Config Tab for 3itx UI
local ConfigTab = main:AddTab("Config")
FlagsManager:SetLibrary(lib)
FlagsManager:SetIgnoreIndexes({})
FlagsManager:SetFolder("Config/DigGame")
FlagsManager:InitSaveSystem(ConfigTab)

-- ✅ Final success notification
lib:Notification('zzz Hub Loaded', 'Dig to Earth\'s Core script loaded successfully!', 5)
