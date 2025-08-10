local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Game configurations
local GAMES = {
    
    -- Steal a Brainrot
    {
        placeIds = {96342491571673, 109983668079237},
        name = "Steal a Brainrot",
        emoji = "🧠",
        scripts = {
            {name = "VRTX Hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/refs/heads/main/main/vrtx.lua.txt", color = Color3.fromRGB(255, 0, 255)}
        }
    },
    
    -- Dig Game  
    {
        placeIds = {126244816328678},
        name = "Dig Game",
        emoji = "⛏️",
        scripts = {
            {name = "ZZZ Hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/dig.lua", color = Color3.fromRGB(139, 69, 19)}
        }
    },
    
    -- Dead Rails  
    {
        placeIds = {70876832253163, 11649582918852},
        name = "Dead Rails",
        emoji = "🚂",
        scripts = {
            {name = "Best Auto Bone", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/zzzhubautobone", color = Color3.fromRGB(75, 0, 130)}
        }
    },
    
    -- Musical Chairs
    {
        placeIds = {113323927469374},
        name = "Musical Chairs",
        emoji = "🪑",
        scripts = {
            {name = "Musical Chairs", url = "https://raw.githubusercontent.com/ktroTRB/perfect-hub/refs/heads/main/Musical%20Chairs.lua", color = Color3.fromRGB(255, 105, 180)}
        }
    },
    
    -- Ink Game
    {
        placeIds = {125009265613167, 99567941238278},
        name = "Ink Game",
        emoji = "🟢",
        scripts = {
            {name = "zzzhubv2   +all", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/newinkgame.lua", color = Color3.fromRGB(0, 255, 0)}
        }
    },
    
    -- Brookhaven
    {
        placeIds = {4924922222},
        name = "Brookhaven",
        emoji = "🏠",
        scripts = {
            {name = "zzz hub op", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Brookhaven%20RP.lua", color = Color3.fromRGB(64, 224, 208)}
        }
    },
    
    -- Shrink Hide & Seek
    {
        placeIds = {137541498231955},
        name = "Shrink Hide & Seek",
        emoji = "🫥",
        scripts = {
            {name = "Shrink Hide & Seek", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Shrink%20Hide%20&%20Seek.txt", color = Color3.fromRGB(255, 165, 0)}
        }
    },
    
    -- Slap Battles
    {
        placeIds = {6403373529, 124596094333302},
        name = "Slap Battles",
        emoji = "👋",
        scripts = {
            {name = "Slap Battles", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Slap%20Battles.txt", color = Color3.fromRGB(255, 69, 0)}
        }
    },
    
    -- Something Evil Will Happen
    {
        placeIds = {16991287194},
        name = "Something Evil Will Happen",
        emoji = "👹",
        scripts = {
            {name = "Something Evil Will Happen", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/something%20evil%20will%20happen.txt", color = Color3.fromRGB(139, 0, 0)}
        }
    },
    
    -- Troll Tower 2
    {
        placeIds = {118771036645714},
        name = "Troll Tower 2 🖐",
        emoji = "🗼",
        scripts = {
            {name = "Tower Script", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/scripts/Tower%20of%20Hell", color = Color3.fromRGB(255, 140, 0)}
        }
    },
    
    -- Tower of Hell
    {
        placeIds = {1962086868},
        name = "Tower of Hell",
        emoji = "🔥",
        scripts = {
            {name = "Tower of Hell", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Tower%20of%20Hell.txt", color = Color3.fromRGB(255, 0, 0)}
        }
    },
    
    -- Emergency Hamburg
    {
        placeIds = {7711635737},
        name = "Emergency Hamburg",
        emoji = "🍔",
        scripts = {
            {name = "Emergency Hamburg", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Emergency%20Hamburg.txt", color = Color3.fromRGB(255, 215, 0)}
        }
    },
    
    -- Forsaken | Auto Farm
    {
        placeIds = {18687417158},
        name = "Forsaken | Auto Farm",
        emoji = "🌾",
        scripts = {
            {name = "Forsaken Auto Farm", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Forsaken%20_%20Auto%20Farm.txt", color = Color3.fromRGB(34, 139, 34)}
        }
    },
    
    -- Effortless Tower
    {
        placeIds = {13027675420},
        name = "Effortless Tower",
        emoji = "🏗️",
        scripts = {
            {name = "Effortless Tower", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Effortless%20Tower.txt", color = Color3.fromRGB(70, 130, 180)}
        }
    },
    
    -- Player or AI?
    {
        placeIds = {95217169945642},
        name = "Player or AI?",
        emoji = "🤖",
        scripts = {
            {name = "Player or AI?", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Player%20or%20AI_.txt", color = Color3.fromRGB(128, 128, 128)}
        }
    },
    
    -- Hide and Seek Extreme
    {
        placeIds = {205224386},
        name = "Hide and Seek Extreme",
        emoji = "👁️",
        scripts = {
            {name = "Hide and Seek Extreme", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Hide%20and%20Seek%20Extreme.txt", color = Color3.fromRGB(75, 0, 130)}
        }
    },
    
    -- Tower of Misery
    {
        placeIds = {4954752502},
        name = "Tower of Misery",
        emoji = "😵",
        scripts = {
            {name = "Tower of Misery", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Tower%20of%20Misery.lua", color = Color3.fromRGB(139, 69, 19)}
        }
    },
    
    -- Ultimate Driving
    {
        placeIds = {54865335},
        name = "Ultimate Driving",
        emoji = "🚗",
        scripts = {
            {name = "Ultimate Driving", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Ultimate%20Driving.lua", color = Color3.fromRGB(30, 144, 255)}
        }
    },
    
    -- Gunfight Arena
    {
        placeIds = {14518422161},
        name = "Gunfight Arena",
        emoji = "🔫",
        scripts = {
            {name = "Gunfight Arena Hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Gunfight%20Arena.txt", color = Color3.fromRGB(34, 139, 34)}
        }
    },

    -- MM2
    {
        placeIds = {142823291},
        name = "MM2",
        emoji = "🔪",
        scripts = {
            {name = "MM2 Hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/mm2.txt", color = Color3.fromRGB(34, 139, 34)}
        }
    },
    
    -- LifeTogether RP
    {
        placeIds = {13967668166},
        name = "LifeTogether 🏠 RP",
        emoji = "🏡",
        scripts = {
            {name = "Life Together RP", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Life%20Together%20RP.lua", color = Color3.fromRGB(255, 20, 147)}
        }
    },

    {
        placeIds = {79546208627805, 126509999114328},
        name = "99 Nights in the Forest",
        emoji = "🌲",
        scripts = {
            {name = "Lot Features - 99 Nights", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Lot%20Features%20-%2099%20Nights.txt", color = Color3.fromRGB(34, 139, 34)},
            {name = "Item Grabber", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/iteamgraber[99nights.txt", color = Color3.fromRGB(46, 125, 50)}
        }
    },
    
    -- Legends of Speed
    {
        placeIds = {3101667897, 3232996272, 3276265788},
        name = "Legends of Speed",
        emoji = "⚡",
        scripts = {
            {name = "zzz hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/LegendsOfSpeed.lua.lua", color = Color3.fromRGB(255, 193, 7)}
        } 
    },
    
    -- Muscle Legends
    {
        placeIds = {3623096087},
        name = "Muscle Legends",
        emoji = "💪",
        scripts = {
            {name = "zzz hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/zzzhub%20msl.lua", color = Color3.fromRGB(244, 67, 54)}
        }
    }
}

-- Function to check if current place is in a game's place list
local function isInPlaceList(placeId, placeList)
    for _, id in pairs(placeList) do
        if id == placeId then
            return true
        end
    end
    return false
end

-- Function to find current game configuration
local function findCurrentGame()
    local currentPlaceId = game.PlaceId
    
    for _, gameConfig in pairs(GAMES) do
        if isInPlaceList(currentPlaceId, gameConfig.placeIds) then
            return gameConfig
        end
    end
    
    return nil
end

-- Function to create simple choice menu
local function createChoiceMenu(gameConfig)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Create GUI
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local ImageLabel = Instance.new("ImageLabel")
    local UICorner = Instance.new("UICorner")
    local NamaHub = Instance.new("TextLabel")
    local KeySystem = Instance.new("TextLabel")
    local ScrollFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")

    -- Properties
    ScreenGui.Parent = playerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)

    ImageLabel.Parent = MainFrame
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1.000
    ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Size = UDim2.new(0, 450, 0, 300)
    ImageLabel.Image = "rbxassetid://8992230677"
    ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.ImageTransparency = 0.400
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.SliceCenter = Rect.new(99, 99, 99, 99)

    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    NamaHub.Name = "zzzhub"
    NamaHub.Parent = MainFrame
    NamaHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NamaHub.BackgroundTransparency = 1.000
    NamaHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NamaHub.BorderSizePixel = 0
    NamaHub.Position = UDim2.new(0.02, 0, 0, 5)
    NamaHub.Size = UDim2.new(1, -50, 0, 40)
    NamaHub.Font = Enum.Font.RobotoCondensed
    NamaHub.Text = "Welcome to, " .. gameConfig.emoji .. " " .. gameConfig.name
    NamaHub.TextColor3 = Color3.fromRGB(255, 255, 255)
    NamaHub.TextSize = 28.000
    NamaHub.TextXAlignment = Enum.TextXAlignment.Left
    NamaHub.TextScaled = true

    KeySystem.Name = "chooser "
    KeySystem.Parent = MainFrame
    KeySystem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeySystem.BackgroundTransparency = 1.000
    KeySystem.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeySystem.BorderSizePixel = 0
    KeySystem.Position = UDim2.new(0, 0, 0.16, 0)
    KeySystem.Size = UDim2.new(0, 250, 0, 30)
    KeySystem.Font = Enum.Font.FredokaOne
    KeySystem.Text = "SCRIPT CHOOSER"
    KeySystem.TextColor3 = Color3.fromRGB(43, 177, 255)
    KeySystem.TextSize = 24.000

    -- Scrolling Frame for scripts
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Parent = MainFrame
    ScrollFrame.Active = true
    ScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollFrame.BackgroundTransparency = 1.000
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.Position = UDim2.new(0.02, 0, 0.35, 0)
    ScrollFrame.Size = UDim2.new(0.96, 0, 0.6, 0)
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(43, 177, 255)

    UIListLayout.Parent = ScrollFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)

    -- Create script buttons
    for i, script in pairs(gameConfig.scripts) do
        local ScriptContainer = Instance.new("Frame")
        local UICorner_Script = Instance.new("UICorner")
        local ScriptButton = Instance.new("TextButton")
        local UIStroke = Instance.new("UIStroke")

        ScriptContainer.Name = "ScriptContainer"
        ScriptContainer.Parent = ScrollFrame
        ScriptContainer.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        ScriptContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ScriptContainer.BorderSizePixel = 0
        ScriptContainer.Size = UDim2.new(1, -10, 0, 45)
        ScriptContainer.LayoutOrder = i

        UICorner_Script.Parent = ScriptContainer

        ScriptButton.Parent = ScriptContainer
        ScriptButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ScriptButton.BackgroundTransparency = 1.000
        ScriptButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ScriptButton.BorderSizePixel = 0
        ScriptButton.Size = UDim2.new(1, 0, 1, 0)
        ScriptButton.Font = Enum.Font.SourceSans
        ScriptButton.Text = "🚀 " .. script.name
        ScriptButton.TextColor3 = Color3.fromRGB(42, 172, 248)
        ScriptButton.TextSize = 18.000

        UIStroke.Thickness = 3
        UIStroke.Color = Color3.fromRGB(255, 255, 255)
        UIStroke.Transparency = 0.2
        UIStroke.Parent = ScriptContainer

        -- Button functionality
        ScriptButton.MouseButton1Click:Connect(function()
            ScriptButton.Text = "Loading..."
            ScriptButton.TextColor3 = Color3.fromRGB(255, 200, 0)
            
            task.spawn(function()
                local success, result = pcall(function()
                    loadstring(game:HttpGet(script.url))()
                end)
                
                if success then
                    ScriptButton.Text = "✅ Loaded!"
                    ScriptButton.TextColor3 = Color3.fromRGB(50, 255, 50)
                    wait(1)
                    ScreenGui:Destroy()
                else
                    ScriptButton.Text = "❌ Failed - Try Again"
                    ScriptButton.TextColor3 = Color3.fromRGB(255, 50, 50)
                    wait(2)
                    ScriptButton.Text = "🚀 " .. script.name
                    ScriptButton.TextColor3 = Color3.fromRGB(42, 172, 248)
                end
            end)
        end)

        -- Hover effects
        ScriptButton.MouseEnter:Connect(function()
            TweenService:Create(ScriptContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}):Play()
        end)
        
        ScriptButton.MouseLeave:Connect(function()
            TweenService:Create(ScriptContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(38, 38, 38)}):Play()
        end)
    end

    -- Update scroll canvas size
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Close button
    local closeBtn = Instance.new("TextButton", MainFrame)
    closeBtn.Text = "X"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.ZIndex = 2

    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 8)
    closeBtnCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Auto-close after 60 seconds
    task.spawn(function()
        wait(60)
        if ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end)

    -- Notification
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = gameConfig.name .. " Hub Collection";
        Text = "Choose your preferred script from " .. #gameConfig.scripts .. " available options.";
        Duration = 4;
    })
end

-- Main execution
local currentGame = findCurrentGame()

if currentGame then
    -- Game is supported, show chooser
    createChoiceMenu(currentGame)
else
    -- Game not supported message
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚠️ Game Not Supported";
        Text = "This game isn't in our collection yet. Join our Discord to request support!";
        Duration = 6;
    })
end
