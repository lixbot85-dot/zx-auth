-- Script :/

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local dragging = false
local rope
local selectedPart = nil
local highlightedPart = nil
local currentWeld = nil
local weldTarget = nil

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "SurvivalUI"

local ropeBtn = Instance.new("TextButton")
ropeBtn.Size = UDim2.new(0, 100, 0, 100)
ropeBtn.Position = UDim2.new(1, -120, 1, -140)
ropeBtn.AnchorPoint = Vector2.new(1, 1)
ropeBtn.Text = "Grab"
ropeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ropeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ropeBtn.TextScaled = true
ropeBtn.Font = Enum.Font.FredokaOne
ropeBtn.BorderSizePixel = 0
ropeBtn.AutoButtonColor = true
ropeBtn.Visible = false
ropeBtn.Parent = ScreenGui
Instance.new("UICorner", ropeBtn).CornerRadius = UDim.new(0.3, 0)

local weldBtn = Instance.new("TextButton")
weldBtn.Size = UDim2.new(0, 100, 0, 50)
weldBtn.Position = UDim2.new(1, -120, 1, -250)
weldBtn.AnchorPoint = Vector2.new(1, 1)
weldBtn.Text = "Weld"
weldBtn.BackgroundColor3 = Color3.fromRGB(20, 120, 80)
weldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
weldBtn.TextScaled = true
weldBtn.Font = Enum.Font.FredokaOne
weldBtn.BorderSizePixel = 0
weldBtn.AutoButtonColor = true
weldBtn.Visible = false
weldBtn.Parent = ScreenGui
Instance.new("UICorner", weldBtn).CornerRadius = UDim.new(0.3, 0)

-- THROW BUTTON
local throwBtn = Instance.new("TextButton")
throwBtn.Size = UDim2.new(0, 100, 0, 50)
throwBtn.Position = UDim2.new(1, -120, 1, -310)
throwBtn.AnchorPoint = Vector2.new(1, 1)
throwBtn.Text = "Throw"
throwBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
throwBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
throwBtn.TextScaled = true
throwBtn.Font = Enum.Font.FredokaOne
throwBtn.BorderSizePixel = 0
throwBtn.AutoButtonColor = true
throwBtn.Visible = false
throwBtn.Parent = ScreenGui
Instance.new("UICorner", throwBtn).CornerRadius = UDim.new(0.3, 0)

local grabLabel = Instance.new("TextLabel")
grabLabel.Size = UDim2.new(0, 200, 0, 30)
grabLabel.Position = UDim2.new(0.5, -100, 0.85, 0)
grabLabel.Text = ""
grabLabel.BackgroundTransparency = 1
grabLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
grabLabel.TextStrokeTransparency = 0.4
grabLabel.TextScaled = true
grabLabel.Font = Enum.Font.GothamBold
grabLabel.Parent = ScreenGui

local crosshair = Instance.new("Frame", ScreenGui)
crosshair.Size = UDim2.new(0, 20, 0, 20)
crosshair.Position = UDim2.new(0.5, -10, 0.5, -10)
crosshair.BackgroundTransparency = 1
crosshair.Name = "CoolCrosshair"

local outer = Instance.new("ImageLabel", crosshair)
outer.Size = UDim2.new(1, 0, 1, 0)
outer.Image = "rbxassetid://6031091002"
outer.ImageColor3 = Color3.fromRGB(255, 255, 255)
outer.BackgroundTransparency = 1

local dot = Instance.new("Frame", crosshair)
dot.Size = UDim2.new(0, 4, 0, 4)
dot.Position = UDim2.new(0.5, -2, 0.5, -2)
dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
dot.BorderSizePixel = 0
Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

local function getTarget(ignore)
    local cam = workspace.CurrentCamera
    local ray = Ray.new(cam.CFrame.Position, cam.CFrame.LookVector * 20)
    local part = workspace:FindPartOnRay(ray, ignore or player.Character)
    return part
end

local function clearHighlight()
    if highlightedPart then
        local glow = highlightedPart:FindFirstChild("GlowFX")
        if glow then glow:Destroy() end
        highlightedPart = nil
    end
end

local function highlightPart(part)
    if part ~= highlightedPart then
        clearHighlight()
        if part and part:IsA("BasePart") and not part.Anchored then
            local glow = Instance.new("Highlight", part)
            glow.Name = "GlowFX"
            glow.FillColor = Color3.fromRGB(255, 255, 100)
            glow.OutlineColor = Color3.fromRGB(255, 255, 255)
            glow.FillTransparency = 0.4
            glow.OutlineTransparency = 0.1
            highlightedPart = part
        end
    end
end

local function startDragging(part)
    selectedPart = part
    dragging = true
    ropeBtn.Text = "Drop"
    grabLabel.Text = "Holding: " .. part.Name
    throwBtn.Visible = true -- SHOW THROW
    clearHighlight()
end

local function stopDragging()
    selectedPart = nil
    dragging = false
    ropeBtn.Text = "Grab"
    grabLabel.Text = ""
    weldBtn.Visible = false
    throwBtn.Visible = false -- HIDE THROW
end

ropeBtn.MouseButton1Click:Connect(function()
    if not dragging then
        local part = getTarget()
        if part and part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
            startDragging(part)
        end
    else
        if currentWeld then
            currentWeld:Destroy()
            currentWeld = nil
        end
        stopDragging()
    end
end)

weldBtn.MouseButton1Click:Connect(function()
    if currentWeld then
        currentWeld:Destroy()
        currentWeld = nil
        ropeBtn.Visible = true
        weldBtn.Text = "Weld"
    else
        if selectedPart and weldTarget and not currentWeld then
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = selectedPart
            weld.Part1 = weldTarget
            weld.Parent = selectedPart
            currentWeld = weld
            stopDragging()
            ropeBtn.Visible = false
            weldBtn.Text = "Unweld"
        end
    end
end)

-- THROW FUNCTION
throwBtn.MouseButton1Click:Connect(function()
    if selectedPart then
        local cam = workspace.CurrentCamera
        selectedPart.Velocity = cam.CFrame.LookVector * 120
        stopDragging()
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and selectedPart then
        local cam = workspace.CurrentCamera
        local targetPos = cam.CFrame.Position + cam.CFrame.LookVector * 8
        selectedPart.Velocity = (targetPos - selectedPart.Position) * 5

        local target = getTarget(selectedPart)
        if target and target:IsA("BasePart") and not target.Anchored and not target:IsDescendantOf(player.Character) then
            weldBtn.Visible = true
            weldBtn.Text = currentWeld and "Unweld" or "Weld"
            weldTarget = target
        else
            weldBtn.Visible = false
            weldTarget = nil
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then return end
    local part = getTarget()
    if part and part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
        ropeBtn.Visible = true
        grabLabel.Text = "Hold to Grab: " .. part.Name
        highlightPart(part)
    else
        ropeBtn.Visible = false
        grabLabel.Text = ""
        clearHighlight()
    end
end)

print("ULTRA Grab & Weld + THROW tool ready. Credit: Rai + CreatorOfNoob. Sub or ur weld breaks.")
