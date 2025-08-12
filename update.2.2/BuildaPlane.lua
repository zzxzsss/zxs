-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/ui/dummyui"))()

local name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local supportedVersion = "v1.5.2"
local supportedVersionp = 1399
local scriptversion = "2.2"

-- Create Main Window
local Window = Library:Window({
    Title = "zzz hub - ".. name .. " " .. scriptversion,
    Desc = "by ktro",
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

local function modal(title, description, call)
    Window:Notify({
        Title = title,
        Desc = description,
        Time = 5
    })
    if call then
        task.spawn(call)
    end
end

if isfile and readfile and listfiles and writefile and makefolder then
    if not isfolder("CandyHub\\Builds") then
        makefolder("CandyHub\\Builds")
    end
else
    print("filing system unsupported")
end

if not _G.candyhub then _G.candyhub = {
    autofarm = false,
    moon = false,
    x = 17000,
    y = 160,
    endpos = 100000,
    allitems = true,
    maxfps = 0,
    mode = "SuperFast",
    autotake = true,
    items = {
        propeller_2 = false,
        shield = false,
        fuel_1 = false,
        block_1 = false,
        wing_1 = false,
        missile_1 = false,
        tail_1 = false,
        tail_2 = false,
        fuel_3 = false,
        boost_1 = false,
        fuel_2 = false,
        balloon = false,
        seat_1 = false,
        wing_2 = false,
        propeller_1 = false,
    },
    custom = {
        fuel = {
            enabled = false,
            amount = 45
        },
        propeller = {
            enabled = false,
            amount = 5000,
            customfuel = false,
            fueluse = 0,
        },
        wing = {
            enabled = false,
            amount = 36,
        },
        rocket = {
            enabled = false,
            amount = 6,
        }, 
        missile = {
            enabled = false
        }, 
        shield = {
            enabled = false
        }
    },
    distance = 100000,
    autobuy = false,
    lags = false,
    gm = false,
    nofall = false,
    posy = 60,
    abs = false,
    afk = false,
    fillscreen = false,
    fpschanger = false,
}end

local autofarming = false
local automooning = false

local abs = function(num)
    if num ~= 0 then
        return -num
    end
    return num
end

local function getplot()
    local plots = workspace.Islands
    for i, plot in plots:GetChildren() do
        if plot.Important.OwnerID.Value == game.Players.LocalPlayer.UserId then
            return plot
        end
    end
end

local plot = getplot()
repeat task.wait(0.1) until plot:FindFirstChild("SpawnPart")
local spawnpart = plot:FindFirstChild("SpawnPart")
local spawnpartpos = spawnpart.Position
local spawnpartcfr = spawnpart.CFrame

local function getitems()
    local items = {}
    for i, item in game:GetService("Players").LocalPlayer.PlayerGui.Main.BlockShop.Shop.Container.ScrollingFrame:GetChildren() do
        if item.Name ~= "ExtraScrollPadding" and item.Name ~= "TemplateFrame" and item.ClassName == "Frame" then
            table.insert(items, item.Name)
        end
    end
    return items
end

_G.filetarget = ""

local function place(name,x,y,z)
    local args = {
        name,
        {
            target = plot:FindFirstChild("Plot"),
            hitPosition = vector.create(x,y,z),
            targetSurface = Enum.NormalId.Top
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuildingEvents"):WaitForChild("PlaceBlock"):FireServer(unpack(args))
end

local function simulatetable()
    local zip = {}
    for i, item in plot:FindFirstChild("PlacedBlocks"):GetChildren() do
        table.insert(zip, 
            {
                item.Name,
                {
                    item.PrimaryPart.Position.X,
                    item.PrimaryPart.Position.Y,
                    item.PrimaryPart.Position.Z
                }
            }
        )
    end
    return zip
end

local function simulatetable2()
    local zip = {}
    for i, item in plot:FindFirstChild("PlacedBlocks"):GetChildren() do
        local plotn = plot.Name:gsub("Island","")
        local ploti = tonumber(plotn)-1

        local x,y,z = item.PrimaryPart.Position.X,item.PrimaryPart.Position.Y,item.PrimaryPart.Position.Z
        z = z + (85*ploti)

        table.insert(zip, 
            {
                item.Name,
                {
                    x,
                    y,
                    z
                }
            }
        )
    end
    return zip
end

local function readbuild(name)
    local fixedname = name:gsub("CandyHub\\Builds","")
    fixedname = fixedname:gsub("Candyhub/Builds","")
    fixedname = fixedname:gsub("/","")
    fixedname = fixedname:gsub("CandyHubBuilds", "")
    fixedname = fixedname:gsub(".json","")

    local path = "CandyHub\\Builds\\"..fixedname..".json"
    return readfile(path)
end

local function decode(table)
    if type(table) == "table" then return table else
        return game:GetService("HttpService"):JSONDecode(table)
    end
end

local function encode(table)
    if type(table) == "string" then return table else
        return game:GetService("HttpService"):JSONEncode(table)
    end
end

local function save(name,table)
    local path = "CandyHub\\Builds\\"..name..".json"
    writefile(path,encode(table))
end

local function load(name)
    local path = "CandyHub\\Builds\\"..name..".json"
    if isfile(path) then
        return decode(readfile(path))
    else
        return nil
    end
end

local function takeall()
    for _, it in plot.PlacedBlocks:GetChildren() do
        local i = it.PrimaryPart
        local args = {
            {
                target = i,
                hitPosition = vector.create(i.CFrame.p.X, i.CFrame.p.Y, i.CFrame.p.Z),
                targetSurface = Enum.NormalId.Left
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuildingEvents"):WaitForChild("GrabBlock"):FireServer(unpack(args))
    end
end

local function getblocks(zip)
    local blocks = {}
    for _, res in ipairs(zip) do
        local name = res[1]
        blocks[name] = blocks[name] or {}
        table.insert(blocks[name], res)
    end
    return blocks
end

local function hasresources(zip)
    local blocks = getblocks(zip)
    for name, blockList in pairs(blocks) do
        local inventoryItem = game.Players.LocalPlayer.Important.Inventory:FindFirstChild(name)
        if not inventoryItem or inventoryItem.Value < #blockList then
            return false
        end
    end
    return true
end

local function loaddecoded(decoded)
    for i, item in decoded do
        task.spawn(function()
            local plotn = plot.Name:gsub("Island","")
            local ploti = tonumber(plotn)-1
            local itemname = item[1]
            local x = item[2][1]
            local y = item[2][2]
            local z = item[2][3] - (85*ploti)
            place(itemname,x,y,z)
        end)
    end
end

local function savecfg()
    local name = "Config"
    local fixedname = name:gsub("CandyHub","")
    fixedname = fixedname:gsub("Candyhub/Builds","")
    fixedname = fixedname:gsub("/","")
    fixedname = fixedname:gsub("\\","")
    fixedname = fixedname:gsub("CandyHub/", "")
    fixedname = fixedname:gsub(".json","")
    local path = fixedname..".json"
    writefile(path,encode(_G.candyhub))
end

local function loadcfg()
    local name = "Config"
    local fixedname = name:gsub("CandyHub","")
    fixedname = fixedname:gsub("Candyhub/Builds","")
    fixedname = fixedname:gsub("/","")
    fixedname = fixedname:gsub("\\","")
    fixedname = fixedname:gsub("CandyHub/", "")
    fixedname = fixedname:gsub(".json","")
    if isfile(name) then
        _G.candyhub = decode(readfile(name))
    end
end

loadcfg()

local function getseat(blocks)
    local x = nil
    for i, item in blocks:GetChildren() do
        if string.find(item.Name, "driver_seat") then x = item end
    end
    return x
end

local function alive()
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
                return true
            end
        end 
    end
    return false
end

local function char()
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
                return game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            end
        end 
    end
    return nil
end

local function plane()
    local x = (plot.PlacedBlocks:FindFirstChild("driver_seat_1") or plot.PlacedBlocks:FindFirstChild("driver_seat_2") or plot.PlacedBlocks:FindFirstChild("driver_seat_3") or plot.PlacedBlocks:FindFirstChild("driver_seat_4")) or nil
    if x == nil then 
        return false
    elseif x:FindFirstChild("Hitbox") and x:FindFirstChildOfClass("VehicleSeat") then
        if x:FindFirstChildOfClass("VehicleSeat"):FindFirstChild("BodyGyro") then
            return true
        end
    end
    return false
end

local function getoffseat()
    local seat = seat or getseat(plot.PlacedBlocks)
    if seat and seat:FindFirstChildOfClass("VehicleSeat") then
        if seat:FindFirstChildOfClass("VehicleSeat").Occupant ~= nil then
            seat:FindFirstChildOfClass("VehicleSeat").Disabled = true
            seat:FindFirstChildOfClass("VehicleSeat").Disabled = false
        end
    end
end

-- Create Tabs
local Main = Window:Tab({Title = "Main", Icon = "star"})
local BuildTab = Window:Tab({Title = "Build", Icon = "hammer"})
local EventsTab = Window:Tab({Title = "Events", Icon = "calendar"})
local MiscTab = Window:Tab({Title = "Misc", Icon = "settings"})
local InfoTab = Window:Tab({Title = "Info", Icon = "info"})

-- Main Tab
Main:Section({Title = "Main Features"})

local my1, my2
local statsVisible = false

Main:Toggle({
    Title = "Auto Fly (Default Map)",
    Value = _G.candyhub.autofarm,
    Callback = function(v)
        task.spawn(function()
            _G.candyhub.autofarm = v
            savecfg()

            if _G.candyhub.autofarm then
                local money = game:GetService("Players").LocalPlayer.leaderstats.Cash.Value
                local runnin = math.floor(tick())

                if not statsVisible then
                    Main:Section({Title = "Stats"})
                    my1 = Main:Label({Text = "Money Earned: 0"})
                    my2 = Main:Label({Text = "Time: 0h 0m 0s"})
                    statsVisible = true
                end

                task.spawn(function()
                    while _G.candyhub.autofarm and task.wait(0.1) do
                        if ((not game:GetService("ReplicatedStorage").ActiveEvents.BloodMoonActive.Value and _G.candyhub.moon) or not _G.candyhub.moon) then
                            if my1 then my1:SetText("Money Earned: " .. tostring(abs(money-game:GetService("Players").LocalPlayer.leaderstats.Cash.Value))) end
                            if my2 then my2:SetText("Time: " .. tostring(math.floor((math.floor(tick())-runnin)/3600)) .. "h " .. tostring(math.floor(((math.floor(tick())-runnin)%3600)/60)) .. "m " .. tostring(math.floor((math.floor(tick())-runnin)%60)) .. "s") end
                        end
                    end
                end)
            end

            while _G.candyhub.autofarm and task.wait(.1) do
                if ((not game:GetService("ReplicatedStorage").ActiveEvents.BloodMoonActive.Value and _G.candyhub.moon) or not _G.candyhub.moon) then
                    repeat task.wait(0.1) until not automooning
                    autofarming = true

                    local aplane = plot.PlacedBlocks
                    local driver = (aplane:FindFirstChild("driver_seat_1") or aplane:FindFirstChild("driver_seat_2") or aplane:FindFirstChild("driver_seat_3"))
                    local launched = plot.Important.Launched
                    local x,z = spawnpartpos.X, spawnpartpos.Z

                    if not alive() then
                        repeat task.wait(0.1) until alive()
                    end

                    if driver == nil then
                        repeat
                            task.wait(1) 
                        until (aplane:FindFirstChild("driver_seat_1") or aplane:FindFirstChild("driver_seat_2") or aplane:FindFirstChild("driver_seat_3")) ~= nil or not _G.candyhub.autofarm
                        driver = (aplane:FindFirstChild("driver_seat_1") or aplane:FindFirstChild("driver_seat_2") or aplane:FindFirstChild("driver_seat_3"))
                    end

                    if not driver:FindFirstChild("Hitbox") then
                        repeat task.wait(0.05) until driver:FindFirstChild("Hitbox") or not _G.candyhub.autofarm
                    end

                    repeat 
                        if not launched.Value and alive() then
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("LaunchEvents"):WaitForChild("Launch"):FireServer()
                        end 
                        task.wait(1)
                    until launched.Value or not _G.candyhub.autofarm

                    task.wait(0.35)
                    local abc = true

                    while launched.Value and _G.candyhub.autofarm and (plane() and alive()) and abc and ((not game:GetService("ReplicatedStorage").ActiveEvents.BloodMoonActive.Value and _G.candyhub.moon) or not _G.candyhub.moon) do
                        if plane() and alive() then
                            local target = driver:FindFirstChild("Hitbox") or game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            target.CFrame = CFrame.new(
                                Vector3.new(
                                    target.Position.X + (_G.candyhub.x / 100),
                                    _G.candyhub.y,
                                    z
                                ),
                                Vector3.new(
                                    target.Position.X + ((_G.candyhub.x + 10) / 100),
                                    _G.candyhub.y,
                                    z
                                )
                            )

                            if (target.Position.X >= _G.candyhub.endpos) then
                                abc = false
                                autofarming = false
                            end
                        end
                        task.wait(0.001)
                    end
                    autofarming = false
                    task.wait(1)
                    repeat task.wait(0.1) game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("LaunchEvents"):WaitForChild("Return"):FireServer() until not alive() or not launched.Value
                    task.wait(0.01)
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "GodMode",
    Value = _G.candyhub.gm,
    Callback = function(v)
        task.spawn(function()
            _G.candyhub.gm = v
            savecfg()

            while _G.candyhub.gm and task.wait(.4) do
                for i, item in plot:FindFirstChild("PlacedBlocks"):GetDescendants() do
                    if item.ClassName == "Part" or item.ClassName == "MeshPart" and (item.Parent.Name ~= "driver_seat_1" and item.Name ~= "Part") then
                        if item.CanTouch then
                            item.CanTouch = false
                        end
                    end
                end
            end
            for i, item in plot:FindFirstChild("PlacedBlocks"):GetDescendants() do
                if item.ClassName == "Part" or item.ClassName == "MeshPart" and (item.Parent.Name ~= "driver_seat_1" and item.Name ~= "Part") then
                    item.CanTouch = true
                end
            end
        end)
    end
})

Main:Slider({
    Title = "Y Position",
    Min = -50,
    Max = 500,
    Value = _G.candyhub.y,
    Callback = function(v)
        _G.candyhub.y = v
        savecfg()
    end
})

Main:Slider({
    Title = "Speed Multiplier",
    Min = 0,
    Max = 20000,
    Value = _G.candyhub.x,
    Callback = function(v)
        _G.candyhub.x = v
        savecfg()
    end
})

Main:Textbox({
    Title = "Distance To End",
    Value = tostring(_G.candyhub.endpos),
    Placeholder = "Enter distance",
    Callback = function(text)
        local num = tonumber(text)
        if num then
            _G.candyhub.endpos = num
            savecfg()
        end
    end
})

-- Auto Buy Section
Main:Section({Title = "Auto Buy System"})

Main:Toggle({
    Title = "Auto Buy Items",
    Value = _G.candyhub.autobuy,
    Callback = function(v)
        _G.candyhub.autobuy = v
        savecfg()

        while _G.candyhub.autobuy and task.wait(0.1) do
            if _G.candyhub.allitems then
                local items = getitems()
                for i, item in ipairs(items) do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ShopEvents"):WaitForChild("BuyBlock"):FireServer(item)
                end
            else
                for i, item in _G.candyhub.items do
                    if item then
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ShopEvents"):WaitForChild("BuyBlock"):FireServer(i)
                    end
                end
            end
        end
    end
})

Main:Toggle({
    Title = "Buy All Blocks",
    Value = _G.candyhub.allitems,
    Callback = function(v)
        _G.candyhub.allitems = v
        savecfg()
    end
})

-- Events Tab
EventsTab:Section({Title = "Event Features"})

EventsTab:Toggle({
    Title = "OP FARMER (Use Before Patched)",
    Value = _G.candyhub.superfarmer or false,
    Callback = function(v)
        _G.candyhub.superfarmer = v
        savecfg()
        game:GetService("CoreGui").PurchasePromptApp.Enabled = not _G.candyhub.superfarmer

        if _G.candyhub.superfarmer then
            for i = 1, 300 do
                task.spawn(function() 
                    while _G.candyhub.superfarmer and task.wait() do
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EventEvents"):WaitForChild("SpawnEvilEye"):InvokeServer()
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EventEvents"):WaitForChild("KillEvilEye"):InvokeServer()
                    end
                end)
            end

            for i = 1, 80 do
                task.spawn(function()
                    while _G.candyhub.superfarmer and task.wait() do
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinEvents"):WaitForChild("PurchaseSpin"):InvokeServer()
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinEvents"):WaitForChild("PerformSpin"):InvokeServer()
                    end
                end)
            end
        end
    end
})

EventsTab:Toggle({
    Title = "Auto Buy Spins",
    Value = _G.candyhub.abs,
    Callback = function(v)
        _G.candyhub.abs = v
        savecfg()

        while _G.candyhub.abs and task.wait(0.01) do
            if game:GetService("Players").LocalPlayer.Important.RedMoons.Value >= 10 then
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinEvents"):WaitForChild("PurchaseSpin"):InvokeServer()
            end
        end
    end
})

EventsTab:Toggle({
    Title = "Auto Spin",
    Value = _G.candyhub.abs2,
    Callback = function(v)
        _G.candyhub.abs2 = v
        savecfg()

        while _G.candyhub.abs2 and task.wait(0.01) do
            if game:GetService("Players").LocalPlayer.replicated_data.available_spins.Value >= 1 then
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinEvents"):WaitForChild("PerformSpin"):InvokeServer()
            end
        end
    end
})

-- Misc Tab
MiscTab:Section({Title = "Miscellaneous"})

MiscTab:Toggle({
    Title = "Anti AFK",
    Value = _G.candyhub.afk,
    Callback = function(v)
        _G.candyhub.afk = v
        savecfg()
    end
})

-- Info Tab
InfoTab:Section({Title = "Script Information"})

local serverVersion = game:GetService("Players").LocalPlayer.PlayerGui.Main.ServerVersion.Text
local bb1, bb2, security = 0, 0, ""

if supportedVersionp >= game.PlaceVersion then
    bb1 = 0
    bb2 = 255
    security = "Fully Secure, unlikely to get banned."
elseif supportedVersion == serverVersion then
    bb1 = 200
    bb2 = 200
    security = "Secure, likely to get banned."
else
    bb1 = 255
    bb2 = 0
    security = "Insecure, more likely to get banned."
end

InfoTab:Label({Text = "Made by zzz hub"})
InfoTab:Label({Text = "Supported Version: ".. supportedVersion .." | " .. tostring(supportedVersionp) .. "\nServer/Game Version: " .. serverVersion .. " | " .. tostring(game.PlaceVersion)})
InfoTab:Label({Text = security})

-- Anti-AFK Handler
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if _G.candyhub.afk then
        local vu = game:GetService("VirtualUser")
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)

-- Final Notification
Window:Notify({
    Title = "zzz hub",
    Desc = "BuildaPlane script loaded successfully!",
    Time = 4
})
