-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/ui/dummyui"))()

-- Create Main Window
local Window = Library:Window({
    Title = "zzz hub by ktro",
    Desc = "Auto Farm Hub",
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

_G.candyhub = {
    autofloppa = false,
    tokill = "Floppa",
    questmode = true,
    quest = "Floppa Quest 1",
    autos = true,
    allowbosses = true,
    devtest = true,
    platform = true,
    buyfruitmode = 'Money',
    stats_s = {},
    boss = false,
    weapon = 'Combat',
    memebeast = false,
    autoboss = false,
    tokill_level = 1,
    tokill_bosses = {},
    evilnoob = false,
    amount = 1,
    autoraid = false,
    monsters = {},
    autokillspec = false,
    tokill_monster = 'Red Sus',
}

local function getNil(name,class) 
    return game.Players.LocalPlayer.Character:FindFirstChildOfClass('Tool')
end

local function Press(key)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, key, false, nil)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, key, false, nil)
end

local function click(cd)
    if not game.Players.LocalPlayer.Character:FindFirstChild(_G.candyhub.weapon) then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(_G.candyhub.weapon) then
            game.Players.LocalPlayer.Backpack:FindFirstChild(_G.candyhub.weapon).Parent = game.Players.LocalPlayer.Character
        end
    end
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton1(Vector2.new(10000,10000), game:GetService("Workspace").Camera.CFrame)
end

local function CheckQuest()
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('QuestGui') then
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('QuestGui'):FindFirstChild('Holder') then
            if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('QuestGui'):FindFirstChild('Holder'):FindFirstChild('QuestSlot1') then
                return game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1.Visible
            end
        end
    end
end

local function SureQuest(QuestTarget)
    if game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1.QuestGiver.Text ~= QuestTarget then
        local args = {[1] = "Abandon_Quest",[2] = {["QuestSlot"] = "QuestSlot1"}}
        game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("QuestEvents"):WaitForChild("Quest"):FireServer(unpack(args))
    end
end

local function GetLevel()
    return game:GetService("Players").LocalPlayer.PlayerData.Level.Value
end

local function Lives()
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
            if game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
                if game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health >= 1 then
                    return true
                else
                    return false
                end
            end
        end
    end
end

local function StoreEquippedFruit()
    if Lives() then
        local args = {[1] = "Eatable_Power",[2] = {["Action"] = "Store",["Tool"] = getNil("PowerName", "PowerClassName")}}
        game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules"):FireServer(unpack(args))
    end
end

local function UseAura()
    if Lives() then
        if game.Players.LocalPlayer.Character:FindFirstChild('AuraColor_Folder') then
            if not game.Players.LocalPlayer.Character:FindFirstChild('AuraColor_Folder'):FindFirstChild('LeftHand_AuraColor') then
                game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Ability"):InvokeServer('Aura')
            end
        end
    end
end

local function AreaCheck(level)
    if level >= 2200 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn9') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["MrBeast Island"].CFrame
        end
    elseif level >= 2100 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn9') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["MrBeast Island"].CFrame
        end
    elseif level >= 1900 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn8') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Pvp Arena"].CFrame
        end
    elseif level >= 1700 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn10') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Forgotten Island"].CFrame
        end
    elseif level >= 1450 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn7') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Sus Island"].CFrame
        end
    elseif level >= 1200 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn6') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Moai Island"].CFrame
        end
    elseif level >= 1150 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn7') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Sus Island"].CFrame
        end
    elseif level >= 950 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn5') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Pumpkin Island"].CFrame
        end
    elseif level >= 750 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn4') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Sand Island"].CFrame
        end
    elseif level >= 600 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn3') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Gorilla Island"].CFrame
        end
    elseif level >= 300 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn2') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Snow Island"].CFrame
        end
    elseif level >= 1 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn1') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Floppa Island"].CFrame
        end
    end
end

local function UseQuest(proximity)
    if identifyexecutor() == 'Solara' then
        fireproximityprompt(proximity, 5)
    elseif identifyexecutor() == 'Xeno' then
        fireproximityprompt(proximity, 5)
    else
        local VirtualInputManager = game:GetService("VirtualInputManager")
        VirtualInputManager:SendKeyEvent(true, "E", false, nil)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, "E", false, nil)
    end
end

local function GetQuest(npc)
    local u = 'Floppa Quest '
    if npc == 'Floppa' then
        return u..'1'
    elseif npc == 'Golden Floppa' then
        return u..'2'
    elseif npc == 'Big Floppa' then
        return u..'3'
    elseif npc == 'Doge' then
        return u..'4'
    elseif npc == 'Cheems' then
        return u..'5'
    elseif npc == 'Walter Dog' then
        return u..'6'
    elseif npc == 'Staring Fish' then
        return u..'7'
    elseif npc == 'Hamster' then
        return u..'8'
    elseif npc == 'Snow Tree' then
        return u..'9'
    elseif npc == 'The Rock' then
        return u..'10'
    elseif npc == 'Banana Cat' then
        return u..'11'
    elseif npc == 'Egg Dog' then
        return u..'13'
    elseif npc == 'Sus Face' then
        return u..'12'
    elseif npc == 'Popcat' then
        return u..'14'
    elseif npc == 'Gorilla King' then
        return u..'15'
    elseif npc == 'Smiling Cat' then
        return u..'16'
    elseif npc == 'Killerfish' then
        return u..'17'
    elseif npc == 'Bingus' then
        return u..'18'
    elseif npc == 'Obamid' then
        return u..'19'
    elseif npc == 'Floppy' then
        return u..'20'
    elseif npc == 'Creepy Head' then
        return u..'21'
    elseif npc == 'Scary Skull' then
        return u..'22'
    elseif npc == 'Pink Absorber' then
        return u..'24'
    elseif npc == 'Troll Face' then
        return u..'25'
    elseif npc == 'Uncanny Cat' then
        return u..'26'
    elseif npc == 'Quandale Dingle' then
        return u..'27'
    elseif npc == 'Moai' then
        return u..'28'
    elseif npc == 'Evil Noob' then
        return u..'29'
    elseif npc == 'Red Sus' then
        return u..'30'
    elseif npc == 'Sus Duck' then
        return u..'31'
    elseif npc == 'Lord Sus' then
        return u..'32'
    elseif npc == 'Sigma Man' then
        return u..'33'
    elseif npc == 'Dancing Cat' then
        return u..'34'
    elseif npc == 'Toothless Dragon' then
        return u..'35'
    elseif npc == 'Manly Nugget' then
        return u..'36'
    elseif npc == 'Huh Cat' then
        return u..'37'
    elseif npc == 'Mystical Tree' then
        return u..'38'
    elseif npc == 'Old Man' then
        return u..'39'
    elseif npc == 'Nyan Cat' then
        return u..'40'
    elseif npc == 'Baller' then
        return u..'41'
    elseif npc == 'Slicer' then
        return u..'42'
    elseif npc == 'Rick Roller' then
        return u..'43'
    elseif npc == 'Gigachad' then
        return u..'44'
    elseif npc == 'MrBeast' then
        return u..'45'
    elseif npc == 'Handsome Man' then
        return u..'46'
    elseif npc == 'Sogga' then
        return 'Dancing Banana Quest'
    else
        return ''
    end
end

local itemslist = {}
for i, item in game.Players.LocalPlayer.Backpack:GetChildren() do
    if not item.Name:match('Power') then
        table.insert(itemslist, tostring(item.Name))
    end
end

-- AutoFarm Tab
local AutoFarmTab = Window:Tab({Title = "AutoFarm", Icon = "star"})

AutoFarmTab:Section({Title = "Weapon Settings"})

AutoFarmTab:Dropdown({
    Title = "AutoFarm Weapon",
    List = itemslist,
    Value = "Combat",
    Callback = function(choice)
        _G.candyhub.weapon = choice
    end
})

AutoFarmTab:Button({
    Title = "Refresh Weapons List",
    Desc = "Update weapon dropdown with current inventory",
    Callback = function()
        itemslist = {}
        for i, item in game.Players.LocalPlayer.Backpack:GetChildren() do
            if not item.Name:match('Power') then
                table.insert(itemslist, tostring(item.Name))
            end
        end
        Window:Notify({
            Title = "Weapons Updated",
            Desc = "Weapon list refreshed successfully!",
            Time = 3
        })
    end
})

AutoFarmTab:Section({Title = "Auto Farm Controls"})

AutoFarmTab:Toggle({
    Title = "Auto Farm",
    Desc = "Enable automatic farming",
    Value = false,
    Callback = function(v)
        _G.candyhub.autofloppa = v
        while _G.candyhub.autofloppa and task.wait() do
            for i,monster in workspace.Monster:GetChildren() do
                if monster.Name == _G.candyhub.tokill then
                    if monster:FindFirstChild("HumanoidRootPart") and monster:FindFirstChild("Humanoid") then
                        if Lives() then
                            if monster:FindFirstChild("Humanoid").Health >= 1 then
                                monster:FindFirstChild("HumanoidRootPart").Size=Vector3.new(17,17,17)
                                if _G.candyhub.devtest then
                                    monster:FindFirstChild("HumanoidRootPart").Transparency = 0.8
                                end
                                SureQuest(_G.candyhub.quest)
                                if not CheckQuest() then
                                    if workspace.NPCs.Quests_Npc:FindFirstChild(_G.candyhub.quest) then
                                        if Lives() and workspace.NPCs.Quests_Npc[_G.candyhub.quest]:FindFirstChild('Block') then
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.QuestLocaion:FindFirstChild(_G.candyhub.quest).CFrame
                                            task.wait(0.1)
                                            UseQuest(workspace.NPCs.Quests_Npc[_G.candyhub.quest].Block:FindFirstChild('QuestPrompt'))
                                            UseQuest(workspace.NPCs.Quests_Npc[_G.candyhub.quest].Block:FindFirstChild('QuestPrompt'))
                                            task.wait(0.1)
                                        end
                                    else
                                        if Lives() then
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.QuestLocaion:FindFirstChild(_G.candyhub.quest).CFrame
                                        end
                                    end
                                end
                                UseAura()
                                while monster:FindFirstChild("Humanoid").Health >= 1 and _G.candyhub.autofloppa and Lives() do
                                    if monster:FindFirstChild("HumanoidRootPart") then
                                        monster:FindFirstChild("HumanoidRootPart").Size=Vector3.new(17,17,17)
                                        if _G.candyhub.devtest then
                                            monster:FindFirstChild("HumanoidRootPart").Transparency = 0.8
                                        end
                                    end
                                    if Lives() then
                                        monster:FindFirstChild("HumanoidRootPart").Size=Vector3.new(17,17,17)
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = monster:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, -5, 8)
                                    end
                                    click(10)
                                    task.wait()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
})

AutoFarmTab:Toggle({
    Title = "Allow Bosses",
    Desc = "Include bosses in auto farm rotation",
    Value = false,
    Callback = function(v)
        _G.candyhub.allowbosses = v
    end
})

AutoFarmTab:Toggle({
    Title = "Bring Enemies",
    Desc = "Teleport enemies closer (Ignore Bosses)",
    Value = false,
    Callback = function(v)
        _G.candyhub.bringenemies = v
        while _G.candyhub.bringenemies and task.wait() do
            if _G.candyhub.autofloppa and not _G.candyhub.autoraid and not _G.candyhub.autokillspec then
                for i, monster in workspace.Monster:GetChildren() do
                    if monster:FindFirstChild('Humanoid') then
                        if monster:FindFirstChild('Humanoid').Health >= 1 then
                            if monster:FindFirstChild('HumanoidRootPart') and Lives()then
                                if monster.Name == _G.candyhub.tokill and not _G.candyhub.boss then
                                    if workspace.NPCs.Quests_Npc:FindFirstChild(_G.candyhub.quest) then
                                        if Lives() and workspace.NPCs.Quests_Npc[_G.candyhub.quest]:FindFirstChild('Block') then
                                            monster:FindFirstChild('HumanoidRootPart').CFrame = workspace.NPCs.Quests_Npc[_G.candyhub.quest].Block.CFrame * CFrame.new(0,8,0)
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

-- Boss Farm Tab
local BossFarmTab = Window:Tab({Title = "Boss Farm", Icon = "shield"})

BossFarmTab:Section({Title = "Boss Controls"})

BossFarmTab:Toggle({
    Title = "Auto Meme Beast",
    Desc = "Automatically farm Meme Beast",
    Value = false,
    Callback = function(v)
        _G.candyhub.memebeast = v
        while _G.candyhub.memebeast and task.wait() do
            if workspace:FindFirstChild('Monster'):FindFirstChild('Meme Beast') then
                if Lives() then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.Enemy_Location["Meme Beast"].CFrame
                    if not workspace:FindFirstChild('Monster'):FindFirstChild('Meme Beast') then
                        task.wait(1)
                    else
                        UseAura()
                        if workspace:FindFirstChild('Monster'):FindFirstChild('Meme Beast'):FindFirstChild('HumanoidRootPart') then
                            if workspace:FindFirstChild('Monster'):FindFirstChild('Meme Beast'):FindFirstChild('Humanoid') then
                                if workspace:FindFirstChild('Monster'):FindFirstChild('Meme Beast'):FindFirstChild('Humanoid').Health >= 1 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild('Monster'):FindFirstChild('Meme Beast'):FindFirstChild('HumanoidRootPart').CFrame * CFrame.new(0, -5, 8)
                                    click(10)
                                end
                            end
                        end
                    end
                end
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.Enemy_Location["Meme Beast"].CFrame
                if not workspace:FindFirstChild('Monster'):FindFirstChild('Meme Beast') then
                    task.wait(1)
                end
            end
        end
    end
})

-- Stats Tab
local StatsTab = Window:Tab({Title = "Stats", Icon = "trending-up"})

StatsTab:Section({Title = "Auto Stats"})

StatsTab:Toggle({
    Title = "Auto Stats",
    Desc = "Automatically upgrade stats",
    Value = false,
    Callback = function(v)
        _G.candyhub.autostats = v
        while _G.candyhub.autostats and task.wait(0.1) do
            for i, stat in _G.candyhub.stats_s do
                local args = {[1] = {["Target"] = stat,["Action"] = "UpgradeStats",["Amount"] = 1}}
                game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("StatsFunction"):InvokeServer(unpack(args))
            end
        end
    end
})

-- Shop Tab
local ShopTab = Window:Tab({Title = "Shop", Icon = "shopping-cart"})

ShopTab:Section({Title = "Codes & Powers"})

ShopTab:Button({
    Title = "Redeem All Codes",
    Desc = "Automatically redeem all available codes",
    Callback = function()
        local codes = {"100MVisits","100KLikes","100KFavorites","100KActive","70KActive","40KActive","20KActive","10KActive","10KMembers","Update4","4KActive","10KLikes","10MVisits","9MVisits"}
        for i, code in codes do
            game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Code"):InvokeServer(code)
        end
        Window:Notify({
            Title = "Codes Redeemed",
            Desc = "All available codes have been redeemed!",
            Time = 3
        })
    end
})

ShopTab:Button({
    Title = "Roll Powers",
    Desc = "Roll for random powers",
    Callback = function()
        for i = 1,_G.candyhub.amount do
            local args = {[1] = "Random_Power",[2] = {["Type"] = "Once",["NPCName"] = "Floppa Gacha",["GachaType"] = _G.candyhub.buyfruitmode}}
            game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules"):FireServer(unpack(args))
        end
        Window:Notify({
            Title = "Powers Rolled",
            Desc = "Rolled " .. _G.candyhub.amount .. " powers!",
            Time = 3
        })
    end
})

ShopTab:Slider({
    Title = "Roll Amount",
    Min = 1,
    Max = 500,
    Rounding = 0,
    Value = 1,
    Callback = function(val)
        _G.candyhub.amount = val
    end
})

ShopTab:Dropdown({
    Title = "Buy Mode",
    List = {"Money","Gem"},
    Value = "Money",
    Callback = function(choice)
        _G.candyhub.buyfruitmode = choice
    end
})

-- Settings Tab
local SettingsTab = Window:Tab({Title = "Settings", Icon = "settings"})

SettingsTab:Section({Title = "Configuration"})

SettingsTab:Toggle({
    Title = "No Quests",
    Desc = "Disable quest system",
    Value = false,
    Callback = function(v)
        _G.candyhub.questmode = not v
    end
})

SettingsTab:Button({
    Title = "Force Stop AutoFarm",
    Desc = "Emergency stop for all farming functions",
    Callback = function()
        _G.candyhub.autofloppa = false
        _G.candyhub.memebeast = false
        _G.candyhub.autoboss = false
        _G.candyhub.autoraid = false
        _G.candyhub.autokillspec = false
        Window:Notify({
            Title = "AutoFarm Stopped",
            Desc = "All farming functions have been stopped!",
            Time = 3
        })
    end
})

-- Level-based enemy selection loop
while true and task.wait(.5) do
    if GetLevel() >= 2350 then
        _G.candyhub.tokill = "Handsome Man"
        _G.candyhub.quest = "Floppa Quest 46"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 2350
    elseif GetLevel() >= 2300 and _G.candyhub.allowbosses == true then
        _G.candyhub.tokill = "MrBeast"
        _G.candyhub.quest = "Floppa Quest 45"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 2300
    elseif GetLevel() >= 2250 then
        _G.candyhub.tokill = "Gigachad"
        _G.candyhub.quest = "Floppa Quest 44"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 2250
    elseif GetLevel() >= 2200 and _G.candyhub.allowbosses == true then
        _G.candyhub.tokill = "Rick Roller"
        _G.candyhub.quest = "Floppa Quest 43"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 2200
    elseif GetLevel() >= 2150 then
        _G.candyhub.tokill = "Slicer"
        _G.candyhub.quest = "Floppa Quest 42"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 2150
    elseif GetLevel() >= 2100 then
        _G.candyhub.tokill = "Baller"
        _G.candyhub.quest = "Floppa Quest 41"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 2100
    elseif GetLevel() >= 2050 then
        _G.candyhub.tokill = "Nyan Cat"
        _G.candyhub.quest = "Floppa Quest 40"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 2050
    elseif GetLevel() >= 2000 then
        _G.candyhub.tokill = "Old Man"
        _G.candyhub.quest = "Floppa Quest 39"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 2000
    elseif GetLevel() >= 1950 then
        _G.candyhub.tokill = "Mystical Tree"
        _G.candyhub.quest = "Floppa Quest 38"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1950
    elseif GetLevel() >= 1900 then
        _G.candyhub.tokill = "Huh Cat"
        _G.candyhub.quest = "Floppa Quest 37"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1900
    elseif GetLevel() >= 1850 then
        _G.candyhub.tokill = "Manly Nugget"
        _G.candyhub.quest = "Floppa Quest 36"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1850
    elseif GetLevel() >= 1800 then
        _G.candyhub.tokill = "Toothless Dragon"
        _G.candyhub.quest = "Floppa Quest 35"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1800
    elseif GetLevel() >= 1750 then
        _G.candyhub.tokill = "Dancing Cat"
        _G.candyhub.quest = "Floppa Quest 34"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1750
    elseif GetLevel() >= 1700 then
        _G.candyhub.tokill = "Sigma Man"
        _G.candyhub.quest = "Floppa Quest 33"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1700
    elseif GetLevel() >= 1500 then 
        _G.candyhub.tokill = "Sus Duck"
        _G.candyhub.quest = "Floppa Quest 31"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1500
    elseif GetLevel() >= 1450 then 
        _G.candyhub.tokill = "Red Sus"
        _G.candyhub.quest = "Floppa Quest 30"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1450
    elseif GetLevel() >= 1350 and _G.candyhub.allowbosses == true then 
        _G.candyhub.tokill = "Moai"
        _G.candyhub.quest = "Floppa Quest 28"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 1350
    elseif GetLevel() >= 1300 then 
        _G.candyhub.tokill = "Quandale Dingle"
        _G.candyhub.quest = "Floppa Quest 27"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1300
    elseif GetLevel() >= 1250 then 
        _G.candyhub.tokill = "Uncanny Cat"
        _G.candyhub.quest = "Floppa Quest 26"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1250
    elseif GetLevel() >= 1200 then 
        _G.candyhub.tokill = "Troll Face"
        _G.candyhub.quest = "Floppa Quest 25"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1200
    elseif GetLevel() >= 1150 and _G.candyhub.allowbosses == true then 
        _G.candyhub.tokill = "Pink Absorber"
        _G.candyhub.quest = "Floppa Quest 24"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 1150
    elseif GetLevel() >= 1050 then
        _G.candyhub.tokill = "Scary Skull"
        _G.candyhub.quest = "Floppa Quest 22"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1050
    elseif GetLevel() >= 1000 then 
        _G.candyhub.tokill = "Creepy Head"
        _G.candyhub.quest = "Floppa Quest 21"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1000
    elseif GetLevel() >= 950 then 
        _G.candyhub.tokill = "Floppy"
        _G.candyhub.quest = "Floppa Quest 20"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 950
    elseif GetLevel() >= 900 and _G.candyhub.allowbosses == true then 
        _G.candyhub.tokill = "Obamid"
        _G.candyhub.quest = "Floppa Quest 19"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 900
    elseif GetLevel() >= 850 then 
        _G.candyhub.tokill = "Bingus"
        _G.candyhub.quest = "Floppa Quest 18"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 850
    elseif GetLevel() >= 800 then 
        _G.candyhub.tokill = "Killerfish"
        _G.candyhub.quest = "Floppa Quest 17"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 800
    elseif GetLevel() >= 750 then 
        _G.candyhub.tokill = "Smiling Cat"
        _G.candyhub.quest = "Floppa Quest 16"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 750
    elseif GetLevel() >= 700 and _G.candyhub.allowbosses == true then 
        _G.candyhub.tokill = "Gorilla King"
        _G.candyhub.quest = "Floppa Quest 15"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 700
    elseif GetLevel() >= 650 then
        _G.candyhub.tokill = "Popcat"
        _G.candyhub.quest = "Floppa Quest 14"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 650
    elseif GetLevel() >= 600 then 
        _G.candyhub.tokill = "Egg Dog"
        _G.candyhub.quest = "Floppa Quest 13"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 600
    elseif GetLevel() >= 550 and _G.candyhub.allowbosses == true then 
        _G.candyhub.tokill = "Sus Face"
        _G.candyhub.quest = "Floppa Quest 12"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 550
    elseif GetLevel() >= 500 then 
        _G.candyhub.tokill = "Banana Cat"
        _G.candyhub.quest = "Floppa Quest 11"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 500
    elseif GetLevel() >= 450 then 
        _G.candyhub.tokill = "The Rock"
        _G.candyhub.quest = "Floppa Quest 10"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 450
    elseif GetLevel() >= 400 then 
        _G.candyhub.tokill = "Snow Tree"
        _G.candyhub.quest = "Floppa Quest 9"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 400
    elseif GetLevel() >= 350 then 
        _G.candyhub.tokill = "Hamster"
        _G.candyhub.quest = "Floppa Quest 8"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 350
    elseif GetLevel() >= 300 then 
        _G.candyhub.tokill = "Staring Fish"
        _G.candyhub.quest = "Floppa Quest 7"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 300
    elseif GetLevel() >= 250 and _G.candyhub.allowbosses == true then 
        _G.candyhub.tokill = "Walter Dog"
        _G.candyhub.quest = "Floppa Quest 6"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 250
    elseif GetLevel() >= 200 then
        _G.candyhub.tokill = "Cheems"
        _G.candyhub.quest = "Floppa Quest 5"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 200
    elseif GetLevel() >= 150 then
        _G.candyhub.tokill = "Doge"
        _G.candyhub.quest = "Floppa Quest 4"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 150
    elseif GetLevel() >= 100 and _G.candyhub.allowbosses == true then
        _G.candyhub.tokill = "Big Floppa"
        _G.candyhub.quest = "Floppa Quest 3"
        _G.candyhub.boss = true
        _G.candyhub.tokill_level = 100
    elseif GetLevel() >= 50 then
        _G.candyhub.tokill = "Golden Floppa"
        _G.candyhub.quest = "Floppa Quest 2"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 50
    elseif GetLevel() >= 1 then
        _G.candyhub.tokill = "Floppa"
        _G.candyhub.quest = "Floppa Quest 1"
        _G.candyhub.boss = false
        _G.candyhub.tokill_level = 1
    end
    if _G.candyhub.autofloppa then
        AreaCheck(GetLevel())
    end
end

-- Final Notification
Window:Notify({
    Title = "zzz hub by ktro",
    Desc = "All features loaded successfully!",
    Time = 4
})
