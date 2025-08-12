if game.GameId == 4019583467 then
    -- Load DummyUI Library
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/ui/dummyui"))()

    local Window = Library:Window({
        Title = "zzz hub",
        Desc = "Be NPC or Die",
        Icon = 105059922903197,
        Theme = "Dark",
        Config = {
            Keybind = Enum.KeyCode.LeftControl,
            Size = UDim2.new(0, 830, 0, 525)
        },
        CloseUIButton = {
            Enabled = true,
            Text = "zzz hub"
        }
    })

    local players = game:GetService("Players")
    local plr = players.LocalPlayer

    local function getCharacter()
        local char = plr.Character or plr.CharacterAdded:Wait()
        local humPart = char:WaitForChild("HumanoidRootPart", 5)
        return char, humPart
    end

    local char, humPart = getCharacter()

    plr.CharacterAdded:Connect(
        function()
            char, humPart = getCharacter()
            char:WaitForChild("Humanoid").UseJumpPower = true
        end
    )

    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    local Lighting = game:GetService("Lighting")

    if queueteleport then
        local TeleportCheck = false
        plr.OnTeleport:Connect(function(State)
            if queueteleport and (not TeleportCheck) then
                TeleportCheck = true
                queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/beanpcordie.lua'))()")
            end
        end)
    end

    if game.PlaceId == 11276071411 then
        local MainTab = Window:Tab({Title = "Main", Icon = "house"})
        local FarmTab = Window:Tab({Title = "Farm", Icon = "circle-dollar-sign"})
        local PlayerTab = Window:Tab({Title = "Player", Icon = "person-standing"})
        local StatsTab = Window:Tab({Title = "Players Stats", Icon = "chart-no-axes-column"})
        local SettingsTab = Window:Tab({Title = "Settings", Icon = "settings"})

        local collect = workspace:FindFirstChild("CollectableItems")

        local function serverHop()
            local servers = {}
            local req = request({
                Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",
                Method = "GET"
            })

            if req.StatusCode == 200 then
                local body = HttpService:JSONDecode(req.Body)
                if body and body.data then
                    for _, server in ipairs(body.data) do
                        if server.playing < server.maxPlayers and server.id ~= game.JobId then
                            table.insert(servers, server.id)
                        end
                    end
                end
            else
                warn("Failed to fetch server list: " .. req.StatusMessage)
            end

            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], plr)
            else
                warn("No suitable servers found")
            end
        end

        -- Farm Tab
        local farmEnabled = false
        FarmTab:Toggle({
            Title = "Cash Farm",
            Desc = "Automatically collect cash items",
            Value = false,
            Callback = function(value)
                farmEnabled = value
                if value then
                    spawn(function()
                        while farmEnabled do
                            pcall(function()
                                for _, p in ipairs(collect:GetChildren()) do
                                    if not farmEnabled then break end
                                    if not p:GetAttribute("CannotSee") then
                                        humPart.CFrame = p.CFrame
                                        wait(.5)
                                        local humanoid = char:FindFirstChildWhichIsA("Humanoid")
                                        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                                    end
                                    wait(1)
                                end
                            end)
                            wait(.5)
                        end
                    end)
                end
            end
        })

        local resetOnFull = false
        FarmTab:Toggle({
            Title = "Reset if Bag is Full",
            Desc = "Auto reset when cash bag is full",
            Value = false,
            Callback = function(value)
                resetOnFull = value
                if value then
                    spawn(function()
                        local bag = plr.PlayerGui:WaitForChild("Timer"):WaitForChild("Frame"):WaitForChild("Bags"):WaitForChild("CashBag"):WaitForChild("Bag"):WaitForChild("AmountCollected")
                        while resetOnFull do
                            if bag and farmEnabled then
                                if bag.Text == "FULL!" and plr.Team and plr.Team.Name == "Criminals" then
                                    local humanoid = char:FindFirstChildWhichIsA("Humanoid")
                                    if humanoid then humanoid.Health = 0 end
                                end
                            end
                            wait(1)
                        end
                    end)
                end
            end
        })

        local resetOnSheriff = false
        FarmTab:Toggle({
            Title = "Reset if Sheriff",
            Desc = "Auto reset when you become sheriff",
            Value = false,
            Callback = function(value)
                resetOnSheriff = value
                if value then
                    spawn(function()
                        while resetOnSheriff do
                            if plr.Team and plr.Team.Name == "Sheriffs" and farmEnabled then
                                local humanoid = char:FindFirstChildWhichIsA("Humanoid")
                                if humanoid then humanoid.Health = 0 end
                            end
                            wait(1)
                        end
                    end)
                end
            end
        })

        FarmTab:Button({
            Title = "Server Hop",
            Desc = "Switch to a different server",
            Callback = function()
                serverHop()
            end
        })

        local autoServerHop = false
        FarmTab:Toggle({
            Title = "Auto Server Hop",
            Desc = "Auto hop when less than 3 players",
            Value = false,
            Callback = function(value)
                autoServerHop = value
                if value then
                    spawn(function()
                        while autoServerHop do
                            if #players:GetPlayers() <= 3 then
                                serverHop()
                            end
                            wait(1)
                        end
                    end)
                end
            end
        })

        -- Main Tab
        local espEnabled = false
        MainTab:Toggle({
            Title = "ESP",
            Desc = "See players through walls",
            Value = false,
            Callback = function(value)
                espEnabled = value
                if value then
                    spawn(function()
                        while espEnabled do
                            for _, player in pairs(workspace:GetDescendants()) do
                                if player:IsA("Model") and player:FindFirstChild("HumanoidRootPart") then
                                    if player:FindFirstChild("HumanoidRootPart").CollisionGroup == "Player" and player ~= char then
                                        local playerObject = players:GetPlayerFromCharacter(player)

                                        if playerObject and playerObject.Team and playerObject.Team.Name == "Sheriffs" then
                                            if player:FindFirstChild("ESP") then
                                                player:FindFirstChild("ESP").Color3 = Color3.new(0, 0, 1)
                                            else
                                                local box = Instance.new("BoxHandleAdornment", player)
                                                box.Name = "ESP"
                                                box.Adornee = player
                                                box.AlwaysOnTop = true
                                                box.Size = Vector3.new(4, 5, 1)
                                                box.ZIndex = 0
                                                box.Transparency = 0.3
                                                box.Color3 = Color3.new(0, 0, 1)
                                            end
                                        else
                                            if not player:FindFirstChild("ESP") then
                                                local box = Instance.new("BoxHandleAdornment", player)
                                                box.Name = "ESP"
                                                box.Adornee = player
                                                box.AlwaysOnTop = true
                                                box.Size = Vector3.new(4, 5, 1)
                                                box.ZIndex = 0
                                                box.Transparency = 0.3
                                                box.Color3 = Color3.new(0, 1, 0)
                                            end
                                        end
                                    end
                                end
                            end
                            task.wait(1)
                        end
                    else
                        for _, e in pairs(workspace:GetDescendants()) do
                            if e.Name == "ESP" then
                                e:Destroy()
                            end
                        end
                    end
                end
            end
        })

        MainTab:Button({
            Title = "Kill Nearest NPCs",
            Desc = "Eliminate nearby NPCs",
            Callback = function()
                for i, v in ipairs(players:GetPlayers()) do
                    if v == plr then
                        Instance.new("Folder", v.Character).Name = "testt"
                    end
                end
                task.wait(.5)
                for i, v in ipairs(workspace:GetChildren()) do
                    if v:FindFirstChild("testt") == nil and v:FindFirstChild("Died") == nil and v:FindFirstChild("Humanoid") then
                        local Magnitude = (plr.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                        if Magnitude <= 50 then
                            v.Humanoid.RigType = "R6"
                            v.Humanoid.Health = 0
                            Instance.new("Folder", v).Name = "Died"
                        end
                    end
                end
            end
        })

        -- Player Tab
        local infStamina = false
        PlayerTab:Toggle({
            Title = "Infinite Stamina",
            Desc = "Never run out of stamina",
            Value = false,
            Callback = function(value)
                infStamina = value
                if value then
                    spawn(function()
                        while infStamina do
                            pcall(function()
                                if plr:WaitForChild("PlayerGui"):FindFirstChild("Modules"):FindFirstChild("Gameplay"):WaitForChild("Sprint") then
                                    plr:WaitForChild("PlayerGui"):FindFirstChild("Modules"):FindFirstChild("Gameplay"):WaitForChild("Sprint"):FindFirstChild("Stamina").Value = 9e9
                                end
                            end)
                            wait(.6)
                        end
                    end)
                else
                    if plr:WaitForChild("PlayerGui"):FindFirstChild("Modules"):FindFirstChild("Gameplay"):WaitForChild("Sprint") then
                        plr:WaitForChild("PlayerGui"):FindFirstChild("Modules"):FindFirstChild("Gameplay"):WaitForChild("Sprint"):FindFirstChild("Stamina").Value = 6
                    end
                end
            end
        })

        local speedValue = 22
        PlayerTab:Textbox({
            Title = "Speed Value",
            Desc = "Set your walking speed",
            Placeholder = tostring(char:WaitForChild("Humanoid").WalkSpeed),
            Value = tostring(char:WaitForChild("Humanoid").WalkSpeed),
            ClearTextOnFocus = false,
            Callback = function(text)
                speedValue = tonumber(text) or 22
            end
        })

        local speedEnabled = false
        PlayerTab:Toggle({
            Title = "Speed Toggle",
            Desc = "Enable custom speed",
            Value = false,
            Callback = function(value)
                speedEnabled = value
                if value then
                    spawn(function()
                        while speedEnabled do
                            char:WaitForChild("Humanoid").WalkSpeed = speedValue
                            wait()
                        end
                    end)
                else
                    if plr.Team and plr.Team.Name == "Lobby" then
                        char:WaitForChild("Humanoid").WalkSpeed = 22
                    elseif plr.Team and plr.Team.Name == "Sheriffs" then
                        char:WaitForChild("Humanoid").WalkSpeed = 10
                    elseif plr.Team and plr.Team.Name == "Criminals" then
                        char:WaitForChild("Humanoid").WalkSpeed = 6.5
                    end
                end
            end
        })

        PlayerTab:Button({
            Title = "FullBright",
            Desc = "Make everything visible",
            Callback = function()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            end
        })

        -- Stats Tab related functions and UI elements (copied from original)
        local function updatePlayerList()
            local player_list = {}
            for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                table.insert(player_list, p.Name)
            end
            return player_list
        end

        local PlayersDropdown =
            StatsTab:Dropdown(
            "Players",
            {
                Title = "Choose Player",
                Values = updatePlayerList(),
                Multi = false,
                Default = 1
            }
        )
        local DisplayName =
            StatsTab:Label(
            "DisplayName",
            {
                Title = "Display Name:",
                Content = ""
            }
        )
        local CashStat =
            StatsTab:Label(
            "CashStat",
            {
                Title = "Player Cash:",
                Content = "0 Cash"
            }
        )
        local RubiesStat =
            StatsTab:Label(
            "RubiesStat",
            {
                Title = "Player Rubies:",
                Content = "0 Rubies"
            }
        )
        local LevelStat =
            StatsTab:Label(
            "LevelStat",
            {
                Title = "Player Level:",
                Content = "0"
            }
        )
        local XPStat =
            StatsTab:Label(
            "XPStat",
            {
                Title = "Player XP:",
                Content = "0"
            }
        )
        local EquippedWeapon =
            StatsTab:Label(
            "EquippedWeapon",
            {
                Title = "Player Equipped Weapon:",
                Content = ""
            }
        )
        local EquippedSheriff =
            StatsTab:Label(
            "EquippedSheriff",
            {
                Title = "Player Equipped Sheriff:",
                Content = ""
            }
        )
        local EquippedHouse =
            StatsTab:Label(
            "EquippedHouse",
            {
                Title = "Player Equipped House:",
                Content = ""
            }
        )
        local StatisticsLabel =
            StatsTab:Label(
            "InventoryLabel",
            {
                Title = "-- Statistics: --",
                Content = ""
            }
        )
        local GamesPlayed =
            StatsTab:Label(
            "GamesPlayed",
            {
                Title = "Games Played:",
                Content = "0"
            }
        )
        local HidersCaught =
            StatsTab:Label(
            "InventoryLabel",
            {
                Title = "Hiders Caught:",
                Content = "0"
            }
        )
        local NPCsShot =
            StatsTab:Label(
            "InventoryLabel",
            {
                Title = "NPCs Shot:",
                Content = "0"
            }
        )
        local TasksCompleted =
            StatsTab:Label(
            "InventoryLabel",
            {
                Title = "Tasks Completed: ",
                Content = "0"
            }
        )
        local WinsAsHider =
            StatsTab:Label(
            "InventoryLabel",
            {
                Title = "Wins As Hider:",
                Content = "0"
            }
        )
        local WinsAsSeeker =
            StatsTab:Label(
            "InventoryLabel",
            {
                Title = "Wins As Seeker:",
                Content = "0"
            }
        )
        local InventoryLabel =
            StatsTab:Label(
            "InventoryLabel",
            {
                Title = "-- Inventory: --",
                Content = ""
            }
        )
        local HousesHouse =
            StatsTab:Label(
            "HousesHouse",
            {
                Title = "Player Houses:",
                Content = ""
            }
        )
        local SheriffsHouse =
            StatsTab:Label(
            "SheriffsHouse",
            {
                Title = "Player Sheriffs:",
                Content = ""
            }
        )
        local WeaponsHouse =
            StatsTab:Label(
            "WeaponsHouse",
            {
                Title = "Player Weapons:",
                Content = ""
            }
        )

        local level
        local houses_list = {}
        local sheriffs_list = {}
        local weapons_list = {}
        local currentPlayer = nil

        PlayersDropdown:OnChanged(
            function(Value)
                pcall(
                    function()
                        local function splitCamelCase(str)
                            return str:gsub("(%l)(%u)", "%1 %2")
                        end

                        -- Level
                        for _, p in pairs(game.Players[Value].leaderstats:GetChildren()) do
                            if string.find(p.Name, "Level") then
                                level = p
                                break
                            end
                        end

                        -- Houses
                        houses_list = {}
                        for _, p in pairs(game.Players[Value].Data.Inventory.Houses:GetChildren()) do
                            table.insert(houses_list, splitCamelCase(p.Name) .. ": " .. p.Value)
                        end

                        -- Sheriffs
                        sheriffs_list = {}
                        for _, p in pairs(game.Players[Value].Data.Inventory.Sheriffs:GetChildren()) do
                            table.insert(sheriffs_list, splitCamelCase(p.Name) .. ": " .. p.Value)
                        end

                        -- Weapons
                        weapons_list = {}
                        for _, p in pairs(game.Players[Value].Data.Inventory.Weapons:GetChildren()) do
                            table.insert(weapons_list, splitCamelCase(p.Name) .. ": " .. p.Value)
                        end

                        local selectedPlayer = game.Players[Value]

                        if not selectedPlayer or not selectedPlayer.Data then
                            return
                        end

                        currentPlayer = selectedPlayer

                        local function updateStats()
                            if currentPlayer == selectedPlayer and selectedPlayer.Data then
                                HousesHouse:SetValue(table.concat(houses_list, "\n"))
                                SheriffsHouse:SetValue(table.concat(sheriffs_list, "\n"))
                                WeaponsHouse:SetValue(table.concat(weapons_list, "\n"))
                                DisplayName:SetValue(selectedPlayer.DisplayName)
                                if selectedPlayer.Data.Statistics.GamesPlayed then
                                    GamesPlayed:SetValue(selectedPlayer.Data.Statistics.GamesPlayed.Value)
                                end
                                if selectedPlayer.Data.Statistics.HidersCaught then
                                    HidersCaught:SetValue(selectedPlayer.Data.Statistics.HidersCaught.Value)
                                end
                                if selectedPlayer.Data.Statistics.NPCsShot then
                                    NPCsShot:SetValue(selectedPlayer.Data.Statistics.NPCsShot.Value)
                                end
                                if selectedPlayer.Data.Statistics.TasksCompleted then
                                    TasksCompleted:SetValue(selectedPlayer.Data.Statistics.TasksCompleted.Value)
                                end
                                if selectedPlayer.Data.Statistics.WinsAsHider then
                                    WinsAsHider:SetValue(selectedPlayer.Data.Statistics.WinsAsHider.Value)
                                end
                                if selectedPlayer.Data.Statistics.WinsAsSeeker then
                                    WinsAsSeeker:SetValue(selectedPlayer.Data.Statistics.WinsAsSeeker.Value)
                                end
                                if selectedPlayer.Data.Cash then
                                    CashStat:SetValue(selectedPlayer.Data.Cash.Value .. " Cash")
                                end
                                if selectedPlayer.Data.Rubies then
                                    RubiesStat:SetValue(selectedPlayer.Data.Rubies.Value .. " Rubies")
                                end
                                if level then
                                    LevelStat:SetValue(level.Value .. " Level")
                                end
                                if selectedPlayer.Data.XP then
                                    XPStat:SetValue(selectedPlayer.Data.XP.Value .. " XP")
                                end
                                if selectedPlayer.Data.EquippedWeapon then
                                    EquippedWeapon:SetValue(splitCamelCase(selectedPlayer.Data.EquippedWeapon.Value))
                                end
                                if selectedPlayer.Data.EquippedSheriff then
                                    EquippedSheriff:SetValue(splitCamelCase(selectedPlayer.Data.EquippedSheriff.Value))
                                end
                                if selectedPlayer.Data.EquippedHouse then
                                    EquippedHouse:SetValue(splitCamelCase(selectedPlayer.Data.EquippedHouse.Value))
                                end
                            end
                        end

                        if selectedPlayer and selectedPlayer.Data then
                            if selectedPlayer.Data.Statistics.GamesPlayed then
                                selectedPlayer.Data.Statistics.GamesPlayed.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.Statistics.HidersCaught then
                                selectedPlayer.Data.Statistics.HidersCaught.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.Statistics.NPCsShot then
                                selectedPlayer.Data.Statistics.NPCsShot.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.Statistics.TasksCompleted then
                                selectedPlayer.Data.Statistics.TasksCompleted.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.Statistics.WinsAsHider then
                                selectedPlayer.Data.Statistics.WinsAsHider.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.Statistics.WinsAsSeeker then
                                selectedPlayer.Data.Statistics.WinsAsSeeker.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.Cash then
                                selectedPlayer.Data.Cash.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.Rubies then
                                selectedPlayer.Data.Rubies.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.XP then
                                selectedPlayer.Data.XP.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.EquippedWeapon then
                                selectedPlayer.Data.EquippedWeapon.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.EquippedSheriff then
                                selectedPlayer.Data.EquippedSheriff.Changed:Connect(updateStats)
                            end
                            if selectedPlayer.Data.EquippedHouse then
                                selectedPlayer.Data.EquippedHouse.Changed:Connect(updateStats)
                            end
                            if level then
                                level.Changed:Connect(updateStats)
                            end
                        end

                        updateStats()
                    end
                )
            end
        )

        local function refreshDropdown()
            PlayersDropdown:SetValues(updatePlayerList())
        end

        game:GetService("Players").PlayerAdded:Connect(
            function()
                refreshDropdown()
            end
        )

        game:GetService("Players").PlayerRemoving:Connect(
            function()
                refreshDropdown()
            end
        )


        -- Settings Tab
        SettingsTab:Button({
            Title = "zzz hub",
            Desc = "Script by zzz hub team",
            Callback = function()
                Window:Notify({
                    Title = "zzz hub",
                    Desc = "Be NPC or Die script loaded successfully!",
                    Time = 3
                })
            end
        })

    elseif game.PlaceId == 96523225033576 then
        local PlayerTab = Window:Tab({Title = "Player", Icon = "person-standing"})
        local SettingsTab = Window:Tab({Title = "Settings", Icon = "settings"})

        PlayerTab:Button({
            Title = "Anti AFK",
            Desc = "Prevent getting kicked for being idle",
            Callback = function()
                local bb = game:GetService("VirtualUser")
                plr.Idled:connect(function()
                    bb:CaptureController()
                    bb:ClickButton2(Vector2.new())
                end)
            end
        })

        PlayerTab:Textbox({
            Title = "Speed Value",
            Desc = "Set your walking speed",
            Placeholder = tostring(char:WaitForChild("Humanoid").WalkSpeed),
            Value = tostring(char:WaitForChild("Humanoid").WalkSpeed),
            ClearTextOnFocus = false,
            Callback = function(text)
                local speed = tonumber(text)
                if speed then
                    char:WaitForChild("Humanoid").WalkSpeed = speed
                end
            end
        })

        SettingsTab:Button({
            Title = "zzz hub",
            Desc = "Script by zzz hub team",
            Callback = function()
                Window:Notify({
                    Title = "zzz hub",
                    Desc = "Be NPC or Die script loaded successfully!",
                    Time = 3
                })
            end
        })
    end

    -- Final notification
    Window:Notify({
        Title = "zzz hub",
        Desc = "Script loaded successfully!",
        Time = 4
    })
end