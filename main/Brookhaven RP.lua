local Libary = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()
workspace.FallenPartsDestroyHeight = -math.huge

local Window = Libary:MakeWindow({
    Title = "zzz hub| Brookhaven RP ",
    SubTitle = "by: ktro and ktro",
    LoadText = "Loading zzz hub",
    Flags = "ChaosHub_Broookhaven"
})
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://131669852271916", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

local InfoTab = Window:MakeTab({ Title = "Info", Icon = "rbxassetid://15309138473" })

InfoTab:AddSection({ "Script Information" })
InfoTab:AddParagraph({ "Owner / Developer:", "Luscaa and venom." })
InfoTab:AddParagraph({ "Collaborations:", "Blue, sukuna, Magekko, Darkness, Star, Toddy" })
InfoTab:AddParagraph({ "You are using:", "Chaos Hub Brookhaven " })
InfoTab:AddParagraph({"Your executor:", executor})

InfoTab:AddSection({ "Rejoin" })
InfoTab:AddButton({
    Name = "Rejoin",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

local TrollTab = Window:MakeTab({ Title = "Troll Scripts", Icon = "rbxassetid://13364900349" })

TrollTab:AddSection({ "Black Hole" })
TrollTab:AddButton({
    Name = "Black Hole",
    Description = "Activating this pulls Parts to your character",
    Callback = function()
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local angle = 1
local radius = 10
local blackHoleActive = false

local function setupPlayer()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local Folder = Instance.new("Folder", Workspace)
    local Part = Instance.new("Part", Folder)
    local Attachment1 = Instance.new("Attachment", Part)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1

    return humanoidRootPart, Attachment1
end

local humanoidRootPart, Attachment1 = setupPlayer()

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(part)
        if typeof(part) == "Instance" and part:IsA("BasePart") and part:IsDescendantOf(Workspace) then
            table.insert(Network.BaseParts, part)
            part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            part.CanCollide = false
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = Workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, part in pairs(Network.BaseParts) do
                if part:IsDescendantOf(Workspace) then
                    part.Velocity = Network.Velocity
                end
            end
        end)
    end

    EnablePartControl()
end

local function ForcePart(v)
    if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
        for _, x in next, v:GetChildren() do
            if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                x:Destroy()
            end
        end
        if v:FindFirstChild("Attachment") then
            v:FindFirstChild("Attachment"):Destroy()
        end
        if v:FindFirstChild("AlignPosition") then
            v:FindFirstChild("AlignPosition"):Destroy()
        end
        if v:FindFirstChild("Torque") then
            v:FindFirstChild("Torque"):Destroy()
        end
        v.CanCollide = false
        
        local Torque = Instance.new("Torque", v)
        Torque.Torque = Vector3.new(1000000, 1000000, 1000000)
        local AlignPosition = Instance.new("AlignPosition", v)
        local Attachment2 = Instance.new("Attachment", v)
        Torque.Attachment0 = Attachment2
        AlignPosition.MaxForce = math.huge
        AlignPosition.MaxVelocity = math.huge
        AlignPosition.Responsiveness = 500
        AlignPosition.Attachment0 = Attachment2
        AlignPosition.Attachment1 = Attachment1
    end
end

local function toggleBlackHole()
    blackHoleActive = not blackHoleActive
    if blackHoleActive then
        for _, v in next, Workspace:GetDescendants() do
            ForcePart(v)
        end

        Workspace.DescendantAdded:Connect(function(v)
            if blackHoleActive then
                ForcePart(v)
            end
        end)

        spawn(function()
            while blackHoleActive and RunService.RenderStepped:Wait() do
                angle = angle + math.rad(2)

                local offsetX = math.cos(angle) * radius
                local offsetZ = math.sin(angle) * radius

                Attachment1.WorldCFrame = humanoidRootPart.CFrame * CFrame.new(offsetX, 0, offsetZ)
            end
        end)
    else
        Attachment1.WorldCFrame = CFrame.new(0, -1000, 0)
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    humanoidRootPart, Attachment1 = setupPlayer()
    if blackHoleActive then
        toggleBlackHole()
    end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()
local window = library:Window("Project LKB")

window:Slider("Radius Blackhole",1,100,10, function(Value)
   radius = Value
end)

window:Toggle("Blackhole", true, function(Value)
       if Value then
            toggleBlackHole()
        else
            blackHoleActive = false
        end
end)

spawn(function()
    while true do
        RunService.RenderStepped:Wait()
        if blackHoleActive then
            angle = angle + math.rad(angleSpeed)
        end
    end
end)

toggleBlackHole()
    end
})

TrollTab:AddSection({ "Pull Parts" })
TrollTab:AddButton({
    Name = "Pull Parts",
    Description = "To use, get close to the selected player",
    Callback = function()
        -- Gui to Lua
-- Version: 3.2

-- Instances:

local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Box = Instance.new("TextBox")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local Label = Instance.new("TextLabel")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local Button = Instance.new("TextButton")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")

--Properties:

Gui.Name = "Gui"
Gui.Parent = gethui()
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.335954279, 0, 0.542361975, 0)
Main.Size = UDim2.new(0.240350261, 0, 0.166880623, 0)
Main.Active = true
Main.Draggable = true

Box.Name = "Box"
Box.Parent = Main
Box.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
Box.BorderSizePixel = 0
Box.Position = UDim2.new(0.0980926454, 0, 0.218712583, 0)
Box.Size = UDim2.new(0.801089942, 0, 0.364963502, 0)
Box.FontFace = Font.new("rbxasset://fonts/families/SourceSansSemibold.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Box.PlaceholderText = "Player here"
Box.Text = ""
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.TextScaled = true
Box.TextSize = 31.000
Box.TextWrapped = true

UITextSizeConstraint.Parent = Box
UITextSizeConstraint.MaxTextSize = 31

Label.Name = "Label"
Label.Parent = Main
Label.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
Label.BorderSizePixel = 0
Label.Size = UDim2.new(1, 0, 0.160583943, 0)
Label.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Label.Text = "Bring Parts | Made by: Lusquinha_067"
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextScaled = true
Label.TextSize = 14.000
Label.TextWrapped = true

UITextSizeConstraint_2.Parent = Label
UITextSizeConstraint_2.MaxTextSize = 21

Button.Name = "Button"
Button.Parent = Main
Button.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
Button.BorderSizePixel = 0
Button.Position = UDim2.new(0.183284417, 0, 0.656760991, 0)
Button.Size = UDim2.new(0.629427791, 0, 0.277372271, 0)
Button.Font = Enum.Font.Nunito
Button.Text = "Bring | Off"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true
Button.TextSize = 28.000
Button.TextWrapped = true

UITextSizeConstraint_3.Parent = Button
UITextSizeConstraint_3.MaxTextSize = 28

-- Scripts:

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local character
local humanoidRootPart

mainStatus = true
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
		mainStatus = not mainStatus
		Main.Visible = mainStatus
	end
end)

local Folder = Instance.new("Folder", Workspace)
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
	}

	Network.RetainPart = function(Part)
		if Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
			table.insert(Network.BaseParts, Part)
			Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			Part.CanCollide = false
		end
	end

	local function EnablePartControl()
		LocalPlayer.ReplicationFocus = Workspace
		RunService.Heartbeat:Connect(function()
			sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
			for _, Part in pairs(Network.BaseParts) do
				if Part:IsDescendantOf(Workspace) then
					Part.Velocity = Network.Velocity
				end
			end
		end)
	end

	EnablePartControl()
end

local function ForcePart(v)
	if v:IsA("BasePart") and not v.Anchored and not v.Parent:FindFirstChildOfClass("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
		for _, x in ipairs(v:GetChildren()) do
			if x:IsA("BodyMover") or x:IsA("RocketPropulsion") then
				x:Destroy()
			end
		end
		if v:FindFirstChild("Attachment") then
			v:FindFirstChild("Attachment"):Destroy()
		end
		if v:FindFirstChild("AlignPosition") then
			v:FindFirstChild("AlignPosition"):Destroy()
		end
		if v:FindFirstChild("Torque") then
			v:FindFirstChild("Torque"):Destroy()
		end
		v.CanCollide = false
		local Torque = Instance.new("Torque", v)
		Torque.Torque = Vector3.new(100000, 100000, 100000)
		local AlignPosition = Instance.new("AlignPosition", v)
		local Attachment2 = Instance.new("Attachment", v)
		Torque.Attachment0 = Attachment2
		AlignPosition.MaxForce = math.huge
		AlignPosition.MaxVelocity = math.huge
		AlignPosition.Responsiveness = 200
		AlignPosition.Attachment0 = Attachment2
		AlignPosition.Attachment1 = Attachment1
	end
end

local blackHoleActive = false
local DescendantAddedConnection

local function toggleBlackHole()
	blackHoleActive = not blackHoleActive
	if blackHoleActive then
		Button.Text = "Bring Parts | On"
		for _, v in ipairs(Workspace:GetDescendants()) do
			ForcePart(v)
		end

		DescendantAddedConnection = Workspace.DescendantAdded:Connect(function(v)
			if blackHoleActive then
				ForcePart(v)
			end
		end)

		spawn(function()
			while blackHoleActive and RunService.RenderStepped:Wait() do
				Attachment1.WorldCFrame = humanoidRootPart.CFrame
			end
		end)
	else
		Button.Text = "Bring Parts | Off"
		if DescendantAddedConnection then
			DescendantAddedConnection:Disconnect()
		end
	end
end

local function getPlayer(name)
	local lowerName = string.lower(name)
	for _, p in pairs(Players:GetPlayers()) do
		local lowerPlayer = string.lower(p.Name)
		if string.find(lowerPlayer, lowerName) then
			return p
		elseif string.find(string.lower(p.DisplayName), lowerName) then
			return p
		end
	end
end

local player = nil

local function VDOYZQL_fake_script() -- Box.Script 
	local script = Instance.new('Script', Box)

	script.Parent.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			player = getPlayer(Box.Text)
			if player then
				Box.Text = player.Name
				print("Player found:", player.Name)
			else
				print("Player not found")
			end
		end
	end)
end
coroutine.wrap(VDOYZQL_fake_script)()
local function JUBNQKI_fake_script() -- Button.Script 
	local script = Instance.new('Script', Button)

	script.Parent.MouseButton1Click:Connect(function()
		if player then
			character = player.Character or player.CharacterAdded:Wait()
			humanoidRootPart = character:WaitForChild("HumanoidRootPart")
			toggleBlackHole()
		else
			print("Player is not selected")
		end
	end)
end
coroutine.wrap(JUBNQKI_fake_script)()
    end
})

TrollTab:AddSection({ "Invisible" })

TrollTab:AddButton({
    Name = "Become Invisible",
    Description = "Become invisible FE",
Callback = function()
        
        local args = {
    [1] = {
        [1] = 102344834840946,
        [2] = 70400527171038,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Wear"):InvokeServer(111858803548721)
local allaccessories = {}

for zxcwefwfecas, xcaefwefas in ipairs({
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.BackAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.FaceAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.FrontAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.NeckAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.HatAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.HairAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.ShouldersAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.WaistAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.GraphicTShirt
}) do
    for scacvdfbdb in string.gmatch(xcaefwefas, "%d+") do
        table.insert(allaccessories, tonumber(scacvdfbdb))
    end
end

wait()

for asdwr,asderg in ipairs(allaccessories) do
    task.spawn(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Wear"):InvokeServer(asderg)
        print(asderg)
    end)
end
    end
})

TrollTab:AddSection({ "RGB Avatar" })

local colors = { "Bright red", "Lime green", "Bright blue", "Bright yellow", "Bright cyan", "Hot pink", "Royal purple" }
local rgbEnabled = false

local function changeColor(color)
    local args = { color }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeBodyColor"):FireServer(unpack(args))
end

local function toggleRGBCharacter(enabled)
    rgbEnabled = enabled
    if rgbEnabled then
        while rgbEnabled do
            for _, color in ipairs(colors) do
                if not rgbEnabled then return end
                changeColor(color)
                wait(0.5)
            end
        end
    end
end

TrollTab:AddToggle({
    Name = "RGB Character",
    Description = "Makes your character RGB",
    Default = false,
    Callback = function(value)
        toggleRGBCharacter(value)
    end
})

TrollTab:AddSection({ "RGB Hair" })
local hairColors = {
    Color3.new(1, 1, 0), Color3.new(0, 0, 1), Color3.new(1, 0, 1), Color3.new(1, 1, 1),
    Color3.new(0, 1, 0), Color3.new(0.5, 0, 1), Color3.new(1, 0.647, 0), Color3.new(0, 1, 1)
}
local isActive = false

local function changeHairColor()
    local i = 1
    while isActive do
        if not isActive then break end
        local args = { [1] = "ChangeHairColor2", [2] = hairColors[i] }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Max1y"):FireServer(unpack(args))
        wait(0.1)
        i = i % #hairColors + 1
    end
end

TrollTab:AddToggle({
    Name = "RGB Hair",
    Description = "Makes your hair RGB",
    Default = false,
    Callback = function(value)
        isActive = value
        if isActive then
            changeHairColor()
        end
    end
})

-- Tab 4: Anti Sit
TrollTab:AddSection({ "Anti Sit" })
TrollTab:AddToggle({
    Name = "Anti Sit",
    Description = "Doesn't let your character sit",
    Default = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local connections = {}
        local runService = game:GetService("RunService")

        local function preventSitting(humanoid)
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                local sitConnection = humanoid.StateChanged:Connect(function(_, newState)
                    if newState == Enum.HumanoidStateType.Seated then
                        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end)
                table.insert(connections, sitConnection)
            end
        end

        local function monitorCharacter()
            local function onCharacterAdded(character)
                local humanoid = character:WaitForChild("Humanoid")
                preventSitting(humanoid)
            end

            local characterAddedConnection = player.CharacterAdded:Connect(onCharacterAdded)
            table.insert(connections, characterAddedConnection)

            if player.Character then
                onCharacterAdded(player.Character)
            end
        end

        local function resetSitting()
            for _, connection in ipairs(connections) do
                connection:Disconnect()
            end
            connections = {}
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            end
        end

        if Value then
            monitorCharacter()
            local heartbeatConnection = runService.Heartbeat:Connect(function()
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                end
            end)
            table.insert(connections, heartbeatConnection)
        else
            resetSitting()
        end
    end
})

local Troll = Window:MakeTab({ Title = "Troll Players", Icon = "rbxassetid://131153193945220" })

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local cam = workspace.CurrentCamera

local selectedPlayerName = nil
local methodKill = nil
getgenv().Target = nil
local Character = LocalPlayer.Character
local Humanoid = Character and Character:WaitForChild("Humanoid")
local RootPart = Character and Character:WaitForChild("HumanoidRootPart")

-- Function to clean up the couch
local function cleanupCouch()
    local char = LocalPlayer.Character
    if char then
        local couch = char:FindFirstChild("Chaos.Couch") or LocalPlayer.Backpack:FindFirstChild("Chaos.Couch")
        if couch then
            couch:Destroy()
        end
    end
    -- Clear tools via remote
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
end

-- Connect CharacterAdded event
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = newCharacter:WaitForChild("Humanoid")
    RootPart = newCharacter:WaitForChild("HumanoidRootPart")
    cleanupCouch()
    
    -- Connect Died event for the new Humanoid
    Humanoid.Died:Connect(function()
        cleanupCouch()
    end)
end)

-- Connect Died event for the initial Humanoid, if it exists
if Humanoid then
    Humanoid.Died:Connect(function()
        cleanupCouch()
    end)
end

-- KillPlayerCouch Function
local function KillPlayerCouch()
    if not selectedPlayerName then
        warn("Error: No player selected")
        return
    end
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then
        warn("Error: Target player not found or no character")
        return
    end

    local char = LocalPlayer.Character
    if not char then
        warn("Error: Local player character not found")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not root or not tRoot then
        warn("Error: Necessary components not found")
        return
    end

    local originalPos = root.Position 
    local sitPos = Vector3.new(145.51, -350.09, 21.58)

    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)

    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)

    local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
    if tool then tool.Parent = char end
    task.wait(0.1)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

    local align = Instance.new("BodyPosition")
    align.Name = "BringPosition"
    align.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    align.D = 10
    align.P = 30000
    align.Position = root.Position
    align.Parent = tRoot

    task.spawn(function()
        local angle = 0
        local startTime = tick()
        while tick() - startTime < 5 and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = target.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end

            local hrp = target.Character.HumanoidRootPart
            local adjustedPos = hrp.Position + (hrp.Velocity / 1.5)

            angle += 50
            root.CFrame = CFrame.new(adjustedPos + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angle), 0, 0)
            align.Position = root.Position + Vector3.new(2, 0, 0)

            task.wait()
        end

        align:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        cam.CameraSubject = hum

        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end

        task.wait(0.1)
        root.CFrame = CFrame.new(sitPos)
        task.wait(0.3)

        local tool = char:FindFirstChild("Couch")
        if tool then tool.Parent = LocalPlayer.Backpack end

        task.wait(0.01)
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        task.wait(0.2)
        root.CFrame = CFrame.new(originalPos)
    end)
end

-- BringPlayerLLL Function
local function BringPlayerLLL()
    if not selectedPlayerName then
        warn("Error: No player selected")
        return
    end
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then
        warn("Error: Target player not found or no character")
        return
    end

    local char = LocalPlayer.Character
    if not char then
        warn("Error: Local player character not found")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not root or not tRoot then
        warn("Error: Necessary components not found")
        return
    end

    local originalPos = root.Position 
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)

    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)

    local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
    if tool then
        tool.Parent = char
    end
    task.wait(0.1)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

    local align = Instance.new("BodyPosition")
    align.Name = "BringPosition"
    align.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    align.D = 10
    align.P = 30000
    align.Position = root.Position
    align.Parent = tRoot

    task.spawn(function()
        local angle = 0
        local startTime = tick()
        while tick() - startTime < 5 and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = target.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end

            local hrp = target.Character.HumanoidRootPart
            local adjustedPos = hrp.Position + (hrp.Velocity / 1.5)

            angle += 50
            root.CFrame = CFrame.new(adjustedPos + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angle), 0, 0)
            align.Position = root.Position + Vector3.new(2, 0, 0)

            task.wait()
        end

        align:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        cam.CameraSubject = hum

        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end

        task.wait(0.1)
        root.Anchored = true
        root.CFrame = CFrame.new(originalPos)
        task.wait(0.001)
        root.Anchored = false

        task.wait(0.7)
        local tool = char:FindFirstChild("Couch")
        if tool then
            tool.Parent = LocalPlayer.Backpack
        end

        task.wait(0.001)
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    end)
end

-- BringWithCouch Function
local function BringWithCouch()
    local targetPlayer = Players:FindFirstChild(getgenv().Target)
    if not targetPlayer then
        warn("Error: No target player selected")
        return
    end
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Error: Target player has no character or HumanoidRootPart")
        return
    end

    local args = { [1] = "ClearAllTools" }
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

    local couch = LocalPlayer.Backpack:WaitForChild("Couch", 2)
    if not couch then
        warn("Error: Couch not found in Backpack")
        return
    end

    couch.Name = "Chaos.Couch"
    local seat1 = couch:FindFirstChild("Seat1")
    local seat2 = couch:FindFirstChild("Seat2")
    local handle = couch:FindFirstChild("Handle")
    if seat1 and seat2 and handle then
        seat1.Disabled = true
        seat2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Error: Couch components not found")
        return
    end
    couch.Parent = LocalPlayer.Character

    local tet = Instance.new("BodyVelocity", seat1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"

    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local tRoot = targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if not tRoot then break end
            pos.x = tRoot.Position.X + (tRoot.Velocity.X / 2)
            pos.y = tRoot.Position.Y + (tRoot.Velocity.Y / 2)
            pos.z = tRoot.Position.Z + (tRoot.Velocity.Z / 2)
            seat1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        couch.Parent = LocalPlayer.Backpack
        task.wait()
        couch:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        task.wait()
        couch.Parent = LocalPlayer.Backpack
        couch.Handle.Name = "Handle "
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        tet = Instance.new("BodyVelocity", seat1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until targetPlayer.Character and targetPlayer.Character.Humanoid and targetPlayer.Character.Humanoid.Sit == true
    task.wait()
    tet:Destroy()
    couch.Parent = LocalPlayer.Backpack
    task.wait()
    couch:FindFirstChild("Handle ").Name = "Handle"
    task.wait(0.3)
    couch.Parent = LocalPlayer.Character
    task.wait(0.3)
    couch.Grip = CFrame.new(Vector3.new(0, 0, 0))
    task.wait(0.3)
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end

-- KillWithCouch Function
local function KillWithCouch()
    local targetPlayer = Players:FindFirstChild(getgenv().Target)
    if not targetPlayer then
        warn("Error: No target player selected")
        return
    end
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Error: Target player has no character or HumanoidRootPart")
        return
    end

    local args = { [1] = "ClearAllTools" }
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

    local couch = LocalPlayer.Backpack:WaitForChild("Couch", 2)
    if not couch then
        warn("Error: Couch not found in Backpack")
        return
    end

    couch.Name = "Chaos.Couch"
    local seat1 = couch:FindFirstChild("Seat1")
    local seat2 = couch:FindFirstChild("Seat2")
    local handle = couch:FindFirstChild("Handle")
    if seat1 and seat2 and handle then
        seat1.Disabled = true
        seat2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Error: Couch components not found")
        return
    end
    couch.Parent = LocalPlayer.Character

    local tet = Instance.new("BodyVelocity", seat1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"

    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local tRoot = targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if not tRoot then break end
            pos.x = tRoot.Position.X + (tRoot.Velocity.X / 2)
            pos.y = tRoot.Position.Y + (tRoot.Velocity.Y / 2)
            pos.z = tRoot.Position.Z + (tRoot.Velocity.Z / 2)
            seat1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        couch.Parent = LocalPlayer.Backpack
        task.wait()
        couch:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        task.wait()
        couch.Parent = LocalPlayer.Backpack
        couch.Handle.Name = "Handle "
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        tet = Instance.new("BodyVelocity", seat1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until targetPlayer.Character and targetPlayer.Character.Humanoid and targetPlayer.Character.Humanoid.Sit == true
    task.wait()
    couch.Parent = LocalPlayer.Backpack
    seat1.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    seat2.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    couch.Parent = LocalPlayer.Character
    task.wait(0.1)
    couch.Parent = LocalPlayer.Backpack
    task.wait(2)
    local bv = seat1:FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W")
    if bv then bv:Destroy() end
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end
    local PlayerSection = Troll:AddSection({ Name = "Troll Player" })

    -- Function to get player list
    local function getPlayerList()
        local players = Players:GetPlayers()
        local playerNames = {}
        for _, player in ipairs(players) do
            if player ~= LocalPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        return playerNames
    end

    local killDropdown = Troll:AddDropdown({
        Name = "Select Player",
        Options = getPlayerList(),
        Default = "",
        Callback = function(value)
            selectedPlayerName = value
            getgenv().Target = value
            print("Player selected: " .. tostring(value))
        end
    })

    Troll:AddButton({
        Name = "Refresh Player List",
        Callback = function()
            local tablePlayers = Players:GetPlayers()
            local newPlayers = {}
            if killDropdown and #tablePlayers > 0 then
                for _, player in ipairs(tablePlayers) do
                    if player.Name ~= LocalPlayer.Name then
                        table.insert(newPlayers, player.Name)
                    end
                end
                killDropdown:Set(newPlayers)
                print("Player list updated: ", table.concat(newPlayers, ", "))
                if selectedPlayerName and not Players:FindFirstChild(selectedPlayerName) then
                    selectedPlayerName = nil
                    getgenv().Target = nil
                    killDropdown:SetValue("")
                    print("Selection reset, player is no longer in server.")
                end
            else
                print("Error: Dropdown not found or no players available.")
            end
        end
    })

    Troll:AddButton({
        Name = "Teleport to Player",
        Callback = function()
            if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
                print("Error: Player not selected or does not exist")
                return
            end
            local character = LocalPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then
                warn("Error: Local player's HumanoidRootPart not found")
                return
            end

            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            else
                print("Error: Target player not found or no HumanoidRootPart")
            end
        end
    })

    Troll:AddToggle({
        Name = "Spectate Player",
        Default = false,
        Callback = function(value)
            local Camera = workspace.CurrentCamera

            local function UpdateCamera()
                if value then
                    local targetPlayer = Players:FindFirstChild(selectedPlayerName)
                    if targetPlayer and targetPlayer.Character then
                        local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            Camera.CameraSubject = humanoid
                        end
                    end
                else
                    if LocalPlayer.Character then
                        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            Camera.CameraSubject = humanoid
                        end
                    end
                end
            end

            if value then
                if not getgenv().CameraConnection then
                    getgenv().CameraConnection = RunService.Heartbeat:Connect(UpdateCamera)
                end
            else
                if getgenv().CameraConnection then
                    getgenv().CameraConnection:Disconnect()
                    getgenv().CameraConnection = nil
                end
                UpdateCamera()
            end
        end
    })

    local MethodSection = Troll:AddSection({ Name = "Methods" })

    Troll:AddDropdown({
        Name = "Select Kill Method",
        Options = {"Bus", "Couch", "Couch Without going to target [BETA]"},
        Default = "",
        Callback = function(value)
            methodKill = value
            print("Method selected: " .. tostring(value))
        end
    })

    Troll:AddButton({
        Name = "Kill Player",
        Callback = function()
            if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
                print("Error: Player not selected or does not exist")
                return
            end
            if methodKill == "Couch" then
                KillPlayerCouch()
            elseif methodKill == "Couch Without going to target [BETA]" then
                KillWithCouch()
            else
                -- Bus method
                local character = LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then
                    warn("Error: Local player's HumanoidRootPart not found")
                    return
                end

                local originalPosition = humanoidRootPart.CFrame

                local function GetBus()
                    local vehicles = game.Workspace:FindFirstChild("Vehicles")
                    if vehicles then
                        return vehicles:FindFirstChild(LocalPlayer.Name .. "Car")
                    end
                    return nil
                end

                local bus = GetBus()

                if not bus then
                    humanoidRootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    local remoteEvent = ReplicatedStorage:FindFirstChild("RE")
                    if remoteEvent and remoteEvent:FindFirstChild("1Ca1r") then
                        remoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                    end
                    task.wait(1)
                    bus = GetBus()
                end

                if bus then
                    local seat = bus:FindFirstChild("Body") and bus.Body:FindFirstChild("VehicleSeat")
                    if seat and character:FindFirstChildOfClass("Humanoid") and not character.Humanoid.Sit then
                        repeat
                            humanoidRootPart.CFrame = seat.CFrame * CFrame.new(0, 2, 0)
                            task.wait()
                        until character.Humanoid.Sit or not bus.Parent
                        if character.Humanoid.Sit or not bus.Parent then
                            for k, v in pairs(bus.Body:GetChildren()) do
                                if v:IsA("Seat") then
                                    v.CanTouch = false
                                end
                            end
                        end
                    end
                end

                local function TrackPlayer()
                    while true do
                        if selectedPlayerName then
                            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
                            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                                if targetHumanoid and targetHumanoid.Sit then
                                    if character.Humanoid then
                                        bus:SetPrimaryPartCFrame(CFrame.new(9999, -450, 9999))
                                        print("Player sat, taking bus to void!")
                                        task.wait(0.2)

                                        local function simulateJump()
                                            local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                                            if humanoid then
                                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                            end
                                        end

                                        simulateJump()
                                        print("Simulating jump!")
                                        task.wait(0.5)
                                        humanoidRootPart.CFrame = originalPosition
                                        print("Player returned to initial position.")
                                    end
                                    break
                                else
                                    local targetRoot = targetPlayer.Character.HumanoidRootPart
                                    local time = tick() * 35
                                    local lateralOffset = math.sin(time) * 4
                                    local frontBackOffset = math.cos(time) * 20
                                    bus:SetPrimaryPartCFrame(targetRoot.CFrame * CFrame.new(lateralOffset, 0, frontBackOffset))
                                end
                            end
                        end
                        RunService.RenderStepped:Wait()
                    end
                end

                spawn(TrackPlayer)
            end
        end
    })

    Troll:AddButton({
        Name = "Pull Player",
        Callback = function()
            if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
                print("Error: Player not selected or does not exist")
                return
            end
            if methodKill == "Couch" then
                BringPlayerLLL()
            elseif methodKill == "Couch Without going to target [BETA]" then
                BringWithCouch()
            else
                -- Bus method
                local character = LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then
                    warn("Error: Local player's HumanoidRootPart not found")
                    return
                end

                local originalPosition = humanoidRootPart.CFrame

                local function GetBus()
                    local vehicles = game.Workspace:FindFirstChild("Vehicles")
                    if vehicles then
                        return vehicles:FindFirstChild(LocalPlayer.Name .. "Car")
                    end
                    return nil
                end

                local bus = GetBus()

                if not bus then
                    humanoidRootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    local remoteEvent = ReplicatedStorage:FindFirstChild("RE")
                    if remoteEvent and remoteEvent:FindFirstChild("1Ca1r") then
                        remoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                    end
                    task.wait(1)
                    bus = GetBus()
                end

                if bus then
                    local seat = bus:FindFirstChild("Body") and bus.Body:FindFirstChild("VehicleSeat")
                    if seat and character:FindFirstChildOfClass("Humanoid") and not character.Humanoid.Sit then
                        repeat
                            humanoidRootPart.CFrame = seat.CFrame * CFrame.new(0, 2, 0)
                            task.wait()
                        until character.Humanoid.Sit or not bus.Parent
                    end
                end

                local function TrackPlayer()
                    while true do
                        if selectedPlayerName then
                            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
                            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                                if targetHumanoid and targetHumanoid.Sit then
                                    if character.Humanoid then
                                        bus:SetPrimaryPartCFrame(originalPosition)
                                        task.wait(0.7)
                                        local args = { [1] = "DeleteAllVehicles" }
                                        ReplicatedStorage.RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                                    end
                                    break
                                else
                                    local targetRoot = targetPlayer.Character.HumanoidRootPart
                                    local time = tick() * 35
                                    local lateralOffset = math.sin(time) * 4
                                    local frontBackOffset = math.cos(time) * 20
                                    bus:SetPrimaryPartCFrame(targetRoot.CFrame * CFrame.new(lateralOffset, 0, frontBackOffset))
                                end
                            end
                        end
                        RunService.RenderStepped:Wait()
                    end
                end

                spawn(TrackPlayer)
            end
        end
    })

local function houseBanKill()
    if not selectedPlayerName then
        print("No player selected!")
        return
    end

    local Player = game.Players.LocalPlayer
    local Backpack = Player.Backpack
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Houses = game.Workspace:FindFirstChild("001_Lots")
    local OldPos = RootPart.CFrame
    local Angles = 0
    local Vehicles = Workspace.Vehicles
    local Pos

    function Check()
        if Player and Character and Humanoid and RootPart and Vehicles then
            return true
        else
            return false
        end
    end

    local selectedPlayer = game.Players:FindFirstChild(selectedPlayerName)
    if selectedPlayer and selectedPlayer.Character then
        if Check() then
            local House = Houses:FindFirstChild(Player.Name .. "House")
            if not House then
                local EHouse
                local availableHouses = {}
                
                -- Collect all available houses ("For Sale")
                for _, Lot in pairs(Houses:GetChildren()) do
                    if Lot.Name == "For Sale" then
                        for _, num in pairs(Lot:GetDescendants()) do
                            if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                                table.insert(availableHouses, {Lot = Lot, Number = num.Value})
                                break
                            end
                        end
                    end
                end

                -- Choose a random house from the list
                if #availableHouses > 0 then
                    local randomHouse = availableHouses[math.random(1, #availableHouses)]
                    EHouse = randomHouse.Lot
                    local houseNumber = randomHouse.Number

                    -- Teleport to BuyDetector and click
                    local BuyDetector = EHouse:FindFirstChild("BuyHouse")
                    Pos = BuyDetector.Position
                    if BuyDetector and BuyDetector:IsA("BasePart") then
                        RootPart.CFrame = BuyDetector.CFrame + Vector3.new(0, -6, 0)
                        task.wait(0.5)
                        local ClickDetector = BuyDetector:FindFirstChild("ClickDetector")
                        if ClickDetector then
                            fireclickdetector(ClickDetector)
                        end
                    end

                    -- Fire the new remote event to build the house
                    task.wait(0.5)
                    local args = {
                        houseNumber, -- Random house number
                        "056_House" -- House type
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Lot:BuildProperty"):FireServer(unpack(args))
                else
                    print("No house available for purchase!")
                    return
                end
            end

            task.wait(0.5)
            local PreHouse = Houses:FindFirstChild(Player.Name .. "House")
            if PreHouse then
                task.wait(0.5)
                local Number
                for i, x in pairs(PreHouse:GetDescendants()) do
                    if x.Name == "Number" and x:IsA("NumberValue") then
                        Number = x
                    end
                end
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse", "049_House", Number.Value)
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                if Check() then
                    RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                    task.wait(0.5)
                    local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
                    task.wait(0.5)
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat
                            task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if PCar then
                if not Humanoid.Sit then
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat
                            task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end

                local Target = selectedPlayer
                local TargetC = Target.Character
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetC and TargetH and TargetRP then
                    if not TargetH.Sit then
                        while not TargetH.Sit do
                            task.wait()
                            local Fling = function(alvo, pos, angulo)
                                PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                            end
                            Angles = Angles + 100
                            Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(2.25, 1.5, -2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        end
                        task.wait(0.2)
                        local House = Houses:FindFirstChild(Player.Name .. "House")
                        PCar:SetPrimaryPartCFrame(CFrame.new(House.HouseSpawnPosition.Position))
                        task.wait(0.2)
                        local pedro = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30, 30, 30), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30, 30, 30))
                        local a = workspace:FindPartsInRegion3(pedro, game.Players.LocalPlayer.Character.HumanoidRootPart, math.huge)
                        for i, v in pairs(a) do
                            if v.Name == "HumanoidRootPart" then
                                local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                                local args = {
                                    [1] = "BanPlayerFromHouse",
                                    [2] = b,
                                    [3] = v.Parent
                                }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
                                local args = {
                                    [1] = "DeleteAllVehicles"
                                }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
    end
end

Troll:AddButton({
    Name = "House Ban Kill",
    Callback = houseBanKill
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local cam = workspace.CurrentCamera
local currentPlayers, selectedPlayer = {}, nil
local viewing = false
local flingActive = false

Troll:AddToggle({
    Name = "Auto Fling ",
    Default = false,
    Callback = function(state)

        flingActive = state
        if state and selectedPlayerName then
            local target = Players:FindFirstChild(selectedPlayerName)
            if not target or not target.Character then return end
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            if not root or not tRoot then return end
            local char = LocalPlayer.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local original = root.CFrame

local args = {
	"ClearAllTools"
}
game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))

task.wait(0.2)


            local args = {
                [1] = "PickingTools",
                [2] = "Couch"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

            task.wait(0.3)
            local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
            if tool then
                tool.Parent = char
            end
				task.wait(0.2)
				game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
task.wait(0.25)

            workspace.FallenPartsDestroyHeight = 0/0
            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingForce"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(1/0, 1/0, 1/0)
            bv.Parent = root
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            hum.PlatformStand = false
            cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

            task.spawn(function()
                local angle = 0
                local parts = {root}
                while flingActive and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
                    local tHum = target.Character:FindFirstChildOfClass("Humanoid")
                    if tHum.Sit then break end
                    angle += 50

                    for _, part in ipairs(parts) do
                        local pos_x = target.Character.HumanoidRootPart.Position.X
                        local pos_y = target.Character.HumanoidRootPart.Position.Y
                        local pos_z = target.Character.HumanoidRootPart.Position.Z
                        pos_x = pos_x + (target.Character.HumanoidRootPart.Velocity.X / 1.5)
                        pos_y = pos_y + (target.Character.HumanoidRootPart.Velocity.Y / 1.5)
                        pos_z = pos_z + (target.Character.HumanoidRootPart.Velocity.Z / 1.5)
                        root.CFrame = CFrame.new(pos_x, pos_y, pos_z) * CFrame.Angles(math.rad(angle), 0, 0)
                    end

                    root.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    task.wait()
                end
                flingActive = false
                bv:Destroy()
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                hum.PlatformStand = false
                root.CFrame = original
                cam.CameraSubject = hum
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Velocity = Vector3.zero
                        p.RotVelocity = Vector3.zero
                    end
                end
                hum:UnequipTools()
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            end)
        end
    end
})

local function FlingBall(target)

    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")
    local backpack = player:WaitForChild("Backpack")
    local ServerBalls = workspace.WorkspaceCom:WaitForChild("001_SoccerBalls")

    local function GetBall()
        if not backpack:FindFirstChild("SoccerBall") then
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "SoccerBall")
        end
        repeat task.wait() until backpack:FindFirstChild("SoccerBall")
        backpack.SoccerBall.Parent = character
        repeat task.wait() until ServerBalls:FindFirstChild("Soccer" .. player.Name)
        character.SoccerBall.Parent = backpack
        return ServerBalls:FindFirstChild("Soccer" .. player.Name)
    end

    local Ball = ServerBalls:FindFirstChild("Soccer" .. player.Name) or GetBall()
    Ball.CanCollide = false
    Ball.Massless = true
    Ball.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)

    if target ~= player then
        local tchar = target.Character
        if tchar and tchar:FindFirstChild("HumanoidRootPart") and tchar:FindFirstChild("Humanoid") then
            local troot = tchar.HumanoidRootPart
            local thum = tchar.Humanoid

            if Ball:FindFirstChildWhichIsA("BodyVelocity") then
                Ball:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
            end

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingPower"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.P = 9e900
            bv.Parent = Ball

            workspace.CurrentCamera.CameraSubject = thum
            local StartTime = os.time()
            repeat
                if troot.Velocity.Magnitude > 0 then
                -- Adjusted position calculation based on target velocity
                local pos_x = troot.Position.X + (troot.Velocity.X / 1.5)
                local pos_y = troot.Position.Y + (troot.Velocity.Y / 1.5)
                local pos_z = troot.Position.Z + (troot.Velocity.Z / 1.5)

                -- Position the ball directly at the adjusted position
                local position = Vector3.new(pos_x, pos_y, pos_z)
                Ball.CFrame = CFrame.new(position)
                Ball.Orientation += Vector3.new(45, 60, 30)
else
for i, v in pairs(tchar:GetChildren()) do
if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
Ball.CFrame = v.CFrame
task.wait(1/6000)
end
end
end
                task.wait(1/6000)
            until troot.Velocity.Magnitude > 1000 or thum.Health <= 0 or not tchar:IsDescendantOf(workspace) or target.Parent ~= players
            workspace.CurrentCamera.CameraSubject = humanoid
        end
    end
end

Troll:AddButton({
    Name = "Fling Ball",
    Callback = function()
        FlingBall(game:GetService("Players")[selectedPlayerName])
    end
})

local Players = game:GetService('Players')
local lplayer = Players.LocalPlayer

local function isItemInInventory(itemName)
    for _, item in pairs(lplayer.Backpack:GetChildren()) do
        if item.Name == itemName then
            return true
        end
    end
    return false
end

local function equipItem(itemName)
    local item = lplayer.Backpack:FindFirstChild(itemName)
    if item then
        lplayer.Character.Humanoid:EquipTool(item)
    end
end

local function unequipItem(itemName)
    local item = lplayer.Character:FindFirstChild(itemName)
    if item then
        item.Parent = lplayer.Backpack
    end
end

local function ActiveAutoFling(targetPlayer)
    if not isItemInInventory("Couch") then
        local args = { [1] = "PickingTools", [2] = "Couch" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
    end

    equipItem("Couch")
    getgenv().flingloop = true

    while getgenv().flingloop do
        local function flingloopfix()
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local AllBool = false

            local SkidFling = function(TargetPlayer)
                local Character = Player.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Humanoid and Humanoid.RootPart
                local TCharacter = TargetPlayer.Character
                local THumanoid, TRootPart, THead, Accessory, Handle

                if TCharacter:FindFirstChildOfClass("Humanoid") then
                    THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
                end
                if THumanoid and THumanoid.RootPart then
                    TRootPart = THumanoid.RootPart
                end
                if TCharacter:FindFirstChild("Head") then
                    THead = TCharacter.Head
                end
                if TCharacter:FindFirstChildOfClass("Accessory") then
                    Accessory = TCharacter:FindFirstChildOfClass("Accessory")
                end
                if Accessory and Accessory:FindFirstChild("Handle") then
                    Handle = Accessory.Handle
                end

                if Character and Humanoid and RootPart then
                    if RootPart.Velocity.Magnitude < 50 then
                        getgenv().OldPos = RootPart.CFrame
                    end
                    if THumanoid and THumanoid.Sit and not AllBool then
                        unequipItem("Couch")
                        getgenv().flingloop = false
                        return
                    end
                    if THead then
                        workspace.CurrentCamera.CameraSubject = THead
                    elseif not THead and Handle then
                        workspace.CurrentCamera.CameraSubject = Handle
                    elseif THumanoid and TRootPart then
                        workspace.CurrentCamera.CameraSubject = THumanoid
                    end

                    if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                        return
                    end

                    local FPos = function(BasePart, Pos, Ang)
                        RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                        Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    end

                    local SFBasePart = function(BasePart)
                        local TimeToWait = 2
                        local Time = tick()
                        local Angle = 0
                        repeat
                            if RootPart and THumanoid then
                                if BasePart.Velocity.Magnitude < 50 then
                                    Angle = Angle + 100
                                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                else
                                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                end
                            else
                                break
                            end
                        until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait or getgenv().flingloop == false
                    end

                    workspace.FallenPartsDestroyHeight = 0/0
                    local BV = Instance.new("BodyVelocity")
                    BV.Name = "SpeedDoPai"
                    BV.Parent = RootPart
                    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                    if TRootPart and THead then
                        if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                            SFBasePart(THead)
                        else
                            SFBasePart(TRootPart)
                        end
                    elseif TRootPart and not THead then
                        SFBasePart(TRootPart)
                    elseif not TRootPart and THead then
                        SFBasePart(THead)
                    elseif not TRootPart and not THead and Accessory and Handle then
                        SFBasePart(Handle)
                    end
                    BV:Destroy()
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                    workspace.CurrentCamera.CameraSubject = Humanoid

                    repeat
                        RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                        Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                        Humanoid:ChangeState("GettingUp")
                        table.foreach(Character:GetChildren(), function(_, x)
                            if x:IsA("BasePart") then
                                x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                            end
                        end)
                        task.wait()
                    until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25

                    workspace.FallenPartsDestroyHeight = getgenv().FPDH
                end
            end

            if AllBool then
                for _, x in next, Players:GetPlayers() do
                    SkidFling(x)
                end
            end

            if targetPlayer then
                SkidFling(targetPlayer)
            end

            task.wait()
        end

        wait()
        pcall(flingloopfix)
    end
end

local kill = Troll:AddSection({Name = "Fling Boat"})

Troll:AddButton({
    Name = "Fling - Boat",
    Callback = function()
        if not selectedPlayerName or not game.Players:FindFirstChild(selectedPlayerName) then
            warn("No player selected or does not exist")
            return
        end

        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")

        if not Humanoid or not RootPart then
            warn("Invalid Humanoid or RootPart")
            return
        end

        local function spawnBoat()
            RootPart.CFrame = CFrame.new(1754, -2, 58)
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")
            task.wait(1)
            return Vehicles:FindFirstChild(Player.Name.."Car")
        end

        local PCar = Vehicles:FindFirstChild(Player.Name.."Car") or spawnBoat()
        if not PCar then
            warn("Failed to spawn boat")
            return
        end

        local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
        if not Seat then
            warn("Seat not found")
            return
        end

        repeat 
            task.wait(0.1)
            RootPart.CFrame = Seat.CFrame * CFrame.new(0, 1, 0)
        until Humanoid.SeatPart == Seat

        print("Boat spawned!")

        local TargetPlayer = game.Players:FindFirstChild(selectedPlayerName)
        if not TargetPlayer or not TargetPlayer.Character then
            warn("Player not found")
            return
        end

        local TargetC = TargetPlayer.Character
        local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
        local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")

        if not TargetRP or not TargetH then
            warn("Target Humanoid or RootPart not found")
            return
        end

        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = PCar.PrimaryPart
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0, 369, 0) 

        print("Fling active!")

        local function moveCar(TargetRP, offset)
            if PCar and PCar.PrimaryPart then
                PCar:SetPrimaryPartCFrame(CFrame.new(TargetRP.Position + offset))
            end
        end

        task.spawn(function()
            while PCar and PCar.Parent and TargetRP and TargetRP.Parent do
                task.wait(0.01) 
                
                moveCar(TargetRP, Vector3.new(0, 1, 0))  
                moveCar(TargetRP, Vector3.new(0, -2.25, 5))  
                moveCar(TargetRP, Vector3.new(0, 2.25, 0.25))  
                moveCar(TargetRP, Vector3.new(-2.25, -1.5, 2.25))  
                moveCar(TargetRP, Vector3.new(0, 1.5, 0))  
                moveCar(TargetRP, Vector3.new(0, -1.5, 0))  

                if PCar and PCar.PrimaryPart then
                    local Rotation = CFrame.Angles(
                        math.rad(math.random(-369, 369)),  
                        math.rad(math.random(-369, 369)), 
                        math.rad(math.random(-369, 369))
                    )
                    PCar:SetPrimaryPartCFrame(CFrame.new(TargetRP.Position + Vector3.new(0, 1.5, 0)) * Rotation)
                end
            end

            if Spin and Spin.Parent then
                Spin:Destroy()
                print("Fling deactivated")
            end
        end)
    end
})
print("Fling - Boat button created")

Troll:AddButton({
    Name = "Turn off Fling - Boat",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")

        if not RootPart or not Humanoid then
            warn("No RootPart or Humanoid found!")
            return
        end

        Humanoid.PlatformStand = true
        print("Player paralyzed to reduce spin effects.")

        for _, obj in pairs(RootPart:GetChildren()) do
            if obj:IsA("BodyAngularVelocity") or obj:IsA("BodyVelocity") then
                obj:Destroy()
            end
        end
        print("Spin and forces removed from player.")

        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
        task.wait(0.5)

        local PCar = Vehicles and Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar and PCar.PrimaryPart then
            for _, obj in pairs(PCar.PrimaryPart:GetChildren()) do
                if obj:IsA("BodyAngularVelocity") or obj:IsA("BodyVelocity") then
                    obj:Destroy()
                end
            end
            print("Spin removed from boat.")
        end

        task.wait(1)

        local safePos = Vector3.new(0, 1000, 0)
        local bp = Instance.new("BodyPosition", RootPart)
        bp.Position = safePos
        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

        local bg = Instance.new("BodyGyro", RootPart)
        bg.CFrame = RootPart.CFrame
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

        print("Player is stuck at safe coordinates.")

        task.wait(3)

        bp:Destroy()
        bg:Destroy()
        Humanoid.PlatformStand = false

        print("Player released, safe in position.")
    end
})

local kill = Troll:AddSection({Name = "Click Kill Methods"})

Troll:AddButton({
  Name = "Click Fling Doors [Beta]",
Description = "To Use, I recommend getting close to other doors, after it goes to you, click on the player you want to fling",
  Callback = function()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Invisible Target (BlackHole)
local BlackHole = Instance.new("Part")
BlackHole.Size = Vector3.new(100000, 100000, 100000)
BlackHole.Transparency = 1
BlackHole.Anchored = true
BlackHole.CanCollide = false
BlackHole.Name = "BlackHoleTarget"
BlackHole.Parent = Workspace

-- Base Attachment in BlackHole
local baseAttachment = Instance.new("Attachment")
baseAttachment.Name = "Luscaa_BlackHoleAttachment"
baseAttachment.Parent = BlackHole

-- Update BlackHole position
RunService.Heartbeat:Connect(function()
	BlackHole.CFrame = HRP.CFrame
end)

-- List of controlled doors
local ControlledDoors = {}

-- Prepares a door to be controlled
local function SetupPart(part)
	if not part:IsA("BasePart") or part.Anchored or not string.find(part.Name, "Door") then return end
	if part:FindFirstChild("Luscaa_Attached") then return end

	part.CanCollide = false

	for _, obj in ipairs(part:GetChildren()) do
		if obj:IsA("AlignPosition") or obj:IsA("Torque") or obj:IsA("Attachment") then
			obj:Destroy()
		end
	end

	local marker = Instance.new("BoolValue", part)
	marker.Name = "Luscaa_Attached"

	local a1 = Instance.new("Attachment", part)

	local align = Instance.new("AlignPosition", part)
	align.Attachment0 = a1
	align.Attachment1 = baseAttachment
	align.MaxForce = 1e20
	align.MaxVelocity = math.huge
	align.Responsiveness = 99999

	local torque = Instance.new("Torque", part)
	torque.Attachment0 = a1
	torque.RelativeTo = Enum.ActuatorRelativeTo.World
	torque.Torque = Vector3.new(
		math.random(-10e5, 10e5) * 10000,
		math.random(-10e5, 10e5) * 10000,
		math.random(-10e5, 10e5) * 10000
	)

	table.insert(ControlledDoors, {Part = part, Align = align})
end

-- Detects and prepares existing doors
for _, obj in ipairs(Workspace:GetDescendants()) do
	if obj:IsA("BasePart") and string.find(obj.Name, "Door") then
		SetupPart(obj)
	end
end

-- New doors in the future
Workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("BasePart") and string.find(obj.Name, "Door") then
		SetupPart(obj)
	end
end)

-- Fling player with timeout and return
local function FlingPlayer(player)
	local char = player.Character
	if not char then return end
	local targetHRP = char:FindFirstChild("HumanoidRootPart")
	if not targetHRP then return end

	local targetAttachment = targetHRP:FindFirstChild("SHNMAX_TargetAttachment")
	if not targetAttachment then
		targetAttachment = Instance.new("Attachment", targetHRP)
		targetAttachment.Name = "SHNMAX_TargetAttachment"
	end

	for _, data in ipairs(ControlledDoors) do
		if data.Align then
			data.Align.Attachment1 = targetAttachment
		end
	end

	local start = tick()
	local flingDetected = false

	while tick() - start < 5 do
		if targetHRP.Velocity.Magnitude >= 20 then
			flingDetected = true
			break
		end
		RunService.Heartbeat:Wait()
	end

	-- Always return the doors
	for _, data in ipairs(ControlledDoors) do
		if data.Align then
			data.Align.Attachment1 = baseAttachment
		end
	end
end

-- Click (works on mobile)
UserInputService.TouchTap:Connect(function(touchPositions, processed)
	if processed then return end
	local pos = touchPositions[1]
	local camera = Workspace.CurrentCamera
	local unitRay = camera:ScreenPointToRay(pos.X, pos.Y)
	local raycast = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)

	if raycast and raycast.Instance then
		local hit = raycast.Instance
		local player = Players:GetPlayerFromCharacter(hit:FindFirstAncestorOfClass("Model"))
		if player and player ~= LocalPlayer then
			FlingPlayer(player)
		end
	end
end)
  end
})


Troll:AddButton({
    Name = "Click Fling Couch (Tool)",
    Callback = function()

local jogadores = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local entrada = game:GetService("UserInputService")
local eu = jogadores.LocalPlayer
local cam = workspace.CurrentCamera

local podeClicar = true
local ferramentaEquipada = false
local NOME_FERRAMENTA = "Click Fling Couch"

local mochila = eu:WaitForChild("Backpack")

if not mochila:FindFirstChild(NOME_FERRAMENTA) and not (eu.Character and eu.Character:FindFirstChild(NOME_FERRAMENTA)) then
	local ferramenta = Instance.new("Tool")
	ferramenta.Name = NOME_FERRAMENTA
	ferramenta.RequiresHandle = false
	ferramenta.CanBeDropped = false

	ferramenta.Equipped:Connect(function()
		ferramentaEquipada = true
	end)

	ferramenta.Unequipped:Connect(function()
		ferramentaEquipada = false
	end)

	ferramenta.Parent = mochila
end

local function jogarComSofa(alvo)
	if not ferramentaEquipada then return end
	if not alvo or not alvo.Character or alvo == eu then return end

	local jogando = true
	local raiz = eu.Character and eu.Character:FindFirstChild("HumanoidRootPart")
	local alvoRaiz = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
	if not raiz or not alvoRaiz then return end

	local boneco = eu.Character
	local humano = boneco:FindFirstChildOfClass("Humanoid")
	local posOriginal = raiz.CFrame

	rep:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
	task.wait(0.2)

	rep.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
	task.wait(0.3)

	local sofa = eu.Backpack:FindFirstChild("Couch")
	if sofa then
		sofa.Parent = boneco
	end
	task.wait(0.1)

	game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
	task.wait(0.25)

	workspace.FallenPartsDestroyHeight = 0/0

	local forca = Instance.new("BodyVelocity")
	forca.Name = "ForcaJogada"
	forca.Velocity = Vector3.new(9e8, 9e8, 9e8)
	forca.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	forca.Parent = raiz

	humano:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	humano.PlatformStand = false
	cam.CameraSubject = alvo.Character:FindFirstChild("Head") or alvoRaiz or humano

	task.spawn(function()
		local angulo = 0
		local partes = {raiz}
		while jogando and alvo and alvo.Character and alvo.Character:FindFirstChildOfClass("Humanoid") do
			local alvoHum = alvo.Character:FindFirstChildOfClass("Humanoid")
			if alvoHum.Sit then break end
			angulo += 50

			for _, parte in ipairs(partes) do
				local hrp = alvo.Character.HumanoidRootPart
				local pos = hrp.Position + hrp.Velocity / 1.5
				raiz.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(angulo), 0, 0)
			end

			raiz.Velocity = Vector3.new(9e8, 9e8, 9e8)
			raiz.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
			task.wait()
		end

		jogando = false
		forca:Destroy()
		humano:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		humano.PlatformStand = false
		raiz.CFrame = posOriginal
		cam.CameraSubject = humano

		for _, p in pairs(boneco:GetDescendants()) do
			if p:IsA("BasePart") then
				p.Velocity = Vector3.zero
				p.RotVelocity = Vector3.zero
			end
		end

		humano:UnequipTools()
		rep.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
	end)

	while jogando do
		task.wait()
	end
end

entrada.TouchTap:Connect(function(toques, processado)
	if processado or not podeClicar or not ferramentaEquipada then return end

	local pos = toques[1]
	local raio = cam:ScreenPointToRay(pos.X, pos.Y)
	local acerto = workspace:Raycast(raio.Origin, raio.Direction * 1000)

	if acerto and acerto.Instance then
		local alvo = jogadores:GetPlayerFromCharacter(acerto.Instance:FindFirstAncestorOfClass("Model"))
		if alvo and alvo ~= eu then
			podeClicar = false
			jogarComSofa(alvo)
			task.delay(2, function()
				podeClicar = true
			end)
		end
	end
end)
end
})

Troll:AddButton({
    Name = "Click Fling Ball (Tool)",
    Callback = function()
local jogadores = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local mundo = game:GetService("Workspace")
local entrada = game:GetService("UserInputService")
local cam = mundo.CurrentCamera
local eu = jogadores.LocalPlayer

local NOME_FERRAMENTA = "Click Fling Ball"
local ferramentaEquipada = false

local mochila = eu:WaitForChild("Backpack")
if not mochila:FindFirstChild(NOME_FERRAMENTA) then
	local ferramenta = Instance.new("Tool")
	ferramenta.Name = NOME_FERRAMENTA
	ferramenta.RequiresHandle = false
	ferramenta.CanBeDropped = false

	ferramenta.Equipped:Connect(function()
		ferramentaEquipada = true
	end)

	ferramenta.Unequipped:Connect(function()
		ferramentaEquipada = false
	end)

	ferramenta.Parent = mochila
end

-- FlingBall function (ball)
local function FlingBall(target)
    

    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")
    local backpack = player:WaitForChild("Backpack")
    local ServerBalls = workspace.WorkspaceCom:WaitForChild("001_SoccerBalls")

    local function GetBall()
        if not backpack:FindFirstChild("SoccerBall") and not character:FindFirstChild("SoccerBall") then
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "SoccerBall")
        end

        repeat task.wait() until backpack:FindFirstChild("SoccerBall") or character:FindFirstChild("SoccerBall")

        local ballTool = backpack:FindFirstChild("SoccerBall")
        if ballTool then
            ballTool.Parent = character
        end

        repeat task.wait() until ServerBalls:FindFirstChild("Soccer" .. player.Name)

        return ServerBalls:FindFirstChild("Soccer" .. player.Name)
    end

    local Ball = ServerBalls:FindFirstChild("Soccer" .. player.Name) or GetBall()
    Ball.CanCollide = false
    Ball.Massless = true
    Ball.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)

    if target ~= player then
        local tchar = target.Character
        if tchar and tchar:FindFirstChild("HumanoidRootPart") and tchar:FindFirstChild("Humanoid") then
            local troot = tchar.HumanoidRootPart
            local thum = tchar.Humanoid

            if Ball:FindFirstChildWhichIsA("BodyVelocity") then
                Ball:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
            end

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingPower"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.P = 9e900
            bv.Parent = Ball

            workspace.CurrentCamera.CameraSubject = thum

            repeat
                if troot.Velocity.Magnitude > 0 then
                    local pos = troot.Position + (troot.Velocity / 1.5)
                    Ball.CFrame = CFrame.new(pos)
                    Ball.Orientation += Vector3.new(45, 60, 30)
                else
                    for i, v in pairs(tchar:GetChildren()) do
                        if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
                            Ball.CFrame = v.CFrame
                            task.wait(1/6000)
                        end
                    end
                end
                task.wait(1/6000)
            until troot.Velocity.Magnitude > 1000 or thum.Health <= 0 or not tchar:IsDescendantOf(workspace) or target.Parent ~= players

            workspace.CurrentCamera.CameraSubject = humanoid
        end
    end
end

-- Touch screen to apply the ball
entrada.TouchTap:Connect(function(toques, processado)
	if not ferramentaEquipada or processado then return end
	local pos = toques[1]
	local raio = cam:ScreenPointToRay(pos.X, pos.Y)
	local hit = mundo:Raycast(raio.Origin, raio.Direction * 1000)
	if hit and hit.Instance then
		local modelo = hit.Instance:FindFirstAncestorOfClass("Model")
		local jogador = jogadores:GetPlayerFromCharacter(modelo)
		if jogador and jogador ~= eu then
			FlingBall(jogador)
		end
	end
end)

end
})

Troll:AddButton({
    Name = "Click Kill Couch (Tool)",
    Callback = function()

local jogadores = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local loop = game:GetService("RunService")
local mundo = game:GetService("Workspace")
local entrada = game:GetService("UserInputService")

local eu = jogadores.LocalPlayer
local cam = mundo.CurrentCamera

local NOME_FERRAMENTA = "Click Kill Couch"
local ferramentaEquipada = false
local nomeAlvo = nil
local loopTP = nil
local sofaEquipado = false
local base = nil
local posInicial = nil
local raiz = nil

local mochila = eu:WaitForChild("Backpack")
if not mochila:FindFirstChild(NOME_FERRAMENTA) then
	local ferramenta = Instance.new("Tool")
	ferramenta.Name = NOME_FERRAMENTA
	ferramenta.RequiresHandle = false
	ferramenta.CanBeDropped = false

	ferramenta.Equipped:Connect(function()
		ferramentaEquipada = true
	end)

	ferramenta.Unequipped:Connect(function()
		ferramentaEquipada = false
		nomeAlvo = nil
		limparSofa()
	end)

	ferramenta.Parent = mochila
end

function limparSofa()
	if loopTP then
		loopTP:Disconnect()
		loopTP = nil
	end

	if sofaEquipado then
		local boneco = eu.Character
		if boneco then
			local sofa = boneco:FindFirstChild("Couch")
			if sofa then
				sofa.Parent = eu.Backpack
				sofaEquipado = false
			end
		end
	end

	if base then
		base:Destroy()
		base = nil
	end

	if getgenv().AntiSit then
		getgenv().AntiSit:Set(false)
	end

	local humano = eu.Character and eu.Character:FindFirstChildOfClass("Humanoid")
	if humano then
		humano:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		humano:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

	if posInicial and raiz then
		raiz.CFrame = posInicial
		posInicial = nil
	end
end

function pegarSofa()
	local boneco = eu.Character
	if not boneco then return end
	local mochila = eu.Backpack

	if not mochila:FindFirstChild("Couch") and not boneco:FindFirstChild("Couch") then
		local args = { "PickingTools", "Couch" }
		rep.RE["1Too1l"]:InvokeServer(unpack(args))
		task.wait(0.1)
	end

	local sofa = mochila:FindFirstChild("Couch") or boneco:FindFirstChild("Couch")
	if sofa then
		sofa.Parent = boneco
		sofaEquipado = true
	end
end

function posAleatoriaAbaixo(boneco)
	local rp = boneco:FindFirstChild("HumanoidRootPart")
	if not rp then return Vector3.new() end
	local offset = Vector3.new(math.random(-2, 2), -5.1, math.random(-2, 2))
	return rp.Position + offset
end

function tpAbaixo(alvo)
	if not alvo or not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then return end

	local meuBoneco = eu.Character
	local minhaRaiz = meuBoneco and meuBoneco:FindFirstChild("HumanoidRootPart")
	local humano = meuBoneco and meuBoneco:FindFirstChildOfClass("Humanoid")

	if not minhaRaiz or not humano then return end

	humano:SetStateEnabled(Enum.HumanoidStateType.Physics, false)

	if not base then
		base = Instance.new("Part")
		base.Size = Vector3.new(10, 1, 10)
		base.Anchored = true
		base.CanCollide = true
		base.Transparency = 0.5
		base.Parent = mundo
	end

	local destino = posAleatoriaAbaixo(alvo.Character)
	base.Position = destino
	minhaRaiz.CFrame = CFrame.new(destino)

	humano:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
end

function arremessarComSofa(alvo)
	if not alvo then return end
	nomeAlvo = alvo.Name
	local boneco = eu.Character
	if not boneco then return end

	posInicial = boneco:FindFirstChild("HumanoidRootPart") and boneco.HumanoidRootPart.CFrame
	raiz = boneco:FindFirstChild("HumanoidRootPart")
	pegarSofa()

	loopTP = loop.Heartbeat:Connect(function()
		local alvoAtual = jogadores:FindFirstChild(nomeAlvo)
		if not alvoAtual or not alvoAtual.Character or not alvoAtual.Character:FindFirstChild("Humanoid") then
			limparSofa()
			return
		end
		if getgenv().AntiSit then
			getgenv().AntiSit:Set(true)
		end
		tpAbaixo(alvoAtual)
	end)

	task.spawn(function()
		local alvoAtual = jogadores:FindFirstChild(nomeAlvo)
		while alvoAtual and alvoAtual.Character and alvoAtual.Character:FindFirstChild("Humanoid") do
			task.wait(0.05)
			if alvoAtual.Character.Humanoid.SeatPart then
				local buraco = CFrame.new(265.46, -450.83, -59.93)
				alvoAtual.Character.HumanoidRootPart.CFrame = buraco
				eu.Character.HumanoidRootPart.CFrame = buraco
				task.wait(0.4)
				limparSofa()
				task.wait(0.2)
				if posInicial then
					eu.Character.HumanoidRootPart.CFrame = posInicial
				end
				break
			end
		end
	end)
end

entrada.TouchTap:Connect(function(toques, processado)
	if not ferramentaEquipada or processado then return end
	local pos = toques[1]
	local raio = cam:ScreenPointToRay(pos.X, pos.Y)
	local hit = mundo:Raycast(raio.Origin, raio.Direction * 1000)
	if hit and hit.Instance then
		local modelo = hit.Instance:FindFirstAncestorOfClass("Model")
		local jogador = jogadores:GetPlayerFromCharacter(modelo)
		if jogador and jogador ~= eu then
			arremessarComSofa(jogador)
		end
	end
end)
end
})

local kill = Troll:AddSection({Name = "All methods"})

Troll:AddButton({
    Name = "Kill All Bus",
    Callback = function()
        local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local destination = Vector3.new(145.51, -374.09, 21.58) 
local originalPosition = nil  

local function GetBus()  
    local vehicles = Workspace:FindFirstChild("Vehicles")  
    if vehicles then  
        return vehicles:FindFirstChild(Players.LocalPlayer.Name.."Car")  
    end  
    return nil  
end  

local function TrackPlayer(selectedPlayerName, callback)
    while true do  
        if selectedPlayerName then  
            local targetPlayer = Players:FindFirstChild(selectedPlayerName)  
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then  
                local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")  
                if targetHumanoid and targetHumanoid.Sit then  
                    local bus = GetBus()
                    if bus then
                        bus:SetPrimaryPartCFrame(CFrame.new(destination))   
                        print("Player sat, taking bus to void!")  

                        task.wait(0.2)  

                        local function simulateJump()  
                            local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")  
                            if humanoid then  
                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)  
                            end  
                        end  

                        simulateJump()  
                        print("Simulating first jump!")  

                        task.wait(0.4)  
                        simulateJump()
                        print("Simulating second jump!")  

                        task.wait(0.5)
                        if originalPosition then
                            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalPosition  
                            print("Player returned to initial position Xique")  

                            task.wait(0.1)
                            local args = {
                                [1] = "DeleteAllVehicles"
                            }
                            ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
                            print("All vehicles have been deleted!")
                        end
                    end
                    break  
                else  
                    local targetRoot = targetPlayer.Character.HumanoidRootPart  
                    local time = tick() * 35
               
                    local lateralOffset = math.sin(time) * 10  -- Fast lateral movement  
                    local frontBackOffset = math.cos(time) * 20  -- Forward/backward movement
                      
                    local bus = GetBus()
                    if bus then
                        bus:SetPrimaryPartCFrame(targetRoot.CFrame * CFrame.new(0, 0, frontBackOffset))  
                    end
                end  
            end  
        end  
        RunService.RenderStepped:Wait()  
    end
    
    if callback then
        callback()
    end
end  

local function StartKillBusao(playerName, callback)
    local selectedPlayerName = playerName

    local player = Players.LocalPlayer  
    local character = player.Character or player.CharacterAdded:Wait()  
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")  

    originalPosition = humanoidRootPart.CFrame  

    local bus = GetBus()  

    if not bus then  
        humanoidRootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)  
        task.wait(0.5)  
        local remoteEvent = ReplicatedStorage:FindFirstChild("RE")  
        if remoteEvent and remoteEvent:FindFirstChild("1Ca1r") then  
            remoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")  
        end  
        task.wait(1)  
        bus = GetBus()  
    end  

    if bus then  
        local seat = bus:FindFirstChild("Body") and bus.Body:FindFirstChild("VehicleSeat")  
        if seat and character:FindFirstChildOfClass("Humanoid") and not character.Humanoid.Sit then  
            repeat  
                humanoidRootPart.CFrame = seat.CFrame * CFrame.new(0, 2, 0)  
                task.wait()  
            until character.Humanoid.Sit or not bus.Parent  
        end  
    end  

    spawn(function()
        TrackPlayer(selectedPlayerName, callback)
    end)
end

local function PerformActionForAllPlayers(players)
    if #players == 0 then
        return
    end

    local player = table.remove(players, 1)
    StartKillBusao(player.Name, function()
        task.wait(0.5)
        PerformActionForAllPlayers(players)
    end)
end

PerformActionForAllPlayers(Players:GetPlayers())
    end
})
print("Kill All Bus button created")

Troll:AddButton({
    Name = "House Ban kill All",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")


local function executeScriptForPlayer(targetPlayer)
    local Player = game.Players.LocalPlayer
    local Backpack = Player.Backpack
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Houses = game.Workspace:FindFirstChild("001_Lots")
    local OldPos = RootPart.CFrame
    local Angles = 0
    local Vehicles = Workspace.Vehicles
    local Pos


    function Check()
        if Player and Character and Humanoid and RootPart and Vehicles then
            return true
        else
            return false
        end
    end


    if Check() then
        local House = Houses:FindFirstChild(Player.Name.."House")
        if not House then
            local EHouse
            for _, Lot in pairs(Houses:GetChildren()) do
                if Lot.Name == "For Sale" then
                    for _, num in pairs(Lot:GetDescendants()) do
                        if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                            EHouse = Lot
                            break
                        end
                    end
                end
            end


            local BuyDetector = EHouse:FindFirstChild("BuyHouse")
            Pos = BuyDetector.Position
            if BuyDetector and BuyDetector:IsA("BasePart") then
                RootPart.CFrame = BuyDetector.CFrame + Vector3.new(0, -6, 0)
                task.wait(0.5)
                local ClickDetector = BuyDetector:FindFirstChild("ClickDetector")
                if ClickDetector then
                    fireclickdetector(ClickDetector)
                end
            end
        end


        task.wait(0.5)
        local PreHouse = Houses:FindFirstChild(Player.Name .. "House")
        if PreHouse then
            task.wait(0.5)
            local Number
            for i, x in pairs(PreHouse:GetDescendants()) do
                if x.Name == "Number" and x:IsA("NumberValue") then
                    Number = x
                end
            end
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse", "049_House", Number.Value)
        end


        task.wait(0.5)
        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if not PCar then
            if Check() then
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                task.wait(0.5)
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end


        task.wait(0.5)
        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar then
            if not Humanoid.Sit then
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end


            local Target = targetPlayer
            local TargetC = Target.Character
            local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
            local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
            if TargetC and TargetH and TargetRP then
                if not TargetH.Sit then
                    while not TargetH.Sit do
                        task.wait()
                        local Fling = function(alvo, pos, angulo)
                            PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                        end
                        Angles = Angles + 100
                        Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(2.25, 1.5, -2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                    end
                    task.wait(0.2)
                    local House = Houses:FindFirstChild(Player.Name.."House")
                    PCar:SetPrimaryPartCFrame(CFrame.new(House.HouseSpawnPosition.Position))
                    task.wait(0.2)
                    local pedro = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30,30,30), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30,30,30))
                    local a = workspace:FindPartsInRegion3(pedro, game.Players.LocalPlayer.Character.HumanoidRootPart, math.huge)
                    for i, v in pairs(a) do
                        if v.Name == "HumanoidRootPart" then
                            local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                            local args = {
                                [1] = "BanPlayerFromHouse",
                                [2] = b,
                                [3] = v.Parent
                            }
                            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
                        end
                    end
                end
            end
        end
    end


    -- Delete vehicle
    local deleteArgs = {
        [1] = "DeleteAllVehicles"
    }
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(deleteArgs))
end


-- Iterate over all players on the map
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Player then
        executeScriptForPlayer(player)
       task.wait(2)
    end
end
    end
})
print("House Ban kill All button created")

Troll:AddButton({
    Name = "Fling Boat all",
    Callback = function()
        local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Vehicles = game.Workspace:FindFirstChild("Vehicles")
    local OldPos = RootPart.CFrame
    local Angles = 0
    local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
    
    -- If there's no car, create one  
            if not PCar then  
                if RootPart then  
                    RootPart.CFrame = CFrame.new(1754, -2, 58)  
                    task.wait(0.5)  
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")  
                    task.wait(0.5)  
                    PCar = Vehicles:FindFirstChild(Player.Name.."Car")  
                    task.wait(0.5)  
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")  
                    if Seat then  
                        repeat  
                            task.wait()  
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)  
                        until Humanoid.Sit  
                    end  
                end  
            end  
      
            task.wait(0.5)  
            PCar = Vehicles:FindFirstChild(Player.Name.."Car")  
      
            -- If the car exists, teleport to the seat if necessary  
            if PCar then  
                if not Humanoid.Sit then  
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")  
                    if Seat then  
                        repeat  
                            task.wait()  
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)  
                        until Humanoid.Sit  
                    end  
                end  
            end  
      
            -- Add BodyGyro to car for movement control  
            local SpinGyro = Instance.new("BodyGyro")  
            SpinGyro.Parent = PCar.PrimaryPart  
            SpinGyro.MaxTorque = Vector3.new(1e7, 1e7, 1e7)  
            SpinGyro.P = 1e7  
            SpinGyro.CFrame = PCar.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0)  
      
            -- Fling Function on each player for 3 seconds  
            local function flingPlayer(TargetC, TargetRP, TargetH)
    Angles = 0  
                local endTime = tick() + 1  -- Set end time to 2 seconds from now  
                while tick() < endTime do  
                    Angles = Angles + 100  
                    task.wait()  
      
                    -- Movements and angles for Fling  
                    local kill = function(alvo, pos, angulo)  
                        PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)  
                    end  
      
                    -- Fling to various positions around TargetRP  
                    kill(TargetRP, CFrame.new(0, 3, 0), CFrame.Angles(math.rad(Angles), 0, 0))  
                    kill(TargetRP, CFrame.new(0, -1.5, 2), CFrame.Angles(math.rad(Angles), 0, 0))  
                    kill(TargetRP, CFrame.new(2, 1.5, 2.25), CFrame.Angles(math.rad(50), 0, 0))  
                    kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25), CFrame.Angles(math.rad(30), 0, 0))  
                    kill(TargetRP, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))  
                    kill(TargetRP, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))  
                end  
            end  
      
            -- Iterate over all players  
            for _, Target in pairs(game.Players:GetPlayers()) do  
                -- Skip local player  
                if Target ~= Player then  
                    local TargetC = Target.Character  
                    local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")  
                    local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")  
      
                    -- If target and its components are found, execute fling  
                    if TargetC and TargetH and TargetRP then  
                        flingPlayer(TargetC, TargetRP, TargetH)  -- Fling on current player  
                    end  
                end  
            end  
      
            -- Return player to original position  
            task.wait(0.5)  
            PCar:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))  
            task.wait(0.5)  
            Humanoid.Sit = false  
            task.wait(0.5)  
            RootPart.CFrame = OldPos  
      
            -- Remove BodyGyro after effect  
            SpinGyro:Destroy()  
    end
})
print("Fling Boat All button created")

Troll:AddButton({
    Name = "Auto Fling All",
    Callback = function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local cam = workspace.CurrentCamera


    local function ProcessPlayer(target)
        if not target or not target.Character or target == LocalPlayer then return end
        
        local flingActive = true
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
        if not root or not tRoot then return end
        
        local char = LocalPlayer.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local original = root.CFrame

    
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
        task.wait(0.2)

  
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        task.wait(0.3)

        local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
        if tool then
            tool.Parent = char
        end
task.wait(0.1)

game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
task.wait(0.25)

        workspace.FallenPartsDestroyHeight = 0/0

        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlingForce"
        bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = root

        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        hum.PlatformStand = false
        cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

 
        task.spawn(function()
            local angle = 0
            local parts = {root}
            while flingActive and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
                local tHum = target.Character:FindFirstChildOfClass("Humanoid")
                if tHum.Sit then break end
                angle += 50

                for _, part in ipairs(parts) do
                    local hrp = target.Character.HumanoidRootPart
                    local pos = hrp.Position + hrp.Velocity / 1.5
                    root.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(angle), 0, 0)
                end

                root.Velocity = Vector3.new(9e8, 9e8, 9e8)
                root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                task.wait()
            end

         
            flingActive = false
            bv:Destroy()
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            hum.PlatformStand = false
            root.CFrame = original
            cam.CameraSubject = hum

            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Velocity = Vector3.zero
                    p.RotVelocity = Vector3.zero
                end
            end

            hum:UnequipTools()
            ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        end)
       
        while flingActive do
            task.wait()
        end
    end


    for _, player in ipairs(Players:GetPlayers()) do
        ProcessPlayer(player)
			end
    end
})

Troll:AddButton({
    Name = "Bring All Couch [best]",
    Callback = function()
        local args = {
    [1] = "ClearAllTools"
}

game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))

wait(0.2)

toolselcted = "Couch"
dupeamot = 25 --Put amouth to dupe
picktoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
cleartoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Duping",Text="Don't click anything while duping. ", Button1 = " I understand" ,Duration=5})
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Because It will break the script and you will need to rejoin.", Button1 = "I understand" ,Duration=5}) 
duping = true
oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
    task.wait()
    game.Players.LocalPlayer.Character.Humanoid.Sit = false
end
wait(0.1)
if game:GetService("Workspace"):FindFirstChild("Camera") then
    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() 
end
for m=1,2 do 
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
end
task.wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.5)
for aidj,afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if afh.Name == toolselcted == false then
        if afh:IsA("Tool") then
            afh.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end
for aiefhiewhwf,dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if dvjbvj:IsA("Tool") then
        if dvjbvj.Name == toolselcted == false then
            dvjbvj:Destroy()
        end
    end
end
for ttjtjutjutjjtj,ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
        if ddvdvdsvdfbrnytytmvdv.name == toolselcted == false then
            ddvdvdsvdfbrnytytmvdv:Destroy()
        end
    end
end
for findin,toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if toollel:IsA("Tool") then
        if toollel.Name == toolselcted then
            toollllfoun2 = true
            for basc,aijfw in pairs(toollel:GetDescendants()) do
                if aijfw.Name == "Handle" then
                    aijfw.Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                    toollel.Parent = game.Players.LocalPlayer.Backpack
                    toollel.Parent = game.Players.LocalPlayer.Character
                    tollllahhhh = toollel
                    task.wait()
                end
            end
        else 
            toollllfoun2 = false
        end
    end
end
for fiifi,toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if toollll:IsA("Tool") then
        if toollll.Name == toolselcted then
            toollllfoun = true
            for nana,jjsjsj in pairs(toollll:GetDescendants()) do
                if jjsjsj.Name == "Handle" then
                    toollll.Parent = game.Players.LocalPlayer.Character
                    wait()
                    jjsjsj.Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                    toollll.Parent = game.Players.LocalPlayer.Backpack
                    toollll.Parent = game.Players.LocalPlayer.Character
                    toolllffel = toollll
                end
            end
        else 
            toollllfoun = false
        end
    end
end
if toollllfoun == true then
    if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then  
        toollllfoun = false 
    end
    repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
    toollllfoun = false
end
if toollllfoun2 == true then
    if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then 
        toollllfoun2 = false 
    end
    repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
    toollllfoun2 = false
end
wait(0.1)
for m=1, dupeamot do
    if duping == false then 
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false 
        return 
    end
    if game:GetService("Workspace"):FindFirstChild("Camera") then
        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() 
    end
    if m <= dupeamot then
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="Duping life",Text="You have".." "..m.." ".."Duped".." "..toolselcted.."!",Duration=0.5})
    elseif m == dupeamot or m >= dupeamot - 1 then
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="Duping",Text="You have".." "..m.." ".."Duped".." "..toolselcted.."!".." ".."Duping tools is done now, Please wait a little bit to respawn.",Duration=4})
    end
    local args = {
        [1] = "PickingTools",
        [2] = toolselcted
    }
    
    picktoolremote:InvokeServer(unpack(args))
    game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolselcted).Parent = game.Players.LocalPlayer.Character
    if duping == false then 
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false 
        return 
    end
    wait()
    game:GetService("Players").LocalPlayer.Character[toolselcted]:FindFirstChild("Handle").Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
    game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Backpack
    game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Character
    repeat  
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() 
        end
        task.wait() 
    until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted) == nil
end
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
wait()
duping = false

for wwefef,weifwwe in pairs(game.Players:GetPlayers()) do
    if weifwwe.Name == game.Players.LocalPlayer.Name == false then
        ewoifjwoifjiwo = wwefef
    end
end
for m=1,ewoifjwoifjiwo do
    game.Players.LocalPlayer.Backpack.Couch.Name = "couch"..m
end
wait()
for weofefawd,iwiejguiwg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if iwiejguiwg.Name == "couch"..weofefawd then
        iwiejguiwg.Handle.Name = "Handle "
    end
end
wait(0.2)
local function bring(skjdfuwiruwg,woiejewg)
    if woiejewg == nil == false then
        game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg]:FindFirstChild("Seat1").Disabled = true
        game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg]:FindFirstChild("Seat2").Disabled = true
        game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character
        tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg]:FindFirstChild("Handle "))
        tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0,0,0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
        repeat
            for m=1,35 do
                local pos = {x=0, y=0, z=0}
                pos.x = woiejewg.Character.HumanoidRootPart.Position.X
                pos.y = woiejewg.Character.HumanoidRootPart.Position.Y
                pos.z = woiejewg.Character.HumanoidRootPart.Position.Z
                pos.x = pos.x + woiejewg.Character.HumanoidRootPart.Velocity.X / 2
                pos.y = pos.y + woiejewg.Character.HumanoidRootPart.Velocity.Y / 2
                pos.z = pos.z + woiejewg.Character.HumanoidRootPart.Velocity.Z / 2
                game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg]:FindFirstChild("Seat1").CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(-2,2,0)
                task.wait()
            end
            game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack
            wait()
            game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg]:FindFirstChild("Handle ").Name = "Handle"
            wait(0.2)
            game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character
            wait()
            game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack
            game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg].Handle.Name = "Handle "
            wait(0.2)
            game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character
            tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg]:FindFirstChild("Seat1"))
            tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            tet.P = 1250
            tet.Velocity = Vector3.new(0,0,0)
            tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
        until woiejewg.Character.Humanoid.Sit == true
        wait()
        game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg]:FindFirstChild("Handle "):FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"):Destroy()
        game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack
        wait()
        game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg]:FindFirstChild("Handle ").Name = "Handle"
        wait(0.2)
        game.Players.LocalPlayer.Backpack["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character
        wait()
        game.Players.LocalPlayer.Character["couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack
    end
end
for mwef,weuerg in pairs(game.Players:GetPlayers()) do
    if weuerg.Name == game.Players.LocalPlayer.Name == false then
        spawn(function()
            bring(mwef,weuerg)
        end)
    end
end
    end
})
print("Bring All Couch button created")

Troll:AddButton({
    Name = "Kill All Couch [best]",
    Callback = function()
        local args = {
    [1] = "ClearAllTools"
}

game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))

wait(0.2)

local initialPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

local part = Instance.new("Part")
part.Size = Vector3.new(5000, 10, 5000)
part.Position = Vector3.new(0, -500, 0)
part.Anchored = true
part.CanCollide = true
part.Parent = game.Workspace
task.wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
wait(2)
toolselcted = "Couch"
dupeamot = 25 -- dupe
picktoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
cleartoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Duping",Text="Don't click anything", Button1 = "Got it" ,Duration=5})
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Duping",Text="Wait", Button1 = "Understood" ,Duration=5})
duping = true
oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
    task.wait()
    game.Players.LocalPlayer.Character.Humanoid.Sit = false
end
wait(0.1)
if game:GetService("Workspace"):FindFirstChild("Camera") then
    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
end
for m=1,2 do 
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
end
task.wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.5)
for aidj,afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if afh.Name == toolselcted == false then
        if afh:IsA("Tool") then
            afh.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end
for aiefhiewhwf,dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if dvjbvj:IsA("Tool") then
        if dvjbvj.Name == toolselcted == false then
            dvjbvj:Destroy()
        end
    end
end
for ttjtjutjutjjtj,ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
        if ddvdvdsvdfbrnytytmvdv.Name == toolselcted == false then
            ddvdvdsvdfbrnytytmvdv:Destroy()
        end
    end
end
for findin,toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if toollel:IsA("Tool") then
        if toollel.Name == toolselcted then
            toollllfoun2 = true
            for basc,aijfw in pairs(toollel:GetDescendants()) do
                if aijfw.Name == "Handle" then
                    aijfw.Name = "HÃ¢ÂÂ¥aÃ¢ÂÂ¥nÃ¢ÂÂ¥dÃ¢ÂÂ¥lÃ¢ÂÂ¥e"
                    toollel.Parent = game.Players.LocalPlayer.Backpack
                    toollel.Parent = game.Players.LocalPlayer.Character
                    tollllahhhh = toollel
                    task.wait()
                end
            end
        else 
            toollllfoun2 = false
        end
    end
end
for fiifi,toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if toollll:IsA("Tool") then
        if toollll.Name == toolselcted then
            toollllfoun = true
            for nana,jjsjsj in pairs(toollll:GetDescendants()) do
                if jjsjsj.Name == "Handle" then
                    toollll.Parent = game.Players.LocalPlayer.Character
                    wait()
                    jjsjsj.Name = "HÃ¢ÂÂ¥aÃ¢ÂÂ¥nÃ¢ÂÂ¥dÃ¢ÂÂ¥lÃ¢ÂÂ¥e"
                    toollll.Parent = game.Players.LocalPlayer.Backpack
                    toollll.Parent = game.Players.LocalPlayer.Character
                    toolllffel = toollll
                end
            end
        else 
            toollllfoun = false
        end
    end
end
if toollllfoun == true then
    if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then 
        toollllfoun = false 
    end
    repeat 
        wait() 
    until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
    toollllfoun = false
end
if toollllfoun2 == true then
    if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then 
        toollllfoun2 = false 
    end
    repeat 
        wait() 
    until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
    toollllfoun2 = false
end
wait(0.1)
for m=1, dupeamot do
    if duping == false then 
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false 
        return 
    end
    if game:GetService("Workspace"):FindFirstChild("Camera") then
        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() 
    end
    if m <= dupeamot then
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Now you have".." "..m.." ".."Duped".." "..toolselcted.."!",Duration=0.5})
    elseif m == dupeamot or m >= dupeamot - 1 then
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Now you have".." "..m.." ".."Duped".." "..toolselcted.."!".." ".."Tools are being duped. Don't click anything, fella.",Duration=4})
    end
    local args = {
        [1] = "PickingTools",
        [2] = toolselcted
    }

    picktoolremote:InvokeServer(unpack(args)) 
    game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolselcted).Parent = game.Players.LocalPlayer.Character 
    if duping == false then 
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false 
        return 
    end 
    wait() 
    game:GetService("Players").LocalPlayer.Character[toolselcted]:FindFirstChild("Handle").Name = "HÃ¢ÂÂ¥aÃ¢ÂÂ¥nÃ¢ÂÂ¥dÃ¢ÂÂ¥lÃ¢ÂÂ¥e" 
    game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Backpack 
    game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Character 
    repeat 
        if game:GetService("Workspace"):FindFirstChild("Camera") then 
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() 
        end 
        task.wait() 
    until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted) == nil 
end 
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false 
repeat 
    wait() 
until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil 
repeat 
    wait() 
until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf 
wait() 
duping = false 
for wwefef,weifwwe in pairs(game.Players:GetPlayers()) do 
    if weifwwe.Name == game.Players.LocalPlayer.Name == false then 
        ewoifjwoifjiwo = wwefef 
    end 
end 
for m=1,ewoifjwoifjiwo do 
    game.Players.LocalPlayer.Backpack.Couch.Name = "Chaos Couch"..m 
end 
wait() 
for weofefawd,iwiejguiwg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
    if iwiejguiwg.Name == "Chaos Couch"..weofefawd then 
        iwiejguiwg.Handle.Name = "Handle " 
    end 
end 
wait(0.2) 
local function bring(skjdfuwiruwg,woiejewg) 
    if woiejewg == nil == false then 
        game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Seat1").Disabled = true 
        game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Seat2").Disabled = true 
        game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character 
        tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Handle ")) 
        tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge) 
        tet.P = 1250 
        tet.Velocity = Vector3.new(0,0,0) 
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W" 
        repeat 
            for m=1,35 do 
                local pos = {x=0, y=0, z=0} 
                pos.x = woiejewg.Character.HumanoidRootPart.Position.X 
                pos.y = woiejewg.Character.HumanoidRootPart.Position.Y 
                pos.z = woiejewg.Character.HumanoidRootPart.Position.Z 
                pos.x = pos.x + woiejewg.Character.HumanoidRootPart.Velocity.X / 2 
                pos.y = pos.y + woiejewg.Character.HumanoidRootPart.Velocity.Y / 2 
                pos.z = pos.z + woiejewg.Character.HumanoidRootPart.Velocity.Z / 2 
                game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Seat1").CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(-2,2,0) 
                task.wait() 
            end 
            game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack 
            wait() 
            game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Handle ").Name = "Handle" 
            wait(0.2) 
            game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character 
            wait() 
            game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack 
            game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg].Handle.Name = "Handle " 
            wait(0.2) 
            game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character 
            tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Seat1")) 
            tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge) 
            tet.P = 1250 
            tet.Velocity = Vector3.new(0,0,0) 
            tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W" 
        until woiejewg.Character.Humanoid.Sit == true 
        wait() 
        game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Handle "):FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"):Destroy() 
        game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack 
        wait() 
        game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg]:FindFirstChild("Handle ").Name = "Handle" 
        wait(0.2) 
        game.Players.LocalPlayer.Backpack["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Character 
        wait() 
        game.Players.LocalPlayer.Character["Chaos Couch"..skjdfuwiruwg].Parent = game.Players.LocalPlayer.Backpack 
    end 
end 
for mwef,weuerg in pairs(game.Players:GetPlayers()) do 
    if weuerg.Name == game.Players.LocalPlayer.Name == false then 
        spawn(function() bring(mwef,weuerg) end) 
    end 
end 

-- Function to teleport the player back to the initial position after 10 seconds
task.delay(14, function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(initialPosition)
end)

-- Function to clear all tools 0.5 seconds after teleporting to the initial position
task.delay(14.1, function()
    game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
end)
    end
})
print("Kill All Couch button created")  

Troll:AddButton({
    Name = "Fling Ball all",
    Callback = function()
local player=game:GetService("Players").LocalPlayer
local SoccerBalls=workspace.WorkspaceCom["001_SoccerBalls"]
local MyBall=SoccerBalls:FindFirstChild("Soccer"..player.Name)

if not MyBall then
if not player.Backpack:FindFirstChild("SoccerBall") then
local args={[1]="PickingTools",[2]="SoccerBall"}
game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
task.wait()
player.Backpack.SoccerBall.Parent=player.Character
repeat MyBall=SoccerBalls:FindFirstChild("Soccer"..player.Name) task.wait() until MyBall
player.Character.SoccerBall.Parent=player.Backpack
task.wait()
else
player.Backpack.SoccerBall.Parent=player.Character
repeat MyBall=SoccerBalls:FindFirstChild("Soccer"..player.Name) task.wait() until MyBall
player.Character.SoccerBall.Parent=player.Backpack
end
end


for i,v in pairs(game.Players:GetPlayers()) do
if v~=game.Players.LocalPlayer then
local target=v
local TCharacter=target.Character or target.CharacterAdded:Wait()
local THumanoidRootPart=TCharacter:WaitForChild("HumanoidRootPart")
if not MyBall or not THumanoidRootPart then return end

for _,v in pairs(MyBall:GetChildren()) do
if v:IsA("BodyMover") then v:Destroy() end
end

local bodyVelocity=Instance.new("BodyVelocity")
bodyVelocity.Velocity=Vector3.new(9e8,9e8,9e8)
bodyVelocity.MaxForce=Vector3.new(1/0,1/0,1/0)
bodyVelocity.P=1e10
bodyVelocity.Parent=MyBall

local bv=Instance.new("BodyVelocity")
bv.Velocity=Vector3.new(9e8,9e8,9e8)
bv.MaxForce=Vector3.new(1/0,1/0,1/0)
bv.P=1e9
bv.Parent=THumanoidRootPart

local oldPos=THumanoidRootPart.Position
workspace.CurrentCamera.CameraSubject=THumanoidRootPart

repeat
local velocity=THumanoidRootPart.Velocity.Magnitude
local parts={}
for _,v in pairs(TCharacter:GetDescendants()) do
if v:IsA("BasePart") and v.CanCollide and not v.Anchored then table.insert(parts,v) end
end
for _,part in ipairs(parts) do
local pos_x=target.Character.HumanoidRootPart.Position.X
local pos_y=target.Character.HumanoidRootPart.Position.Y
local pos_z=target.Character.HumanoidRootPart.Position.Z
pos_x=pos_x+(target.Character.HumanoidRootPart.Velocity.X/1.5)
pos_y=pos_y+(target.Character.HumanoidRootPart.Velocity.Y/1.5)
pos_z=pos_z+(target.Character.HumanoidRootPart.Velocity.Z/1.5)
MyBall.CFrame=CFrame.new(pos_x,pos_y,pos_z)
task.wait(1/6000)
end
task.wait(1/6000)
until THumanoidRootPart.Velocity.Magnitude>5000 or TCharacter.Humanoid.Health==0 or target.Parent~=game.Players or THumanoidRootPart.Parent~=TCharacter or TCharacter~=target.Character

end
end

workspace.CurrentCamera.CameraSubject=game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
  end
})


local Tab = Window:MakeTab({"Avatar", "rbxassetid://10734952036"})

Tab:AddSection({ Name = "Copy Skin" })

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Target = nil

-- Function to get player names
local function GetPlayerNames()
    local PlayerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        table.insert(PlayerNames, player.Name)
    end
    return PlayerNames
end

-- Player selection dropdown
local Dropdown = Tab:AddDropdown({
    Name = "Select Player",
    Options = GetPlayerNames(),
    Default = Target,
    Callback = function(Value)
        Target = Value
    end
})

-- Update dropdown options when someone joins or leaves
local function UpdateDropdown()
    Dropdown:Refresh(GetPlayerNames(), true)
end

Players.PlayerAdded:Connect(UpdateDropdown)
Players.PlayerRemoving:Connect(UpdateDropdown)

Tab:AddButton({
    Name = "Copy Avatar",
    Callback = function()
        if not Target then return end

        local LP = Players.LocalPlayer
        local LChar = LP.Character
        local TPlayer = Players:FindFirstChild(Target)

        if TPlayer and TPlayer.Character then
            local LHumanoid = LChar and LChar:FindFirstChildOfClass("Humanoid")
            local THumanoid = TPlayer.Character:FindFirstChildOfClass("Humanoid")

            if LHumanoid and THumanoid then
                -- RESET LOCALPLAYER
                local LDesc = LHumanoid:GetAppliedDescription()

                -- Remove current accessories, clothes and face
                for _, acc in ipairs(LDesc:GetAccessories(true)) do
                    if acc.AssetId and tonumber(acc.AssetId) then
                        Remotes.Wear:InvokeServer(tonumber(acc.AssetId))
                        task.wait(0.2)
                    end
                end

                if tonumber(LDesc.Shirt) then
                    Remotes.Wear:InvokeServer(tonumber(LDesc.Shirt))
                    task.wait(0.2)
                end

                if tonumber(LDesc.Pants) then
                    Remotes.Wear:InvokeServer(tonumber(LDesc.Pants))
                    task.wait(0.2)
                end

                if tonumber(LDesc.Face) then
                    Remotes.Wear:InvokeServer(tonumber(LDesc.Face))
                    task.wait(0.2)
                end

                -- COPY FROM TARGET PLAYER
                local PDesc = THumanoid:GetAppliedDescription()

                -- Send body parts
                local argsBody = {
                    [1] = {
                        [1] = PDesc.Torso,
                        [2] = PDesc.RightArm,
                        [3] = PDesc.LeftArm,
                        [4] = PDesc.RightLeg,
                        [5] = PDesc.LeftLeg,
                        [6] = PDesc.Head
                    }
                }
                Remotes.ChangeCharacterBody:InvokeServer(unpack(argsBody))
                task.wait(0.5)

                if tonumber(PDesc.Shirt) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.Shirt))
                    task.wait(0.3)
                end

                if tonumber(PDesc.Pants) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.Pants))
                    task.wait(0.3)
                end

                if tonumber(PDesc.Face) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.Face))
                    task.wait(0.3)
                end

                for _, v in ipairs(PDesc:GetAccessories(true)) do
                    if v.AssetId and tonumber(v.AssetId) then
                        Remotes.Wear:InvokeServer(tonumber(v.AssetId))
                        task.wait(0.3)
                    end
                end

                local SkinColor = TPlayer.Character:FindFirstChild("Body Colors")
                if SkinColor then
                    Remotes.ChangeBodyColor:FireServer(tostring(SkinColor.HeadColor))
                    task.wait(0.3)
                end

                if tonumber(PDesc.IdleAnimation) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.IdleAnimation))
                    task.wait(0.3)
                end

                -- Name, bio and color
                local Bag = TPlayer:FindFirstChild("PlayersBag")
                if Bag then
                    if Bag:FindFirstChild("RPName") and Bag.RPName.Value ~= "" then
                        Remotes.RPNameText:FireServer("RolePlayName", Bag.RPName.Value)
                        task.wait(0.3)
                    end
                    if Bag:FindFirstChild("RPBio") and Bag.RPBio.Value ~= "" then
                        Remotes.RPNameText:FireServer("RolePlayBio", Bag.RPBio.Value)
                        task.wait(0.3)
                    end
                    if Bag:FindFirstChild("RPNameColor") then
                        Remotes.RPNameColor:FireServer("PickingRPNameColor", Bag.RPNameColor.Value)
                        task.wait(0.3)
                    end
                    if Bag:FindFirstChild("RPBioColor") then
                        Remotes.RPNameColor:FireServer("PickingRPBioColor", Bag.RPBioColor.Value)
                        task.wait(0.3)
                    end
                end
            end
        end
    end
})

-- Define colors for RGB effect
local colors = {
    Color3.new(1, 0, 0),       -- Red
    Color3.new(0, 1, 0),       -- Green
    Color3.new(0, 0, 1),       -- Blue
    Color3.new(1, 1, 0),       -- Yellow
    Color3.new(0, 1, 1),       -- Cyan
    Color3.new(1, 0, 1)        -- Magenta
}

-- Variable to control the state of House RGB toggle
local isHouseRGBActive = false

-- Function to change house color
local function changeColor()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local remoteEvent = replicatedStorage:FindFirstChild("RE") and replicatedStorage.RE:FindFirstChild("1Player1sHous1e")
    
    if not remoteEvent then
        warn("RemoteEvent '1Player1sHous1e' not found.")
        return
    end

    while isHouseRGBActive do
        for _, color in ipairs(colors) do
            if not isHouseRGBActive then return end
            local args = {
                [1] = "ColorPickHouse",
                [2] = color
            }
            pcall(function()
                remoteEvent:FireServer(unpack(args))
            end)
            task.wait(0.8)
        end
    end
end

local function toggleHouseRGB(state)
    isHouseRGBActive = state
    if isHouseRGBActive then
        print("House RGB Activated")
        spawn(changeColor)
    else
        print("House RGB Deactivated")
    end
end

-- Global variables
local isUnbanActive = false
local HouseTab = Window:MakeTab({"Houses", "home"})
local SelectHouse = nil
local NoclipDoor = nil

-- Function to get house list
local function getHouseList()
    local Tabela = {}
    local lots = workspace:FindFirstChild("001_Lots")
    if lots then
        for _, House in ipairs(lots:GetChildren()) do
            if House.Name ~= "For Sale" and House:IsA("Model") then
                table.insert(Tabela, House.Name)
            end
        end
    end
    return Tabela
end

-- Dropdown to select houses
pcall(function()
    HouseTab:AddDropdown({
        Name = "Select House",
        Options = getHouseList(),
        Default = "...",
        Callback = function(Value)
            SelectHouse = Value
            if NoclipDoor then
                NoclipDoor:Set(false)
            end
            print("House selected: " .. tostring(Value))
        end
    })
end)

-- Function to update house list
local function DropdownHouseUpdate()
    local Tabela = getHouseList()
    print("DropdownHouseUpdate called. Houses found:", #Tabela)
    pcall(function()
        HouseTab:ClearDropdown("Select House") -- Try to clear dropdown, if supported
        HouseTab:AddDropdown({
            Name = "Select House",
            Options = Tabela,
            Default = "...",
            Callback = function(Value)
                SelectHouse = Value
                if NoclipDoor then
                    NoclipDoor:Set(false)
                end
            end
        })
    end)
end

-- Initialize dropdown
pcall(DropdownHouseUpdate)

-- Button to update house list
pcall(function()
    HouseTab:AddButton({
        Name = "Update House List",
        Callback = function()
            print("Update House List button clicked.")
            pcall(DropdownHouseUpdate)
        end
    })
end)

-- Button to teleport to house
pcall(function()
    HouseTab:AddButton({
        Name = "Teleport to House",
        Callback = function()
            local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
            if House and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(House.WorldPivot.Position)
            else
                print("House not found: " .. tostring(SelectHouse))
            end
        end
    })
end)

-- Button to teleport to vault
pcall(function()
    HouseTab:AddButton({
        Name = "Teleport to Vault",
        Callback = function()
            local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
            if House and House:FindFirstChild("HousePickedByPlayer") and game.Players.LocalPlayer.Character then
                local safe = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_Safe")
                if safe then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(safe.WorldPivot.Position)
                else
                    print("Vault not found in house: " .. tostring(SelectHouse))
                end
            else
                print("House not found: " .. tostring(SelectHouse))
            end
        end
    })
end)

-- Toggle for noclip door
pcall(function()
    NoclipDoor = HouseTab:AddToggle({
        Name = "Noclip House Door",
        Description = "",
        Default = false,
        Callback = function(Value)
            pcall(function()
                local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
                if House and House:FindFirstChild("HousePickedByPlayer") then
                    local housepickedbyplayer = House.HousePickedByPlayer
                    local doors = housepickedbyplayer.HouseModel:FindFirstChild("001_HouseDoors")
                    if doors and doors:FindFirstChild("HouseDoorFront") then
                        for _, Base in ipairs(doors.HouseDoorFront:GetChildren()) do
                            if Base:IsA("BasePart") then
                                Base.CanCollide = not Value
                            end
                        end
                    end
                end
            end)
        end
    })
end)

-- Toggle for ringing doorbell
pcall(function()
    HouseTab:AddToggle({
        Name = "Ring Doorbell",
        Description = "",
        Default = false,
        Callback = function(Value)
            getgenv().ChaosHubAutoSpawnDoorbellValue = Value
            spawn(function()
                while getgenv().ChaosHubAutoSpawnDoorbellValue do
                    local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
                    if House and House:FindFirstChild("HousePickedByPlayer") then
                        local doorbell = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_DoorBell")
                        if doorbell and doorbell:FindFirstChild("TouchBell") then
                            pcall(function()
                                fireclickdetector(doorbell.TouchBell.ClickDetector)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })
end)

-- Toggle for knocking on door
pcall(function()
    HouseTab:AddToggle({
        Name = "Knock on Door",
        Description = "",
        Default = false,
        Callback = function(Value)
            getgenv().ChaosHubAutoSpawnDoorValue = Value
            spawn(function()
                while getgenv().ChaosHubAutoSpawnDoorValue do
                    local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
                    if House and House:FindFirstChild("HousePickedByPlayer") then
                        local doors = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_HouseDoors")
                        if doors and doors:FindFirstChild("HouseDoorFront") and doors.HouseDoorFront:FindFirstChild("Knock") then
                            pcall(function()
                                fireclickdetector(doors.HouseDoorFront.Knock.TouchBell.ClickDetector)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })
end)
pcall(function()
    HouseTab:AddSection({ Name = "Teleport to Houses" })
end)

-- List of houses for teleport
local casas = {
    ["House 1"] = Vector3.new(260.29, 4.37, 209.32),
    ["House 2"] = Vector3.new(234.49, 4.37, 228.00),
    ["House 3"] = Vector3.new(262.79, 21.37, 210.84),
    ["House 4"] = Vector3.new(229.60, 21.37, 225.40),
    ["House 5"] = Vector3.new(173.44, 21.37, 228.11),
    ["House 6"] = Vector3.new(-43, 21, -137),
    ["House 7"] = Vector3.new(-40, 36, -137),
    ["House 11"] = Vector3.new(-21, 40, 436),
    ["House 12"] = Vector3.new(155, 37, 433),
    ["House 13"] = Vector3.new(255, 35, 431),
    ["House 14"] = Vector3.new(254, 38, 394),
    ["House 15"] = Vector3.new(148, 39, 387),
    ["House 16"] = Vector3.new(-17, 42, 395),
    ["House 17"] = Vector3.new(-189, 37, -247),
    ["House 18"] = Vector3.new(-354, 37, -244),
    ["House 19"] = Vector3.new(-456, 36, -245),
    ["House 20"] = Vector3.new(-453, 38, -295),
    ["House 21"] = Vector3.new(-356, 38, -294),
    ["House 22"] = Vector3.new(-187, 37, -295),
    ["House 23"] = Vector3.new(-410, 68, -447),
    ["House 24"] = Vector3.new(-348, 69, -496),
    ["House 28"] = Vector3.new(-103, 12, 1087),
    ["House 29"] = Vector3.new(-730, 6, 808),
    ["House 30"] = Vector3.new(-245, 7, 822),
    ["House 31"] = Vector3.new(639, 76, -361),
    ["House 32"] = Vector3.new(-908, 6, -361),
    ["House 33"] = Vector3.new(-111, 70, -417),
    ["House 34"] = Vector3.new(230, 38, 569),
    ["House 35"] = Vector3.new(-30, 13, 2209)
}

-- Create ordered list of house names
local casasNomes = {}
for nome, _ in pairs(casas) do
    table.insert(casasNomes, nome)
end

table.sort(casasNomes, function(a, b)
    local numA = tonumber(a:match("%d+")) or 0
    local numB = tonumber(b:match("%d+")) or 0
    return numA < numB
end)

-- Dropdown for teleport
pcall(function()
    HouseTab:AddDropdown({
        Name = "Select House",
        Options = casasNomes,
        Callback = function(casaSelecionada)
            local player = game.Players.LocalPlayer
            if player and player.Character then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(casas[casaSelecionada])
            end
        end
    })
end)

-- Label after dropdown
pcall(function()
    HouseTab:AddLabel("Teleport to the House you want")
end)

-- Section for Auto Unban
pcall(function()
    HouseTab:AddSection({ Name = "Auto Unban" })
end)

-- Toggle for Auto Unban
pcall(function()
    HouseTab:AddToggle({
        Name = "Auto Unban",
        Default = false,
        Callback = function(state)
            isUnbanActive = state
            if isUnbanActive then
                print("Auto Unban Activated")
                spawn(startAutoUnban)
            else
                print("Auto Unban Deactivated")
            end
        end
    })
end)

-- Label after Auto Unban
pcall(function()
    HouseTab:AddLabel("Automatically unbans you from Houses")
end)

-- Section for House RGB
pcall(function()
    HouseTab:AddSection({ Name = "House RGB" })
end)

-- Toggle for House RGB
pcall(function()
    HouseTab:AddToggle({
        Name = "House RGB",
        Default = false,
        Callback = function(state)
            toggleHouseRGB(state)
        end
    })
end)

-- Label after House RGB
pcall(function()
    HouseTab:AddLabel("Makes your house RGB")
end)

-- Function for Auto Unban
function startAutoUnban()
    while isUnbanActive do
        pcall(function()
            for _, v in pairs(game:GetService("Workspace"):WaitForChild("001_Lots"):GetDescendants()) do
                if v.Name:match("^BannedBlock%d+$") then
                    v:Destroy()
                end
            end
        end)
        task.wait(1)
    end
end

local Tab = Window:MakeTab({"Audio All", "music"})

-- Create a section
Tab:AddSection({"Audio All Players"})

-- List of audios
local audios = {
    {Name = "Yamete Kudasai", ID = 108494476595033},
    {Name = "Little Scream", ID = 5710016194},
    {Name = "Horrible Jumpscare", ID = 85435253347146},
    {Name = "Loud Audio", ID = 6855150757},
    {Name = "Noise", ID = 120034877160791},
    {Name = "Jumpscare 2", ID = 110637995610528},
    {Name = "Minecraft Witch Laugh", ID = 116214940486087},
    {Name = "The Boiled One", ID = 137177653817621},
    {Name = "I laid down an Ave Maria crazy", ID = 128669424001766},
    {Name = "Mandrake Detected", ID = 9068077052},
    {Name = "Aaaaaaaaa", ID = 80156405968805},
    {Name = "AAAHHHH", ID = 9084006093},
    {Name = "amongus", ID = 6651571134},
    {Name = "Sus", ID = 6701126635},
    {Name = "Big Scream AAAAAAAAA", ID = 5853668794},
    {Name = "UHHHHH COFFCOFF", ID = 7056720271},
    {Name = "SUS", ID = 7153419575},
    {Name = "Sonic.exe", ID = 2496367477},
    {Name = "Tubers93 1", ID = 270145703},
    {Name = "Tubers93 2", ID = 18131809532},
    {Name = "John's Laugh", ID = 130759239},
    {Name = "Don't know KKKK", ID = 6549021381},
    {Name = "Scream", ID = 80156405968805},
    {Name = "Sus Audio", ID = 7705506391},
    {Name = "AAAH", ID = 7772283448},
    {Name = "Gay, gay", ID = 18786647417},
    {Name = "Bat Hit", ID = 7129073354},
    {Name = "Nuclear Siren", ID = 675587093},
    {Name = "No idea for name KK", ID = 7520729342},
    {Name = "Scream 2", ID = 91412024101709},
    {Name = "Ear Exploder", ID = 268116333},
    {Name = "Humming", ID = 106835463235574},
    {Name = "Take Jack", ID = 132603645477541},
    {Name = "Order ifood order", ID = 133843750864059},
    {Name = "I Ghost The down", ID = 84663543883498},
    {Name = "Buy Online On shoopee", ID = 8747441609},
    {Name = "Ugh How disgusting", ID = 103440368630269},
    {Name = "Get out of here Dishwasher", ID = 101232400175829},
    {Name = "Seloko not worth it", ID = 78442476709262},
}

local selectedAudioID

-- Add a textbox to insert audio ID
Tab:AddTextBox({
    Name = "Enter Audio or Music ID",
    Description = "Type the audio ID",
    PlaceholderText = "Audio ID",
    Callback = function(value)
        selectedAudioID = tonumber(value)
    end
})

-- Add a dropdown to select audio
local audioNames = {}
for _, audio in ipairs(audios) do
    table.insert(audioNames, audio.Name)
end

Tab:AddDropdown({
    Name = "Select Audio",
    Description = "Choose an audio from the list",
    Options = audioNames,
    Default = audioNames[1],
    Flag = "selected_audio",
    Callback = function(value)
        for _, audio in ipairs(audios) do
            if audio.Name == value then
                selectedAudioID = audio.ID
                break
            end
        end
    end
})

-- Loop control
local audioLoop = false

-- New section for audio loop
Tab:AddSection({"Audio Loop"})

-- Function to play audio repeatedly
local function playLoopedAudio()
    while audioLoop do
        if selectedAudioID then
            local args = {
                [1] = game:GetService("Workspace"),
                [2] = selectedAudioID,
                [3] = 1,
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))

            -- Create and play audio
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. selectedAudioID
            sound.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            sound:Play()
        else
            warn("No audio selected!")
        end

        task.wait(0.5) -- Small delay to avoid overload
    end
end

-- Toggle for audio loop
Tab:AddToggle({
    Name = "Loop Play Audio",
    Description = "Activates audio loop",
    Default = false,
    Flag = "audio_loop",
    Callback = function(value)
        audioLoop = value
        if audioLoop then
            task.spawn(playLoopedAudio) -- Starts the loop in a new thread
        end
    end
})

-- Add a paragraph as label
Tab:AddParagraph({"Info", "Audio loop (All players on server hear)"})

-- Function to play normal audio
local function playAudio()
    if selectedAudioID then
        local args = {
            [1] = game:GetService("Workspace"),
            [2] = selectedAudioID,
            [3] = 1,
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))

        -- Create and play audio
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. selectedAudioID
        sound.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        sound:Play()
    else
        warn("No audio selected!")
    end
end

-- New section for playing audio
Tab:AddSection({"Play Audio"})

-- Button to play audio
Tab:AddButton({"Play Audio", function()
    playAudio()
end})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local audioID = 6314880174 -- Fixed audio ID

local function Audio_All_ClientSide(ID)
    local function CheckFolderAudioAll()
        local FolderAudio = workspace:FindFirstChild("Audio all client")
        if not FolderAudio then
            FolderAudio = Instance.new("Folder")
            FolderAudio.Name = "Audio all client"
            FolderAudio.Parent = workspace
        end
        return FolderAudio
    end

    local function CreateSound(ID)
        if type(ID) ~= "number" then
            print("Enter a valid number!")
            return nil
        end

        local Folder_Audio = CheckFolderAudioAll()
        if Folder_Audio then
            local Sound = Instance.new("Sound")
            Sound.SoundId = "rbxassetid://" .. ID
            Sound.Volume = 1
            Sound.Looped = false
            Sound.Parent = Folder_Audio
            Sound:Play()
            task.wait(1) -- Wait time before removing sound
            Sound:Destroy()
        end
    end

    CreateSound(ID)
end

local function Audio_All_ServerSide(ID)
    if type(ID) ~= "number" then
        print("Enter a valid number!")
        return nil
    end

    local GunSoundEvent = ReplicatedStorage:FindFirstChild("1Gu1nSound1s", true)
    if GunSoundEvent then
        GunSoundEvent:FireServer(workspace, ID, 1)
    end
end

-- Toggle for "Explode everyone's ears"
Tab:AddToggle({
    Name = "Explode everyone's ears LOL",
    Description = "Plays audio repeatedly for everyone",
    Default = false,
    Flag = "audio_spam",
    Callback = function(value)
        getgenv().Audio_All_loop_fast = value

        while getgenv().Audio_All_loop_fast do
            Audio_All_ServerSide(audioID)
            task.spawn(function()
                Audio_All_ClientSide(audioID)
            end)
            task.wait(0.03) -- Extremely fast delay (0.03 seconds)
        end
    end
})

Tab:AddParagraph({"Info", "Everyone on the server hears the audio"})


local Tab = Window:MakeTab({"Lag Server", "bomb"})

-- Shutdown Custom Section
local Section = Tab:AddSection({
    Name = "Custom Shutdown"
})

-- Shutdown Server Button
Tab:AddButton({
    Name = "Shutdown Server",
    Callback = function()
        for m = 1, 495 do
            local args = {
                [1] = "PickingTools",
                [2] = "FireHose"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            local args = {
                [1] = "FireHose",
                [2] = "DestroyFireHose"
            }
            game:GetService("Players").LocalPlayer.Backpack.FireHose.ToolSound:FireServer(unpack(args))
        end
        local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -475, 999999999.414)
        local rootpart = game.Players.LocalPlayer.Character.HumanoidRootPart
        repeat wait() until rootpart.Parent == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Shutdown Complete, Now will turn off",
            Button1 = "Ok",
            Duration = 5
        })
        wait()
        for _, ergeg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ergeg.Name == "FireHose" then
                ergeg.Parent = game.Players.LocalPlayer.Character
            end
        end
        wait(0.2)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Starting duplication, please be patient",
            Button1 = "Ok",
            Duration = 5
        })
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9999, -475, 9999)
    end
})

-- Shutdown Server (Internet Error) Button
Tab:AddButton({
    Name = "Shutdown Server (Internet Error)",
    Callback = function()
        for m = 1, 535 do
            local args = {
                [1] = "PickingTools",
                [2] = "FireHose"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            local args = {
                [1] = "FireHose",
                [2] = "DestroyFireHose"
            }
            game:GetService("Players").LocalPlayer.Backpack.FireHose.ToolSound:FireServer(unpack(args))
        end
        local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -475, 999999999.414)
        local rootpart = game.Players.LocalPlayer.Character.HumanoidRootPart
        repeat wait() until rootpart.Parent == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Shutdown Complete, Now will turn off",
            Button1 = "Ok",
            Duration = 5
        })
        wait()
        for _, ergeg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ergeg.Name == "FireHose" then
                ergeg.Parent = game.Players.LocalPlayer.Character
            end
        end
        wait(0.2)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Starting duplication, please be patient",
            Button1 = "Ok",
            Duration = 5
        })
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9999, -475, 9999)
    end
})

-- Shutdown Server (Timeout Error) Button
Tab:AddButton({
    Name = "Shutdown Server (Connection Timeout Error)",
    Callback = function()
        for m = 1, 635 do
            local args = {
                [1] = "PickingTools",
                [2] = "FireHose"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            local args = {
                [1] = "FireHose",
                [2] = "DestroyFireHose"
            }
            game:GetService("Players").LocalPlayer.Backpack.FireHose.ToolSound:FireServer(unpack(args))
        end
        local oldcf = game. ascended
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Shutdown Complete, Now will turn off",
            Button1 = "Ok",
            Duration = 5
        })
        wait()
        for _, ergeg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ergeg.Name == "FireHose" then
                ergeg.Parent = game.Players.LocalPlayer.Character
            end
        end
        wait(0.2)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Starting duplication, please be patient",
            Button1 = "Ok",
            Duration = 5
        })
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9999, -475, 9999)
    end
})

-- Lag Laptop Section
local Section = Tab:AddSection({
    Name = "Lag with Laptop"
})

-- Toggle State for Lag Laptop
local toggles = { LagLaptop = false }

-- Function to Simulate Normal Click
local function clickNormally(object)
    local clickDetector = object:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

-- Function to Lag Game with Laptop
local function lagarJogoLaptop(laptopPath, maxTeleports)
    if laptopPath then
        local teleportCount = 0
        while teleportCount < maxTeleports and toggles.LagLaptop do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = laptopPath.CFrame
            clickNormally(laptopPath)
            teleportCount = teleportCount + 1
            wait(0.0001)
        end
    else
        warn("Laptop not found.")
    end
end

-- Lag Laptop Toggle
Tab:AddToggle({
    Name = "Lag with Laptop",
    Default = false,
    Callback = function(state)
        toggles.LagLaptop = state
        if state then
            local laptopPath = workspace:FindFirstChild("WorkspaceCom"):FindFirstChild("001_GiveTools"):FindFirstChild("Laptop")
            if laptopPath then
                spawn(function()
                    lagarJogoLaptop(laptopPath, 999999999)
                end)
            else
                warn("Laptop not found.")
            end
        else
            print("Lag with Laptop deactivated.")
        end
    end
})

-- Lag Laptop Paragraph
Tab:AddParagraph({
    "Lag Information",
    "The lag effect starts after 35 seconds"
})

-- Lag Phone Section
local Section = Tab:AddSection({
    Name = "Lag with Phone"
})

-- Toggle State for Lag Phone
toggles.LagPhone = false

-- Function to Lag Game with Phone
local function lagarJogoPhone(phonePath, maxTeleports)
    if phonePath then
        local teleportCount = 0
        while teleportCount < maxTeleports and toggles.LagPhone do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = phonePath.CFrame
            clickNormally(phonePath)
            teleportCount = teleportCount + 1
            wait(0.01)
        end
    else
        warn("Phone not found.")
    end
end

-- Lag Phone Toggle
Tab:AddToggle({
    Name = "Lag with Phone",
    Default = false,
    Callback = function(state)
        toggles.LagPhone = state
        if state then
            local phonePath = workspace:FindFirstChild("WorkspaceCom"):FindFirstChild("001_CommercialStores"):FindFirstChild("CommercialStorage1"):FindFirstChild("Store"):FindFirstChild("Tools"):FindFirstChild("Iphone")
            if phonePath then
                spawn(function()
                    lagarJogoPhone(phonePath, 999999)
                end)
            else
                warn("Phone not found.")
            end
        else
            print("Lag with Phone deactivated.")
        end
    end
})

-- Lag Phone Paragraph
Tab:AddParagraph({
    "Lag Information",
    "The script starts causing lag after 35 seconds"
})

local Section = Tab:AddSection({
    Name = "Lag with Bomb"
})


local BombActive = false

Tab:AddToggle({
    Name = "Lag with Bomb",
    Default = false,
    Callback = function(Value)
        if Value then
            BombActive = true

            local Player = game.Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local RootPart = Character:WaitForChild("HumanoidRootPart")
            local WorkspaceService = game:GetService("Workspace")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Bomb = WorkspaceService:WaitForChild("WorkspaceCom"):WaitForChild("001_CriminalWeapons"):WaitForChild("GiveTools"):WaitForChild("Bomb")

            task.spawn(function()
                while BombActive do
                    if Bomb and RootPart then
                        RootPart.CFrame = Bomb.CFrame
                        fireclickdetector(Bomb.ClickDetector) -- Activates the bomb's ClickDetector
                        task.wait(0.00001) -- Minimum delay to avoid freezing
                    else
                        task.wait(0.0001) 
                    end
                end
            end)

            task.spawn(function()
                while BombActive do
                    if Bomb and RootPart then
                        local VirtualInputManager = game:GetService("VirtualInputManager")
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0) 
                        task.wait(1.5)
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0) 

                        -- Executes FireServer with the player's name
                        local args = {
                            [1] = "Bomb" .. Player.Name -- Uses the current player's name
                        }
                        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Blo1wBomb1sServe1r"):FireServer(unpack(args))
                    end
                    task.wait(1.5) -- 1 second interval for click and FireServer
                end
            end)
        else
            -- Deactivating the functionality
            BombActive = false
        end
    end
})

Tab:AddParagraph({
    "Lag Information",
    "The script starts causing lag after 35 seconds"
})

local Tab = Window:MakeTab({"Names", "Paper"})

local isNameActive = false
local isBioActive = false

local SectionRGBName = Tab:AddSection({
    Name = "RGB Name"
})

Tab:AddToggle({
    Name = "RGB Name",
    Description = "Activate RGB Name",
    Default = false,
    Callback = function(value)
        isNameActive = value
        print(value and "RGB Name activated" or "RGB Name deactivated")
    end
})


local SectionRGBBio = Tab:AddSection({
    Name = "RGB BIO"
})

Tab:AddToggle({
    Name = "RGB BIO",
    Description = "Activate RGB BIO",
    Default = false,
    Callback = function(value)
        isBioActive = value
        print(value and "RGB BIO activated" or "RGB BIO deactivated")
    end
})


local vibrantColors = {
    Color3.fromRGB(255, 0, 0),   -- Red
    Color3.fromRGB(0, 255, 0),   -- Green
    Color3.fromRGB(0, 0, 255),   -- Blue
    Color3.fromRGB(255, 255, 0), -- Yellow
    Color3.fromRGB(255, 0, 255), -- Magenta
    Color3.fromRGB(0, 255, 255), -- Cyan
    Color3.fromRGB(255, 165, 0), -- Orange
    Color3.fromRGB(128, 0, 128), -- Purple
    Color3.fromRGB(255, 20, 147) -- Hot Pink
}

spawn(function()
    while true do
        if isNameActive then
            local randomColor = vibrantColors[math.random(#vibrantColors)]
            local args = {
                [1] = "PickingRPNameColor",
                [2] = randomColor
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r"):FireServer(unpack(args))
        end
        wait(0.7)
    end
end)

spawn(function()
    while true do
        if isBioActive then
            local randomColor = vibrantColors[math.random(#vibrantColors)]
            local args = {
                [1] = "PickingRPBioColor",
                [2] = randomColor
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r"):FireServer(unpack(args))
        end
        wait(0.7)
    end
end)

local SectionNames = Tab:AddSection({
    Name = "Add Names to Player"
})

local names = {
    {"Anonymus", " Anonymus "},
    {"PRO", " PRO "},
    {"ERR0R_666", " ERR0R_666 "},
    {"DARKNE1SSS", " DARKNE1SSS "},
    {"GHOST", " GHOST "},
    {"JOKER", " JOKER "},
    {"ADMIN", " ADMIN "},
    {"TUBERS93", " TUBERS 93 "},
    {"CO0LKID", " CO0 LKID "},
    {"GAME ATTACKED BY MAFIA", " GAME ATTACKED BY MAFIA "},
    {"INC0MUN", " INC0MUN"},
    {"BAD BOY", " BAD BOY "}
}

for _, name in ipairs(names) do
    Tab:AddButton({
        Name = "Name: " .. name[1],
        Callback = function()
            game:GetService("ReplicatedStorage").RE["1RPNam1eTex1t"]:FireServer("RolePlayName", name[2])
        end
    })
end


local CarTab = Window:MakeTab({"Car", "car"})

-- Colors for RGB
local colors = {
    Color3.new(1, 0, 0),     -- Red
    Color3.new(0, 1, 0),     -- Green
    Color3.new(0, 0, 1),     -- Blue
    Color3.new(1, 1, 0),     -- Yellow
    Color3.new(1, 0, 1),     -- Magenta
    Color3.new(0, 1, 1),     -- Cyan
    Color3.new(0.5, 0, 0.5), -- Purple
    Color3.new(1, 0.5, 0)    -- Orange
}

-- Replicated Storage Service
local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = replicatedStorage:WaitForChild("RE"):WaitForChild("1Player1sCa1r")

-- RGB Color Change Logic
local isColorChanging = false
local colorChangeCoroutine = nil

local function changeCarColor()
    while isColorChanging do
        for _, color in ipairs(colors) do
            if not isColorChanging then return end
            local args = {
                [1] = "PickingCarColor",
                [2] = color
            }
            remoteEvent:FireServer(unpack(args))
            wait(1)
        end
    end
end

CarTab:AddButton({
    Name = "Remove All Cars",
    Callback = function()
        local ofnawufn = false

if ofnawufn == true then
    return
end
ofnawufn = true

local cawwfer = "MilitaryBoatFree" -- Changed to MilitaryBoatFree
local oldcfffff = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1754, -2, 58) -- Updated coordinates
wait(0.3)

local args = {
    [1] = "PickingBoat", -- Changed to PickingBoat
    [2] = cawwfer
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
wait(1)

local wrinfjn
for _, errb in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
    if errb:IsA("VehicleSeat") then
        wrinfjn = errb
    end
end

repeat
    if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        if not game.Players.LocalPlayer.Character.Humanoid.SeatPart == wrinfjn then
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame + Vector3.new(0,1,0)
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame + Vector3.new(0,-1,0)
    task.wait()
until game.Players.LocalPlayer.Character.Humanoid.SeatPart == wrinfjn

for _, wifn in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
    if wifn.Name == "PhysicalWheel" then
        wifn:Destroy()
    end
end

local FLINGED = Instance.new("BodyThrust", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass) 
FLINGED.Force = Vector3.new(50000, 0, 50000) 
FLINGED.Name = "SUNTERIUM HUB FLING"
FLINGED.Location = game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.Position

for _, wvwvwasc in pairs(game.workspace.Vehicles:GetChildren()) do
    for _, ascegr in pairs(wvwvwasc:GetDescendants()) do
        if ascegr.Name == "VehicleSeat" then
            local targetcar = ascegr
            local tet = Instance.new("BodyVelocity", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass)
            tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            tet.P = 1250
            tet.Velocity = Vector3.new(0,0,0)
            tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
            for m=1,25 do
                local pos = {x=0, y=0, z=0}
                pos.x = targetcar.Position.X
                pos.y = targetcar.Position.Y
                pos.z = targetcar.Position.Z
                pos.x = pos.x + targetcar.Velocity.X / 2
                pos.y = pos.y + targetcar.Velocity.Y / 2
                pos.z = pos.z + targetcar.Velocity.Z / 2
                if pos.y <= -200 then
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(0,1000,0)
                else
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
                    task.wait()
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) + Vector3.new(0,-2,0)
                    task.wait()
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(0,0,2)
                    task.wait()
                    game.workspace.Vehicles[
game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(2,0,0)
                    task.wait()
                end
                task.wait()
            end
        end
    end
end

task.wait()
local args = {
    [1] = "DeleteAllVehicles"
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
game.Players.LocalPlayer.Character.Humanoid.Sit = false
wait()
local tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
tet.P = 1250
tet.Velocity = Vector3.new(0,0,0)
tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
wait(0.1)
for m=1,2 do 
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcfffff
end
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcfffff
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"):Destroy()
wait(0.2)
ofnawufn = false
    end
})

CarTab:AddParagraph({"Information:", "I recommend using it twice to ensure all vehicles are removed"})

CarTab:AddButton({
    Name = "Bring All Cars",
    Callback = function()
        for _, v in next, workspace.Vehicles:GetChildren() do
            v:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame())
        end
    end
})

CarTab:AddParagraph({"Information:", "Pulls all server cars to you"})

-- Speed V1 Section
local SpeedSection = CarTab:AddSection({"Speed V1"})

local Speed = 50
local Turbo = 50

local function ChangeCarSpeedAndTurbo(speedValue, turboValue)
    local player = game.Players.LocalPlayer
    local car = workspace.Vehicles:FindFirstChild(player.Name .. "Car")

    if car then
        local body = car:FindFirstChild("Body").VehicleSeat
        if body then
            body.TopSpeed.Value = speedValue
            body.Turbo.Value = turboValue
            wait(0.1)
            redzlib:MakeNotification({
                Name = "Mafia Hub",
                Content = "Done, You can Move Now!",
                Time = 5
            })
        else
            redzlib:MakeNotification({
                Name = "Error",
                Content = "Sit in car first!",
                Time = 5
            })
        end
    else
        redzlib:MakeNotification({
            Name = "Error",
            Content = "Put a Car First!",
            Time = 5
        })
    end
end

CarTab:AddTextBox({
    Name = "Speed",
    PlaceholderText = "50",
    Callback = function(value)
        local newSpeed = tonumber(value)
        if newSpeed then
            Speed = newSpeed
        end
    end
})

CarTab:AddTextBox({
    Name = "Turbo",
    PlaceholderText = "50",
    Callback = function(value)
        local newTurbo = tonumber(value)
        if newTurbo then
            Turbo = newTurbo
        end
    end
})

CarTab:AddTextBox({
    Name = "Drift",
    PlaceholderText = "50",
    Callback = function(value)
        local args = {
            [1] = "DriftingNumber",
            [2] = value
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(args))
    end
})

CarTab:AddButton({
    Name = "Apply Speed, Turbo and Drift",
    Callback = function()
        ChangeCarSpeedAndTurbo(Speed, Turbo)
    end
})

-- Turbo V2 Section
local TurboSection = CarTab:AddSection({"Turbo V2"})

CarTab:AddButton({
    Name = "Turbo V2 [Best]",
    Callback = function()
     local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

local voando = false
local velocidade = 30

local telaGui = Instance.new("ScreenGui", player.PlayerGui)

local function criarBotaoImagem(nome, posicao, idImagem, rotacao, acao)
    local botao = Instance.new("ImageButton", telaGui)
    botao.Size = UDim2.new(0, 60, 0, 60)
    botao.Position = posicao
    botao.BackgroundTransparency = 1
    botao.Image = "rbxassetid://" .. idImagem
    botao.Rotation = rotacao
    botao.MouseButton1Down:Connect(acao)
    return botao
end

local botaoFrente = criarBotaoImagem("BotaoFrente", UDim2.new(0, 10, 0.35, 0), "18478249606", 0, function()
    voando = true
    while voando do
        if humanoidRootPart then
            humanoidRootPart.Velocity = humanoidRootPart.CFrame.LookVector * velocidade
        end
        task.wait()
    end
end)

local botaoTras = criarBotaoImagem("BotaoTras", UDim2.new(0, 10, 0.5, 0), "18478249606", 180, function()
    voando = true
    while voando do
        if humanoidRootPart then
            humanoidRootPart.Velocity = -humanoidRootPart.CFrame.LookVector * velocidade
        end
        task.wait()
    end
end)

local botaoEsquerda = criarBotaoImagem("BotaoEsquerda", UDim2.new(1, -210, 0.3, 0), "18478249606", -90, function()
    voando = true
    while voando do
        if humanoidRootPart then
            humanoidRootPart.Velocity = -humanoidRootPart.CFrame.RightVector * velocidade
        end
        task.wait()
    end
end)

local botaoDireita = criarBotaoImagem("BotaoDireita", UDim2.new(1, -140, 0.3, 0), "18478249606", 90, function()
    voando = true
    while voando do
        if humanoidRootPart then
            humanoidRootPart.Velocity = humanoidRootPart.CFrame.RightVector * velocidade
        end
        task.wait()
    end
end)

local function pararVoo()
    voando = false
    if humanoidRootPart then
        humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

botaoFrente.MouseButton1Up:Connect(pararVoo)
botaoTras.MouseButton1Up:Connect(pararVoo)
botaoEsquerda.MouseButton1Up:Connect(pararVoo)
botaoDireita.MouseButton1Up:Connect(pararVoo)

local botaoTurbo = Instance.new("ImageButton", telaGui)
botaoTurbo.Size = UDim2.new(0, 60, 0, 60)
botaoTurbo.Position = UDim2.new(1, -130, 0, 10)
botaoTurbo.BackgroundTransparency = 1
botaoTurbo.Image = "rbxassetid://97607579386418"
botaoTurbo.MouseButton1Down:Connect(function()
    velocidade = 300
end)

-- Minimize button (with "+" or "-" depending on state)
local botaoMinimizar = Instance.new("TextButton", telaGui)
botaoMinimizar.Size = UDim2.new(0, 60, 0, 60)
botaoMinimizar.Position = UDim2.new(0, 10, 0, 10)  -- Changed to top left corner
botaoMinimizar.BackgroundTransparency = 1
botaoMinimizar.Text = "-"  -- Starts with "-" symbol
botaoMinimizar.TextSize = 40
botaoMinimizar.TextColor3 = Color3.fromRGB(255, 255, 255)

local botoes = {botaoFrente, botaoTras, botaoEsquerda, botaoDireita, botaoTurbo}

local minimizado = false

local function alternarBotoes()
    minimizado = not minimizado
    for _, botao in ipairs(botoes) do
        botao.Visible = not minimizado
    end
    -- Change the text of the minimize button
    if minimizado then
        botaoMinimizar.Text = "+"
    else
        botaoMinimizar.Text = "-"
    end
end

botaoMinimizar.MouseButton1Down:Connect(alternarBotoes)    
    end
})

CarTab:AddParagraph({"Information:", "Both turbos do not require Gamepass"})

-- Music Section
local MusicSection = CarTab:AddSection({"Music for Cars, Houses"})

local musicIds = {
    "71373562243752", "138129019858244", "138480372357526", "122199933878670",
    "74187181906707", "82793916573031", "107421761958790", "91394092603440",
    "113198957973421", "81452315991527", "93786060174790", "74752089069476",
    "131592235762789", "132081774507495", "124394293950763", "83381647646350",
    "16190782181", "1841682637", "3148329638", "124928367733395",
    "106317184644394", "100247055114504", "107035638005233", "109351649716900",
    "84751398517083", "125259969174449", "89269071829332", "88094479399489",
    "72440232513341", "92893359226454", "111281710445018", "98677515506006",
    "105882833374061", "104541292443133", "105832154444494", "84733736048142",
    "94718473830640", "130324826943718", "123039027577735", "113312785512702",
    "139161205970637", "113768944849093", "135667903253566", "81335392002580",
    "77428091165211", "14145624031", "8080255618", "8654835474",
    "13530439502", "18841894272", "90323407842935", "136932193331774",
    "113504863495384", "1836175030", "79998949362539", "109188610023287",
    "134939857094956", "132245626038510", "124567809277408", "72591334498716",
    "76578817848504", "17422156627", "81902909302285", "130449561461006",
    "110519234838026", "106434295960535", "86271123924168", "85481949732828",
    "106476166672589", "87968531262747", "73966367524216", "137962454483542",
    "98371771055411", "111668097052966", "140095882383991", "122873874738223",
    "105461615542794"
}

local function playCarMusic(musicId)
    if musicId and musicId ~= "" then
        local carArgs = {
            [1] = "PickingCarMusicText",
            [2] = musicId
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(carArgs))
    end
end

local function playScooterMusic(musicId)
    if musicId and musicId ~= "" then
        local scooterArgs = {
            [1] = "PickingScooterMusicText",
            [2] = musicId
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1NoMoto1rVehicle1s"):FireServer(unpack(scooterArgs))
    end
end

local function playHouseMusic(musicId)
    if musicId and musicId ~= "" then
        local houseArgs = {
            [1] = "PickHouseMusicText",
            [2] = musicId
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Player1sHous1e"):FireServer(unpack(houseArgs))
    end
end

CarTab:AddTextBox({
    Name = "Music ID (Gamepass Required)",
    PlaceholderText = "Enter Music ID",
    Callback = function(value)
        playCarMusic(value)
        playScooterMusic(value)
        playHouseMusic(value)
    end
})

CarTab:AddDropdown({
    Name = "Select Music (Gamepass Required)",
    Options = musicIds,
    Callback = function(value)
        playCarMusic(value)
        playScooterMusic(value)
        playHouseMusic(value)
    end
})

CarTab:AddParagraph({"Note", "The music script works on all cars and houses"})

-- Car RGB Section
local RGBSection = CarTab:AddSection({"Car RGB"})

CarTab:AddToggle({
    Name = "Car RGB",
    Default = false,
    Callback = function(state)
        isColorChanging = state
        if isColorChanging then
            colorChangeCoroutine = coroutine.create(changeCarColor)
            coroutine.resume(colorChangeCoroutine)
        end
    end
})

CarTab:AddParagraph({"Note", "Activating this will make your car RGB"})

-- Spam Horn Section
local HornSection = CarTab:AddSection({"Spam Horn"})

local spamming = false
local args = {"Horn"}

local function spamHorn()
    while spamming do
        remoteEvent:FireServer(unpack(args))
        wait(0.1)
    end
end

CarTab:AddToggle({
    Name = "Spam Horn",
    Default = false,
    Callback = function(value)
        spamming = value
        if spamming then
            spawn(spamHorn)
        end
    end
})

-- Fly Car Section
local FlySection = CarTab:AddSection({"Fly Car"})

CarTab:AddButton({
    Name = "Fly Car",
    Callback = function()
        --by Luscaa
-- Version: 4.1

-- Instances:
local Flymguiv2 = Instance.new("ScreenGui")
local Drag = Instance.new("Frame")
local FlyFrame = Instance.new("Frame")
local ddnsfbfwewefe = Instance.new("TextButton")
local Speed = Instance.new("TextBox")
local Fly = Instance.new("TextButton")
local Speeed = Instance.new("TextLabel")
local Stat = Instance.new("TextLabel")
local Stat2 = Instance.new("TextLabel")
local Unfly = Instance.new("TextButton")
local Vfly = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local Flyon = Instance.new("Frame")
local W = Instance.new("TextButton")
local S = Instance.new("TextButton")

--Properties:

Flymguiv2.Name = "Car Fly gui v2"
Flymguiv2.Parent = game.CoreGui
Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Drag.Name = "Drag"
Drag.Parent = Flymguiv2
Drag.Active = true
Drag.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Drag.BorderSizePixel = 0
Drag.Draggable = true
Drag.Position = UDim2.new(0.482438415, 0, 0.454874992, 0)
Drag.Size = UDim2.new(0, 237, 0, 27)

FlyFrame.Name = "FlyFrame"
FlyFrame.Parent = Drag
FlyFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FlyFrame.BorderSizePixel = 0
FlyFrame.Draggable = true
FlyFrame.Position = UDim2.new(-0.00200000009, 0, 0.989000022, 0)
FlyFrame.Size = UDim2.new(0, 237, 0, 139)

ddnsfbfwewefe.Name = "ddnsfbfwewefe"
ddnsfbfwewefe.Parent = FlyFrame
ddnsfbfwewefe.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
ddnsfbfwewefe.BorderSizePixel = 0
ddnsfbfwewefe.Position = UDim2.new(-0.000210968778, 0, -0.00395679474, 0)
ddnsfbfwewefe.Size = UDim2.new(0, 237, 0, 27)
ddnsfbfwewefe.Font = Enum.Font.SourceSans
ddnsfbfwewefe.Text = "by Lusquinha_067"
ddnsfbfwewefe.TextColor3 = Color3.fromRGB(255, 255, 255)
ddnsfbfwewefe.TextScaled = true
ddnsfbfwewefe.TextSize = 14.000
ddnsfbfwewefe.TextWrapped = true

Speed.Name = "Speed"
Speed.Parent = FlyFrame
Speed.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
Speed.BorderColor3 = Color3.fromRGB(0, 0, 191)
Speed.BorderSizePixel = 0
Speed.Position = UDim2.new(0.445025861, 0, 0.402877688, 0)
Speed.Size = UDim2.new(0, 111, 0, 33)
Speed.Font = Enum.Font.SourceSans
Speed.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Speed.Text = "50"
Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
Speed.TextScaled = true
Speed.TextSize = 14.000
Speed.TextWrapped = true

Fly.Name = "Fly"
Fly.Parent = FlyFrame
Fly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Fly.BorderSizePixel = 0
Fly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
Fly.Size = UDim2.new(0, 199, 0, 32)
Fly.Font = Enum.Font.SourceSans
Fly.Text = "Enable"
Fly.TextColor3 = Color3.fromRGB(255, 255, 255)
Fly.TextScaled = true
Fly.TextSize = 14.000
Fly.TextWrapped = true
Fly.MouseButton1Click:Connect(function()
	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
	Fly.Visible = false
	Stat2.Text = "On"
	Stat2.TextColor3 = Color3.fromRGB(0, 255, 0)
	Unfly.Visible = true
	Flyon.Visible = true
	local BV = Instance.new("BodyVelocity",HumanoidRP)
	local BG = Instance.new("BodyGyro",HumanoidRP)
	BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	game:GetService('RunService').RenderStepped:connect(function()
	BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
	BG.D = 5000
	BG.P = 100000
	BG.CFrame = game.Workspace.CurrentCamera.CFrame
	end)
end)

Speeed.Name = "Speeed"
Speeed.Parent = FlyFrame
Speeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Speeed.BorderSizePixel = 0
Speeed.Position = UDim2.new(0.0759493634, 0, 0.402877688, 0)
Speeed.Size = UDim2.new(0, 87, 0, 32)
Speeed.ZIndex = 0
Speeed.Font = Enum.Font.SourceSans
Speeed.Text = "Speed:"
Speeed.TextColor3 = Color3.fromRGB(255, 255, 255)
Speeed.TextScaled = true
Speeed.TextSize = 14.000
Speeed.TextWrapped = true

Stat.Name = "Stat"
Stat.Parent = FlyFrame
Stat.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Stat.BorderSizePixel = 0
Stat.Position = UDim2.new(0.299983799, 0, 0.239817441, 0)
Stat.Size = UDim2.new(0, 85, 0, 15)
Stat.Font = Enum.Font.SourceSans
Stat.Text = "Status:"
Stat.TextColor3 = Color3.fromRGB(255, 255, 255)
Stat.TextScaled = true
Stat.TextSize = 14.000
Stat.TextWrapped = true

Stat2.Name = "Stat2"
Stat2.Parent = FlyFrame
Stat2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Stat2.BorderSizePixel = 0
Stat2.Position = UDim2.new(0.546535194, 0, 0.239817441, 0)
Stat2.Size = UDim2.new(0, 27, 0, 15)
Stat2.Font = Enum.Font.SourceSans
Stat2.Text = "Off"
Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
Stat2.TextScaled = true
Stat2.TextSize = 14.000
Stat2.TextWrapped = true

Unfly.Name = "Unfly"
Unfly.Parent = FlyFrame
Unfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Unfly.BorderSizePixel = 0
Unfly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
Unfly.Size = UDim2.new(0, 199, 0, 32)
Unfly.Visible = false
Unfly.Font = Enum.Font.SourceSans
Unfly.Text = "Disable"
Unfly.TextColor3 = Color3.fromRGB(255, 255, 255)
Unfly.TextScaled = true
Unfly.TextSize = 14.000
Unfly.TextWrapped = true
Unfly.MouseButton1Click:Connect(function()
	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
	Fly.Visible = true
	Stat2.Text = "Off"
	Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
	wait()
	Unfly.Visible = false
	Flyon.Visible = false
	HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()
	HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()
end)

Vfly.Name = "Vfly"
Vfly.Parent = Drag
Vfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Vfly.BorderSizePixel = 0
Vfly.Size = UDim2.new(0, 57, 0, 27)
Vfly.Font = Enum.Font.SourceSans
Vfly.Text = "Car fly"
Vfly.TextColor3 = Color3.fromRGB(255, 255, 255)
Vfly.TextScaled = true
Vfly.TextSize = 14.000
Vfly.TextWrapped = true

Close.Name = "Close"
Close.Parent = Drag
Close.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.875, 0, 0, 0)
Close.Size = UDim2.new(0, 27, 0, 27)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true
Close.MouseButton1Click:Connect(function()
	Flymguiv2:Destroy()
end)

Minimize.Name = "Minimize"
Minimize.Parent = Drag
Minimize.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0.75, 0, 0, 0)
Minimize.Size = UDim2.new(0, 27, 0, 27)
Minimize.Font = Enum.Font.SourceSans
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextScaled = true
Minimize.TextSize = 14.000
Minimize.TextWrapped = true
function Mini()
	if Minimize.Text == "-" then
		Minimize.Text = "+"
		FlyFrame.Visible = false
	elseif Minimize.Text == "+" then
		Minimize.Text = "-"
		FlyFrame.Visible = true
	end
end
Minimize.MouseButton1Click:Connect(Mini)

Flyon.Name = "Fly on"
Flyon.Parent = Flymguiv2
Flyon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Flyon.BorderSizePixel = 0
Flyon.Position = UDim2.new(0.117647067, 0, 0.550284624, 0)
Flyon.Size = UDim2.new(0.148000002, 0, 0.314999998, 0)
Flyon.Visible = false
Flyon.Active = true
Flyon.Draggable = true

W.Name = "W"
W.Parent = Flyon
W.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
W.BorderSizePixel = 0
W.Position = UDim2.new(0.134719521, 0, 0.0152013302, 0)
W.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
W.Font = Enum.Font.SourceSans
W.Text = "^"
W.TextColor3 = Color3.fromRGB(255, 255, 255)
W.TextScaled = true
W.TextSize = 14.000
W.TextWrapped = true
W.TouchLongPress:Connect(function()
	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

W.MouseButton1Click:Connect(function()
	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

S.Name = "S"
S.Parent = Flyon
S.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
S.BorderSizePixel = 0
S.Position = UDim2.new(0.134000003, 0, 0.479999989, 0)
S.Rotation = 180.000
S.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
S.Font = Enum.Font.SourceSans
S.Text = "^"
S.TextColor3 = Color3.fromRGB(255, 255, 255)
S.TextScaled = true
S.TextSize = 14.000
S.TextWrapped = true
S.TouchLongPress:Connect(function()
	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

S.MouseButton1Click:Connect(function()
	local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
	wait(.1)
	HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)
    end
})

CarTab:AddParagraph({"Note", "Activating this you can fly with your car"})

-- Spam Cars Section
local SpamCarSection = CarTab:AddSection({"Spam Car"})

local carList = {
    "SchoolBus", "SmartCar", "FarmTruck", "Cadillac", "Excavator",
    "Jeep", "NascarTruck", "TowTruck", "Snowplow", "MilitaryTruck",
    "Tank", "Limo", "FireTruck"
}

local spamCarsActive = false

local function spawnCar(carName)
    local args = {
        [1] = "PickingCar",
        [2] = carName
    }
    game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
end

CarTab:AddToggle({
    Name = "Spam Cars",
    Default = false,
    Callback = function(state)
        spamCarsActive = state
        if spamCarsActive then
            task.spawn(function()
                while spamCarsActive do
                    for _, carName in ipairs(carList) do
                        if not spamCarsActive then break end
                        spawnCar(carName)
                        wait(0.4)
                    end
                end
            end)
        end
    end
})

CarTab:AddParagraph({"Information:", "Spam various cars"})


-- Global variables
local pl = game.Players.LocalPlayer
local players = {}

-- Function to update player list
local function updatePlayerList()
    players = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(players, player.Name)
    end
    return players
end

-- Initialize player list
updatePlayerList()

-- Child Tab
local ChildTab = Window:MakeTab({"Child", "baby"})

local Section = ChildTab:AddSection({
    Name = "Child"
})

local chasingplayer = nil
local playerChild = ChildTab:AddDropdown({
    Name = "Select a player to chase",
    Options = players,
    Default = "",
    Callback = function(selected)
        if game.Players:FindFirstChild(selected) then
            chasingplayer = selected
        else
            chasingplayer = nil
        end
    end
})

ChildTab:AddButton({
    Name = "Refresh Player List",
    Callback = function()
        local updatedPlayers = updatePlayerList()
        if playerChild and updatedPlayers then
            pcall(function()
                playerChild:Refresh(updatedPlayers)
            end)
            if chasingplayer and not game.Players:FindFirstChild(chasingplayer) then
                chasingplayer = nil
                pcall(function()
                    playerChild:Set("")
                end)
            end
        end
    end
})

-- Player join/leave events
game.Players.PlayerAdded:Connect(function()
    task.wait(0.1)
    local updatedPlayers = updatePlayerList()
    if playerChild and updatedPlayers then
        pcall(function()
            playerChild:Refresh(updatedPlayers)
        end)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    task.wait(0.1)
    local updatedPlayers = updatePlayerList()
    if playerChild and updatedPlayers then
        pcall(function()
            playerChild:Refresh(updatedPlayers)
        end)
        if chasingplayer == player.Name then
            chasingplayer = nil
            pcall(function()
                playerChild:Set("")
            end)
        end
    end
end)

ChildTab:AddButton({
    Name = "Send Child",
    Callback = function()
        if not chasingplayer then
            warn("No player selected!")
            return
        end
        if not workspace:FindFirstChild(pl.Name) or not workspace[pl.Name]:FindFirstChild("FollowCharacter") then
            local args = {
                [1] = "CharacterFollowSpawnPlayer",
                [2] = "BabyBoy"
            }
            local success, err = pcall(function()
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Bab1yFollo1w"):FireServer(unpack(args))
            end)
            if not success then
                warn("Error sending child: " .. err)
            end
        end
        
        task.wait(0.2)
        
        if workspace:FindFirstChild(pl.Name) then
            for _, v in pairs(workspace[pl.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end

        local target = chasingplayer
        if workspace:FindFirstChild(target) and workspace:FindFirstChild(pl.Name) and workspace[pl.Name]:FindFirstChild("FollowCharacter") then
            workspace[pl.Name].FollowCharacter.Parent = workspace[target]

            if rawget(getgenv(), "RunService") then
                return
            end

            getgenv().RunService = game:GetService("RunService").Heartbeat:Connect(function()
                local followCharacter = workspace[target]:FindFirstChild("FollowCharacter")
                if followCharacter and followCharacter:FindFirstChild("Torso") and followCharacter.Torso:FindFirstChild("BodyPosition") then
                    local humanoidRootPart = workspace[target]:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        followCharacter.Torso.BodyPosition.Position = humanoidRootPart.Position - (humanoidRootPart.CFrame.LookVector * 3)
                        followCharacter.Torso.BodyGyro.CFrame = humanoidRootPart.CFrame
                    end
                end
            end)
        end
    end
})

ChildTab:AddButton({
    Name = "Return Child",
    Callback = function()
        if rawget(getgenv(), "RunService") then
            getgenv().RunService:Disconnect()
            getgenv().RunService = nil
        end

        local args = { [1] = "DeleteFollowCharacter" }
        local success, err = pcall(function()
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Bab1yFollo1w"):FireServer(unpack(args))
        end)
        if not success then
            warn("Error returning child: " .. err)
        end

        local args1 = { [1] = "CharacterFollowSpawnPlayer", [2] = "BabyBoy" }
        success, err = pcall(function()
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Bab1yFollo1w"):FireServer(unpack(args1))
        end)
        if not success then
            warn("Error spawning child: " .. err)
        end
    end
})

ChildTab:AddToggle({
    Name = "Spectate Player",
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera

        if Value then
            if not chasingplayer then
                warn("No player selected to spectate!")
                return false
            end

            if not rawget(getgenv(), "CameraConnection") then
                getgenv().CameraConnection = RunService.Heartbeat:Connect(function()
                    local targetPlayer = Players:FindFirstChild(chasingplayer)
                    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                        Camera.CameraSubject = targetPlayer.Character.Humanoid
                    else
                        if rawget(getgenv(), "CameraConnection") then
                            getgenv().CameraConnection:Disconnect()
                            getgenv().CameraConnection = nil
                        end
                        Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
                    end
                end)
            end
        else
            if rawget(getgenv(), "CameraConnection") then
                getgenv().CameraConnection:Disconnect()
                getgenv().CameraConnection = nil
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = LocalPlayer.Character.Humanoid
            end
        end
    end
})

ChildTab:AddParagraph({
    Title = "FE",
    Content = "FE Features"
})

-- Local Player Tab
local LocalPlayerTab = Window:MakeTab({"Local Player", "user"})

local Section = LocalPlayerTab:AddSection({
    Name = "Speed, Gravity and Jump"
})

LocalPlayerTab:AddTextBox({
    Name = "Player Speed",
    PlaceholderText = "Enter speed",
    Callback = function(value)
        local speed = tonumber(value)
        if speed and pl.Character and pl.Character:FindFirstChild("Humanoid") then
            pl.Character.Humanoid.WalkSpeed = speed
        else
            warn("Invalid speed or character not found!")
        end
    end
})

LocalPlayerTab:AddButton({
    Name = "Reset Speed",
    Callback = function()
        if pl.Character and pl.Character:FindFirstChild("Humanoid") then
            pl.Character.Humanoid.WalkSpeed = 16
        end
    end
})

LocalPlayerTab:AddTextBox({
    Name = "Jump Height",
    PlaceholderText = "Enter jump height",
    Callback = function(value)
        local jumpHeight = tonumber(value)
        if jumpHeight and pl.Character and pl.Character:FindFirstChild("Humanoid") then
            pl.Character.Humanoid.JumpPower = jumpHeight
        else
            warn("Invalid jump height or character not found!")
        end
    end
})

LocalPlayerTab:AddButton({
    Name = "Reset Jump",
    Callback = function()
        if pl.Character and pl.Character:FindFirstChild("Humanoid") then
            pl.Character.Humanoid.JumpPower = 50
        end
    end
})

LocalPlayerTab:AddTextBox({
    Name = "Gravity",
    PlaceholderText = "Enter gravity",
    Callback = function(value)
        local gravity = tonumber(value)
        if gravity then
            workspace.Gravity = gravity
        else
            warn("Invalid gravity!")
        end
    end
})

LocalPlayerTab:AddButton({
    Name = "Reset Gravity",
    Callback = function()
        workspace.Gravity = 196.2
    end
})

Section = LocalPlayerTab:AddSection({
    Name = "Spam Chat"
})

local TextSave
local tcs = game:GetService("TextChatService")
local chat = tcs.ChatInputBarConfiguration and tcs.ChatInputBarConfiguration.TargetTextChannel

function sendchat(msg)
    if not msg or msg == "" then return end
    if tcs.ChatVersion == Enum.ChatVersion.LegacyChatService then
        local success, err = pcall(function()
            game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents").SayMessageRequest:FireServer(msg, "All")
        end)
        if not success then
            warn("Error sending chat: " .. err)
        end
    elseif chat then
        local success, err = pcall(function()
            chat:SendAsync(msg)
        end)
        if not success then
            warn("Error sending chat: " .. err)
        end
    end
end

LocalPlayerTab:AddTextBox({
    Name = "Enter text",
    PlaceholderText = "Enter message",
    Callback = function(text)
        TextSave = text
    end
})

LocalPlayerTab:AddButton({
    Name = "Send Chat",
    Callback = function()
        sendchat(TextSave)
    end
})

getgenv().ChaosHubEnviarDelay = 1

LocalPlayerTab:AddSlider({
    Name = "Spam Delay",
    Min = 0.4,
    Max = 10,
    Default = 1,
    Increment = 0.1,
    Callback = function(Value)
        getgenv().ChaosHubEnviarDelay = Value
    end
})

LocalPlayerTab:AddToggle({
    Name = "Spam Chat",
    Default = false,
    Flag = "Text Spawn",
    Callback = function(Value)
        getgenv().ChaosHubSpawnText = Value
        while getgenv().ChaosHubSpawnText do
            sendchat(TextSave)
            task.wait(getgenv().ChaosHubEnviarDelay)
        end
    end
})

LocalPlayerTab:AddButton({
    Name = "Spam chat Hacked By Mafia",
    Callback = function()
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then 
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rServer: Hacked by Mafia Hub")
        else 
            print("Nothing")
    end
end
})

LocalPlayerTab:AddButton({
    Name = "Clear Chat",
    Callback = function()
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then 
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rServer: Chat Cleared")
        else 
            print("Nothing")
    end
end
})

Section = LocalPlayerTab:AddSection({
    Name = "Headsit"
})

local selectedHeadSit = nil
local headSitConnection = nil

local headSitDropdown = LocalPlayerTab:AddDropdown({
    Name = "Select Player",
    Default = "",
    Options = players,
    Callback = function(Value)
        selectedHeadSit = Value
    end
})

LocalPlayerTab:AddToggle({
    Name = "Head Sit (Piggyback)",
    Default = false,
    Callback = function(bool)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")

        if not selectedHeadSit or selectedHeadSit == "" then
            warn("No player selected for Head Sit!")
            return false
        end

        local selectedPlayer = game.Players:FindFirstChild(selectedHeadSit)

        if bool then
            if selectedPlayer and selectedPlayer.Character then
                humanoid.Sit = true

                if headSitConnection then
                    headSitConnection:Disconnect()
                end

                headSitConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Head") and humanoid.Sit then
                        local targetHead = selectedPlayer.Character.Head
                        humanoidRootPart.CFrame = targetHead.CFrame * CFrame.Angles(0, 0, 0) * CFrame.new(0, 1.6, 0.4)
                    else
                        if headSitConnection then
                            headSitConnection:Disconnect()
                            headSitConnection = nil
                            humanhumanoid.Sit = false
                        end
                    end
                end)
            else
                warn("Selected player not found or no Character!")
                return false
            end
        else
            if headSitConnection then
                headSitConnection:Disconnect()
                headSitConnection = nil
            end
            humanoid.Sit = false
        end
    end
})

LocalPlayerTab:AddButton({
    Name = "Update table",
    Callback = function()
        local updatedPlayers = updatePlayerList()
        if headSitDropdown and updatedPlayers then
            pcall(function()
                headSitDropdown:Refresh(updatedPlayers)
            end)
            if selectedHeadSit and not game.Players:FindFirstChild(selectedHeadSit) then
                selectedHeadSit = nil
                pcall(function()
                    headSitDropdown:Set("")
                end)
            end
        end
    end
})

local Tab = Window:MakeTab({"Teleports", "tp"}) -- Icon name: 'portal' in lowercase for teleport

-- Teleport Buttons
local teleportButtons = {
    {"To Backstage", CFrame.new(192, 4, 272)},
    {"To Urban Center", CFrame.new(136, 4, 117)},
    {"To Crime Area", CFrame.new(-119, -28, 235)},
    {"To Desert House", CFrame.new(986, 4, 63)},
    {"To Agency Portal", CFrame.new(672, 4, -296)},
    {"To Hideout", CFrame.new(505, -75, 143)},
    {"To School", CFrame.new(-312, 4, 211)},
    {"To Brook Cafe", CFrame.new(161, 8, 52)},
    {"To Start Point", CFrame.new(-26, 4, -23)},
    {"To Main Arch", CFrame.new(-589, 141, -59)},
    {"To Hospital", CFrame.new(-309, 4, 71)},
    {"To Agency Base", CFrame.new(179, 4, -464)},
    {"To Workshop Hidden Room", CFrame.new(0, 4, -495)},
    {"To Secret Room 2", CFrame.new(-343, 4, -613)},
    {"To Isolated Island", CFrame.new(-1925, 23, 127)},
    {"To Hotels Plaza", CFrame.new(182, 4, 150)},
    {"Climb Mountain 1", CFrame.new(-670, 251, 765)},
    {"To Main Bank", CFrame.new(2.28, 4.65, 254.58)},
    {"To Clothing Store", CFrame.new(-46.15, 4.65, 253.20)},
    {"To Refuge", CFrame.new(-88.48, 22.05, 262.34)},
    {"To Dental Clinic", CFrame.new(-53.58, 22.15, 265.61)},
    {"To Cafeteria", CFrame.new(-97.12, 4.65, 254.99)}
}

for _, btn in ipairs(teleportButtons) do
    Tab:AddButton({
        btn[1],
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = btn[2]
        end
    })
end


local ToolsTab = Window:MakeTab({"Items", "backpack"})

-- Color Table
local colorsTable = {
    {Name = "Red", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "Orange", Color = Color3.fromRGB(255, 165, 0)},
    {Name = "Yellow", Color = Color3.fromRGB(255, 255, 0)},
    {Name = "Green", Color = Color3.fromRGB(0, 255, 0)},
    {Name = "Cyan", Color = Color3.fromRGB(0, 255, 255)},
    {Name = "Blue", Color = Color3.fromRGB(0, 0, 255)},
    {Name = "Purple", Color = Color3.fromRGB(128, 0, 128)},
    {Name = "Black", Color = Color3.fromRGB(0, 0, 0)}
}

-- Button to color the map
ToolsTab:AddButton({
    Name = "Color Map Floor [Very OP]",
    Callback = function()
      local toolselected = "PaintRoller"
local dupeamot = 100
local picktoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
local cleartoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
local duping = true
local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame


local TablaGripPos = {}
for i = 1, 100 do
    if i == 1 then
        table.insert(TablaGripPos, Vector3.new(0, 5, 0))
    else
        table.insert(TablaGripPos, Vector3.new((i - 1) * 1.2, 5, 0))
    end
end

local toolCount = 0
for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") and tool.Name == toolselected then
        toolCount = toolCount + 1
    end
end
for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if tool:IsA("Tool") and tool.Name == toolselected then
        toolCount = toolCount + 1
    end
end

if toolCount >= dupeamot then
    -- Unequip and move tools to defined positions
    for i, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == toolselected then
            tool.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == toolselected then
            tool.Parent = game.Players.LocalPlayer.Character
            local gripPosIndex = math.min(i, #TablaGripPos)
            local gripPos = TablaGripPos[gripPosIndex]
            tool.GripPos = gripPos
        end
    end
else

    local args = {
        [1] = "ClearAllTools"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))

    wait(0.2)

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Mafia Hub Dupe",
        Text = "Don't click anything while tools are being duped",
        Button1 = "Understood",
        Duration = 3
    })

    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        task.wait()
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end

    wait(0.1)

    if game:GetService("Workspace"):FindFirstChild("Camera") then
        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
    end

    for m = 1, 2 do
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
    end

    task.wait(0.2)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    wait(0.5)

    for aidj, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if not afh.Name == toolselected then
            if afh:IsA("Tool") then
                afh.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end

    for aiefhiewhwf, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if dvjbvj:IsA("Tool") then
            if not dvjbvj.Name == toolselected then
                dvjbvj:Destroy()
            end
        end
    end

    for ttjtjutjutjjtj, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
            if not ddvdvdsvdfbrnytytmvdv.name == toolselected then
                ddvdvdsvdfbrnytytmvdv:Destroy()
            end
        end
    end

    for findin, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if toollel:IsA("Tool") then
            if toollel.Name == toolselected then
                toollllfoun2 = true
                for basc, aijfw in pairs(toollel:GetDescendants()) do
                    if aijfw.Name == "Handle" then
                        aijfw.Name = "Hâ¥aâ¥nâ¥dâ¥lâ¥e"
                        toollel.Parent = game.Players.LocalPlayer.Backpack
                        toollel.Parent = game.Players.LocalPlayer.Character
                        tollllahhhh = toollel
                        task.wait()
                    end
                end
            else
                toollllfoun2 = false
            end
        end
    end

    for fiifi, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if toollll:IsA("Tool") then
            if toollll.Name == toolselected then
                toollllfoun = true
                for nana, jjsjsj in pairs(toollll:GetDescendants()) do
                    if jjsjsj.Name == "Handle" then
                        toollll.Parent = game.Players.LocalPlayer.Character
                        wait()
                        jjsjsj.Name = "Hâ¥aâ¥nâ¥dâ¥lâ¥e"
                        toollll.Parent = game.Players.LocalPlayer.Backpack
                        toollll.Parent = game.Players.LocalPlayer.Character
                        toolllffel = toollll
                    end
                end
            else
                toollllfoun = false
            end
        end
    end

    if toollllfoun == true then
        if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
            toollllfoun = false
        end
        repeat
            wait()
        until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
        toollllfoun = false
    end

    if toollllfoun2 == true then
        if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
            toollllfoun2 = false
        end
        repeat
            wait()
        until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
        toollllfoun2 = false
    end

    wait(0.1)

    for m = 1, dupeamot do
        if duping == false then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            return
        end
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        if m <= dupeamot then
        elseif m == dupeamot or m >= dupeamot - 1 then
        end
        local args = {
            [1] = "PickingTools",
            [2] = toolselected
        }
        picktoolremote:InvokeServer(unpack(args))
        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolselected).Parent = game.Players.LocalPlayer.Character
        if duping == false then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            return
        end
        wait()
        game:GetService("Players").LocalPlayer.Character[toolselected]:FindFirstChild("Handle").Name = "Hâ¥aâ¥nâ¥dâ¥lâ¥e"
        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselected).Parent = game.Players.LocalPlayer.Backpack
        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolselected).Parent = game.Players.LocalPlayer.Character
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Mafia Hub Tool",
            Text = "Tool Duped: " .. m .. " / " .. dupeamot,
            Duration = 1
        })
        repeat
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            task.wait()
        until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselected) == nil
    end

    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
    repeat
        wait()
    until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
    repeat
        wait()
    until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf

    for z, x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if x.Name == toolselected then
            toolamouth = z
        end
    end

    wait()
    duping = false
    wait(0.1)

    for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = game.Players.LocalPlayer.Character
            local gripPosIndex = math.min(i, #TablaGripPos)
            local gripPos = TablaGripPos[gripPosIndex]
            if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                tool.GripPos = gripPos
            else
                warn("", tool.Name, "")
            end
        end
    end

    wait(1)

    function EquipAll()

        local player = game:GetService("Players").LocalPlayer


        local function changeAnimation(tool)
            if tool:FindFirstChild("CycleNextAnimation") then
                tool.CycleNextAnimation:FireServer()
            end
        end


        for _, tool in ipairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "PaintRoller" then
                changeAnimation(tool)
            end
        end


        local character = player.Character or player.CharacterAdded:Wait()
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "PaintRoller" then
                changeAnimation(tool)
            end
        end

    end

    EquipAll()
    wait(1)
    EquipAll()
    wait(1)
    EquipAll()

    function startSpin()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")

        task.wait(1)

        local spinSpeed = math.rad(1750)

        RunService.RenderStepped:Connect(function(dt)
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, spinSpeed * dt, 0)
        end)

    end

    startSpin()
end
    end
})

ToolsTab:AddButton({
    Name = "Color Map Sky [Very OP]",
    Callback = function()
       local toolselected = "PaintRoller"
local dupeamot = 100
local picktoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
local cleartoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
local duping = true
local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame


local TablaGripPos = {}
for i = 1, 100 do
    if i == 1 then
        table.insert(TablaGripPos, Vector3.new(2, 50, -50))
    else
        table.insert(TablaGripPos, Vector3.new((i - 1) * 2, 50, -50))
    end
end

local toolCount = 0
for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") and tool.Name == toolselected then
        toolCount = toolCount + 1
    end
end
for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if tool:IsA("Tool") and tool.Name == toolselected then
        toolCount = toolCount + 1
    end
end

if toolCount >= dupeamot then
    -- Unequip and move tools to defined positions
    for i, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == toolselected then
            tool.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == toolselected then
            tool.Parent = game.Players.LocalPlayer.Character
            local gripPosIndex = math.min(i, #TablaGripPos)
            local gripPos = TablaGripPos[gripPosIndex]
            tool.GripPos = gripPos
        end
    end
else

    local args = {
        [1] = "ClearAllTools"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))

    wait(0.2)

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Mafia Hub Dupe",
        Text = "Don't click anything while tools are being duped",
        Button1 = "Understood",
        Duration = 3
    })

    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        task.wait()
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end

    wait(0.1)

    if game:GetService("Workspace"):FindFirstChild("Camera") then
        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
    end

    for m = 1, 2 do
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
    end

    task.wait(0.2)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    wait(0.5)

    for aidj, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if not afh.Name == toolselected then
            if afh:IsA("Tool") then
                afh.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end

    for aiefhiewhwf, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if dvjbvj:IsA("Tool") then
            if not dvjbvj.Name == toolselected then
                dvjbvj:Destroy()
            end
        end
    end

    for ttjtjutjutjjtj, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
            if not ddvdvdsvdfbrnytytmvdv.name == toolselected then
                ddvdvdsvdfbrnytytmvdv:Destroy()
            end
        end
    end

    for findin, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if toollel:IsA("Tool") then
            if toollel.Name == toolselected then
                toollllfoun2 = true
                for basc, aijfw in pairs(toollel:GetDescendants()) do
                    if aijfw.Name == "Handle" then
                        aijfw.Name = "Hâ¥aâ¥nâ¥dâ¥lâ¥e"
                        toollel.Parent = game.Players.LocalPlayer.Backpack
                        toollel.Parent = game.Players.LocalPlayer.Character
                        tollllahhhh = toollel
                        task.wait()
                    end
                end
            else
                toollllfoun2 = false
            end
        end
    end

    for fiifi, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if toollll:IsA("Tool") then
            if toollll.Name == toolselected then
                toollllfoun = true
                for nana, jjsjsj in pairs(toollll:GetDescendants()) do
                    if jjsjsj.Name == "Handle" then
                        toollll.Parent = game.Players.LocalPlayer.Character
                        wait()
                        jjsjsj.Name = "Hâ¥aâ¥nâ¥dâ¥lâ¥e"
                        toollll.Parent = game.Players.LocalPlayer.Backpack
                        toollll.Parent = game.Players.LocalPlayer.Character
                        toolllffel = toollll
                    end
                end
            else
                toollllfoun = false
            end
        end
    end

    if toollllfoun == true then
        if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
            toollllfoun = false
        end
        repeat
            wait()
        until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
        toollllfoun = false
    end

    if toollllfoun2 == true then
        if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
            toollllfoun2 = false
        end
        repeat
            wait()
        until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
        toollllfoun2 = false
    end

    wait(0.1)

    for m = 1, dupeamot do
        if duping == false then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            return
        end
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        if m <= dupeamot then
        elseif m == dupeamot or m >= dupeamot - 1 then
        end
        local args = {
            [1] = "PickingTools",
            [2] = toolselected
        }
        picktoolremote:InvokeServer(unpack(args))
        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolselected).Parent = game.Players.LocalPlayer.Character
        if duping == false then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            return
        end
        wait()
        game:GetService("Players").LocalPlayer.Character[toolselected]:FindFirstChild("Handle").Name = "Hâ¥aâ¥nâ¥dâ¥lâ¥e"
        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselected).Parent = game.Players.LocalPlayer.Backpack
        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolselected).Parent = game.Players.LocalPlayer.Character
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Mafia Hub Tool",
            Text = "Tool Duped: " .. m .. " / " .. dupeamot,
            Duration = 1
        })
        repeat
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            task.wait()
        until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselected) == nil
    end

    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
    repeat
        wait()
    until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
    repeat
        wait()
    until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf

    for z, x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if x.Name == toolselected then
            toolamouth = z
        end
    end

    wait()
    duping = false
    wait(0.1)

    for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = game.Players.LocalPlayer.Character
            local gripPosIndex = math.min(i, #TablaGripPos)
            local gripPos = TablaGripPos[gripPosIndex]
            if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                tool.GripPos = gripPos
            else
                warn("", tool.Name, "")
            end
        end
    end

    wait(1)

    function EquipAll()

        local player = game:GetService("Players").LocalPlayer


        local function changeAnimation(tool)
            if tool:FindFirstChild("CycleNextAnimation") then
                tool.CycleNextAnimation:FireServer()
            end
        end


        for _, tool in ipairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "PaintRoller" then
                changeAnimation(tool)
            end
        end


        local character = player.Character or player.CharacterAdded:Wait()
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "PaintRoller" then
                changeAnimation(tool)
            end
        end

    end

    EquipAll()
    wait(1)
    EquipAll()
    wait(1)
    EquipAll()

    function startSpin()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")

        task.wait(1)

        local spinSpeed = math.rad(1750)

        RunService.RenderStepped:Connect(function(dt)
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, spinSpeed * dt, 0)
        end)


    end

    startSpin() end
end
})
-- Variable to store the selected color
local selectedColor = colorsTable[1].Color

-- Function to apply the selected color
local function applySelectedColor()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local backpack = LocalPlayer.Backpack
    local character = LocalPlayer.Character
    local args = {selectedColor}

    local function changeToolColor(tool)
        if tool:IsA("Tool") and tool.Name == "PaintRoller" then
            local SetColor = tool:FindFirstChild("SetColor", true)
            if SetColor then
                SetColor:FireServer(unpack(args))
            end
        end
    end

    for _, tool in ipairs(backpack:GetChildren()) do
        changeToolColor(tool)
    end
    for _, tool in ipairs(character:GetChildren()) do
        changeToolColor(tool)
    end
end

-- Function to equip and unequip tools
local function equipAndUnequipTools(callback)
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local backpack = LocalPlayer.Backpack
    local character = LocalPlayer.Character

    local function unequipTools()
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "PaintRoller" then
                tool.Parent = backpack
            end
        end
    end

    local function equipTools()
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "PaintRoller" then
                tool.Parent = character
            end
        end
    end

    unequipTools()
    wait(0.7)
    if callback then callback() end
    wait(0.7)
    equipTools()
end

-- Dropdown to select the color
ToolsTab:AddDropdown({
    Name = "Select Color",
    Description = "Choose a color to apply",
    Options = (function()
        local colorNames = {}
        for _, color in ipairs(colorsTable) do
            table.insert(colorNames, color.Name)
        end
        return colorNames
    end)(),
    Default = colorsTable[1].Name,
    Callback = function(selected)
        for _, color in ipairs(colorsTable) do
            if color.Name == selected then
                selectedColor = color.Color
                equipAndUnequipTools(applySelectedColor)
                break
            end
        end
    end
})

-- Function to apply RGB cycle
local function applyRGBCycle()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local backpack = LocalPlayer.Backpack
    local character = LocalPlayer.Character
    local toolIndex = 0
    local totalColors = #colorsTable

    local function changeToolColor(tool, color)
        if tool:IsA("Tool") and tool.Name == "PaintRoller" then
            local SetColor = tool:FindFirstChild("SetColor", true)
            if SetColor then
                SetColor:FireServer(color)
            end
        end
    end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool.Name == "PaintRoller" then
            toolIndex = toolIndex + 1
            local color = colorsTable[(toolIndex - 1) % totalColors + 1].Color
            changeToolColor(tool, color)
        end
    end
    for _, tool in ipairs(character:GetChildren()) do
        if tool.Name == "PaintRoller" then
            toolIndex = toolIndex + 1
            local color = colorsTable[(toolIndex - 1) % totalColors + 1].Color
            changeToolColor(tool, color)
        end
    end
end

-- Button to apply color cycle
ToolsTab:AddButton({
    Name = "Colored",
    Callback = function()
        equipAndUnequipTools(applyRGBCycle)
    end
})

-- Color combinations
local colorCombinations = {}
for i, color1 in ipairs(colorsTable) do
    for j, color2 in ipairs(colorsTable) do
        if i ~= j then
            table.insert(colorCombinations, {Name = color1.Name .. " and " .. color2.Name, Colors = {color1.Color, color2.Color}})
        end
    end
end

-- Dropdown for color combinations
ToolsTab:AddDropdown({
    Name = "Select Color Combination",
    Description = "Choose a color combination",
    Options = (function()
        local combinationNames = {}
        for _, combination in ipairs(colorCombinations) do
            table.insert(combinationNames, combination.Name)
        end
        return combinationNames
    end)(),
    Default = colorCombinations[1].Name,
    Callback = function(selected)
        for _, combination in ipairs(colorCombinations) do
            if combination.Name == selected then
                local function applyDoubleColor()
                    local LocalPlayer = game:GetService("Players").LocalPlayer
                    local backpack = LocalPlayer.Backpack
                    local character = LocalPlayer.Character
                    local toolIndex = 0
                    local colors = combination.Colors

                    local function changeToolColor(tool, color)
                        if tool:IsA("Tool") and tool.Name == "PaintRoller" then
                            local SetColor = tool:FindFirstChild("SetColor", true)
                            if SetColor then
                                SetColor:FireServer(color)
                            end
                        end
                    end

                    for _, tool in ipairs(backpack:GetChildren()) do
                        if tool.Name == "PaintRoller" then
                            toolIndex = toolIndex + 1
                            local color = colors[(toolIndex - 1) % 2 + 1]
                            changeToolColor(tool, color)
                        end
                    end
                    for _, tool in ipairs(character:GetChildren()) do
                        if tool.Name == "PaintRoller" then
                            toolIndex = toolIndex + 1
                            local color = colors[(toolIndex - 1) % 2 + 1]
                            changeToolColor(tool, color)
                        end
                    end
                end
                equipAndUnequipTools(applyDoubleColor)
                break
            end
        end
    end
})

-- References to remotes
local cleartoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
local picktoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")

-- Item control section
local Section = ToolsTab:AddSection({
    Name = "Items Control"
})

-- Button to clear all tools
ToolsTab:AddButton({
    Name = "Clear All Tools",
    Callback = function()
        local args = {
            [1] = "ClearAllTools"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
    end
})

-- Section to equip items
Section = ToolsTab:AddSection({
    Name = "Equip Items"
})

-- Button to equip all items
ToolsTab:AddButton({
    Name = "Equip all items",
    Callback = function()
        for _, tool in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = game.Players.LocalPlayer.Character
            end
        end
    end
})

-- Section for N4zi Grip
Section = ToolsTab:AddSection({
    Name = "N4zi Grip"
})

-- Button for Giant Joust Blue N4zi
ToolsTab:AddButton({
    Name = "Giant Joust Blue N4zi",
    Callback = function()
       toolselcted = "JoustBlue"
        dupeamot = 175 --Put amount to dupe
        picktoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        cleartoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
                                duping = true
                                oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.", Button1 = "I understand" ,Duration=5})
                                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                                        task.wait()
                                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                end
                                wait(0.1)
                                if game:GetService("Workspace"):FindFirstChild("Camera") then
                                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                                        for m=1,2 do task.wait()
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
                                                end
                                                task.wait(0.2)
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                                wait(0.5)
                                for aidj,afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                        if afh.Name == toolselcted == false then
                                                if afh:IsA("Tool") then
                                                        afh.Parent = game.Players.LocalPlayer.Backpack
                                                end
                                        end
                                end
                                for aiefhiewhwf,dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                                        if dvjbvj:IsA("Tool") then
                                                if dvjbvj.Name == toolselcted == false then
                                                        dvjbvj:Destroy()
                                                end
                                        end
                                end
                                for ttjtjutjutjjtj,ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                        if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                                                if ddvdvdsvdfbrnytytmvdv.name == toolselcted == false then
                                                        ddvdvdsvdfbrnytytmvdv:Destroy()
                                                end
                                        end
                                end
                                for findin,toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                        if toollel:IsA("Tool") then
                                                if toollel.Name == toolselcted then
                                                        toollllfoun2 = true
                                                        for basc,aijfw in pairs(toollel:GetDescendants()) do
                                                                if aijfw.Name == "Handle" then
                                                                        aijfw.Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                                                                        toollel.Parent = game.Players.LocalPlayer.Backpack
                                                                toollel.Parent = game.Players.LocalPlayer.Character
                                                                tollllahhhh = toollel
                                                                task.wait()
                                                        end
                                                end
                                        else toollllfoun2 = false
                                        end
                                end
                        end
                                for fiifi,toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                                        if toollll:IsA("Tool") then
                                                if toollll.Name == toolselcted then
                                                        toollllfoun = true
                                                        for nana,jjsjsj in pairs(toollll:GetDescendants()) do
                                                                if jjsjsj.Name == "Handle" then
                                                                        toollll.Parent = game.Players.LocalPlayer.Character
                                                wait()
                                                jjsjsj.Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                                                toollll.Parent = game.Players.LocalPlayer.Backpack
                                                toollll.Parent = game.Players.LocalPlayer.Character
                                                toolllffel = toollll
                                                                end
                                                        end
                                                else toollllfoun = false
                                        end
                                end
                                end
                                if toollllfoun == true then
                                                                        if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then  toollllfoun = false end
                                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
                                toollllfoun = false
                                end
                                if toollllfoun2 == true then
                                        if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then toollllfoun2 = false end
                                        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
                                        toollllfoun2 = false
                                end
                                wait(1)
                                for m=1, dupeamot do
                                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                                        if game:GetService("Workspace"):FindFirstChild("Camera") then
                                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                                                if m <= dupeamot then
                elseif m == dupeamot or m >= dupeamot - 1 then
                end
                                        local args = {
                                                [1] = "PickingTools",
                                                [2] = toolselcted
                                        }

                                        picktoolremote:InvokeServer(unpack(args))
                                        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolselcted).Parent = game.Players.LocalPlayer.Character
                                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                                        wait()
                                        game:GetService("Players").LocalPlayer.Character[toolselcted]:FindFirstChild("Handle").Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Backpack
                                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Character
                                        repeat         if game:GetService("Workspace"):FindFirstChild("Camera") then
                                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                                                 task.wait() until
                                                 game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted) == nil
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
                                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
                                for z,x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                        if x.Name == toolselcted then
                                                toolamouth = z
                                        end
                                end
                                wait()
                                duping = false
   wait(1)


local TablaGripPos = {
                      Vector3.new(0, 3, 6),
                      Vector3.new(1, 3, 6),
                      Vector3.new(2, 3, 6),
                      Vector3.new(3, 3, 6),
                      Vector3.new(4, 3, 6),
                      Vector3.new(5, 3, 6),
                      Vector3.new(6, 3, 6),
                      Vector3.new(0, 3, 17),
                      Vector3.new(1, 3, 17),
                      Vector3.new(2, 3, 17),
                      Vector3.new(3, 3, 17),
                      Vector3.new(4, 3, 17),
                      Vector3.new(5, 3, 17),
                      Vector3.new(6, 3, 17),
                      Vector3.new(0, 3, 30),
                      Vector3.new(1, 3, 30),
                      Vector3.new(2, 3, 30),
                      Vector3.new(3, 3, 30),
                      Vector3.new(4, 3, 30),
                      Vector3.new(5, 3, 30),
                      Vector3.new(6, 3, 30),
                      Vector3.new(0, 3, 43),
                      Vector3.new(1, 3, 43),
                      Vector3.new(2, 3, 43),
                      Vector3.new(3, 3, 43),
                      Vector3.new(4, 3, 43),
                      Vector3.new(5, 3, 43),
                      Vector3.new(6, 3, 43),
                      Vector3.new(0, 3, 55),
                      Vector3.new(1, 3, 55),
                      Vector3.new(2, 3, 55),
                      Vector3.new(3, 3, 55),
                      Vector3.new(4, 3, 55),
                      Vector3.new(5, 3, 55),
                      Vector3.new(6, 3, 55),
                      Vector3.new(-1 , 3, 6),
                      Vector3.new(-2 , 3, 6),
                      Vector3.new(-3 , 3, 6),
                      Vector3.new(-4 , 3, 6),
                      Vector3.new(-5 , 3, 6),
                      Vector3.new(-6 , 3, 6),
                      Vector3.new(-7 , 3, 6),
                      Vector3.new(-8 , 3, 6),
                      Vector3.new(-9 , 3, 6),
                      Vector3.new(-10 , 3, 6),
                      Vector3.new(-11 , 3, 6),
                      Vector3.new(-12 , 3, 6),
                      Vector3.new(-13 , 3, 6),
                      Vector3.new(-14 , 3, 6),
                      Vector3.new(-15 , 3, 6),
                      Vector3.new(-16 , 3, 6),
                      Vector3.new(-17 , 3, 6),
                      Vector3.new(-18 , 3, 6),
                      Vector3.new(-19 , 3, 6),
                      Vector3.new(-20 , 3, 6),
                      Vector3.new(-21 , 3, 6),
                      Vector3.new(1 , 3, 55),
                      Vector3.new(2 , 3, 55),
                      Vector3.new(3 , 3, 55),
                      Vector3.new(4 , 3, 55),
                      Vector3.new(5 , 3, 55),
                      Vector3.new(6 , 3, 55),
                      Vector3.new(7 , 3, 55),
                      Vector3.new(8 , 3, 55),
                      Vector3.new(9 , 3, 55),
                      Vector3.new(10 , 3, 55),
                      Vector3.new(11 , 3, 55),
                      Vector3.new(12 , 3, 55),
                      Vector3.new(13 , 3, 55),
                      Vector3.new(14 , 3, 55),
                      Vector3.new(15 , 3, 55),
                      Vector3.new(16 , 3, 55),
                      Vector3.new(17 , 3, 55),
                      Vector3.new(18 , 3, 55),
                      Vector3.new(19 , 3, 55),
                      Vector3.new(20 , 3, 55),
                      Vector3.new(21 , 3, 55),
                      Vector3.new(22 , 3, 55),
                      Vector3.new(-16, 3, 43),
                                   Vector3.new(-17, 3, 43),
                      Vector3.new(-18, 3, 43),
                      Vector3.new(-19, 3, 43),
                      Vector3.new(-20, 3, 43),
                      Vector3.new(-21, 3, 43),
                      Vector3.new(-16, 3, 43),
                      Vector3.new(-15, 3, 43),
                      Vector3.new(-16, 3, 43),
                                                Vector3.new(-17, 3, 55),
                      Vector3.new(-18, 3, 55),
                      Vector3.new(-19, 3, 55),
                      Vector3.new(-20, 3, 55),
                      Vector3.new(-21, 3, 55),
                      Vector3.new(-16, 3, 55),
                      Vector3.new(-15, 3, 55),
                      Vector3.new(0, 3, 55),
                      Vector3.new(1, 3, 55),
                      Vector3.new(2, 3, 55),
                      Vector3.new(3, 3, 55),
                      Vector3.new(4, 3, 55),
                      Vector3.new(5, 3, 55),
                      Vector3.new(6, 3, 55),
         Vector3.new(23 , 3, 55),
         Vector3.new(24 , 3, 55),
          Vector3.new(25 , 3, 55),
           Vector3.new(26 , 3, 55),
            Vector3.new(27 , 3, 55),
                         Vector3.new(-1 , 3, 30),
                      Vector3.new(-2 , 3, 30),
                      Vector3.new(-3 , 3, 30),
                      Vector3.new(-4 , 3, 30),
                      Vector3.new(-5 , 3, 30),
                      Vector3.new(-6 , 3, 30),
                      Vector3.new(-7 , 3, 30),
                      Vector3.new(-8 , 3, 30),
                      Vector3.new(-9 , 3, 30),
                      Vector3.new(-10 , 3, 30),
                      Vector3.new(-11 , 3, 30),
                      Vector3.new(-12 , 3, 30),
                      Vector3.new(-13 , 3, 30),
                      Vector3.new(-14 , 3, 30),
                      Vector3.new(-15 , 3, 30),
                      Vector3.new(-16 , 3, 30),
                      Vector3.new(-17 , 3, 30),
                      Vector3.new(-18 , 3, 30),
                      Vector3.new(-19 , 3, 30),
                      Vector3.new(-20 , 3, 30),
                      Vector3.new(-21 , 3, 30),
                          Vector3.new(1 , 3, 30),
                      Vector3.new(2 , 3, 30),
                      Vector3.new(3 , 3, 30),
                      Vector3.new(4 , 3, 30),
                      Vector3.new(5 , 3, 30),
                      Vector3.new(6 , 3, 30),
                      Vector3.new(7 , 3, 30),
                      Vector3.new(8 , 3, 30),
                      Vector3.new(9 , 3, 30),
                      Vector3.new(10 , 3, 30),
                      Vector3.new(11 , 3, 30),
                      Vector3.new(12 , 3, 30),
                      Vector3.new(13 , 3, 30),
                      Vector3.new(14 , 3, 30),
                      Vector3.new(15 , 3, 30),
                      Vector3.new(16 , 3, 30),
                      Vector3.new(17 , 3, 30),
                      Vector3.new(18 , 3, 30),
                      Vector3.new(19 , 3, 30),
                      Vector3.new(20 , 3, 30),
                      Vector3.new(21 , 3, 30),
                      Vector3.new(22 , 3, 30),
                      Vector3.new(23 , 3, 30),
                      Vector3.new(24 , 3, 30),
                      Vector3.new(25 , 3, 30),
                      Vector3.new(26 , 3, 30),
                      Vector3.new(27 , 3, 30),
                      Vector3.new(28 , 3, 30),
                      Vector3.new(28, 3, 6),
                      Vector3.new(27, 3, 6),
                      Vector3.new(26, 3, 6),
                      Vector3.new(25, 3, 6),
                      Vector3.new(24, 3, 6),
                      Vector3.new(23, 3, 6),
                      Vector3.new(22, 3, 6),
                      Vector3.new(21, 3, 6),
                      Vector3.new(21, 3, 17),
                      Vector3.new(22, 3, 17),
                      Vector3.new(23, 3, 17),
                      Vector3.new(24, 3, 17),
                      Vector3.new(25, 3, 17),
                      Vector3.new(26, 3, 17),
                      Vector3.new(27, 3, 17),
                      Vector3.new(28, 3, 17),
                         }
                          for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                              if tool:IsA("Tool") then
                                  -- Transfer tool to player character
                                  tool.Parent = game.Players.LocalPlayer.Character

                                  -- Set grip position index
                                  local gripPosIndex = math.min(i, #TablaGripPos)
                                  local gripPos = TablaGripPos[gripPosIndex]

                                  -- Set GripPos if the tool is in the player's character
                                  if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                                      tool.GripPos = gripPos
                                  else
                                      warn("", tool.Name, "")
                                  end
                              end
                          end
    end
})

-- Button for Giant Joust Red N4zi
ToolsTab:AddButton({
    Name = "Giant Joust Red N4zi",
    Callback = function()
        toolselcted = "JoustRed"
        dupeamot = 175 --Put amount to dupe
        picktoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        cleartoolremote = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
                                duping = true
                                oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.", Button1 = "I understand" ,Duration=5})
                                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                                        task.wait()
                                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                end
                                wait(0.1)
                                if game:GetService("Workspace"):FindFirstChild("Camera") then
                                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                                        for m=1,2 do task.wait()
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
                                                end
                                                task.wait(0.2)
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                                wait(0.5)
                                for aidj,afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                        if afh.Name == toolselcted == false then
                                                if afh:IsA("Tool") then
                                                        afh.Parent = game.Players.LocalPlayer.Backpack
                                                end
                                        end
                                end
                                for aiefhiewhwf,dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                                        if dvjbvj:IsA("Tool") then
                                                if dvjbvj.Name == toolselcted == false then
                                                        dvjbvj:Destroy()
                                                end
                                        end
                                end
                                for ttjtjutjutjjtj,ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                        if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                                                if ddvdvdsvdfbrnytytmvdv.name == toolselcted == false then
                                                        ddvdvdsvdfbrnytytmvdv:Destroy()
                                                end
                                        end
                                end
                                for findin,toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                        if toollel:IsA("Tool") then
                                                if toollel.Name == toolselcted then
                                                        toollllfoun2 = true
                                                        for basc,aijfw in pairs(toollel:GetDescendants()) do
                                                                if aijfw.Name == "Handle" then
                                                                        aijfw.Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                                                                        toollel.Parent = game.Players.LocalPlayer.Backpack
                                                                toollel.Parent = game.Players.LocalPlayer.Character
                                                                tollllahhhh = toollel
                                                                task.wait()
                                                        end
                                                end
                                        else toollllfoun2 = false
                                        end
                                end
                        end
                                for fiifi,toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                                        if toollll:IsA("Tool") then
                                                if toollll.Name == toolselcted then
                                                        toollllfoun = true
                                                        for nana,jjsjsj in pairs(toollll:GetDescendants()) do
                                                                if jjsjsj.Name == "Handle" then
                                                                        toollll.Parent = game.Players.LocalPlayer.Character
                                                wait()
                                                jjsjsj.Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                                                toollll.Parent = game.Players.LocalPlayer.Backpack
                                                toollll.Parent = game.Players.LocalPlayer.Character
                                                toolllffel = toollll
                                                                end
                                                        end
                                                else toollllfoun = false
                                        end
                                end
                                end
                                if toollllfoun == true then
                                                                        if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then  toollllfoun = false end
                                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
                                toollllfoun = false
                                end
                                if toollllfoun2 == true then
                                        if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then toollllfoun2 = false end
                                        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
                                        toollllfoun2 = false
                                end
                                wait(1)
                                for m=1, dupeamot do
                                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                                        if game:GetService("Workspace"):FindFirstChild("Camera") then
                                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                                                if m <= dupeamot then
                elseif m == dupeamot or m >= dupeamot - 1 then
                end
                                        local args = {
                                                [1] = "PickingTools",
                                                [2] = toolselcted
                                        }

                                        picktoolremote:InvokeServer(unpack(args))
                                        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolselcted).Parent = game.Players.LocalPlayer.Character
                                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                                        wait()
                                        game:GetService("Players").LocalPlayer.Character[toolselcted]:FindFirstChild("Handle").Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Backpack
                                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolselcted).Parent = game.Players.LocalPlayer.Character
                                        repeat         if game:GetService("Workspace"):FindFirstChild("Camera") then
                                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                                                 task.wait() until
                                                 game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolselcted) == nil
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
                                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
                                for z,x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                        if x.Name == toolselcted then
                                                toolamouth = z
                                        end
                                end
                                wait()
                                duping = false
   wait(1)


local TablaGripPos = {
                      Vector3.new(0, 3, 6),
                      Vector3.new(1, 3, 6),
                      Vector3.new(2, 3, 6),
                      Vector3.new(3, 3, 6),
                      Vector3.new(4, 3, 6),
                      Vector3.new(5, 3, 6),
                      Vector3.new(6, 3, 6),
                      Vector3.new(0, 3, 17),
                      Vector3.new(1, 3, 17),
                      Vector3.new(2, 3, 17),
                      Vector3.new(3, 3, 17),
                      Vector3.new(4, 3, 17),
                      Vector3.new(5, 3, 17),
                      Vector3.new(6, 3, 17),
                      Vector3.new(0, 3, 30),
                      Vector3.new(1, 3, 30),
                      Vector3.new(2, 3, 30),
                      Vector3.new(3, 3, 30),
                      Vector3.new(4, 3, 30),
                      Vector3.new(5, 3, 30),
                      Vector3.new(6, 3, 30),
                      Vector3.new(0, 3, 43),
                      Vector3.new(1, 3, 43),
                      Vector3.new(2, 3, 43),
                      Vector3.new(3, 3, 43),
                      Vector3.new(4, 3, 43),
                      Vector3.new(5, 3, 43),
                      Vector3.new(6, 3, 43),
                      Vector3.new(0, 3, 55),
                      Vector3.new(1, 3, 55),
                      Vector3.new(2, 3, 55),
                      Vector3.new(3, 3, 55),
                      Vector3.new(4, 3, 55),
                      Vector3.new(5, 3, 55),
                      Vector3.new(6, 3, 55),
                      Vector3.new(-1 , 3, 6),
                      Vector3.new(-2 , 3, 6),
                      Vector3.new(-3 , 3, 6),
                      Vector3.new(-4 , 3, 6),
                      Vector3.new(-5 , 3, 6),
                      Vector3.new(-6 , 3, 6),
                      Vector3.new(-7 , 3, 6),
                      Vector3.new(-8 , 3, 6),
                      Vector3.new(-9 , 3, 6),
                      Vector3.new(-10 , 3, 6),
                      Vector3.new(-11 , 3, 6),
                      Vector3.new(-12 , 3, 6),
                      Vector3.new(-13 , 3, 6),
                      Vector3.new(-14 , 3, 6),
                      Vector3.new(-15 , 3, 6),
                      Vector3.new(-16 , 3, 6),
                      Vector3.new(-17 , 3, 6),
                      Vector3.new(-18 , 3, 6),
                      Vector3.new(-19 , 3, 6),
                      Vector3.new(-20 , 3, 6),
                      Vector3.new(-21 , 3, 6),
                      Vector3.new(1 , 3, 55),
                      Vector3.new(2 , 3, 55),
                      Vector3.new(3 , 3, 55),
                      Vector3.new(4 , 3, 55),
                      Vector3.new(5 , 3, 55),
                      Vector3.new(6 , 3, 55),
                      Vector3.new(7 , 3, 55),
                      Vector3.new(8 , 3, 55),
                      Vector3.new(9 , 3, 55),
                      Vector3.new(10 , 3, 55),
                      Vector3.new(11 , 3, 55),
                      Vector3.new(12 , 3, 55),
                      Vector3.new(13 , 3, 55),
                      Vector3.new(14 , 3, 55),
                      Vector3.new(15 , 3, 55),
                      Vector3.new(16 , 3, 55),
                      Vector3.new(17 , 3, 55),
                      Vector3.new(18 , 3, 55),
                      Vector3.new(19 , 3, 55),
                      Vector3.new(20 , 3, 55),
                      Vector3.new(21 , 3, 55),
                      Vector3.new(22 , 3, 55),
                      Vector3.new(-16, 3, 43),
                                   Vector3.new(-17, 3, 43),
                      Vector3.new(-18, 3, 43),
                      Vector3.new(-19, 3, 43),
                      Vector3.new(-20, 3, 43),
                      Vector3.new(-21, 3, 43),
                      Vector3.new(-16, 3, 43),
                      Vector3.new(-15, 3, 43),
                      Vector3.new(-16, 3, 43),
                                                Vector3.new(-17, 3, 55),
                      Vector3.new(-18, 3, 55),
                      Vector3.new(-19, 3, 55),
                      Vector3.new(-20, 3, 55),
                      Vector3.new(-21, 3, 55),
                      Vector3.new(-16, 3, 55),
                      Vector3.new(-15, 3, 55),
                      Vector3.new(0, 3, 55),
                      Vector3.new(1, 3, 55),
                      Vector3.new(2, 3, 55),
                      Vector3.new(3, 3, 55),
                      Vector3.new(4, 3, 55),
                      Vector3.new(5, 3, 55),
                      Vector3.new(6, 3, 55),
         Vector3.new(23 , 3, 55),
         Vector3.new(24 , 3, 55),
          Vector3.new(25 , 3, 55),
           Vector3.new(26 , 3, 55),
            Vector3.new(27 , 3, 55),
                         Vector3.new(-1 , 3, 30),
                      Vector3.new(-2 , 3, 30),
                      Vector3.new(-3 , 3, 30),
                      Vector3.new(-4 , 3, 30),
                      Vector3.new(-5 , 3, 30),
                      Vector3.new(-6 , 3, 30),
                      Vector3.new(-7 , 3, 30),
                      Vector3.new(-8 , 3, 30),
                      Vector3.new(-9 , 3, 30),
                      Vector3.new(-10 , 3, 30),
                      Vector3.new(-11 , 3, 30),
                      Vector3.new(-12 , 3, 30),
                      Vector3.new(-13 , 3, 30),
                      Vector3.new(-14 , 3, 30),
                      Vector3.new(-15 , 3, 30),
                      Vector3.new(-16 , 3, 30),
                      Vector3.new(-17 , 3, 30),
                      Vector3.new(-18 , 3, 30),
                      Vector3.new(-19 , 3, 30),
                      Vector3.new(-20 , 3, 30),
                      Vector3.new(-21 , 3, 30),
                          Vector3.new(1 , 3, 30),
                      Vector3.new(2 , 3, 30),
                      Vector3.new(3 , 3, 30),
                      Vector3.new(4 , 3, 30),
                      Vector3.new(5 , 3, 30),
                      Vector3.new(6 , 3, 30),
                      Vector3.new(7 , 3, 30),
                      Vector3.new(8 , 3, 30),
                      Vector3.new(9 , 3, 30),
                      Vector3.new(10 , 3, 30),
                      Vector3.new(11 , 3, 30),
                      Vector3.new(12 , 3, 30),
                      Vector3.new(13 , 3, 30),
                      Vector3.new(14 , 3, 30),
                      Vector3.new(15 , 3, 30),
                      Vector3.new(16 , 3, 30),
                      Vector3.new(17 , 3, 30),
                      Vector3.new(18 , 3, 30),
                      Vector3.new(19 , 3, 30),
                      Vector3.new(20 , 3, 30),
                      Vector3.new(21 , 3, 30),
                      Vector3.new(22 , 3, 30),
                      Vector3.new(23 , 3, 30),
                      Vector3.new(24 , 3, 30),
                      Vector3.new(25 , 3, 30),
                      Vector3.new(26 , 3, 30),
                      Vector3.new(27 , 3, 30),
                      Vector3.new(28 , 3, 30),
                      Vector3.new(28, 3, 6),
                      Vector3.new(27, 3, 6),
                      Vector3.new(26, 3, 6),
                      Vector3.new(25, 3, 6),
                      Vector3.new(24, 3, 6),
                      Vector3.new(23, 3, 6),
                      Vector3.new(22, 3, 6),
                      Vector3.new(21, 3, 6),
                      Vector3.new(21, 3, 17),
                      Vector3.new(22, 3, 17),
                      Vector3.new(23, 3, 17),
                      Vector3.new(24, 3, 17),
                      Vector3.new(25, 3, 17),
                      Vector3.new(26, 3, 17),
                      Vector3.new(27, 3, 17),
                      Vector3.new(28, 3, 17),
                         }
                          for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                              if tool:IsA("Tool") then
                                  -- Transfer tool to player character
                                  tool.Parent = game.Players.LocalPlayer.Character

                                  -- Set grip position index
                                  local gripPosIndex = math.min(i, #TablaGripPos)
                                  local gripPos = TablaGripPos[gripPosIndex]

                                  -- Set GripPos if the tool is in the player's character
                                  if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                                      tool.GripPos = gripPos
                                  else
                                      warn("", tool.Name, "")
                                  end
                              end
                          end
    end
})

-- Button for Fire N4zi
ToolsTab:AddButton({
    Name = "Fire N4zi",
    Callback = function()
        local nametools = "crystal nazi lel"
        local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.",
            Button1 = "I understand",
            Duration = 5
        })
        local toolthatiwanttodupe = "PaperbagFire"
        local tools = "PaperbagFire"
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        wait(0.1)
        local args = {
            [1] = "ClearAllTools"
        }
        cleartoolremote:FireServer(unpack(args))
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        local duping = true
        for m = 1, 57 do
            if duping == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = {
                [1] = "PickingTools",
                [2] = toolthatiwanttodupe
            }
            picktoolremote:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
            if duping == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "Hândlê"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local toolgrip = true
        duping = false
        wait()
        local gripBase = CFrame.new(-0.290086746, 0.0755810738, -0.0109872818, 0.0439560413, 0.509705901, -0.859225094, -0.0591450632, -0.857220173, -0.511542261, -0.997281134, 0.0733042806, -0.00753343105)
        local gripPositions = {
            Vector3.new(0, 0, 0), Vector3.new(0, 0.5, 0), Vector3.new(0, 1, 0), Vector3.new(0, 1.5, 0),
            Vector3.new(0, 2, 0), Vector3.new(0, 2.5, 0), Vector3.new(0, 3, 0), Vector3.new(0, 3.5, 0),
            Vector3.new(0, 4, 0), Vector3.new(0, 4.5, 0), Vector3.new(0, 5, 0), Vector3.new(0, 5, -1),
            Vector3.new(0, 5, -2), Vector3.new(0, 5, -3), Vector3.new(0, 5, -4), Vector3.new(0, 5, -5),
            Vector3.new(0, 5, -6), Vector3.new(0, 5, -7), Vector3.new(0, 5, -8), Vector3.new(0, 5, -9),
            Vector3.new(0, 5, -10), Vector3.new(0, 5.5, -10), Vector3.new(0, 6, -10), Vector3.new(0, 6.5, -10),
            Vector3.new(0, 7, -10), Vector3.new(0, 7.5, -10), Vector3.new(0, 8, -10), Vector3.new(0, 8.5, -10),
            Vector3.new(0, 9, -10), Vector3.new(0, 9.5, -10), Vector3.new(0, 10, -10), Vector3.new(0, 10, -5),
            Vector3.new(0, 10, -4.5), Vector3.new(0, 10, -4), Vector3.new(0, 10, -3.5), Vector3.new(0, 10, -3),
            Vector3.new(0, 10, -2.5), Vector3.new(0, 10, -2), Vector3.new(0, 10, -1.5), Vector3.new(0, 10, -1),
            Vector3.new(0, 10, -0.5), Vector3.new(0, 10, 0), Vector3.new(0, 9, -5), Vector3.new(0, 8, -5),
            Vector3.new(0, 7, -5), Vector3.new(0, 6, -5), Vector3.new(0, 5, -5), Vector3.new(0, 4, -5),
            Vector3.new(0, 3, -5), Vector3.new(0, 2, -5), Vector3.new(0, 1, -5), Vector3.new(0, 0, -5),
            Vector3.new(0, 0, -10), Vector3.new(0, 0, -9), Vector3.new(0, 0, -8), Vector3.new(0, 0, -7),
            Vector3.new(0, 0, -6)
        }
        for _, pos in ipairs(gripPositions) do
            game.Players.LocalPlayer.Backpack[tools].Grip = gripBase + pos
            game.Players.LocalPlayer.Backpack[tools].Name = nametools
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcframe
        wait(0.5)
        for _, tool in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == nametools then
                tool.Parent = game:GetService("Players").LocalPlayer.Character
            end
        end
    end
})

-- Button for Crystal N4zi
ToolsTab:AddButton({
    Name = "Crystal N4zi",
    Callback = function()
        local nametools = "crystal nazi lel"
        local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.",
            Button1 = "I understand",
            Duration = 5
        })
        local toolthatiwanttodupe = "Crystal"
        local tools = "Crystal"
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        wait(0.1)
        local args = {
            [1] = "ClearAllTools"
        }
        cleartoolremote:FireServer(unpack(args))
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        local duping = true
        for m = 1, 57 do
            if duping == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = {
                [1] = "PickingTools",
                [2] = toolthatiwanttodupe
            }
            picktoolremote:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
            if duping == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "Hândlê"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local toolgrip = true
        duping = false
        wait()
        local gripBase = CFrame.new(-0.290086746, 0.0755810738, -0.0109872818, 0.0439560413, 0.509705901, -0.859225094, -0.0591450632, -0.857220173, -0.511542261, -0.997281134, 0.0733042806, -0.00753343105)
        local gripPositions = {
            Vector3.new(0, 0, 0), Vector3.new(0, 0.5, 0), Vector3.new(0, 1, 0), Vector3.new(0, 1.5, 0),
            Vector3.new(0, 2, 0), Vector3.new(0, 2.5, 0), Vector3.new(0, 3, 0), Vector3.new(0, 3.5, 0),
            Vector3.new(0, 4, 0), Vector3.new(0, 4.5, 0), Vector3.new(0, 5, 0), Vector3.new(0, 5, -1),
            Vector3.new(0, 5, -2), Vector3.new(0, 5, -3), Vector3.new(0, 5, -4), Vector3.new(0, 5, -5),
            Vector3.new(0, 5, -6), Vector3.new(0, 5, -7), Vector3.new(0, 5, -8), Vector3.new(0, 5, -9),
            Vector3.new(0, 5, -10), Vector3.new(0, 5.5, -10), Vector3.new(0, 6, -10), Vector3.new(0, 6.5, -10),
            Vector3.new(0, 7, -10), Vector3.new(0, 7.5, -10), Vector3.new(0, 8, -10), Vector3.new(0, 8.5, -10),
            Vector3.new(0, 9, -10), Vector3.new(0, 9.5, -10), Vector3.new(0, 10, -10), Vector3.new(0, 10, -5),
            Vector3.new(0, 10, -4.5), Vector3.new(0, 10, -4), Vector3.new(0, 10, -3.5), Vector3.new(0, 10, -3),
            Vector3.new(0, 10, -2.5), Vector3.new(0, 10, -2), Vector3.new(0, 10, -1.5), Vector3.new(0, 10, -1),
            Vector3.new(0, 10, -0.5), Vector3.new(0, 10, 0), Vector3.new(0, 9, -5), Vector3.new(0, 8, -5),
            Vector3.new(0, 7, -5), Vector3.new(0, 6, -5), Vector3.new(0, 5, -5), Vector3.new(0, 4, -5),
            Vector3.new(0, 3, -5), Vector3.new(0, 2, -5), Vector3.new(0, 1, -5), Vector3.new(0, 0, -5),
            Vector3.new(0, 0, -10), Vector3.new(0, 0, -9), Vector3.new(0, 0, -8), Vector3.new(0, 0, -7),
            Vector3.new(0, 0, -6)
        }
        for _, pos in ipairs(gripPositions) do
            game.Players.LocalPlayer.Backpack[tools].Grip = gripBase + pos
            game.Players.LocalPlayer.Backpack[tools].Name = nametools
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcframe
        wait(0.5)
        for _, tool in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == nametools then
                tool.Parent = game:GetService("Players").LocalPlayer.Character
            end
        end
    end
})

-- Button for FireX N4zi
ToolsTab:AddButton({
    Name = "FireX N4zi",
    Callback = function()
        local nametools = "nazi firex lel"
        local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Dupe Script",
            Text = "Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.",
            Button1 = "I understand",
            Duration = 5
        })
        local toolthatiwanttodupe = "FireX"
        local tools = "FireX"
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        wait(0.1)
        local args = {
            [1] = "ClearAllTools"
        }
        cleartoolremote:FireServer(unpack(args))
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        local duping = true
        for m = 1, 71 do
            if duping == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = {
                [1] = "PickingTools",
                [2] = toolthatiwanttodupe
            }
            picktoolremote:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
            if duping == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "Hândlê"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local toolgrip = true
        duping = false
        wait()
        local gripBase = CFrame.new(0.0538333468, -0.264812469, -0.0177594293, 0.999998629, 0, 0.00164011808, 0, 1, 0, -0.00164011808, 0, 0.999998629)
        local gripPositions = {
            Vector3.new(0, -2, 0), Vector3.new(0, -4, 0), Vector3.new(0, -6, 0), Vector3.new(0, -8, 0),
            Vector3.new(0, -10, 0), Vector3.new(0, -12, 0), Vector3.new(0, -14, 0), Vector3.new(1, -14, 0),
            Vector3.new(2, -14, 0), Vector3.new(3, -14, 0), Vector3.new(4, -14, 0), Vector3.new(5, -14, 0),
            Vector3.new(6, -14, 0), Vector3.new(7, -14, 0), Vector3.new(8, -14, 0), Vector3.new(9, -14, 0),
            Vector3.new(10, -14, 0), Vector3.new(11, -14, 0), Vector3.new(12, -14, 0), Vector3.new(13, -14, 0),
            Vector3.new(14, -14, 0), Vector3.new(15, -14, 0), Vector3.new(16, -14, 0), Vector3.new(17, -14, 0),
            Vector3.new(18, -14, 0), Vector3.new(19, -14, 0), Vector3.new(20, -14, 0), Vector3.new(20, -16, 0),
            Vector3.new(20, -18, 0), Vector3.new(20, -20, 0), Vector3.new(20, -22, 0), Vector3.new(20, -24, 0),
            Vector3.new(20, -26, 0), Vector3.new(20, -28, 0), Vector3.new(20, -30, 0), Vector3.new(10, -30, 0),
            Vector3.new(10, -28, 0), Vector3.new(10, -26, 0), Vector3.new(10, -24, 0), Vector3.new(10, -22, 0),
            Vector3.new(10, -20, 0), Vector3.new(10, -18, 0), Vector3.new(10, -16, 0), Vector3.new(10, -14, 0),
            Vector3.new(10, -12, 0), Vector3.new(10, -10, 0), Vector3.new(10, -8, 0), Vector3.new(10, -6, 0),
            Vector3.new(10, -4, 0), Vector3.new(10, -2, 0), Vector3.new(11, -2, 0), Vector3.new(12, -2, 0),
            Vector3.new(13, -2, 0), Vector3.new(14, -2, 0), Vector3.new(15, -2, 0), Vector3.new(16, -2, 0),
            Vector3.new(17, -2, 0), Vector3.new(18, -2, 0), Vector3.new(19, -2, 0), Vector3.new(20, -2, 0),
            Vector3.new(1, -30, 0), Vector3.new(0, -30, 0), Vector3.new(2, -30, 0), Vector3.new(3, -30, 0),
            Vector3.new(4, -30, 0), Vector3.new(5, -30, 0), Vector3.new(6, -30, 0), Vector3.new(7, -30, 0),
            Vector3.new(8, -30, 0), Vector3.new(9, -30, 0)
        }
        for _, pos in ipairs(gripPositions) do
            game.Players.LocalPlayer.Backpack[tools].Grip = gripBase + pos
            game.Players.LocalPlayer.Backpack[tools].Name = nametools
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcframe
        wait(0.5)
        for _, tool in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == nametools then
                tool.Parent = game:GetService("Players").LocalPlayer.Character
            end
        end
    end
})

-- Section for Aura Grip
Section = ToolsTab:AddSection({
    Name = "Aura Grip"
})

-- Button for Couch Aura
ToolsTab:AddButton({
    Name = "Couch Aura",
    Callback = function()
    nametools = "Couch Spray lel"
                oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.", Button1 = "I understand" ,Duration=5})
                toolthatiwanttodupe = "Couch"
                tools = "Couch"
                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                        task.wait()
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                wait(0.1)
                local args = {
                        [1] = "ClearAllTools"
                }

                cleartoolremote:FireServer(unpack(args))
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                for m=1,2 do task.wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
                        end
                        task.wait(0.2)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                wait(0.3)
                duping = true
                for m=1, 124 do
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                        local args = {
                                [1] = "PickingTools",
                                [2] = toolthatiwanttodupe
                        }

                        picktoolremote:InvokeServer(unpack(args))
                        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        wait()
                        game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "HÃ¢Â Â¥aÃ¢Â Â¥nÃ¢Â Â¥dÃ¢Â Â¥lÃ¢Â Â¥e"
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        repeat                 if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
                end
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                toolgrip = true
                duping = false
                wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")


print("done")
wait(1)
local TablaGripPos = {
       Vector3.new(0, 0, 0),
  Vector3.new(10, 0, 0),
  Vector3.new(20, 0, 0),
  Vector3.new(30, 0, 0),
  Vector3.new(40, 0, 0),
  Vector3.new(50, 0, 0),
  Vector3.new(60, 0, 0),
  Vector3.new(-0, 0, 0),
  Vector3.new(-10, 0, 0),
  Vector3.new(-20, 0, 0),
  Vector3.new(-30, 0, 0),
  Vector3.new(-40, 0, 0),
  Vector3.new(-50, 0, 0),
  Vector3.new(-60, 0, 0),
                      Vector3.new(0, 0, 30),
  Vector3.new(10, 0, 30),
  Vector3.new(20, 0, 30),
  Vector3.new(30, 0, 30),
  Vector3.new(40, 0, 30),
  Vector3.new(50, 0, 30),
  Vector3.new(60, 0, 30),
  Vector3.new(-0, 0, 30),
  Vector3.new(-10, 0, 30),
  Vector3.new(-20, 0, 30),
  Vector3.new(-30, 0, 30),
  Vector3.new(-40, 0, 30),
  Vector3.new(-50, 0, 30),
  Vector3.new(-60, 0, 30),
                          Vector3.new(0, 0, 45),
  Vector3.new(10, 0, 45),
  Vector3.new(20, 0, 45),
  Vector3.new(30, 0, 45),
  Vector3.new(40, 0, 45),
  Vector3.new(50, 0, 45),
  Vector3.new(60, 0, 45),
  Vector3.new(-0, 0, 45),
  Vector3.new(-10, 0, 45),
  Vector3.new(-20, 0, 45),
  Vector3.new(-30, 0, 45),
  Vector3.new(-40, 0, 45),
  Vector3.new(-50, 0, 45),
  Vector3.new(-60, 0, 45),
  Vector3.new(0, 0, 15),
  Vector3.new(10, 0, 15),
  Vector3.new(20, 0, 15),
  Vector3.new(30, 0, 15),
  Vector3.new(40, 0, 15),
  Vector3.new(50, 0, 15),
  Vector3.new(60, 0, 15),
  Vector3.new(-0, 0, 15),
  Vector3.new(-10, 0, 15),
  Vector3.new(-20, 0, 15),
  Vector3.new(-30, 0, 15),
  Vector3.new(-40, 0, 15),
  Vector3.new(-50, 0, 15),
  Vector3.new(-60, 0, 15),
Vector3.new(0, 0, -15),
  Vector3.new(10, 0, -15),
  Vector3.new(20, 0, -15),
  Vector3.new(30, 0, -15),
  Vector3.new(40, 0, -15),
  Vector3.new(50, 0, -15),
  Vector3.new(60, 0, -15),
  Vector3.new(-0, 0, -15),
  Vector3.new(-10, 0, -15),
  Vector3.new(-20, 0, -15),
  Vector3.new(-30, 0, -15),
  Vector3.new(-40, 0, -15),
  Vector3.new(-50, 0, -15),
  Vector3.new(-60, 0, -15),
  Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -30),
  Vector3.new(20, 0, -30),
  Vector3.new(30, 0, -30),
  Vector3.new(40, 0, -30),
  Vector3.new(50, 0, -30),
  Vector3.new(60, 0, -30),
  Vector3.new(-0, 0, -30),
  Vector3.new(-10, 0, -30),
  Vector3.new(-20, 0, -30),
  Vector3.new(-30, 0, -30),
  Vector3.new(-40, 0, -30),
  Vector3.new(-50, 0, -30),
  Vector3.new(-60, 0, -30),
    Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -45),
  Vector3.new(20, 0, -45),
  Vector3.new(30, 0, -45),
  Vector3.new(40, 0, -45),
  Vector3.new(50, 0, -45),
  Vector3.new(60, 0, -45),
  Vector3.new(-0, 0, -45),
  Vector3.new(-10, 0, -45),
  Vector3.new(-20, 0, -45),
  Vector3.new(-30, 0, -45),
  Vector3.new(-40, 0, -45),
  Vector3.new(-50, 0, -45),
  Vector3.new(-60, 0, -45),
    Vector3.new(10, 0, -60),
  Vector3.new(20, 0, -60),
  Vector3.new(30, 0, -60),
  Vector3.new(40, 0, -60),
  Vector3.new(50, 0, -60),
  Vector3.new(60, 0, -60),
  Vector3.new(-0, 0, -60),
  Vector3.new(-10, 0, -60),
  Vector3.new(-20, 0, -60),
  Vector3.new(-30, 0, -60),
  Vector3.new(-40, 0, -60),
  Vector3.new(-50, 0, -60),
  Vector3.new(-60, 0, -60),
  Vector3.new(10, 0, -75),
  Vector3.new(20, 0, -75),
  Vector3.new(30, 0, -75),
  Vector3.new(40, 0, -75),
  Vector3.new(50, 0, -75),
  Vector3.new(60, 0, -75),
  Vector3.new(-0, 0, -75),
  Vector3.new(-10, 0, -75),
  Vector3.new(-20, 0, -75),
  Vector3.new(-30, 0, -75),
  Vector3.new(-40, 0, -75),
  Vector3.new(-50, 0, -75),
  Vector3.new(-60, 0, -75),


     }
      for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if tool:IsA("Tool") then
              tool.Parent = game.Players.LocalPlayer.Character
              local gripPosIndex = math.min(i, #TablaGripPos)
              local gripPos = TablaGripPos[gripPosIndex]

              if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                  tool.GripPos = gripPos
              else
                  warn("", tool.Name, "")
              end
          end
      end
    end
})

-- Button for Fire Aura
ToolsTab:AddButton({
    Name = "Fire Aura",
    Callback = function()
        nametools = "fire Spray lel"
                oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.", Button1 = "I understand" ,Duration=5})
                toolthatiwanttodupe = "PaperbagFire"
                tools = "PaperbagFire"
                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                        task.wait()
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                wait(0.1)
                local args = {
                        [1] = "ClearAllTools"
                }

                cleartoolremote:FireServer(unpack(args))
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                for m=1,2 do task.wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
                        end
                        task.wait(0.2)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                wait(0.3)
                duping = true
                for m=1, 124 do
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                        local args = {
                                [1] = "PickingTools",
                                [2] = toolthatiwanttodupe
                        }

                        picktoolremote:InvokeServer(unpack(args))
                        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        wait()
                        game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "HÃ¢Â Â¥aÃ¢Â Â¥nÃ¢Â Â¥dÃ¢Â Â¥lÃ¢Â Â¥e"
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        repeat                 if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
                end
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                toolgrip = true
                duping = false
                wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")


print("done")
wait(1)
local TablaGripPos = {
       Vector3.new(0, 0, 0),
  Vector3.new(10, 0, 0),
  Vector3.new(20, 0, 0),
  Vector3.new(30, 0, 0),
  Vector3.new(40, 0, 0),
  Vector3.new(50, 0, 0),
  Vector3.new(60, 0, 0),
  Vector3.new(-0, 0, 0),
  Vector3.new(-10, 0, 0),
  Vector3.new(-20, 0, 0),
  Vector3.new(-30, 0, 0),
  Vector3.new(-40, 0, 0),
  Vector3.new(-50, 0, 0),
  Vector3.new(-60, 0, 0),
                      Vector3.new(0, 0, 30),
  Vector3.new(10, 0, 30),
  Vector3.new(20, 0, 30),
  Vector3.new(30, 0, 30),
  Vector3.new(40, 0, 30),
  Vector3.new(50, 0, 30),
  Vector3.new(60, 0, 30),
  Vector3.new(-0, 0, 30),
  Vector3.new(-10, 0, 30),
  Vector3.new(-20, 0, 30),
  Vector3.new(-30, 0, 30),
  Vector3.new(-40, 0, 30),
  Vector3.new(-50, 0, 30),
  Vector3.new(-60, 0, 30),
                          Vector3.new(0, 0, 45),
  Vector3.new(10, 0, 45),
  Vector3.new(20, 0, 45),
  Vector3.new(30, 0, 45),
  Vector3.new(40, 0, 45),
  Vector3.new(50, 0, 45),
  Vector3.new(60, 0, 45),
  Vector3.new(-0, 0, 45),
  Vector3.new(-10, 0, 45),
  Vector3.new(-20, 0, 45),
  Vector3.new(-30, 0, 45),
  Vector3.new(-40, 0, 45),
  Vector3.new(-50, 0, 45),
  Vector3.new(-60, 0, 45),
  Vector3.new(0, 0, 15),
  Vector3.new(10, 0, 15),
  Vector3.new(20, 0, 15),
  Vector3.new(30, 0, 15),
  Vector3.new(40, 0, 15),
  Vector3.new(50, 0, 15),
  Vector3.new(60, 0, 15),
  Vector3.new(-0, 0, 15),
  Vector3.new(-10, 0, 15),
  Vector3.new(-20, 0, 15),
  Vector3.new(-30, 0, 15),
  Vector3.new(-40, 0, 15),
  Vector3.new(-50, 0, 15),
  Vector3.new(-60, 0, 15),
Vector3.new(0, 0, -15),
  Vector3.new(10, 0, -15),
  Vector3.new(20, 0, -15),
  Vector3.new(30, 0, -15),
  Vector3.new(40, 0, -15),
  Vector3.new(50, 0, -15),
  Vector3.new(60, 0, -15),
  Vector3.new(-0, 0, -15),
  Vector3.new(-10, 0, -15),
  Vector3.new(-20, 0, -15),
  Vector3.new(-30, 0, -15),
  Vector3.new(-40, 0, -15),
  Vector3.new(-50, 0, -15),
  Vector3.new(-60, 0, -15),
  Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -30),
  Vector3.new(20, 0, -30),
  Vector3.new(30, 0, -30),
  Vector3.new(40, 0, -30),
  Vector3.new(50, 0, -30),
  Vector3.new(60, 0, -30),
  Vector3.new(-0, 0, -30),
  Vector3.new(-10, 0, -30),
  Vector3.new(-20, 0, -30),
  Vector3.new(-30, 0, -30),
  Vector3.new(-40, 0, -30),
  Vector3.new(-50, 0, -30),
  Vector3.new(-60, 0, -30),
    Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -45),
  Vector3.new(20, 0, -45),
  Vector3.new(30, 0, -45),
  Vector3.new(40, 0, -45),
  Vector3.new(50, 0, -45),
  Vector3.new(60, 0, -45),
  Vector3.new(-0, 0, -45),
  Vector3.new(-10, 0, -45),
  Vector3.new(-20, 0, -45),
  Vector3.new(-30, 0, -45),
  Vector3.new(-40, 0, -45),
  Vector3.new(-50, 0, -45),
  Vector3.new(-60, 0, -45),
    Vector3.new(10, 0, -60),
  Vector3.new(20, 0, -60),
  Vector3.new(30, 0, -60),
  Vector3.new(40, 0, -60),
  Vector3.new(50, 0, -60),
  Vector3.new(60, 0, -60),
  Vector3.new(-0, 0, -60),
  Vector3.new(-10, 0, -60),
  Vector3.new(-20, 0, -60),
  Vector3.new(-30, 0, -60),
  Vector3.new(-40, 0, -60),
  Vector3.new(-50, 0, -60),
  Vector3.new(-60, 0, -60),
  Vector3.new(10, 0, -75),
  Vector3.new(20, 0, -75),
  Vector3.new(30, 0, -75),
  Vector3.new(40, 0, -75),
  Vector3.new(50, 0, -75),
  Vector3.new(60, 0, -75),
  Vector3.new(-0, 0, -75),
  Vector3.new(-10, 0, -75),
  Vector3.new(-20, 0, -75),
  Vector3.new(-30, 0, -75),
  Vector3.new(-40, 0, -75),
  Vector3.new(-50, 0, -75),
  Vector3.new(-60, 0, -75),


     }
      for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if tool:IsA("Tool") then
              tool.Parent = game.Players.LocalPlayer.Character
              local gripPosIndex = math.min(i, #TablaGripPos)
              local gripPos = TablaGripPos[gripPosIndex]

              if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                  tool.GripPos = gripPos
              else
                  warn("", tool.Name, "")
              end
          end
      end
    end
})

-- Button for Water Aura
ToolsTab:AddButton({
    Name = "Water Aura",
    Callback = function()
        nametools = "water Spray lel"
                oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.", Button1 = "I understand" ,Duration=5})
                toolthatiwanttodupe = "WateringCan"
                tools = "WateringCan"
                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                        task.wait()
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                wait(0.1)
                local args = {
                        [1] = "ClearAllTools"
                }

                cleartoolremote:FireServer(unpack(args))
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                for m=1,2 do task.wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
                        end
                        task.wait(0.2)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                wait(0.3)
                duping = true
                for m=1, 124 do
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                        local args = {
                                [1] = "PickingTools",
                                [2] = toolthatiwanttodupe
                        }

                        picktoolremote:InvokeServer(unpack(args))
                        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        wait()
                        game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "HÃ¢Â Â¥aÃ¢Â Â¥nÃ¢Â Â¥dÃ¢Â Â¥lÃ¢Â Â¥e"
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        repeat                 if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
                end
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                toolgrip = true
                duping = false
                wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")


print("done")
wait(1)
local TablaGripPos = {
       Vector3.new(0, 0, 0),
  Vector3.new(10, 0, 0),
  Vector3.new(20, 0, 0),
  Vector3.new(30, 0, 0),
  Vector3.new(40, 0, 0),
  Vector3.new(50, 0, 0),
  Vector3.new(60, 0, 0),
  Vector3.new(-0, 0, 0),
  Vector3.new(-10, 0, 0),
  Vector3.new(-20, 0, 0),
  Vector3.new(-30, 0, 0),
  Vector3.new(-40, 0, 0),
  Vector3.new(-50, 0, 0),
  Vector3.new(-60, 0, 0),
                      Vector3.new(0, 0, 30),
  Vector3.new(10, 0, 30),
  Vector3.new(20, 0, 30),
  Vector3.new(30, 0, 30),
  Vector3.new(40, 0, 30),
  Vector3.new(50, 0, 30),
  Vector3.new(60, 0, 30),
  Vector3.new(-0, 0, 30),
  Vector3.new(-10, 0, 30),
  Vector3.new(-20, 0, 30),
  Vector3.new(-30, 0, 30),
  Vector3.new(-40, 0, 30),
  Vector3.new(-50, 0, 30),
  Vector3.new(-60, 0, 30),
                          Vector3.new(0, 0, 45),
  Vector3.new(10, 0, 45),
  Vector3.new(20, 0, 45),
  Vector3.new(30, 0, 45),
  Vector3.new(40, 0, 45),
  Vector3.new(50, 0, 45),
  Vector3.new(60, 0, 45),
  Vector3.new(-0, 0, 45),
  Vector3.new(-10, 0, 45),
  Vector3.new(-20, 0, 45),
  Vector3.new(-30, 0, 45),
  Vector3.new(-40, 0, 45),
  Vector3.new(-50, 0, 45),
  Vector3.new(-60, 0, 45),
  Vector3.new(0, 0, 15),
  Vector3.new(10, 0, 15),
  Vector3.new(20, 0, 15),
  Vector3.new(30, 0, 15),
  Vector3.new(40, 0, 15),
  Vector3.new(50, 0, 15),
  Vector3.new(60, 0, 15),
  Vector3.new(-0, 0, 15),
  Vector3.new(-10, 0, 15),
  Vector3.new(-20, 0, 15),
  Vector3.new(-30, 0, 15),
  Vector3.new(-40, 0, 15),
  Vector3.new(-50, 0, 15),
  Vector3.new(-60, 0, 15),
Vector3.new(0, 0, -15),
  Vector3.new(10, 0, -15),
  Vector3.new(20, 0, -15),
  Vector3.new(30, 0, -15),
  Vector3.new(40, 0, -15),
  Vector3.new(50, 0, -15),
  Vector3.new(60, 0, -15),
  Vector3.new(-0, 0, -15),
  Vector3.new(-10, 0, -15),
  Vector3.new(-20, 0, -15),
  Vector3.new(-30, 0, -15),
  Vector3.new(-40, 0, -15),
  Vector3.new(-50, 0, -15),
  Vector3.new(-60, 0, -15),
  Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -30),
  Vector3.new(20, 0, -30),
  Vector3.new(30, 0, -30),
  Vector3.new(40, 0, -30),
  Vector3.new(50, 0, -30),
  Vector3.new(60, 0, -30),
  Vector3.new(-0, 0, -30),
  Vector3.new(-10, 0, -30),
  Vector3.new(-20, 0, -30),
  Vector3.new(-30, 0, -30),
  Vector3.new(-40, 0, -30),
  Vector3.new(-50, 0, -30),
  Vector3.new(-60, 0, -30),
    Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -45),
  Vector3.new(20, 0, -45),
  Vector3.new(30, 0, -45),
  Vector3.new(40, 0, -45),
  Vector3.new(50, 0, -45),
  Vector3.new(60, 0, -45),
  Vector3.new(-0, 0, -45),
  Vector3.new(-10, 0, -45),
  Vector3.new(-20, 0, -45),
  Vector3.new(-30, 0, -45),
  Vector3.new(-40, 0, -45),
  Vector3.new(-50, 0, -45),
  Vector3.new(-60, 0, -45),
    Vector3.new(10, 0, -60),
  Vector3.new(20, 0, -60),
  Vector3.new(30, 0, -60),
  Vector3.new(40, 0, -60),
  Vector3.new(50, 0, -60),
  Vector3.new(60, 0, -60),
  Vector3.new(-0, 0, -60),
  Vector3.new(-10, 0, -60),
  Vector3.new(-20, 0, -60),
  Vector3.new(-30, 0, -60),
  Vector3.new(-40, 0, -60),
  Vector3.new(-50, 0, -60),
  Vector3.new(-60, 0, -60),
  Vector3.new(10, 0, -75),
  Vector3.new(20, 0, -75),
  Vector3.new(30, 0, -75),
  Vector3.new(40, 0, -75),
  Vector3.new(50, 0, -75),
  Vector3.new(60, 0, -75),
  Vector3.new(-0, 0, -75),
  Vector3.new(-10, 0, -75),
  Vector3.new(-20, 0, -75),
  Vector3.new(-30, 0, -75),
  Vector3.new(-40, 0, -75),
  Vector3.new(-50, 0, -75),
  Vector3.new(-60, 0, -75),


     }
      for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if tool:IsA("Tool") then
              tool.Parent = game.Players.LocalPlayer.Character
              local gripPosIndex = math.min(i, #TablaGripPos)
              local gripPos = TablaGripPos[gripPosIndex]

              if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                  tool.GripPos = gripPos
              else
                  warn("", tool.Name, "")
              end
          end
      end
    end
})

-- Button for Water Aura
ToolsTab:AddButton({
    Name = "Water Aura",
    Callback = function()
        nametools = "water Spray lel"
                oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("StarterGui"):SetCore("SendNotification",{Title="Dupe Script",Text="Please do not equip any tools or unequip tools or click tools on inventory. It will break the script.", Button1 = "I understand" ,Duration=5})
                toolthatiwanttodupe = "WateringCan"
                tools = "WateringCan"
                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                        task.wait()
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                wait(0.1)
                local args = {
                        [1] = "ClearAllTools"
                }

                cleartoolremote:FireServer(unpack(args))
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                for m=1,2 do task.wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
                        end
                        task.wait(0.2)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                wait(0.3)
                duping = true
                for m=1, 124 do
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                        local args = {
                                [1] = "PickingTools",
                                [2] = toolthatiwanttodupe
                        }

                        picktoolremote:InvokeServer(unpack(args))
                        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        wait()
                        game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "HÃ¢Â Â¥aÃ¢Â Â¥nÃ¢Â Â¥dÃ¢Â Â¥lÃ¢Â Â¥e"
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        repeat                 if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
                end
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                toolgrip = true
                duping = false
                wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")


print("done")
wait(1)
local TablaGripPos = {
       Vector3.new(0, 0, 0),
  Vector3.new(10, 0, 0),
  Vector3.new(20, 0, 0),
  Vector3.new(30, 0, 0),
  Vector3.new(40, 0, 0),
  Vector3.new(50, 0, 0),
  Vector3.new(60, 0, 0),
  Vector3.new(-0, 0, 0),
  Vector3.new(-10, 0, 0),
  Vector3.new(-20, 0, 0),
  Vector3.new(-30, 0, 0),
  Vector3.new(-40, 0, 0),
  Vector3.new(-50, 0, 0),
  Vector3.new(-60, 0, 0),
                      Vector3.new(0, 0, 30),
  Vector3.new(10, 0, 30),
  Vector3.new(20, 0, 30),
  Vector3.new(30, 0, 30),
  Vector3.new(40, 0, 30),
  Vector3.new(50, 0, 30),
  Vector3.new(60, 0, 30),
  Vector3.new(-0, 0, 30),
  Vector3.new(-10, 0, 30),
  Vector3.new(-20, 0, 30),
  Vector3.new(-30, 0, 30),
  Vector3.new(-40, 0, 30),
  Vector3.new(-50, 0, 30),
  Vector3.new(-60, 0, 30),
                          Vector3.new(0, 0, 45),
  Vector3.new(10, 0, 45),
  Vector3.new(20, 0, 45),
  Vector3.new(30, 0, 45),
  Vector3.new(40, 0, 45),
  Vector3.new(50, 0, 45),
  Vector3.new(60, 0, 45),
  Vector3.new(-0, 0, 45),
  Vector3.new(-10, 0, 45),
  Vector3.new(-20, 0, 45),
  Vector3.new(-30, 0, 45),
  Vector3.new(-40, 0, 45),
  Vector3.new(-50, 0, 45),
  Vector3.new(-60, 0, 45),
  Vector3.new(0, 0, 15),
  Vector3.new(10, 0, 15),
  Vector3.new(20, 0, 15),
  Vector3.new(30, 0, 15),
  Vector3.new(40, 0, 15),
  Vector3.new(50, 0, 15),
  Vector3.new(60, 0, 15),
  Vector3.new(-0, 0, 15),
  Vector3.new(-10, 0, 15),
  Vector3.new(-20, 0, 15),
  Vector3.new(-30, 0, 15),
  Vector3.new(-40, 0, 15),
  Vector3.new(-50, 0, 15),
  Vector3.new(-60, 0, 15),
Vector3.new(0, 0, -15),
  Vector3.new(10, 0, -15),
  Vector3.new(20, 0, -15),
  Vector3.new(30, 0, -15),
  Vector3.new(40, 0, -15),
  Vector3.new(50, 0, -15),
  Vector3.new(60, 0, -15),
  Vector3.new(-0, 0, -15),
  Vector3.new(-10, 0, -15),
  Vector3.new(-20, 0, -15),
  Vector3.new(-30, 0, -15),
  Vector3.new(-40, 0, -15),
  Vector3.new(-50, 0, -15),
  Vector3.new(-60, 0, -15),
  Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -30),
  Vector3.new(20, 0, -30),
  Vector3.new(30, 0, -30),
  Vector3.new(40, 0, -30),
  Vector3.new(50, 0, -30),
  Vector3.new(60, 0, -30),
  Vector3.new(-0, 0, -30),
  Vector3.new(-10, 0, -30),
  Vector3.new(-20, 0, -30),
  Vector3.new(-30, 0, -30),
  Vector3.new(-40, 0, -30),
  Vector3.new(-50, 0, -30),
  Vector3.new(-60, 0, -30),
    Vector3.new(0, 0, -30),
  Vector3.new(10, 0, -45),
  Vector3.new(20, 0, -45),
  Vector3.new(30, 0, -45),
  Vector3.new(40, 0, -45),
  Vector3.new(50, 0, -45),
  Vector3.new(60, 0, -45),
  Vector3.new(-0, 0, -45),
  Vector3.new(-10, 0, -45),
  Vector3.new(-20, 0, -45),
  Vector3.new(-30, 0, -45),
  Vector3.new(-40, 0, -45),
  Vector3.new(-50, 0, -45),
  Vector3.new(-60, 0, -45),
    Vector3.new(10, 0, -60),
  Vector3.new(20, 0, -60),
  Vector3.new(30, 0, -60),
  Vector3.new(40, 0, -60),
  Vector3.new(50, 0, -60),
  Vector3.new(60, 0, -60),
  Vector3.new(-0, 0, -60),
  Vector3.new(-10, 0, -60),
  Vector3.new(-20, 0, -60),
  Vector3.new(-30, 0, -60),
  Vector3.new(-40, 0, -60),
  Vector3.new(-50, 0, -60),
  Vector3.new(-60, 0, -60),
  Vector3.new(10, 0, -75),
  Vector3.new(20, 0, -75),
  Vector3.new(30, 0, -75),
  Vector3.new(40, 0, -75),
  Vector3.new(50, 0, -75),
  Vector3.new(60, 0, -75),
  Vector3.new(-0, 0, -75),
  Vector3.new(-10, 0, -75),
  Vector3.new(-20, 0, -75),
  Vector3.new(-30, 0, -75),
  Vector3.new(-40, 0, -75),
  Vector3.new(-50, 0, -75),
  Vector3.new(-60, 0, -75),


     }
      for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if tool:IsA("Tool") then
              tool.Parent = game.Players.LocalPlayer.Character
              local gripPosIndex = math.min(i, #TablaGripPos)
              local gripPos = TablaGripPos[gripPosIndex]

              if tool:IsDescendantOf(game.Players.LocalPlayer.Character) then
                  tool.GripPos = gripPos
              else
                  warn("", tool.Name, "")
              end
          end
      end
    end
})

-- Section for D1ck Grip
Section = ToolsTab:AddSection({
    Name = "D1ck Grip"
})

-- Button for Black D1ck
ToolsTab:AddButton({
    Name = "Black D1ck",
    Callback = function()
                        oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                toolthatiwanttodupe = "Box"
                tools = "Box"
                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                        task.wait()
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
                wait(0.1)
                local args = {
                        [1] = "ClearAllTools"
                }

                cleartoolremote:FireServer(unpack(args))
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                for m=1,2 do task.wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
                        end
                        task.wait(0.2)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                wait(0.3)
                duping = true
                for m=1, 76 do
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end
                        local args = {
                                [1] = "PickingTools",
                                [2] = toolthatiwanttodupe
                        }

                        picktoolremote:InvokeServer(unpack(args))
                        game:GetService("Players").LocalPlayer.Backpack:WaitForChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        if duping == false then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false return end
                        wait()
                        game:GetService("Players").LocalPlayer.Character[toolthatiwanttodupe]:FindFirstChild("Handle").Name = "Hâ ¥aâ ¥nâ ¥dâ ¥lâ ¥e"
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Backpack
                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolthatiwanttodupe).Parent = game.Players.LocalPlayer.Character
                        repeat                 if game:GetService("Workspace"):FindFirstChild("Camera") then
                                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy() end wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild(toolthatiwanttodupe) == nil
                end
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                toolgrip = true
                duping = false
                wait(1)
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -1.5, 0)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, 2)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, 6)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, 8)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, -8)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, -6)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, -4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, 0, -2)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -1, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -2, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -3, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -4, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -5, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -6, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -7, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -8, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -9, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -10, -10)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -10.5, -9)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -10.5, -8)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -10.5, -6)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -10, -5)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -10.5, -4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -11.5, -4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -12.5, -4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -13.5, -4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -14.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -15.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -16.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -17.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -18.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -19.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -20.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -21.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -22.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -23.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -24.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -25.5, 4)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -26, 3)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -27, 2)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Backpack[tools].Grip = CFrame.new(-0.784089804, 0.623452663, 0.928474426, 0.611631632, 0.0202812403, -0.790882647, 0.107864097, 0.988198876, 0.108758211, 0.783755124, -0.151827812, 0.602226019) + Vector3.new(0, -27, 0)
                game.Players.LocalPlayer.Backpack[tools].Name = "Big Black Dick Lmao"
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcframe
                wait(0.5)
                for _, tool in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                                if tool.Name == nametools then
                                 tool.Parent = game:GetService("Players").LocalPlayer.Character
                                end
                        end
                end
    end
})

local UniversalTab = Window:MakeTab({"Universal Scripts", "plane"})

-- Section for Universal Scripts
Section = UniversalTab:AddSection({
    Name = "Universal Scripts"
})

-- Button for Rael Hub Brook
UniversalTab:AddButton({
    Name = "Rael Hub Brook",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Mimic-Rael-Hub-20921"))()
    end
})

-- Button for ShiftLock
UniversalTab:AddButton({
    Name = "ShiftLock",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/N2tiHgyv"))()
    end
})

-- Button for Ghost Hub
UniversalTab:AddButton({
    Name = "Ghost Hub",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GhostHub-16534"))()
    end
})

-- Button for Infinite Yield
UniversalTab:AddButton({
    Name = "InfiniteYield - Cmd",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

-- Button for TP Tool
UniversalTab:AddButton({
    Name = "TP Tool",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/err0r129/KptHadesBlair/main/Bao.lua"))()
    end
})

-- Button for Fly Gui
UniversalTab:AddButton({
    Name = "Fly Gui",
    Callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Fly-v3-7412"))()
    end
})

-- Button for Nameless Admin
UniversalTab:AddButton({
    Name = "Nameless Admin - Cmd",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
    end
})


UniversalTab:AddButton({
    Name = "Telekinesis",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SAZXHUB/Control-update/main/README.md", true))()
    end
})
