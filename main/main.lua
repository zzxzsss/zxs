
-- Universal Hub Chooser - Premium UI Edition
-- Enhanced with modern design, gradients, animations, and improved UX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Game configurations
local GAMES = {
    
    
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
                {name = "Gunfight Arena Hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/Gunfight%20Arena.txt", color = Color3.fromRGB(34, 139, 34)} -- Example color
            }
        },

        -- MM2
        {
            placeIds = {142823291},
            name = "MM2",
            emoji = "🔪",
            scripts = {
                {name = "MM2 Hub", url = "https://raw.githubusercontent.com/zzxzsss/zxs/main/main/mm2.txt", color = Color3.fromRGB(34, 139, 34)} -- Example color
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

-- Utility functions for enhanced UI
local function createGradientBackground(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Rotation = rotation or 45
    gradient.Parent = parent
    return gradient
end

local function createGlowEffect(parent, color, size, transparency)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    glow.ImageColor3 = color or Color3.fromRGB(255, 255, 255)
    glow.ImageTransparency = transparency or 0.7
    glow.Size = UDim2.new(1, size or 20, 1, size or 20)
    glow.Position = UDim2.new(0, -(size or 20)/2, 0, -(size or 20)/2)
    glow.ZIndex = -1
    glow.Parent = parent
    return glow
end

local function createDropShadow(parent)
    local shadow = Instance.new("Frame")
    shadow.Name = "DropShadow"
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.8
    shadow.Position = UDim2.new(0, 3, 0, 3)
    shadow.Size = UDim2.new(1, 0, 1, 0)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent.Parent
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 12)
    shadowCorner.Parent = shadow
    
    return shadow
end

local function animateButtonPress(button)
    local originalSize = button.Size
    local pressedSize = UDim2.new(originalSize.X.Scale * 0.95, originalSize.X.Offset, originalSize.Y.Scale * 0.95, originalSize.Y.Offset)
    
    local pressDownTween = TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = pressedSize})
    local releaseUpTween = TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = originalSize})
    
    pressDownTween:Play()
    pressDownTween.Completed:Connect(function()
        releaseUpTween:Play()
    end)
end

--- Function to create enhanced choice menu
local function createChoiceMenu(gameConfig)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Create GUI with blur background
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ZZZHubChooser"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    
    -- Background blur overlay
    local blurFrame = Instance.new("Frame")
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.Position = UDim2.new(0, 0, 0, 0)
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 0.3
    blurFrame.BorderSizePixel = 0
    blurFrame.ZIndex = 1
    blurFrame.Parent = screenGui
    
    -- Main frame - Enhanced with gradient background
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.8, 0, 0.8, 0)
    frame.Position = UDim2.new(0.1, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = screenGui
    
    -- Enhanced corner rounding
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 16)
    frameCorner.Parent = frame
    
    -- Gradient background
    createGradientBackground(frame, Color3.fromRGB(25, 25, 35), Color3.fromRGB(35, 35, 50), 135)
    
    -- Glow border effect
    local glowStroke = Instance.new("UIStroke")
    glowStroke.Color = Color3.fromRGB(100, 100, 255)
    glowStroke.Thickness = 2
    glowStroke.Transparency = 0.3
    glowStroke.Parent = frame
    
    -- Drop shadow
    createDropShadow(frame)
    
    -- Animated entrance
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    local entranceTween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.8, 0, 0.8, 0),
        Position = UDim2.new(0.1, 0, 0.1, 0)
    })
    entranceTween:Play()
    
    -- Header section with enhanced styling
    local headerFrame = Instance.new("Frame")
    headerFrame.Size = UDim2.new(1, 0, 0, 120)
    headerFrame.Position = UDim2.new(0, 0, 0, 0)
    headerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    headerFrame.BorderSizePixel = 0
    headerFrame.ZIndex = 3
    headerFrame.Parent = frame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = headerFrame
    
    -- Header gradient
    createGradientBackground(headerFrame, Color3.fromRGB(40, 40, 60), Color3.fromRGB(60, 40, 80), 90)
    
    -- Emoji icon with glow effect
    local emojiLabel = Instance.new("TextLabel")
    emojiLabel.Size = UDim2.new(0, 60, 0, 60)
    emojiLabel.Position = UDim2.new(0, 25, 0, 15)
    emojiLabel.BackgroundTransparency = 1
    emojiLabel.Text = gameConfig.emoji
    emojiLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    emojiLabel.TextScaled = true
    emojiLabel.Font = Enum.Font.SourceSansBold
    emojiLabel.ZIndex = 4
    emojiLabel.Parent = headerFrame
    
    -- Create glow for emoji
    createGlowEffect(emojiLabel, Color3.fromRGB(255, 255, 100), 10, 0.6)
    
    -- Enhanced title with better typography
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 0, 50)
    title.Position = UDim2.new(0, 100, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = gameConfig.name .. " Hub Collection"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 4
    title.Parent = headerFrame
    
    -- Enhanced subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -100, 0, 30)
    subtitle.Position = UDim2.new(0, 100, 0, 70)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Choose your preferred script from the collection below"
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.ZIndex = 4
    subtitle.Parent = headerFrame
    
    -- Script count indicator
    local countLabel = Instance.new("TextLabel")
    countLabel.Size = UDim2.new(0, 80, 0, 25)
    countLabel.Position = UDim2.new(1, -90, 0, 20)
    countLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    countLabel.Text = #gameConfig.scripts .. " Scripts"
    countLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    countLabel.TextScaled = true
    countLabel.Font = Enum.Font.GothamSemibold
    countLabel.ZIndex = 4
    countLabel.Parent = headerFrame
    
    local countCorner = Instance.new("UICorner")
    countCorner.CornerRadius = UDim.new(0, 12)
    countCorner.Parent = countLabel
    
    -- Enhanced ScrollingFrame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -140)
    scrollFrame.Position = UDim2.new(0, 10, 0, 130)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)
    scrollFrame.ScrollBarImageTransparency = 0.2
    scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    scrollFrame.ScrollingEnabled = true
    scrollFrame.ZIndex = 3
    scrollFrame.Parent = frame
    
    -- Enhanced list layout with better spacing
    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 15)
    listLayout.Parent = scrollFrame
    
    -- Enhanced padding
    local scrollPadding = Instance.new("UIPadding")
    scrollPadding.PaddingTop = UDim.new(0, 15)
    scrollPadding.PaddingLeft = UDim.new(0, 15)
    scrollPadding.PaddingRight = UDim.new(0, 15)
    scrollPadding.PaddingBottom = UDim.new(0, 15)
    scrollPadding.Parent = scrollFrame
    
    -- Update canvas size
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 30)
    end)
    
    -- Create enhanced buttons for each script
    for i, script in pairs(gameConfig.scripts) do
        -- Button container frame
        local buttonContainer = Instance.new("Frame")
        buttonContainer.Size = UDim2.new(1, -10, 0, 65)
        buttonContainer.BackgroundTransparency = 1
        buttonContainer.LayoutOrder = i
        buttonContainer.ZIndex = 3
        buttonContainer.Parent = scrollFrame
        
        -- Enhanced button with gradient and effects
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.Position = UDim2.new(0, 0, 0, 0)
        button.BackgroundColor3 = script.color
        button.Text = ""
        button.ZIndex = 4
        button.Parent = buttonContainer
        
        -- Button corner
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 12)
        buttonCorner.Parent = button
        
        -- Enhanced gradient for buttons
        createGradientBackground(button, script.color, Color3.new(
            math.min(1, script.color.R + 0.1),
            math.min(1, script.color.G + 0.1),
            math.min(1, script.color.B + 0.1)
        ), 45)
        
        -- Button stroke
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Color = Color3.fromRGB(255, 255, 255)
        buttonStroke.Thickness = 1
        buttonStroke.Transparency = 0.8
        buttonStroke.Parent = button
        
        -- Button text with icon
        local buttonText = Instance.new("TextLabel")
        buttonText.Size = UDim2.new(1, -20, 1, 0)
        buttonText.Position = UDim2.new(0, 10, 0, 0)
        buttonText.BackgroundTransparency = 1
        buttonText.Text = "🚀 " .. script.name
        buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
        buttonText.TextScaled = true
        buttonText.Font = Enum.Font.GothamBold
        buttonText.TextXAlignment = Enum.TextXAlignment.Left
        buttonText.ZIndex = 5
        buttonText.Parent = button
        
        -- Loading indicator (hidden initially)
        local loadingSpinner = Instance.new("TextLabel")
        loadingSpinner.Size = UDim2.new(0, 30, 0, 30)
        loadingSpinner.Position = UDim2.new(1, -40, 0.5, -15)
        loadingSpinner.BackgroundTransparency = 1
        loadingSpinner.Text = "⟳"
        loadingSpinner.TextColor3 = Color3.fromRGB(255, 255, 255)
        loadingSpinner.TextScaled = true
        loadingSpinner.Font = Enum.Font.GothamBold
        loadingSpinner.Visible = false
        loadingSpinner.ZIndex = 5
        loadingSpinner.Parent = button
        
        -- Enhanced hover effects
        local originalColor = script.color
        local hoverColor = Color3.new(
            math.min(1, originalColor.R + 0.15),
            math.min(1, originalColor.G + 0.15),
            math.min(1, originalColor.B + 0.15)
        )
        
        local hoverTween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = hoverColor})
        local unhoverTween = TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = originalColor})
        
        button.MouseEnter:Connect(function()
            hoverTween:Play()
            TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.4}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            unhoverTween:Play()
            TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
        end)
        
        -- Enhanced click event with animations
        button.MouseButton1Click:Connect(function()
            animateButtonPress(button)
            
            -- Show loading state
            buttonText.Text = "Loading..."
            loadingSpinner.Visible = true
            
            -- Animate loading spinner
            local spinTween = TweenService:Create(loadingSpinner, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
            spinTween:Play()
            
            -- Update header
            title.Text = "Loading " .. script.name
            subtitle.Text = "Please wait while the script loads..."
            
            -- Disable all buttons
            for _, child in pairs(scrollFrame:GetChildren()) do
                if child:IsA("Frame") then
                    local btn = child:FindFirstChild("TextButton")
                    if btn and btn ~= button then
                        btn.Active = false
                        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0.7}):Play()
                    end
                end
            end
            
            -- Load script with enhanced error handling
            task.spawn(function()
                local success, result = pcall(function()
                    loadstring(game:HttpGet(script.url))()
                end)
                
                if success then
                    -- Success animation
                    buttonText.Text = "✅ Loaded Successfully!"
                    wait(1.5)
                    
                    -- Fade out animation
                    local fadeOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
                        Size = UDim2.new(0, 0, 0, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    })
                    fadeOut:Play()
                    TweenService:Create(blurFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                    
                    fadeOut.Completed:Connect(function()
                        screenGui:Destroy()
                    end)
                else
                    -- Error state
                    buttonText.Text = "❌ Failed to Load"
                    buttonText.TextColor3 = Color3.fromRGB(255, 100, 100)
                    loadingSpinner.Visible = false
                    
                    -- Re-enable buttons after error
                    wait(2)
                    buttonText.Text = "🚀 " .. script.name
                    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
                    
                    for _, child in pairs(scrollFrame:GetChildren()) do
                        if child:IsA("Frame") then
                            local btn = child:FindFirstChild("TextButton")
                            if btn then
                                btn.Active = true
                                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                            end
                        end
                    end
                end
            end)
        end)
    end
    
    -- Enhanced close button with better positioning
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.Position = UDim2.new(1, -45, 0, 10)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.ZIndex = 5
    closeButton.Parent = frame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    -- Close button hover effect
    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
    end)
    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        animateButtonPress(closeButton)
        
        -- Enhanced close animation
        local closeTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        closeTween:Play()
        TweenService:Create(blurFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        
        closeTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
    
    -- Auto-close with countdown
    local autoCloseTime = 45
    task.spawn(function()
        for i = autoCloseTime, 1, -1 do
            if not screenGui.Parent then break end
            if i <= 10 then
                subtitle.Text = "Auto-closing in " .. i .. " seconds..."
                subtitle.TextColor3 = Color3.fromRGB(255, 200, 100)
            end
            wait(1)
        end
        
        if screenGui.Parent then
            closeButton.MouseButton1Click:Connect(function() end) -- Trigger close
            task.wait(0.1)
            screenGui:Destroy()
        end
    end)
    
    -- Enhanced notification
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🎮 " .. gameConfig.name .. " Hub Collection";
        Text = "Premium UI loaded! Choose your script from " .. #gameConfig.scripts .. " available options.";
        Duration = 4;
    })
end

-- Main execution
local currentGame = findCurrentGame()

if currentGame then
    -- Game is supported, show enhanced chooser
    createChoiceMenu(currentGame)
else
    -- Enhanced not supported message
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚠️ Game Not Supported";
        Text = "This game isn't in our collection yet. Join our Discord to request support!";
        Duration = 6;
    })
end
