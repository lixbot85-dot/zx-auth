--Enjoy using this script / Kobayashi Yumiko
--This script cannot be turn off and will always be active until you leave.
print("[ ZX ] loading staminaviewer.lua")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

--Configuration
local THRESHOLD = 0.30 -- 30%
local GUI_NAME = "StaminaScreen_OPT"

local staminaValue
local ratio = 1
local currentText = "0/100"

local screenGui, textLabel, vignette
local renderConn, textConn

local targetTextTrans = 1
local targetVigTrans = 1
local curTextTrans = 1
local curVigTrans = 1

local flickState = false
local flickTimer = 0

local zeroCooldown = 0

local function clamp(x, a, b)
	return (x < a and a) or (x > b and b) or x
end

local function parseRatioFromText(text)
	local cur, tot = string.match(text, "(%d+)%s*/%s*(%d+)")
	cur = tonumber(cur) or 0
	tot = tonumber(tot) or 100
	if tot <= 0 then tot = 100 end
	return clamp(cur / tot, 0, 1), cur, tot
end

local function getOrCreateGui()
	local pg = player:WaitForChild("PlayerGui")

	screenGui = pg:FindFirstChild(GUI_NAME)
	if not screenGui then
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = GUI_NAME
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.Parent = pg
	end

	textLabel = screenGui:FindFirstChild("StaminaText")
	if not textLabel then
		textLabel = Instance.new("TextLabel")
		textLabel.Name = "StaminaText"
		textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		textLabel.Position = UDim2.new(0.5, 0, 0.58, 0)
		textLabel.Size = UDim2.new(1.5, 0, 1.5, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextTransparency = 1
		textLabel.Font = Enum.Font.GothamBlack
		textLabel.TextScaled = true
		textLabel.Text = ""
		textLabel.ZIndex = 3
		textLabel.TextStrokeTransparency = 0.8
		textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
		textLabel.Parent = screenGui
	end

	vignette = screenGui:FindFirstChild("Vignette")
	if not vignette then
		vignette = Instance.new("ImageLabel")
		vignette.Name = "Vignette"
		vignette.Size = UDim2.new(1, 0, 1, 0)
		vignette.Position = UDim2.new(0, 0, 0, 0)
		vignette.BackgroundTransparency = 1
		vignette.Image = "rbxassetid://3156051342"
		vignette.ImageTransparency = 1
		vignette.ScaleType = Enum.ScaleType.Fit
		vignette.ZIndex = 2
		vignette.Parent = screenGui
	end
end

local function findStaminaAmount()
	local pg = player:WaitForChild("PlayerGui", 10)
	if not pg then return nil end

	local tmp = pg:FindFirstChild("TemporaryUI")
	if not tmp then return nil end
	local info = tmp:FindFirstChild("PlayerInfo")
	if not info then return nil end
	local bars = info:FindFirstChild("Bars")
	if not bars then return nil end
	local stamina = bars:FindFirstChild("Stamina")
	if not stamina then return nil end
	local amount = stamina:FindFirstChild("Amount")
	return amount
end

local function disconnectAll()
	if textConn then textConn:Disconnect(); textConn = nil end
	if renderConn then renderConn:Disconnect(); renderConn = nil end
end

local function connectTextWatcher()
	if textConn then textConn:Disconnect() end
	if not staminaValue then return end

	textConn = staminaValue:GetPropertyChangedSignal("Text"):Connect(function()
		currentText = staminaValue.Text or "0/100"
		ratio = parseRatioFromText(currentText)
	end)

	currentText = staminaValue.Text or "0/100"
	ratio = parseRatioFromText(currentText)
end

local function ensureRenderLoop()
	if renderConn then return end

	renderConn = RunService.RenderStepped:Connect(function(dt)
		local k = 14
		curTextTrans = curTextTrans + (targetTextTrans - curTextTrans) * clamp(dt * k, 0, 1)
		curVigTrans  = curVigTrans  + (targetVigTrans  - curVigTrans)  * clamp(dt * k, 0, 1)

		textLabel.TextTransparency = curTextTrans
		vignette.ImageTransparency = curVigTrans

		textLabel.Text = currentText

		if ratio > THRESHOLD then
			textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			textLabel.Position = UDim2.new(0.5, 0, 0.58, 0)
			flickTimer = 0
			return
		end

		local strength = 1 - (ratio / THRESHOLD)

		targetTextTrans = 1 - (0.9 * strength)
		targetVigTrans  = 1 - (0.9 * strength)

		local _, cur = parseRatioFromText(currentText)
		zeroCooldown = math.max(0, zeroCooldown - dt)
		if cur == 0 and zeroCooldown == 0 then
			zeroCooldown = 1.0
			textLabel.Text = "NO STAMINA" --Configurable
			currentText = textLabel.Text
		end

		local flickInterval = clamp((ratio ^ 2.2) * 0.25, 0.03, 0.25)
		flickTimer += dt
		if flickTimer >= flickInterval then
			flickTimer = 0
			flickState = not flickState
			textLabel.TextColor3 = flickState and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(255, 255, 255)
		end


		local baseCFrame = camera.CFrame

		local intensity = 0.15 + 0.5 * strength
		local offsetX = (math.random() - 0.5) * intensity
		local offsetY = (math.random() - 0.5) * intensity

		camera.CFrame = baseCFrame * CFrame.new(offsetX, offsetY, 0)

		textLabel.Position = UDim2.new(
			0.5, math.random(-10 * strength, 10 * strength),
			0.58, math.random(-10 * strength, 10 * strength)
		)
	end)
end

local function startDefaultOn()
	disconnectAll()
	getOrCreateGui()

	targetTextTrans, targetVigTrans = 1, 1
	curTextTrans, curVigTrans = 1, 1
	textLabel.TextTransparency = 1
	vignette.ImageTransparency = 1
	textLabel.Text = ""

	staminaValue = findStaminaAmount()
	if not staminaValue then
		task.spawn(function()
			for _ = 1, 30 do
				task.wait(0.25)
				staminaValue = findStaminaAmount()
				if staminaValue then
					connectTextWatcher()
					ensureRenderLoop()
					return
				end
			end
		end)
		return
	end

	connectTextWatcher()
	ensureRenderLoop()
end

startDefaultOn()

player.CharacterAdded:Connect(function()
	task.wait(1)
	startDefaultOn()
end)
print("[ ZX ] loaded")
