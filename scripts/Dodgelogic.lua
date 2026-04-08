local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local lp = Players.LocalPlayer

-- Killer animation IDs
local killerAnims = {
	"126830014841198", "126355327951215", "121086746534252", "18885909645",
	"98456918873918", "105458270463374", "83829782357897", "125403313786645",
	"118298475669935", "82113744478546", "70371667919898", "99135633258223",
	"97167027849946", "109230267448394", "139835501033932", "126896426760253",
	"109667959938617", "126681776859538", "129976080405072", "121293883585738"
}

-- UI Setup
local screenGui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
screenGui.Name = "UltraInstinctUI"
screenGui.ResetOnSpawn = false

local directions = {"Left", "Right", "Forward", "Backward", "Random"}
local currentDirection = 1
local ultraInstinctEnabled = false
local canDodge = true
local lastNotifTime = 0
local notifCooldown = 2

-- Animations
local dodgeAnims = {
	Left = "rbxassetid://17096325697",
	Right = "rbxassetid://17096327600",
	Forward = "rbxassetid://17096329187",
	Backward = "rbxassetid://17096330733",
}

-- Distance TextBox
local dodgeBox = Instance.new("TextBox", screenGui)
dodgeBox.Size = UDim2.new(0, 100, 0, 30)
dodgeBox.Position = UDim2.new(0, 20, 0, 20)
dodgeBox.Text = "7"
dodgeBox.ClearTextOnFocus = false
dodgeBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
dodgeBox.TextColor3 = Color3.new(1,1,1)
dodgeBox.PlaceholderText = "Dodge Dist"

-- Label
local distLabel = Instance.new("TextLabel", screenGui)
distLabel.Size = UDim2.new(0, 100, 0, 20)
distLabel.Position = UDim2.new(0, 20, 0, 0)
distLabel.Text = "Dodge Distance"
distLabel.BackgroundTransparency = 1
distLabel.TextColor3 = Color3.new(1,1,1)

-- Direction Label
local dirLabel = Instance.new("TextLabel", screenGui)
dirLabel.Size = UDim2.new(0, 120, 0, 30)
dirLabel.Position = UDim2.new(0, 20, 0, 60)
dirLabel.Text = "Direction: Left"
dirLabel.BackgroundColor3 = Color3.fromRGB(45,45,45)
dirLabel.TextColor3 = Color3.new(1,1,1)

-- Switch Button
local switchBtn = Instance.new("TextButton", screenGui)
switchBtn.Size = UDim2.new(0, 100, 0, 30)
switchBtn.Position = UDim2.new(0, 20, 0, 100)
switchBtn.Text = "Switch Dir"
switchBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
switchBtn.TextColor3 = Color3.new(1,1,1)

-- Toggle Button
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0, 20, 0, 140)
toggleBtn.Text = "Ultra Instinct: OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
toggleBtn.TextColor3 = Color3.new(1,1,1)

-- HIDE BUTTON
local uiVisible = true
local hideBtn = Instance.new("TextButton", screenGui)
hideBtn.Size = UDim2.new(0, 60, 0, 25)
hideBtn.Position = UDim2.new(0, 130, 0, 20)
hideBtn.Text = "Hide"
hideBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
hideBtn.TextColor3 = Color3.new(1,1,1)

hideBtn.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	for _, v in ipairs(screenGui:GetChildren()) do
		if v:IsA("GuiObject") and v ~= hideBtn then
			v.Visible = uiVisible
		end
	end
	hideBtn.Text = uiVisible and "Hide" or "Show"
end)

-- Button Logic
switchBtn.MouseButton1Click:Connect(function()
	currentDirection = (currentDirection % #directions) + 1
	dirLabel.Text = "Direction: " .. directions[currentDirection]
end)

toggleBtn.MouseButton1Click:Connect(function()
	ultraInstinctEnabled = not ultraInstinctEnabled
	toggleBtn.Text = "Ultra Instinct: " .. (ultraInstinctEnabled and "ON" or "OFF")
	toggleBtn.BackgroundColor3 = ultraInstinctEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(80,0,0)
end)

-- Notify
local function notify(msg)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Ultra Instinct",
			Text = msg,
			Duration = 2
		})
	end)
end

-- Dodge logic
local function playDodge()
	if not canDodge then return end
	canDodge = false

	local char = lp.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	local dir = directions[currentDirection]
	if dir == "Random" then
		local options = {"Left", "Right", "Forward", "Backward"}
		dir = options[math.random(1, #options)]
	end

	local distance = tonumber(dodgeBox.Text) or 7
	local offset = Vector3.new()
	if dir == "Left" then
		offset = -hrp.CFrame.RightVector * distance
	elseif dir == "Right" then
		offset = hrp.CFrame.RightVector * distance
	elseif dir == "Forward" then
		offset = hrp.CFrame.LookVector * distance
	elseif dir == "Backward" then
		offset = -hrp.CFrame.LookVector * distance
	end

	-- Play animation
	local anim = Instance.new("Animation")
	anim.AnimationId = dodgeAnims[dir]
	local track = hum:LoadAnimation(anim)
	track:Play()

	-- Move player
	char:PivotTo(CFrame.new(hrp.Position + offset))

	-- Reset cooldown
	task.delay(2, function()
		canDodge = true
	end)
end

-- Detection
RunService.Heartbeat:Connect(function()
	local char = lp.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local radius = 25

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (plr.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
			if dist <= radius then
				local hum = plr.Character:FindFirstChildOfClass("Humanoid")
				local animator = hum and hum:FindFirstChildOfClass("Animator")
				if animator then
					for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
						local animObj = track.Animation
						if animObj and animObj.AnimationId then
							local animId = tostring(animObj.AnimationId):match("%d+")
							if animId and table.find(killerAnims, animId) then
								if tick() - lastNotifTime >= notifCooldown then
									lastNotifTime = tick()
								end
								if ultraInstinctEnabled and canDodge then
									playDodge()
								end
								return
							end
						end
					end
				end
			end
		end
	end
end)

-- Restore GUI after respawn
lp.CharacterAdded:Connect(function()
	task.wait(1)
	screenGui.Parent = lp:WaitForChild("PlayerGui")
end)
