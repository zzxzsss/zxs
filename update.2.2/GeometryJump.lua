if game.CoreGui:FindFirstChild('hexagon-docs') then
	game.CoreGui:FindFirstChild('hexagon-docs'):Destroy()
end
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/vateq/UILIBrewrites/refs/heads/main/hexagonuilib'))()
library.settings = {
	guiname = "zzz hub",
	title = 'Geometry Jump',
	modal = true,
	font = Enum.Font.SourceSans,
	textsize = 16,
	logo = "rbxassetid://4350178803",
	footer = ' - zzzhub',
	textstroke = true,
}

local Window = library:CreateWindow(
	Vector2.new(475, 525), -- ui lib size
	Vector2.new((workspace.CurrentCamera.ViewportSize.X / 2) - 250, (workspace.CurrentCamera.ViewportSize.Y / 2) - 250) -- ui pointing (id what i just called it lol) just dont change it.
)

local maintab = Window:CreateTab('Main')
local category = maintab:AddCategory("Game Modding",1,1)

local function Alive(player)
	local isalive = false
	if player.Character and player.Character:FindFirstChild('Humanoid') and player.Character:FindFirstChild('Humanoid').Health >= 1 then
		isalive = true
	end
	return isalive
end

_G.candyhub = {
	godmode = false,
	godmode2= false,
	color1 = Color3.fromRGB(255,0,0),
	color2 = Color3.fromRGB(255,0,0),
	attempts = 10,
}

repeat task.wait() until workspace:FindFirstChild('Level')

category:AddToggle('Spikes GodMode',false,'',function(v)
    _G.candyhub.godmode = v
	task.spawn(function()
		while _G.candyhub.godmode and task.wait() do
			for i, box in workspace.Level:GetChildren() do
				if box:FindFirstChild('Kill') then
					box:FindFirstChild('Kill').Name = '_Kill'
				end
			end
		end
		if not _G.candyhub.godmode then
			for i, box in workspace.Level:GetChildren() do
				if box:FindFirstChild('_Kill') then
					box:FindFirstChild('_Kill').Name = 'Kill'
				end
			end
		end
	end)
end)
category:AddToggle('Blocks GodMode',false,'',function(v)
    _G.candyhub.godmode2 = v
	task.spawn(function()
		while _G.candyhub.godmode2 and task.wait() do
			for i, box in workspace.Level:GetChildren() do
				if string.match(box.Name, "Block") and not string.match(box.Name, '__') then
					box.Name = '__'..(box.Name:gsub('Block', '0brick0'))
                    print(box.Name..' -4')
				end
			end
		end
		if not _G.candyhub.godmode2 then
			for i, box in workspace.Level:GetChildren() do
				if string.match(box.Name, "__") then
                    box.Name = box.Name:gsub('0brick0', 'Block'):gsub('__', '')
                    print(box.Name..' -5')
				end
			end
		end
	end)
end)
category:AddTextBox("Attempts Amount", "10", "", function(v)
    _G.candyhub.attempts = v
end, true)
category:AddButton('Set', function()
    game:GetService("ReplicatedStorage").Attempts.Value = _G.candyhub.attempts
end)

local category8 = maintab:AddCategory("Map Modding",1,1)
category8:AddToggle('Editor Mode',false,'',function(v)
    game:GetService("ReplicatedStorage").EditorMode.Value = v
    game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Editor.Visible = v
    if game:GetService("ReplicatedStorage").EditorMode.Value then
        game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Pause.Visible = false
    end
end)
category8:AddLabel('Editor Mode', '')
category8:AddLabel('pause game and toggle on', '')

local category7 = maintab:AddCategory("Game Visuals",1,1)
local blur = game:GetService('Lighting'):FindFirstChild('Blur') or Instance.new('BlurEffect', game:GetService('Lighting')); blur.Enabled = false
local bloom = game:GetService('Lighting'):FindFirstChild('Bloom') or Instance.new('BloomEffect', game:GetService('Lighting')); bloom.Enabled = false
category7:AddToggle('Blur',false,'',function(v)
    blur.Enabled = v
end)
category7:AddSlider('Blur Size', {1, 24, 6, 1, ""}, '', function(v)
    blur.Size = v
end, false)
category7:AddToggle('Bloom',false,'',function(v)
    bloom.Enabled = v
    bloom.Threshold = 0
end)
category7:AddSlider('Bloom Size', {1, 36, 12, 1, ""}, '', function(v)
    bloom.Size = v
end, false)
category7:AddSlider('Bloom Intensity', {1, 36, 12, 1, ""}, '', function(v)
    bloom.Intensity = v
end, false)



local category2 = maintab:AddCategory("Visuals",2,1)
category2:AddButton('Toggle Ship Visibility', function()
    if Alive(game.Players.LocalPlayer) then
		local charactergui = game.Players.LocalPlayer.Character.Sprites.SurfaceGui
		charactergui.Ship.Visible = not charactergui.Ship.Visible
	end
end)
category2:AddSlider('Ship Size', {0.1, 4, 1, 0.1, ""}, '', function(v)
    if Alive(game.Players.LocalPlayer) then
		local charactergui = game.Players.LocalPlayer.Character.Sprites.SurfaceGui
		charactergui.Ship.Size = UDim2.new(v,0,v,0)
	end
end, false)

category2:AddButton('Toggle Player Visibility', function()
    if Alive(game.Players.LocalPlayer) then
		local charactergui = game.Players.LocalPlayer.Character.Sprites.SurfaceGui
		charactergui.Cube.Visible = not charactergui.Ship.Visible
	end
end)
category2:AddSlider('Player Size', {0.1, 4, 1, 0.1, ""}, '', function(v)
    if Alive(game.Players.LocalPlayer) then
		local charactergui = game.Players.LocalPlayer.Character.Sprites.SurfaceGui
		charactergui.Cube.Size = UDim2.new(v,0,v,0)
	end
end, false)

local category3 = maintab:AddCategory("Player Visuals",2,1)
category3:AddColorPicker('Color 1', Color3.fromRGB(255,0,0),'',function(v)
    _G.candyhub.color1 = v
end)
category3:AddColorPicker('Color 2', Color3.fromRGB(255,0,0),'',function(v)
    _G.candyhub.color2 = v
end)
category3:AddButton('Apply Changes', function()
    if Alive(game.Players.LocalPlayer) then
		local charactergui = game.Players.LocalPlayer.Character.Sprites.SurfaceGui
		charactergui.Cube.Color1.ImageColor3 = _G.candyhub.color1
		charactergui.Cube.Color2.ImageColor3 = _G.candyhub.color2
        charactergui.Ship.Cube.Color1.ImageColor3 = _G.candyhub.color1
        charactergui.Ship.Cube.Color2.ImageColor3 = _G.candyhub.color2
        charactergui.Ship.Color1 = _G.candyhub.color1
	end
end)
local category4 = maintab:AddCategory("Player Effects",2,1)
category4:AddToggle('Player Trail',false,'',function(v)
    if Alive(game.Players.LocalPlayer) then
		local character = game.Players.LocalPlayer.Character
        character.Particles.Trail:FindFirstChild('ParticleEmitter').Enabled = v
    end
end)
