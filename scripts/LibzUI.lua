--[[ 
    LIBZ UI FRAMEWORK
    Lightweight Roblox UI Library
    by you + refactor
]]

local LIBZ = {}
LIBZ.Windows = {}

-- Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- =========================
-- UTILS
-- =========================
local function tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- =========================
-- WINDOW CLASS
-- =========================
local Window = {}
Window.__index = Window

function Window:AddButton(name, icon, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Text = (icon and (icon .. " ") or "") .. name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = self.Container

    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)

    return btn
end

function Window:AddToggle(name, icon, callback)
    local state = false

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.Text = (icon and (icon .. " ") or "") .. name .. " [OFF]"
    btn.Parent = self.Container

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = (icon and (icon .. " ") or "") .. name .. (state and " [ON]" or " [OFF]")
        pcall(callback, state)
    end)

    return btn
end

function Window:AddSlider(name, icon, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(45,45,45)
    frame.Parent = self.Container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.5, 0)
    label.Text = (icon and (icon .. " ") or "") .. name
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
    label.Parent = frame

    local bar = Instance.new("TextButton")
    bar.Size = UDim2.new(1, -10, 0.4, 0)
    bar.Position = UDim2.new(0,5,0.5,0)
    bar.Text = ""
    bar.BackgroundColor3 = Color3.fromRGB(70,70,70)
    bar.Parent = frame

    local value = 0

    bar.MouseButton1Down:Connect(function()
        local conn
        conn = game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local x = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                value = math.floor(x * 100)
                pcall(callback, value)
            end
        end)

        game:GetService("UserInputService").InputEnded:Connect(function()
            if conn then conn:Disconnect() end
        end)
    end)

    return frame
end

-- =========================
-- LIB API
-- =========================
function LIBZ.AddNewWindow(name, icon)
    local self = setmetatable({}, Window)

    local gui = Instance.new("ScreenGui")
    gui.Name = "LIBZ_UI"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 300, 0, 400)
    main.Position = UDim2.new(0.3,0,0.3,0)
    main.BackgroundColor3 = Color3.fromRGB(30,30,30)
    main.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,40)
    title.Text = (icon and (icon .. " ") or "") .. name
    title.TextColor3 = Color3.fromRGB(0,255,150)
    title.BackgroundTransparency = 1
    title.Parent = main

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 1, -50)
    container.Position = UDim2.new(0,5,0,45)
    container.BackgroundTransparency = 1
    container.Parent = main

    self.Gui = gui
    self.Main = main
    self.Container = container

    table.insert(LIBZ.Windows, self)

    return self
end

-- =========================
-- RETURN LIB
-- =========================
return LIBZ
