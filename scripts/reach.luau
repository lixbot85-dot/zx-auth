if getgenv().SwordReach then
	pcall(function() getgenv().SwordReach:destroy() end)
end

local rng = Random.new()
local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
local function randomName(length)
	local result = {}
	for i = 1, length do
		local idx = rng:NextInteger(1, #charset)
		result[i] = string.sub(charset, idx, idx)
	end
	return table.concat(result)
end

getgenv().SwordReachConfig = getgenv().SwordReachConfig or {
	GuiName = randomName(32),
	HitboxSize = 8,
	HitboxType = "Sphere",
	Visualize = false,
	Autoclick = false,
	AutoclickDelay = 0.1,
	Enabled = false,
}

local Config = getgenv().SwordReachConfig

local function getGuiParent()
	if gethui then
		local ok, result = pcall(gethui)
		if ok and result then
			return result
		end
	end
	return cloneref(game:GetService("CoreGui"))
end

local function clonerefProxy(serviceName)
	local raw = cloneref(game:GetService(serviceName))
	return setmetatable({}, {
		__index = function(_, key)
			local val = raw[key]
			if typeof(val) == "Instance" then
				return cloneref(val)
			end
			if typeof(val) == "function" then
				return function(_, ...)
					return val(raw, ...)
				end
			end
			return val
		end,
		__newindex = function(_, key, value)
			raw[key] = value
		end,
		__tostring = function()
			return tostring(raw)
		end,
	})
end

local UserInputService = clonerefProxy("UserInputService")
local TextService = clonerefProxy("TextService")
local Players = clonerefProxy("Players")
local RunService = clonerefProxy("RunService")
local RawPlayers = cloneref(game:GetService("Players"))
local RawWorkspace = cloneref(game:GetService("Workspace"))
local LocalPlayer = cloneref(game:GetService("Players").LocalPlayer)

local HitboxType = {
	Sphere = "Sphere",
	Box = "Box",
	Capsule = "Capsule",
	Extended = "Extended",
	Circle = "Circle",
}

local CacheMethod = {
	Direct = "Direct",
	Attribute = "Attribute",
	Weld = "Weld",
	WeldWorkspace = "WeldWorkspace",
	Name = "Name",
	Proximity = "Proximity",
}

local SwordReach = {}
SwordReach.__index = SwordReach

local function FunctionRequire()
	local missing = {}
	if not firetouchinterest then table.insert(missing, "firetouchinterest") end
	if not cloneref then table.insert(missing, "cloneref") end
	if not compareinstances then table.insert(missing, "compareinstances") end
	if #missing == 0 then return true, nil end
	local msg = "[SwordReach] Missing executor functions:\n"
	for _, name in missing do
		msg = msg .. "  • " .. name .. "\n"
	end
	msg = msg .. "\nThis script requires a capable executor!"
	return false, msg
end

local function showErrorUI(message, onClose)
	local parent = getGuiParent()

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = randomName(32)
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 322
	screenGui.Parent = parent

	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	overlay.BackgroundTransparency = 0.5
	overlay.BorderSizePixel = 0
	overlay.ZIndex = 1
	overlay.Parent = screenGui

	local dialog = Instance.new("Frame")
	dialog.Size = UDim2.new(0, 360, 0, 180)
	dialog.Position = UDim2.new(0.5, -180, 0.5, -90)
	dialog.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
	dialog.BorderColor3 = Color3.fromRGB(5, 8, 10)
	dialog.BorderSizePixel = 1
	dialog.ZIndex = 2
	dialog.Parent = screenGui

	local innerBorder = Instance.new("Frame")
	innerBorder.Size = UDim2.new(1, -2, 1, -2)
	innerBorder.Position = UDim2.new(0, 1, 0, 1)
	innerBorder.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
	innerBorder.BorderColor3 = Color3.fromRGB(35, 40, 45)
	innerBorder.BorderSizePixel = 1
	innerBorder.ZIndex = 3
	innerBorder.Parent = dialog

	local topLine = Instance.new("Frame")
	topLine.Size = UDim2.new(1, 0, 0, 2)
	topLine.BackgroundColor3 = Color3.new(1, 1, 1)
	topLine.BorderSizePixel = 0
	topLine.ZIndex = 4
	topLine.Parent = innerBorder

	local topGradient = Instance.new("UIGradient")
	topGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 80, 80)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 30, 30)),
	})
	topGradient.Parent = topLine

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -16, 0, 22)
	titleLabel.Position = UDim2.new(0, 8, 0, 2)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "sword reach — error"
	titleLabel.TextColor3 = Color3.fromRGB(220, 100, 100)
	titleLabel.Font = Enum.Font.Code
	titleLabel.TextSize = 13
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.ZIndex = 4
	titleLabel.Parent = innerBorder

	local msgLabel = Instance.new("TextLabel")
	msgLabel.Size = UDim2.new(1, -24, 0, 100)
	msgLabel.Position = UDim2.new(0, 12, 0, 32)
	msgLabel.BackgroundTransparency = 1
	msgLabel.Text = message
	msgLabel.TextColor3 = Color3.fromRGB(200, 205, 210)
	msgLabel.Font = Enum.Font.Code
	msgLabel.TextSize = 12
	msgLabel.TextXAlignment = Enum.TextXAlignment.Left
	msgLabel.TextYAlignment = Enum.TextYAlignment.Top
	msgLabel.TextWrapped = true
	msgLabel.ZIndex = 4
	msgLabel.Parent = innerBorder

	local okBtn = Instance.new("TextButton")
	okBtn.Size = UDim2.new(0, 80, 0, 24)
	okBtn.Position = UDim2.new(0.5, -40, 1, -34)
	okBtn.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
	okBtn.BorderColor3 = Color3.fromRGB(35, 40, 45)
	okBtn.BorderSizePixel = 1
	okBtn.Text = "OK"
	okBtn.TextColor3 = Color3.fromRGB(0, 180, 180)
	okBtn.Font = Enum.Font.Code
	okBtn.TextSize = 13
	okBtn.ZIndex = 4
	okBtn.Parent = innerBorder

	okBtn.MouseButton1Click:Connect(function()
		pcall(function() screenGui:Destroy() end)
		if onClose then onClose() end
	end)
end

local ok, errMsg = FunctionRequire()
if not ok then
	showErrorUI(errMsg, nil)
	return
end

function SwordReach.new()
	local self = setmetatable({}, SwordReach)

	self._connections = {}
	self._visible = true
	self._visualParts = {}
	self._autoclickActive = {}
	self._autoclickThreads = {}
	self._cacheMethodLabel = nil

	self:_build()
	self:_setupToggle()
	self:_setupLoop()

	return self
end

function SwordReach:_connect(signal, fn)
	local ok2, conn = pcall(function()
		return signal:Connect(fn)
	end)
	if ok2 and conn then
		table.insert(self._connections, conn)
		return conn
	end
end

function SwordReach:_setMethodLabel(text)
	if self._cacheMethodLabel then
		pcall(function()
			self._cacheMethodLabel.Text = "Cache Method: " .. text
		end)
	end
end

function SwordReach:_findAllHandles(myChar, myTool)
	local handles = {}
	local seen = {}

	local function addHandle(part, method)
		if not part or not part:IsA("BasePart") then return end
		local id = tostring(part)
		if seen[id] then return end
		seen[id] = true
		table.insert(handles, { part = part, method = method })
	end

	local directHandle = myTool:FindFirstChild("Handle")
	addHandle(directHandle, CacheMethod.Direct)

	for _, desc in myTool:GetDescendants() do
		if desc:IsA("BasePart") then
			addHandle(desc, CacheMethod.Name)
		end
	end

	local myToolParts = {}
	for _, h in handles do
		table.insert(myToolParts, h.part)
	end

	for _, desc in RawWorkspace:GetDescendants() do
		if desc:IsA("WeldConstraint") then
			local p0, p1 = desc.Part0, desc.Part1
			for _, tp in myToolParts do
				if p0 == tp and p1 and p1:IsA("BasePart") and not p1:IsDescendantOf(myChar) and not p1:IsDescendantOf(myTool) then
					addHandle(p1, CacheMethod.WeldWorkspace)
				elseif p1 == tp and p0 and p0:IsA("BasePart") and not p0:IsDescendantOf(myChar) and not p0:IsDescendantOf(myTool) then
					addHandle(p0, CacheMethod.WeldWorkspace)
				end
			end
		elseif desc:IsA("Weld") then
			local p0, p1 = desc.Part0, desc.Part1
			for _, tp in myToolParts do
				if p0 == tp and p1 and p1:IsA("BasePart") and not p1:IsDescendantOf(myChar) and not p1:IsDescendantOf(myTool) then
					addHandle(p1, CacheMethod.WeldWorkspace)
				elseif p1 == tp and p0 and p0:IsA("BasePart") and not p0:IsDescendantOf(myChar) and not p0:IsDescendantOf(myTool) then
					addHandle(p0, CacheMethod.WeldWorkspace)
				end
			end
		end
	end

	for _, desc in RawWorkspace:GetDescendants() do
		if desc:IsA("BasePart") then
			local attr = desc:GetAttribute("player")
			if typeof(attr) == "string" and attr == LocalPlayer.Name then
				addHandle(desc, CacheMethod.Attribute)
			end
		end
	end

	return handles
end

function SwordReach:_getVictimParts(player)
	local char = player.Character
	if not char then return {} end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then return {} end

	local parts = {}
	for _, v in char:GetChildren() do
		if v:IsA("BasePart") then
			table.insert(parts, v)
		end
	end
	return parts
end

function SwordReach:_isInRange(player, handle)
	local char = player.Character
	if not char then return false end

	local htype = Config.HitboxType
	local size = Config.HitboxSize

	if htype == HitboxType.Sphere then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return false end
		return (hrp.Position - handle.Position).Magnitude <= size

	elseif htype == HitboxType.Box then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return false end
		local localPos = handle.CFrame:PointToObjectSpace(hrp.Position)
		local half = size / 2
		return math.abs(localPos.X) <= half
			and math.abs(localPos.Y) <= half
			and math.abs(localPos.Z) <= half

	elseif htype == HitboxType.Capsule then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return false end
		local delta = hrp.Position - handle.Position
		local axisY = handle.CFrame.UpVector
		local proj = delta:Dot(axisY)
		local clamped = math.clamp(proj, -size, size)
		local closest = handle.Position + axisY * clamped
		return (hrp.Position - closest).Magnitude <= size

	elseif htype == HitboxType.Extended then
		local boneNames = { "Head", "UpperTorso", "Torso", "LowerTorso", "HumanoidRootPart" }
		for _, name in boneNames do
			local part = char:FindFirstChild(name)
			if part and part:IsA("BasePart") then
				if (part.Position - handle.Position).Magnitude <= size then
					return true
				end
			end
		end
		return false

	elseif htype == HitboxType.Circle then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return false end
		local delta = hrp.Position - handle.Position
		local flat = Vector3.new(delta.X, 0, delta.Z)
		return flat.Magnitude <= size
	end

	return false
end

function SwordReach:_fireTouchAllHandles(player, handles)
	local victimParts = self:_getVictimParts(player)
	if #victimParts == 0 then return end

	for _, entry in handles do
		local handle = entry.part
		if not handle or not handle.Parent then continue end

		for _, part in victimParts do
			pcall(function()
				firetouchinterest(part, handle, 0)
				firetouchinterest(part, handle, 1)
			end)
		end
	end
end

function SwordReach:_updateVisualParts(handles)
	local activeKeys = {}

	if not Config.Visualize then
		for _, vp in pairs(self._visualParts) do
			if typeof(vp) == "Instance" and vp.Parent then
				vp.Parent = nil
			end
		end
		return
	end

	for _, entry in handles do
		local handle = entry.part
		if not handle or not handle.Parent then continue end

		local key = tostring(handle)
		activeKeys[key] = true

		local existing = self._visualParts[key]
		if not existing or not existing.Parent then
			local part = Instance.new("Part")
			part.Anchored = true
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			part.CastShadow = false
			part.Massless = true
			part.Material = Enum.Material.Neon
			part.Transparency = 0.55
			part.TopSurface = Enum.SurfaceType.Smooth
			part.BottomSurface = Enum.SurfaceType.Smooth

			if entry.method == CacheMethod.WeldWorkspace or entry.method == CacheMethod.Attribute then
				part.BrickColor = BrickColor.new("Bright orange")
			else
				part.BrickColor = BrickColor.new("Cyan")
			end

			self._visualParts[key] = part
			existing = part
		end

		local size = Config.HitboxSize
		local htype = Config.HitboxType

		if htype == HitboxType.Sphere then
			existing.Shape = Enum.PartType.Ball
			existing.Size = Vector3.new(size * 2, size * 2, size * 2)
			existing.CFrame = handle.CFrame
		elseif htype == HitboxType.Box then
			existing.Shape = Enum.PartType.Block
			existing.Size = Vector3.new(size, size, size)
			existing.CFrame = handle.CFrame
		elseif htype == HitboxType.Capsule then
			existing.Shape = Enum.PartType.Cylinder
			existing.Size = Vector3.new(size * 2, size * 2, size * 2)
			existing.CFrame = handle.CFrame * CFrame.Angles(0, 0, math.pi / 2)
		elseif htype == HitboxType.Extended then
			existing.Shape = Enum.PartType.Block
			existing.Size = Vector3.new(size * 2, size * 3, size * 2)
			existing.CFrame = handle.CFrame
		elseif htype == HitboxType.Circle then
			existing.Shape = Enum.PartType.Cylinder
			existing.Size = Vector3.new(0.3, size * 2, size * 2)
			existing.CFrame = CFrame.new(handle.Position) * CFrame.Angles(0, 0, math.pi / 2)
		end

		existing.Parent = RawWorkspace
	end

	for key, vp in pairs(self._visualParts) do
		if not activeKeys[key] then
			if typeof(vp) == "Instance" and vp.Parent then
				vp.Parent = nil
			end
		end
	end
end

function SwordReach:_hideAllVisuals()
	for _, vp in pairs(self._visualParts) do
		if typeof(vp) == "Instance" and vp.Parent then
			vp.Parent = nil
		end
	end
end

function SwordReach:_destroyAllVisuals()
	for key, vp in pairs(self._visualParts) do
		if typeof(vp) == "Instance" then
			pcall(function() vp:Destroy() end)
		end
		self._visualParts[key] = nil
	end
end

function SwordReach:_startAutoclick(player)
	if self._autoclickActive[player] then return end
	self._autoclickActive[player] = true

	local thread = task.spawn(function()
		while self._autoclickActive[player] do
			if not Config.Enabled or not Config.Autoclick then break end
			pcall(function()
				mouse1press()
				task.wait(0.03)
				mouse1release()
			end)
			task.wait(math.max(Config.AutoclickDelay, 0.05))
		end
		self._autoclickActive[player] = false
	end)

	self._autoclickThreads[player] = thread
end

function SwordReach:_stopAutoclick(player)
	self._autoclickActive[player] = false
	local thread = self._autoclickThreads[player]
	if thread then
		pcall(function() task.cancel(thread) end)
		self._autoclickThreads[player] = nil
	end
end

function SwordReach:_setupLoop()
	self:_connect(RunService.RenderStepped, function()
		if not Config.Enabled then
			for _, player in RawPlayers:GetPlayers() do
				self:_stopAutoclick(player)
			end
			self:_hideAllVisuals()
			self:_setMethodLabel("—")
			return
		end

		local myChar = LocalPlayer.Character
		local myTool = myChar and myChar:FindFirstChildOfClass("Tool")

		if not myTool then
			for _, player in RawPlayers:GetPlayers() do
				self:_stopAutoclick(player)
			end
			self:_hideAllVisuals()
			self:_setMethodLabel("—")
			return
		end

		local handles = self:_findAllHandles(myChar, myTool)

		if #handles == 0 then
			for _, player in RawPlayers:GetPlayers() do
				self:_stopAutoclick(player)
			end
			self:_hideAllVisuals()
			self:_setMethodLabel("—")
			return
		end

		local methodSeen = {}
		local methodNames = {}
		for _, entry in handles do
			if not methodSeen[entry.method] then
				methodSeen[entry.method] = true
				table.insert(methodNames, entry.method)
			end
		end
		self:_setMethodLabel(table.concat(methodNames, " + "))

		self:_updateVisualParts(handles)

		for _, player in RawPlayers:GetPlayers() do
			if compareinstances(player, LocalPlayer) then continue end

			local char = player.Character
			if not char then
				self:_stopAutoclick(player)
				continue
			end

			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hum or hum.Health <= 0 then
				self:_stopAutoclick(player)
				continue
			end

			local inRange = false
			for _, entry in handles do
				if entry.part and entry.part.Parent and self:_isInRange(player, entry.part) then
					inRange = true
					break
				end
			end

			if inRange then
				self:_fireTouchAllHandles(player, handles)
				if Config.Autoclick then
					self:_startAutoclick(player)
				end
			else
				if not Config.Autoclick then
					self:_stopAutoclick(player)
				end
			end

			if not Config.Autoclick then
				self:_stopAutoclick(player)
			end
		end
	end)

	self:_connect(RawPlayers.PlayerRemoving, function(player)
		self:_stopAutoclick(player)
	end)
end

function SwordReach:_build()
	self._screenGui = Instance.new("ScreenGui")
	self._screenGui.Name = Config.GuiName
	self._screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	self._screenGui.ResetOnSpawn = false
	self._screenGui.Parent = getGuiParent()

	self._mainFrame = Instance.new("Frame")
	self._mainFrame.Size = UDim2.new(0, 340, 0, 360)
	self._mainFrame.Position = UDim2.new(0.5, -170, 0.5, -180)
	self._mainFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
	self._mainFrame.BorderColor3 = Color3.fromRGB(5, 8, 10)
	self._mainFrame.BorderSizePixel = 1
	self._mainFrame.Active = true
	self._mainFrame.Parent = self._screenGui

	self._innerBorder = Instance.new("Frame")
	self._innerBorder.Size = UDim2.new(1, -2, 1, -2)
	self._innerBorder.Position = UDim2.new(0, 1, 0, 1)
	self._innerBorder.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
	self._innerBorder.BorderColor3 = Color3.fromRGB(35, 40, 45)
	self._innerBorder.BorderSizePixel = 1
	self._innerBorder.ClipsDescendants = true
	self._innerBorder.Parent = self._mainFrame

	self:_buildTopLine()
	self:_buildTitle()
	self:_buildDrag()
	self:_buildContent()
end

function SwordReach:_buildTopLine()
	local topLine = Instance.new("Frame")
	topLine.Size = UDim2.new(1, 0, 0, 2)
	topLine.BackgroundColor3 = Color3.new(1, 1, 1)
	topLine.BorderSizePixel = 0
	topLine.Parent = self._innerBorder

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 200)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 180, 180)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 150)),
	})
	gradient.Parent = topLine
end

function SwordReach:_buildTitle()
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -16, 0, 22)
	title.Position = UDim2.new(0, 8, 0, 2)
	title.BackgroundTransparency = 1
	title.Text = "sword reach"
	title.TextColor3 = Color3.fromRGB(220, 225, 230)
	title.Font = Enum.Font.Code
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = self._innerBorder
end

function SwordReach:_buildDrag()
	local dragging = false
	local dragStart, startPos

	self:_connect(self._mainFrame.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = self._mainFrame.Position
			local c
			c = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					if c then c:Disconnect() end
				end
			end)
		end
	end)

	self:_connect(UserInputService.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			local delta = input.Position - dragStart
			self._mainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

function SwordReach:_buildContent()
	local contentFrame = Instance.new("Frame")
	contentFrame.Size = UDim2.new(1, -16, 1, -30)
	contentFrame.Position = UDim2.new(0, 8, 0, 26)
	contentFrame.BackgroundTransparency = 1
	contentFrame.ClipsDescendants = false
	contentFrame.Parent = self._innerBorder

	local leftCol = Instance.new("Frame")
	leftCol.Size = UDim2.new(0.5, -4, 1, 0)
	leftCol.BackgroundTransparency = 1
	leftCol.ClipsDescendants = false
	leftCol.Parent = contentFrame

	local leftLayout = Instance.new("UIListLayout")
	leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
	leftLayout.Padding = UDim.new(0, 8)
	leftLayout.Parent = leftCol

	local rightCol = Instance.new("Frame")
	rightCol.Size = UDim2.new(0.5, -4, 1, 0)
	rightCol.Position = UDim2.new(0.5, 4, 0, 0)
	rightCol.BackgroundTransparency = 1
	rightCol.ClipsDescendants = false
	rightCol.Parent = contentFrame

	local rightLayout = Instance.new("UIListLayout")
	rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
	rightLayout.Padding = UDim.new(0, 8)
	rightLayout.Parent = rightCol

	local mainGB = self:_createGroupbox(leftCol, "Reach", UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 0))
	mainGB.AutomaticSize = Enum.AutomaticSize.Y

	self:_createCheckbox(mainGB, "Enabled", Config.Enabled, function(v)
		Config.Enabled = v
		if not v then
			for _, player in RawPlayers:GetPlayers() do
				self:_stopAutoclick(player)
			end
			self:_hideAllVisuals()
			self:_setMethodLabel("—")
		end
	end)

	self:_createSlider(mainGB, "Hitbox Size", 1, 30, Config.HitboxSize, function(v)
		Config.HitboxSize = v
	end, "")

	self:_createDropdown(mainGB, "Hitbox Type", {
		HitboxType.Sphere,
		HitboxType.Box,
		HitboxType.Capsule,
		HitboxType.Extended,
		HitboxType.Circle,
	}, Config.HitboxType, function(v)
		Config.HitboxType = v
	end)

	self:_createCheckbox(mainGB, "Autoclick", Config.Autoclick, function(v)
		Config.Autoclick = v
		if not v then
			for player in pairs(self._autoclickActive) do
				self:_stopAutoclick(player)
			end
		end
	end)

	self:_createSlider(mainGB, "Click Delay", 5, 100, math.floor(Config.AutoclickDelay * 100), function(v)
		Config.AutoclickDelay = v / 100
	end, "")

	local infoGB = self:_createGroupbox(rightCol, "Info", UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 0))
	infoGB.AutomaticSize = Enum.AutomaticSize.Y

	local methodLabel = self:_createInfoLabel(infoGB, "Cache Method: —")
	self._cacheMethodLabel = methodLabel

	self:_createSeparator(infoGB)
	self:_createInfoLabel(infoGB, "F5 — Toggle UI")
	self:_createInfoLabel(infoGB, "Universal for .Touched!")
	self:_createSeparator(infoGB)

	local playerCountLabel = self:_createInfoLabel(infoGB, "Players: " .. tostring(#RawPlayers:GetPlayers()))

	self:_connect(RawPlayers.PlayerAdded, function()
		pcall(function()
			playerCountLabel.Text = "Players: " .. tostring(#RawPlayers:GetPlayers())
		end)
	end)

	self:_connect(RawPlayers.PlayerRemoving, function()
		task.defer(function()
			pcall(function()
				playerCountLabel.Text = "Players: " .. tostring(#RawPlayers:GetPlayers())
			end)
		end)
	end)

	local visualGB = self:_createGroupbox(rightCol, "Visualizer", UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 0))
	visualGB.AutomaticSize = Enum.AutomaticSize.Y

	self:_createCheckbox(visualGB, "Visualize Hitbox", Config.Visualize, function(v)
		Config.Visualize = v
		if not v then
			self:_hideAllVisuals()
		end
	end)

	self:_createSeparator(visualGB)

	local warnFrame = Instance.new("Frame")
	warnFrame.Size = UDim2.new(1, 0, 0, 88)
	warnFrame.BackgroundTransparency = 1
	warnFrame.ClipsDescendants = true
	warnFrame.Parent = visualGB

	local warnLayout = Instance.new("UIListLayout")
	warnLayout.SortOrder = Enum.SortOrder.LayoutOrder
	warnLayout.Padding = UDim.new(0, 2)
	warnLayout.Parent = warnFrame

	local warnLines = {
		{ "⚠ Creates a real Instance", Color3.fromRGB(255, 180, 50) },
		{ "in Workspace to display", Color3.fromRGB(255, 180, 50) },
		{ "hitbox bounds. Easily", Color3.fromRGB(255, 180, 50) },
		{ "detected by anti-tamper", Color3.fromRGB(255, 180, 50) },
		{ "solutions.", Color3.fromRGB(255, 180, 50) },
		{ "Not recommended.", Color3.fromRGB(255, 100, 100) },
	}

	for _, line in warnLines do
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, 0, 0, 13)
		lbl.BackgroundTransparency = 1
		lbl.Text = line[1]
		lbl.TextColor3 = line[2]
		lbl.Font = Enum.Font.Code
		lbl.TextSize = 11
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.TextWrapped = false
		lbl.Parent = warnFrame
	end
end

function SwordReach:_createGroupbox(parent, title, pos, size)
	local groupbox = Instance.new("Frame")
	groupbox.Size = size
	groupbox.Position = pos
	groupbox.BackgroundColor3 = Color3.fromRGB(18, 21, 25)
	groupbox.BorderColor3 = Color3.fromRGB(35, 40, 45)
	groupbox.BorderSizePixel = 1
	groupbox.ClipsDescendants = false
	groupbox.Parent = parent

	local textBounds = TextService:GetTextSize(
		" " .. title .. " ", 13, Enum.Font.Code, Vector2.new(999, 999)
	)

	local labelBg = Instance.new("Frame")
	labelBg.Size = UDim2.new(0, textBounds.X + 4, 0, 14)
	labelBg.Position = UDim2.new(0, 8, 0, -7)
	labelBg.BackgroundColor3 = Color3.fromRGB(18, 21, 25)
	labelBg.BorderSizePixel = 0
	labelBg.ZIndex = 3
	labelBg.Parent = groupbox

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = " " .. title .. " "
	label.TextColor3 = Color3.fromRGB(180, 190, 200)
	label.Font = Enum.Font.Code
	label.TextSize = 13
	label.ZIndex = 4
	label.Parent = labelBg

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 6)
	layout.Parent = groupbox

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 14)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.Parent = groupbox

	return groupbox
end

function SwordReach:_createCheckbox(parent, text, state, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 16)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local box = Instance.new("Frame")
	box.Size = UDim2.new(0, 12, 0, 12)
	box.Position = UDim2.new(0, 0, 0.5, -6)
	box.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
	box.BorderColor3 = Color3.fromRGB(5, 8, 10)
	box.BorderSizePixel = 1
	box.Parent = frame

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(1, -2, 1, -2)
	fill.Position = UDim2.new(0, 1, 0, 1)
	fill.BackgroundColor3 = Color3.fromRGB(0, 180, 180)
	fill.BorderSizePixel = 0
	fill.Visible = state
	fill.Parent = box

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -20, 1, 0)
	lbl.Position = UDim2.new(0, 20, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(210, 215, 220)
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 13
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = frame

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 1, 0)
	btn.BackgroundTransparency = 1
	btn.Text = ""
	btn.Parent = frame

	local currentState = state
	self:_connect(btn.MouseButton1Click, function()
		currentState = not currentState
		fill.Visible = currentState
		if callback then callback(currentState) end
	end)

	return frame
end

function SwordReach:_createSlider(parent, text, min, max, default, callback, suffix)
	suffix = suffix or ""
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 28)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 14)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(210, 215, 220)
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 13
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = frame

	local valLabel = Instance.new("TextLabel")
	valLabel.Size = UDim2.new(1, 0, 0, 14)
	valLabel.BackgroundTransparency = 1
	valLabel.Text = tostring(default) .. suffix
	valLabel.TextColor3 = Color3.fromRGB(130, 140, 150)
	valLabel.Font = Enum.Font.Code
	valLabel.TextSize = 13
	valLabel.TextXAlignment = Enum.TextXAlignment.Right
	valLabel.Parent = frame

	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(1, 0, 0, 6)
	barBg.Position = UDim2.new(0, 0, 0, 20)
	barBg.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
	barBg.BorderColor3 = Color3.fromRGB(5, 8, 10)
	barBg.BorderSizePixel = 1
	barBg.Parent = frame

	local scale = (default - min) / (max - min)
	local fillBar = Instance.new("Frame")
	fillBar.Size = UDim2.new(scale, 0, 1, 0)
	fillBar.BackgroundColor3 = Color3.fromRGB(0, 180, 180)
	fillBar.BorderSizePixel = 0
	fillBar.Parent = barBg

	local sliderBtn = Instance.new("TextButton")
	sliderBtn.Size = UDim2.new(1, 0, 1, 0)
	sliderBtn.BackgroundTransparency = 1
	sliderBtn.Text = ""
	sliderBtn.Parent = barBg

	local sliding = false

	local function update(input)
		local rel = math.clamp(
			(input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X,
			0, 1
		)
		local val = math.floor(min + (max - min) * rel + 0.5)
		fillBar.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
		valLabel.Text = tostring(val) .. suffix
		if callback then callback(val) end
	end

	self:_connect(sliderBtn.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			sliding = true
			update(input)
		end
	end)

	self:_connect(UserInputService.InputChanged, function(input)
		if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)

	self:_connect(UserInputService.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			sliding = false
		end
	end)

	return frame
end

function SwordReach:_createDropdown(parent, text, options, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 40)
	frame.BackgroundTransparency = 1
	frame.ClipsDescendants = false
	frame.ZIndex = 6
	frame.Parent = parent

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 14)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(210, 215, 220)
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 13
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 6
	lbl.Parent = frame

	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, 0, 0, 20)
	box.Position = UDim2.new(0, 0, 0, 18)
	box.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
	box.BorderColor3 = Color3.fromRGB(5, 8, 10)
	box.BorderSizePixel = 1
	box.ClipsDescendants = false
	box.ZIndex = 6
	box.Parent = frame

	local selLabel = Instance.new("TextLabel")
	selLabel.Size = UDim2.new(1, -22, 1, 0)
	selLabel.Position = UDim2.new(0, 6, 0, 0)
	selLabel.BackgroundTransparency = 1
	selLabel.Text = default
	selLabel.TextColor3 = Color3.fromRGB(210, 215, 220)
	selLabel.Font = Enum.Font.Code
	selLabel.TextSize = 13
	selLabel.TextXAlignment = Enum.TextXAlignment.Left
	selLabel.ZIndex = 7
	selLabel.Parent = box

	local arrowFrame = Instance.new("Frame")
	arrowFrame.Size = UDim2.new(0, 18, 1, 0)
	arrowFrame.Position = UDim2.new(1, -18, 0, 0)
	arrowFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 45)
	arrowFrame.BorderSizePixel = 0
	arrowFrame.ZIndex = 7
	arrowFrame.Parent = box

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(1, 0, 1, 0)
	arrow.BackgroundTransparency = 1
	arrow.Text = "+"
	arrow.TextColor3 = Color3.fromRGB(180, 190, 200)
	arrow.Font = Enum.Font.Code
	arrow.TextSize = 14
	arrow.ZIndex = 8
	arrow.Parent = arrowFrame

	local maxVisible = math.min(#options, 5)
	local listHeight = maxVisible * 20

	local dropScroll = Instance.new("ScrollingFrame")
	dropScroll.Size = UDim2.new(1, 0, 0, listHeight)
	dropScroll.Position = UDim2.new(0, 0, 1, 1)
	dropScroll.BackgroundColor3 = Color3.fromRGB(20, 23, 27)
	dropScroll.BorderColor3 = Color3.fromRGB(35, 40, 45)
	dropScroll.BorderSizePixel = 1
	dropScroll.Visible = false
	dropScroll.ZIndex = 50
	dropScroll.ClipsDescendants = true
	dropScroll.ScrollBarThickness = 3
	dropScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 180)
	dropScroll.CanvasSize = UDim2.new(0, 0, 0, #options * 20)
	dropScroll.AutomaticCanvasSize = Enum.AutomaticSize.None
	dropScroll.Parent = box

	local dropLayout = Instance.new("UIListLayout")
	dropLayout.SortOrder = Enum.SortOrder.LayoutOrder
	dropLayout.Parent = dropScroll

	local opened = false

	for _, opt in options do
		local optBtn = Instance.new("TextButton")
		optBtn.Size = UDim2.new(1, 0, 0, 20)
		optBtn.BackgroundColor3 = Color3.fromRGB(20, 23, 27)
		optBtn.BorderSizePixel = 0
		optBtn.Text = "  " .. opt
		optBtn.TextColor3 = Color3.fromRGB(190, 195, 200)
		optBtn.Font = Enum.Font.Code
		optBtn.TextSize = 12
		optBtn.TextXAlignment = Enum.TextXAlignment.Left
		optBtn.ZIndex = 51
		optBtn.Parent = dropScroll

		self:_connect(optBtn.MouseButton1Click, function()
			selLabel.Text = opt
			dropScroll.Visible = false
			opened = false
			arrow.Text = "+"
			if callback then callback(opt) end
		end)

		self:_connect(optBtn.MouseEnter, function()
			optBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 40)
		end)
		self:_connect(optBtn.MouseLeave, function()
			optBtn.BackgroundColor3 = Color3.fromRGB(20, 23, 27)
		end)
	end

	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Size = UDim2.new(1, 0, 1, 0)
	toggleBtn.BackgroundTransparency = 1
	toggleBtn.Text = ""
	toggleBtn.ZIndex = 8
	toggleBtn.Parent = box

	self:_connect(toggleBtn.MouseButton1Click, function()
		opened = not opened
		dropScroll.Visible = opened
		arrow.Text = opened and "-" or "+"
	end)

	return frame
end

function SwordReach:_createSeparator(parent)
	local sep = Instance.new("Frame")
	sep.Size = UDim2.new(1, 0, 0, 1)
	sep.BackgroundColor3 = Color3.fromRGB(35, 40, 45)
	sep.BorderSizePixel = 0
	sep.Parent = parent
	return sep
end

function SwordReach:_createInfoLabel(parent, text)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 14)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(150, 160, 170)
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = parent
	return lbl
end

function SwordReach:_setupToggle()
	self:_connect(UserInputService.InputBegan, function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.F5 then
			self._visible = not self._visible
			self._screenGui.Enabled = self._visible
		end
	end)
end

function SwordReach:destroy()
	for _, conn in self._connections do
		pcall(function() conn:Disconnect() end)
	end

	for player in pairs(self._autoclickActive) do
		self:_stopAutoclick(player)
	end

	self:_destroyAllVisuals()
	pcall(function() self._screenGui:Destroy() end)

	self._connections = {}
	self._visualParts = {}
	self._autoclickActive = {}
	self._autoclickThreads = {}
end

local instance = SwordReach.new()
getgenv().SwordReach = instance
