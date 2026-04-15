local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Mobile%20Friendly%20Orion')))()

local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()

local window = DrRayLibrary:Load("ZX hub lite", "Default")

local tab = DrRayLibrary.newTab("Main", "ImageIdHere")

tab.newButton("give Coca-Cola", "Gives you Coca-Cola", function()
    last_pick_sin_mrazy = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-23, 52, -57)
task.wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local actionRadius = 2

game:GetService("CoreGui").PurchasePrompt.Enabled = false

for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ClickDetector") then
        local objectPosition = v.Parent.Position
        local playerPosition = humanoidRootPart.Position
        local distance = (objectPosition - playerPosition).magnitude 

        if distance <= actionRadius then
            fireclickdetector(v)
        end
    end
end
task.wait(0.1)
for i = 1, 10 do
    wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-25, 56, -58)
end
task.wait(0.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-25, 50, -58)
task.wait(0.1)
game. Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pick_sin_mrazy
end)

tab.newButton("Spam Cola", "Spawns cola in the place where you clicked", function()
    local LP = game.Players.LocalPlayer
repeat wait() until LP.Character
for i,v in pairs(LP.Backpack:GetChildren()) do
   if v.Name == "cola v7" then
       v.Parent = LP.Character
   end
end

while true do
wait(0.1)
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local clickPosition = mouse.Hit.Position

local args = {
    [1] = CFrame.new(clickPosition),
    [2] = Vector3.new(clickPosition),
    [3] = false
}

game:GetService("Players").LocalPlayer.Character:FindFirstChild("cola v7").SpawnGrenade:FireServer(unpack(args))
end
end)

tab.newInput("Make Cola's", "Creates a number of Cola's under the local player", function(text)
    local LP = game.Players.LocalPlayer
repeat wait() until LP.Character
for i,v in pairs(LP.Backpack:GetChildren()) do
   if v.Name == "cola v7" then
       v.Parent = LP.Character
   end
end

for i = 1, text do
local args = {
    [1] = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position),
    [2] = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position),
    [3] = false
}

game:GetService("Players").LocalPlayer.Character:FindFirstChild("cola v7").SpawnGrenade:FireServer(unpack(args))
end
end)

tab.newInput("Explode player", "Spawns a lot of Coca-Cola at a specific player's location", function(text)
    local LP = game.Players.LocalPlayer
repeat wait() until LP.Character
for i,v in pairs(LP.Backpack:GetChildren()) do
   if v.Name == "cola v7" then
       v.Parent = LP.Character
   end
end

    for i = 1, 100 do
local Players = game:GetService("Players")
local TargetPlayerName = text

local args = {
    [1] = CFrame.new(),
    [2] = Vector3.new(),
    [3] = false
}

for _, player in pairs(Players:GetPlayers()) do
    if string.find(player.Name, TargetPlayerName) then
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                args[1] = CFrame.new(humanoidRootPart.Position)
                args[2] = humanoidRootPart.Position
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("cola v7").SpawnGrenade:FireServer(unpack(args))
            end
        end
    end
end
end
end)

tab.newButton("Anti reclining", "You don't get distracted by explosions", function()
    local plr = game.Players.LocalPlayer
local char = plr.Character
  for _, child in pairs(char:GetChildren()) do
    if child:IsA("BasePart") then
      child.Massless = false
      child.CustomPhysicalProperties = PhysicalProperties.new(math.huge, math.huge, math.huge) 
    end
  end
end)

tab.newDropdown("Nuke server", "Spawns cola in a place where other players are", {"Nuke server", "Nuke server v2"}, function(selectedOption)
    if selectedOption == "Nuke server" then

local LP = game.Players.LocalPlayer
repeat wait() until LP.Character
for i,v in pairs(LP.Backpack:GetChildren()) do
   if v.Name == "cola v7" then
       v.Parent = LP.Character
   end
end

	while true do
wait(0.1)
local Players = game:GetService("Players")

local args = {
    [1] = CFrame.new(),
    [2] = Vector3.new(),
    [3] = false
}

local localPlayer = Players.LocalPlayer

for _, player in pairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                args[1] = CFrame.new(humanoidRootPart.Position)
                args[2] = humanoidRootPart.Position
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("cola v7").SpawnGrenade:FireServer(unpack(args))
            end
        end
    end
end
end
end
	if selectedOption == "Nuke server v2" then

local LP = game.Players.LocalPlayer
repeat wait() until LP.Character
for i,v in pairs(LP.Backpack:GetChildren()) do
   if v.Name == "cola v7" then
       v.Parent = LP.Character
   end
end

		  for i = 1, 10 do
local Players = game:GetService("Players")

local args = {
    [1] = CFrame.new(),
    [2] = Vector3.new(),
    [3] = false
}

local localPlayer = Players.LocalPlayer

for _, player in pairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                args[1] = CFrame.new(humanoidRootPart.Position)
                args[2] = humanoidRootPart.Position
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("cola v7").SpawnGrenade:FireServer(unpack(args))
            end
        end
    end
end
end
  end
end)

tab.newDropdown("Godmode way", "Every defense has its own weakness", {"Tutorial", "Get sword", "Get carpet"}, function(selectedOption)
    if selectedOption == "Tutorial" then
			setclipboard("https://youtu.be/UagtWacwRkk?si=bnDpz0wQhuJ3YXuy")
			
			OrionLib:MakeNotification({
	Name = "Info",
	Content = "Copied in clipboard ",
	Image = "rbxassetid://4483345998",
	Time = 5
})
    end
	if selectedOption == "Get sword" then
		  last_pick_sin_mrazy = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15, 52, -34)
task.wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local actionRadius = 1.5

game:GetService("CoreGui").PurchasePrompt.Enabled = false

for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ClickDetector") then
        local objectPosition = v.Parent.Position
        local playerPosition = humanoidRootPart.Position
        local distance = (objectPosition - playerPosition).magnitude 

        if distance <= actionRadius then
            fireclickdetector(v)
        end
    end
end
task.wait(0.1)
for i = 1, 15 do
    wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11, 52, -54)
end
task.wait(0.1)
game. Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pick_sin_mrazy
    end
    if selectedOption == "Get carpet" then
    last_pick_sin_mrazy = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-23, 47, 39)
task.wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local actionRadius = 1.5

game:GetService("CoreGui").PurchasePrompt.Enabled = false

for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ClickDetector") then
        local objectPosition = v.Parent.Position
        local playerPosition = humanoidRootPart.Position
        local distance = (objectPosition - playerPosition).magnitude 

        if distance <= actionRadius then
            fireclickdetector(v)
        end
    end
end
task.wait(0.1)
for i = 1, 50 do
    task.wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-25, 52, 24)
end
task.wait(0.1)
game. Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pick_sin_mrazy
    end
end)

tab.newInput("100% kill player", "For this to work you need to activate the Motorbike", function(text)
    last_pick_sin_mrazy = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 

        PlayerName = arg
local function findPlayer(name)
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name:lower():match(name:lower()) or player.DisplayName:lower():match(name:lower()) then
            return player
        end
    end
    return nil
end

local function teleportToPlayer(targetPlayer)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local targetCharacter = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
    local targetHumanoidRootPart = targetCharacter:WaitForChild("HumanoidRootPart")

    humanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
end

local targetName = PlayerName
local targetPlayer = findPlayer(targetName)

if targetPlayer then
    teleportToPlayer(targetPlayer)
    task.wait(0.1)
    game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 0
    
    wait(4.1)
    
    game. Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pick_sin_mrazy
    end
end)

tab.newLabel("Milk tool")

tab.newButton("Get Milk tool", "Gives you Milk tool", function()
last_pick_sin_mrazy = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-17, 49, 3)
task.wait()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local actionRadius = 1.5

game:GetService("CoreGui").PurchasePrompt.Enabled = false

for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ClickDetector") then
        local objectPosition = v.Parent.Position
        local playerPosition = humanoidRootPart.Position
        local distance = (objectPosition - playerPosition).magnitude 

        if distance <= actionRadius then
            fireclickdetector(v)
        end
    end
end
task.wait(0.1)
for i = 1, 15 do
    wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15, 52, 23)
end
task.wait(0.1)
game. Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_pick_sin_mrazy
end)

tab.newButton("Spam Milk tool", "Well, you understood it yourself", function()
local LP = game.Players.LocalPlayer
repeat wait() until LP.Character
for i,v in pairs(LP.Backpack:GetChildren()) do
   if v.Name == "milk tool" then
       v.Parent = LP.Character
   end
end

while true do
wait(0.1)
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local clickPosition = mouse.Hit.Position

local args = {
    [1] = CFrame.new(clickPosition),
    [2] = Vector3.new(clickPosition),
    [3] = false
}

game:GetService("Players").LocalPlayer.Character:FindFirstChild("milk tool").SpawnGrenade:FireServer(unpack(args))
end
end)

tab.newButton("Spam sound", "The activation sound for this tool is spammy", function()
local LP = game.Players.LocalPlayer
repeat wait() until LP.Character
for i,v in pairs(LP.Backpack:GetChildren()) do
   if v.Name == "milk tool" then
       v.Parent = LP.Character
   end
end

while true do
task.wait()
game:GetService("Players").LocalPlayer.Character:FindFirstChild("milk tool").specialdelivery:FireServer()
end
end)
