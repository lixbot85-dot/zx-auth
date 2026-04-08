local u1 = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local function u7(p2)
    local v3, v4, v5 = ipairs(game:GetDescendants())

    while true do
        local v6

        v5, v6 = v3(v4, v5)

        if v5 == nil then
            break
        end
        if (v6:IsA('Highlight') or v6:IsA('BillboardGui')) and v6.Name == p2 then
            v6:Destroy()
        end
    end
end

local u8 = 2.5
local u9 = nil
local u10 = 3

(function()
    local _Players = game:GetService('Players')
    local _TweenService = game:GetService('TweenService')

    game:GetService('RunService')
    game:GetService('UserInputService')

    local _LocalPlayer = _Players.LocalPlayer

    if _LocalPlayer then
        local _PlayerGui = _LocalPlayer:WaitForChild('PlayerGui')
        local u15 = false
        local u16 = false
        local _ScreenGui = Instance.new('ScreenGui')

        _ScreenGui.Name = 'EmoteGui'
        _ScreenGui.ResetOnSpawn = false
        _ScreenGui.Parent = _PlayerGui

        local _Frame = Instance.new('Frame')

        _Frame.Name = 'Emote'

        local u19 = UDim2.new(0, 600, 0, 300)

        _Frame.Size = u19
        _Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        _Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        _Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        _Frame.BorderSizePixel = 0
        _Frame.Visible = false
        _Frame.Parent = _ScreenGui

        local _UICorner = Instance.new('UICorner')

        _UICorner.CornerRadius = UDim.new(0, 15)
        _UICorner.Parent = _Frame

        local _UIGradient = Instance.new('UIGradient')

        _UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15)),
        })
        _UIGradient.Parent = _Frame

        local _Frame2 = Instance.new('Frame')

        _Frame2.Name = 'Shadow'
        _Frame2.Size = u19
        _Frame2.Position = UDim2.new(0, 5, 0, 5)
        _Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        _Frame2.BackgroundTransparency = 0.5
        _Frame2.BorderSizePixel = 0
        _Frame2.ZIndex = _Frame.ZIndex - 1
        _Frame2.Parent = _Frame

        local _UICorner2 = Instance.new('UICorner')

        _UICorner2.CornerRadius = _UICorner.CornerRadius
        _UICorner2.Parent = _Frame2

        local _TextLabel = Instance.new('TextLabel')

        _TextLabel.Name = 'TitleLabel'
        _TextLabel.Text = 'Emotes'
        _TextLabel.Size = UDim2.new(1, 0, 0, 30)
        _TextLabel.Position = UDim2.new(0, 0, 0, 0)
        _TextLabel.BackgroundTransparency = 1
        _TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        _TextLabel.Font = Enum.Font.GothamBold
        _TextLabel.TextScaled = true
        _TextLabel.Parent = _Frame

        local _ScrollingFrame = Instance.new('ScrollingFrame')

        _ScrollingFrame.Name = 'EmoteScroll'
        _ScrollingFrame.Size = UDim2.new(1, -20, 1, -45)
        _ScrollingFrame.Position = UDim2.new(0, 10, 0, 35)
        _ScrollingFrame.BackgroundTransparency = 1
        _ScrollingFrame.BorderSizePixel = 0
        _ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        _ScrollingFrame.Parent = _Frame

        local _UIGridLayout = Instance.new('UIGridLayout')

        _UIGridLayout.CellSize = UDim2.new(0, 50, 0, 50)
        _UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
        _UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
        _UIGridLayout.Parent = _ScrollingFrame

        local v27 = _UIGridLayout

        _UIGridLayout.GetPropertyChangedSignal(v27, 'AbsoluteContentSize'):Connect(function()
            _ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, _UIGridLayout.AbsoluteContentSize.Y)
        end)

        local function u33()
            if not u16 then
                u16 = true
                _Frame.Visible = true
                _Frame.BackgroundTransparency = 1
                _Frame.Size = UDim2.new(0, 0, 0, 0)
                _Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                _Frame.Position = UDim2.new(0.5, 0, 0.5, 0)

                local v28 = _TweenService
                local v29 = {
                    Size = UDim2.new(0, 50, 0, 25),
                    BackgroundTransparency = 0,
                }
                local v30 = v28:Create(_Frame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v29)

                v30:Play()
                v30.Completed:Wait()

                local v31 = {Size = u19}
                local v32 = _TweenService:Create(_Frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v31)

                v32:Play()
                v32.Completed:Wait()

                u16 = false
            end
        end
        local function u38()
            if not u16 then
                u16 = true

                local v34 = _TweenService
                local v35 = {
                    Size = UDim2.new(0, 50, 0, 25),
                }
                local v36 = v34:Create(_Frame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), v35)

                v36:Play()
                v36.Completed:Wait()

                local v37 = _TweenService:Create(_Frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                })

                v37:Play()
                v37.Completed:Wait()

                _Frame.Visible = false
                _Frame.BackgroundTransparency = 0
                _Frame.Size = u19
                u16 = false
            end
        end
        local function v45(p39)
            local _TextButton = Instance.new('TextButton')

            _TextButton.Name = 'EmoteButton_' .. p39
            _TextButton.Size = UDim2.new(0, 50, 0, 50)
            _TextButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            _TextButton.Text = p39
            _TextButton.Font = Enum.Font.GothamBold
            _TextButton.TextScaled = true
            _TextButton.TextColor3 = Color3.fromRGB(240, 240, 240)
            _TextButton.BorderSizePixel = 0
            _TextButton.AutoButtonColor = false
            _TextButton.Parent = _ScrollingFrame

            local _UICorner3 = Instance.new('UICorner')

            _UICorner3.CornerRadius = UDim.new(0, 10)
            _UICorner3.Parent = _TextButton

            local _UIStroke = Instance.new('UIStroke')

            _UIStroke.Thickness = 2
            _UIStroke.Color = Color3.fromRGB(30, 30, 30)
            _UIStroke.Parent = _TextButton

            local u43 = TweenInfo.new(0.15, Enum.EasingStyle.Quad)

            _TextButton.MouseEnter:Connect(function()
                _TweenService:Create(_TextButton, u43, {
                    BackgroundColor3 = Color3.fromRGB(75, 75, 75),
                }):Play()
            end)
            _TextButton.MouseLeave:Connect(function()
                _TweenService:Create(_TextButton, u43, {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 55),
                }):Play()
            end)
            _TextButton.MouseButton1Click:Connect(function()
                local v44 = {
                    'PlayEmote',
                    'Animations',
                    p39,
                }

                game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Network'):WaitForChild('RemoteEvent'):FireServer(unpack(v44))

                u15 = true

                u38()
            end)
        end

        local _Emotes = _LocalPlayer:WaitForChild('PlayerData'):WaitForChild('Purchased'):WaitForChild('Emotes')
        local v47, v48, v49 = ipairs(_Emotes:GetChildren())
        local u50 = _Frame
        local u51 = u38
        local u52 = u15
        local u53 = u16

        while true do
            local v54

            v49, v54 = v47(v48, v49)

            if v49 == nil then
                break
            end

            v45(v54.Name)
        end

        local _ImageButton = Instance.new('ImageButton')

        _ImageButton.Name = 'ToggleButton'
        _ImageButton.Size = UDim2.new(0, 50, 0, 50)
        _ImageButton.Position = UDim2.new(1, -320, 0, -50)
        _ImageButton.BackgroundTransparency = 1
        _ImageButton.Image = 'rbxassetid://117823860306601'
        _ImageButton.Parent = _ScreenGui

        local _UICorner4 = Instance.new('UICorner')

        _UICorner4.CornerRadius = UDim.new(1, 0)
        _UICorner4.Parent = _ImageButton

        local _UIStroke2 = Instance.new('UIStroke')

        _UIStroke2.Thickness = 2
        _UIStroke2.Color = Color3.fromRGB(30, 30, 30)
        _UIStroke2.Parent = _ImageButton

        _ImageButton.MouseButton1Click:Connect(function()
            if not u53 then
                if u52 then
                    local _Emotes2 = _LocalPlayer:WaitForChild('PlayerData'):WaitForChild('Purchased'):WaitForChild('Emotes')
                    local v59, v60, v61 = ipairs(_Emotes2:GetChildren())

                    while true do
                        local v62

                        v61, v62 = v59(v60, v61)

                        if v61 == nil then
                            break
                        end

                        local v63 = {
                            'StopEmote',
                            'Animations',
                            v62.Name,
                        }

                        game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Network'):WaitForChild('RemoteEvent'):FireServer(unpack(v63))
                    end

                    u52 = false

                    u51()
                elseif u50.Visible then
                    u51()
                else
                    u33()
                end
            end
        end)
    else
        warn('LocalPlayer is nil!')
    end
end)()

if game.PlaceId == 18687417158 then
    game:GetService('StarterGui'):SetCore('SendNotification', {
        Title = 'Hello!',
        Text = 'Welcome to B0bby Hub!',
        Image = '',
        Duration = 5,
    })
    wait(2)
    game:GetService('StarterGui'):SetCore('SendNotification', {
        Title = 'Script Loading..',
        Text = 'Please wait for the script to load.',
        Image = '',
        Duration = 5,
    })
end

(function()
    local u64 = u1:CreateWindow({
        Name = '\u{fffd}\u{fffd}B0bbyHub / Forsaken',
        Icon = 106975314970201,
        LoadingTitle = '\u{fffd}\u{fffd}B0bbyhub / Forsaken',
        LoadingSubtitle = 'Loading..',
        Theme = 'AmberGlow',
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = 'Bobobobobob2',
            FileName = 'bobbobobobobob',
        },
        Discord = {
            Enabled = true,
            Invite = 'v9sSBezmyy',
            RememberJoins = true,
        },
        KeySystem = false,
        KeySettings = {
            Title = 'B0bbyhub | Keysystem',
            Subtitle = 'Get Key at Our discord server!',
            Note = 'Get the key at discord.gg/v9sSBezmyy',
            FileName = 'BombbombBobbyKey',
            SaveKey = true,
            GrabKeyFromSite = false,
            Key = {
                'IFarted',
                'BOBISCOOL',
                'Samuelspizzatrip',
                'BOBBYHUBKEYWJJEBEKEI1827272',
                ' BOBBYHUBKEYWJJEBEKEI1827272',
                'BOBBYHUBKEYWJJEBEKEI1827272 ',
            },
        },
    })
    local _Main = u64:CreateTab('Main', 'home')
    local _Stamina = u64:CreateTab('Stamina', 'accessibility')
    local _Effects = u64:CreateTab('Effects', 'wand-sparkles')
    local _Generators = u64:CreateTab('Generators', 'cpu')
    local _AimbotPlayer = u64:CreateTab('Aimbot / Player', 'crosshair')
    local _Fun = u64:CreateTab('Fun', 'smile')
    local _Credits = u64:CreateTab('Credits', 'clipboard')
    local _Settings = u64:CreateTab('Settings', 'settings')

    u1:Notify({
        Title = 'Made by Bob.47',
        Content = 'Cool',
        Duration = 6.5,
        Image = 'flame',
    })
    _Main:CreateSection('Esp')

    local u73 = nil
    local u74 = nil
    local u75 = nil
    local u76 = false
    local _ = workspace.Map.Ingame

    _Main:CreateToggle({
        Name = 'Killer | Esp',
        CurrentValue = false,
        Flag = 'ToggleKIlllerESP1',
        Callback = function(p77)
            if p77 then
                local _Killers = workspace.Players.Killers
                local _Players2 = game.Workspace:WaitForChild('Players')

                game:GetService('RunService')

                local function u84(p80, p81, p82)
                    local _Highlight = p80:FindFirstChild('Highlight')

                    if not _Highlight then
                        _Highlight = Instance.new('Highlight')
                        _Highlight.Name = 'KillerESP'
                        _Highlight.Parent = p80
                        _Highlight.Adornee = p80
                    end

                    _Highlight.FillTransparency = 0.5
                    _Highlight.FillColor = p82
                    _Highlight.OutlineColor = p81
                    _Highlight.OutlineTransparency = 0
                end
                local function u91(p85, p86, p87)
                    local _BillboardGui = p85:FindFirstChildOfClass('BillboardGui')

                    if _BillboardGui then
                        _BillboardGui.TextLabel.Text = p86
                        _BillboardGui.TextLabel.TextColor3 = p87
                        _BillboardGui.TextLabel.Font = Enum.Font.Antique
                        _BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
                    else
                        local _BillboardGui2 = Instance.new('BillboardGui')

                        _BillboardGui2.Adornee = p85
                        _BillboardGui2.Name = 'KillerESP'
                        _BillboardGui2.Size = UDim2.new(0, 100, 0, 25)
                        _BillboardGui2.AlwaysOnTop = true
                        _BillboardGui2.Parent = p85.Parent
                        _BillboardGui2.StudsOffset = Vector3.new(0, 2, 0)

                        local _TextLabel2 = Instance.new('TextLabel')

                        _TextLabel2.Size = UDim2.new(1, 0, 1, 0)
                        _TextLabel2.BackgroundTransparency = 1
                        _TextLabel2.TextScaled = true
                        _TextLabel2.TextColor3 = p87
                        _TextLabel2.Text = p86
                        _TextLabel2.Font = Enum.Font.Antique
                        _TextLabel2.Parent = _BillboardGui2
                    end
                end
                local function u93(p92)
                    if p92:FindFirstChildOfClass('Humanoid') and p92:FindFirstChild('HumanoidRootPart') then
                        u84(p92, Color3.fromRGB(255, 0, 0), Color3.fromRGB(150, 0, 0))
                        u91(p92:FindFirstChild('HumanoidRootPart'), p92.Name, Color3.fromRGB(255, 0, 0))
                    end
                end
                local function v99()
                    local _Killers2 = _Players2:FindFirstChild('Killers')

                    if _Killers2 then
                        local v95, v96, v97 = pairs(_Killers2:GetChildren())

                        while true do
                            local v98

                            v97, v98 = v95(v96, v97)

                            if v97 == nil then
                                break
                            end

                            u93(v98)
                        end
                    end
                end

                v99()

                u73 = _Killers.ChildAdded:Connect(v99)
                u73 = _Players2.DescendantAdded:Connect(function(p100)
                    if p100.Parent and p100.Parent.Name == 'Killers' then
                        u93(p100)
                    end
                end)
                u73 = _Players2.DescendantRemoving:Connect(function(p101)
                    if p101:IsA('Model') and p101.Name == 'Killers' then
                        p101.AncestryChanged:Connect(function(_, p102)
                            if p102 then
                                u93(p101)
                            end
                        end)
                    end
                end)
            else
                u7('KillerESP')
                u73:Disconnect()

                u73 = nil
            end
        end,
    })

    local u103 = false
    local u104 = {}

    _Main:CreateToggle({
        Name = 'Generator | ESP',
        CurrentValue = false,
        Flag = 'GeneratorToggleESP1',
        Callback = function(p105)
            u103 = p105

            if u103 then
                local _Ingame = workspace:WaitForChild('Map'):WaitForChild('Ingame')
                local v107 = 1
                local u108 = nil

                local function u109()
                    u108 = _Ingame:FindFirstChild('Map')

                    return u108
                end
                local function u114(p110, p111, p112)
                    local _GeneratorHigh = p110:FindFirstChild('GeneratorHigh')

                    if not _GeneratorHigh then
                        _GeneratorHigh = Instance.new('Highlight')
                        _GeneratorHigh.Name = 'GeneratorHigh'
                        _GeneratorHigh.Parent = p110
                        _GeneratorHigh.Adornee = p110
                    end

                    _GeneratorHigh.FillColor = Color3.new(p111[1], p111[2], p111[3])
                    _GeneratorHigh.OutlineColor = Color3.new(p112[1], p112[2], p112[3])
                end
                local function u121(p115)
                    local _Main2 = p115:FindFirstChild('Main')

                    if _Main2 then
                        local _GeneratorHighBillboard = _Main2:FindFirstChild('GeneratorHighBillboard')

                        if not _GeneratorHighBillboard then
                            _GeneratorHighBillboard = Instance.new('BillboardGui')
                            _GeneratorHighBillboard.Name = 'GeneratorHighBillboard'
                            _GeneratorHighBillboard.Adornee = _Main2
                            _GeneratorHighBillboard.Size = UDim2.new(0, 150, 0, 30)
                            _GeneratorHighBillboard.AlwaysOnTop = true
                            _GeneratorHighBillboard.Parent = _Main2

                            local _TextLabel3 = Instance.new('TextLabel')

                            _TextLabel3.Name = 'GeneratorTextLabel'
                            _TextLabel3.Size = UDim2.new(0.8, 0, 0.8, 0)
                            _TextLabel3.BackgroundTransparency = 1
                            _TextLabel3.TextScaled = true
                            _TextLabel3.Font = Enum.Font.Antique
                            _TextLabel3.Text = 'Initializing...'
                            _TextLabel3.TextColor3 = Color3.new(1, 1, 1)
                            _TextLabel3.Parent = _GeneratorHighBillboard
                        end

                        local _GeneratorTextLabel = _GeneratorHighBillboard:FindFirstChild('GeneratorTextLabel')

                        if _GeneratorTextLabel then
                            local v120 = _Main2:FindFirstChild('generatorActivate') ~= nil

                            if v120 then
                                _GeneratorTextLabel.Text = 'Generator: Fixed'
                                _GeneratorTextLabel.TextColor3 = Color3.new(0, 0.5, 0)

                                u114(p115, {0, 0.5, 0}, {0, 1, 0})
                            else
                                _GeneratorTextLabel.Text = 'Generator: Not Fixed'
                                _GeneratorTextLabel.TextColor3 = Color3.new(0.8, 0, 0)

                                u114(p115, {0.5, 0, 0}, {1, 0, 0})
                            end

                            p115:SetAttribute('GeneratorState', v120)
                        end
                    else
                        return
                    end
                end
                local function u127()
                    local v122 = u109()

                    if v122 then
                        local v123, v124, v125 = ipairs(v122:GetChildren())

                        while true do
                            local v126

                            v125, v126 = v123(v124, v125)

                            if v125 == nil then
                                break
                            end
                            if v126.Name == 'Generator' and v126:IsA('Model') then
                                u121(v126)
                            end
                        end
                    end
                end
                local function v132()
                    local v128, v129, v130 = ipairs(u104)

                    while true do
                        local v131

                        v130, v131 = v128(v129, v130)

                        if v130 == nil then
                            break
                        end
                        if v131 then
                            v131:Disconnect()
                        end
                    end

                    u104 = {}
                end
                local function v137()
                    while u103 do
                        task.wait(1)

                        local v133 = u109()

                        if v133 then
                            u127()

                            local v136 = v133.DescendantAdded:Connect(function(p134)
                                if u103 then
                                    local v135 = nil

                                    if p134.Name ~= 'Generator' or not p134:IsA('Model') then
                                        if p134.Name == 'Main' and (p134.Parent and p134.Parent.Name == 'Generator') then
                                            v135 = p134.Parent
                                        end
                                    else
                                        v135 = p134
                                    end
                                    if v135 then
                                        u121(v135)
                                    end
                                end
                            end)

                            table.insert(u104, v136)
                        end
                    end
                end

                u127()
                task.spawn(v137)

                local v138 = u121
                local v139 = u109

                while u103 do
                    local v140 = v139()

                    if v140 then
                        local v141, v142, v143 = ipairs(v140:GetChildren())

                        while true do
                            local v144

                            v143, v144 = v141(v142, v143)

                            if v143 == nil then
                                break
                            end
                            if v144.Name == 'Generator' and v144:IsA('Model') then
                                v138(v144)
                            end
                        end
                    end

                    task.wait(v107)
                end

                v132()
            else
                u103 = false

                u7('GenESP')
            end
        end,
    })
    _Main:CreateToggle({
        Name = 'Items | Esp',
        CurrentValue = false,
        Flag = 'ItemToggle1Esp',
        Callback = function(p145)
            if p145 then
                local _Workspace = game:GetService('Workspace')

                local function u151(p147, p148, p149)
                    if p147 and not p147:FindFirstChildOfClass('Highlight') then
                        local _Highlight2 = Instance.new('Highlight')

                        _Highlight2.Name = 'ItemESP'
                        _Highlight2.Parent = p147
                        _Highlight2.Adornee = p147
                        _Highlight2.FillTransparency = 0.75
                        _Highlight2.FillColor = p149
                        _Highlight2.OutlineColor = p148
                        _Highlight2.OutlineTransparency = 0
                    end
                end
                local function u157(p152, p153, p154)
                    if p152 and not p152:FindFirstChildOfClass('BillboardGui') then
                        local _BillboardGui3 = Instance.new('BillboardGui')

                        _BillboardGui3.Name = 'ItemESP'
                        _BillboardGui3.Adornee = p152
                        _BillboardGui3.Size = UDim2.new(0, 100, 0, 25)
                        _BillboardGui3.AlwaysOnTop = true
                        _BillboardGui3.Parent = p152

                        local _TextLabel4 = Instance.new('TextLabel')

                        _TextLabel4.Size = UDim2.new(1, 0, 1, 0)
                        _TextLabel4.BackgroundTransparency = 1
                        _TextLabel4.TextScaled = true
                        _TextLabel4.TextColor3 = p154
                        _TextLabel4.Text = p153
                        _TextLabel4.Font = Enum.Font.Antique
                        _TextLabel4.Parent = _BillboardGui3
                    end
                end
                local function u161(p158)
                    local _Model = p158:IsA('Model')

                    if _Model then
                        _Model = p158:FindFirstChildWhichIsA('BasePart')
                    end
                    if _Model then
                        local v160

                        if p158.Name ~= 'BloxyCola' then
                            if p158.Name ~= 'Medkit' then
                                if p158.Name ~= 'SubspaceTripmine' or p158:IsDescendantOf(_Workspace.Players.Survivors) then
                                    return
                                end

                                v160 = Color3.fromRGB(0, 191, 255)
                            else
                                v160 = Color3.fromRGB(128, 0, 128)
                            end
                        else
                            v160 = Color3.fromRGB(204, 153, 0)
                        end

                        u151(_Model, v160, v160)
                        u157(_Model, p158.Name, v160)
                    end
                end

                (function()
                    local v162 = _Workspace
                    local v163, v164, v165 = pairs(v162:GetDescendants())

                    while true do
                        local v166

                        v165, v166 = v163(v164, v165)

                        if v165 == nil then
                            break
                        end
                        if v166:IsA('Model') and (v166.Name == 'BloxyCola' or (v166.Name == 'Medkit' or v166.Name == 'SubspaceTripmine' and not v166:IsDescendantOf(_Workspace.Players.Survivors))) then
                            u161(v166)
                        end
                    end
                end)()

                u74 = _Workspace.DescendantAdded:Connect(function(p167)
                    if p167:IsA('Model') and (p167.Name == 'BloxyCola' or (p167.Name == 'Medkit' or p167.Name == 'SubspaceTripmine' and not p167:IsDescendantOf(_Workspace.Players.Survivors))) then
                        wait(1)
                        u161(p167)
                    end
                end)
                u74 = _Workspace.DescendantRemoving:Connect(function(p168)
                    if p168:IsA('Model') then
                        local _Highlight3 = p168:FindFirstChildOfClass('Highlight')

                        if _Highlight3 then
                            _Highlight3:Destroy()
                        end

                        local _BillboardGui4 = p168:FindFirstChildOfClass('BillboardGui')

                        if _BillboardGui4 then
                            _BillboardGui4:Destroy()
                        end
                    end
                end)
            else
                u74:Disconnect()

                u74 = nil

                u7('ItemESP')
            end
        end,
    })
    _Main:CreateToggle({
        Name = 'Survivor | Esp',
        CurrentValue = false,
        Flag = 'PLAYERESPOHMYGOSHITSTOGGLEABLE',
        Callback = function(p171)
            u76 = p171

            if u76 then
                local _Survivors = workspace.Players.Survivors

                game:GetService('Players')

                local function u177(p173, p174, p175)
                    if p173 and not p173:FindFirstChildOfClass('Highlight') then
                        local _Highlight4 = Instance.new('Highlight')

                        _Highlight4.Name = 'PlayerESP'
                        _Highlight4.Parent = p173
                        _Highlight4.Adornee = p173
                        _Highlight4.FillTransparency = 0.75
                        _Highlight4.FillColor = p175
                        _Highlight4.OutlineColor = p174
                        _Highlight4.OutlineTransparency = 0
                    end
                end
                local function u187(p178, p179)
                    local _Head = p178:FindFirstChild('Head')

                    if _Head then
                        local _HealthGui = _Head:FindFirstChild('HealthGui')

                        if _HealthGui then
                            local _HealthLabel = _HealthGui:FindFirstChild('HealthLabel')
                            local _NameLabel = _HealthGui:FindFirstChild('NameLabel')

                            if _HealthLabel then
                                _HealthLabel.TextColor3 = p179
                            end
                            if _NameLabel then
                                _NameLabel.TextColor3 = p179
                            end
                        else
                            local _BillboardGui5 = Instance.new('BillboardGui')

                            _BillboardGui5.Name = 'PlayerESP'
                            _BillboardGui5.Size = UDim2.new(0, 100, 0, 60)
                            _BillboardGui5.AlwaysOnTop = true
                            _BillboardGui5.MaxDistance = math.huge
                            _BillboardGui5.Parent = _Head
                            _BillboardGui5.StudsOffset = Vector3.new(0, 3, 0)

                            local _TextLabel5 = Instance.new('TextLabel')

                            _TextLabel5.Name = 'HealthLabel'
                            _TextLabel5.Size = UDim2.new(1, 0, 0.5, 0)
                            _TextLabel5.Position = UDim2.new(0, 0, 0.5, 0)
                            _TextLabel5.BackgroundTransparency = 1
                            _TextLabel5.TextScaled = true
                            _TextLabel5.Text = ''
                            _TextLabel5.TextColor3 = p179
                            _TextLabel5.Font = Enum.Font.Antique
                            _TextLabel5.Parent = _BillboardGui5

                            local _TextLabel6 = Instance.new('TextLabel')

                            _TextLabel6.Name = 'NameLabel'
                            _TextLabel6.Size = UDim2.new(1, 0, 0.5, 0)
                            _TextLabel6.Position = UDim2.new(0, 0, 0, 0)
                            _TextLabel6.BackgroundTransparency = 1
                            _TextLabel6.TextScaled = true
                            _TextLabel6.Text = p178.Name
                            _TextLabel6.TextColor3 = p179
                            _TextLabel6.Font = Enum.Font.Antique
                            _TextLabel6.Parent = _BillboardGui5
                        end
                    end
                end
                local function v197()
                    local v188 = _Survivors
                    local v189, v190, v191 = ipairs(v188:GetChildren())

                    while true do
                        local v192

                        v191, v192 = v189(v190, v191)

                        if v191 == nil then
                            break
                        end
                        if v192 then
                            local _Humanoid = v192:FindFirstChildOfClass('Humanoid')
                            local _Head2 = v192:FindFirstChild('Head')

                            if _Humanoid and _Head2 then
                                u187(v192, _Humanoid.MaxHealth > 500 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255))

                                local _PlayerESP = _Head2:FindFirstChild('PlayerESP')

                                if _PlayerESP then
                                    local _HealthLabel2 = _PlayerESP:FindFirstChild('HealthLabel')

                                    if _HealthLabel2 then
                                        _HealthLabel2.Text = math.floor(_Humanoid.Health) .. '/' .. _Humanoid.MaxHealth
                                    end
                                end
                            end
                        end
                    end
                end
                local function u205()
                    local v198 = _Survivors
                    local v199, v200, v201 = ipairs(v198:GetChildren())

                    while true do
                        local v202

                        v201, v202 = v199(v200, v201)

                        if v201 == nil then
                            break
                        end
                        if v202 and v202:FindFirstChildOfClass('Humanoid') then
                            local v203 = Color3.fromRGB(128, 128, 128)
                            local v204 = Color3.fromRGB(255, 255, 255)

                            u177(v202, v204, v203)
                            u187(v202, v204)
                        end
                    end
                end

                u205()

                u75 = _Survivors.ChildAdded:Connect(function(_)
                    wait(1)
                    u205()
                end)
                u75 = _Survivors.ChildRemoved:Connect(function(p206)
                    local _Highlight5 = p206:FindFirstChildOfClass('Highlight')

                    if _Highlight5 then
                        _Highlight5:Destroy()
                    end

                    local _Head3 = p206:FindFirstChild('Head')
                    local v209 = _Head3 and _Head3:FindFirstChild('HealthGui')

                    if v209 then
                        v209:Destroy()
                    end
                end)

                local v210 = u205

                while u76 do
                    v210()
                    v197()
                    wait(1)
                end
            else
                u76 = false

                u7('PlayerESP')
                u75:Disconnect()

                u75 = nil
            end
        end,
    })
    _Main:CreateButton({
        Name = '1x1x1x1 Zombie esp',
        Callback = function()
            local _Ingame2 = workspace.Map.Ingame
            local u212 = '1x1x1x1Zombie'
            local u213 = Color3.fromRGB(0, 100, 0)

            local function u218(p214)
                if p214 and not p214:FindFirstChildOfClass('Highlight') then
                    local _Highlight6 = Instance.new('Highlight')

                    _Highlight6.Parent = p214
                    _Highlight6.Adornee = p214
                    _Highlight6.FillTransparency = 0.75
                    _Highlight6.FillColor = u213
                    _Highlight6.OutlineColor = u213
                    _Highlight6.OutlineTransparency = 0

                    local _BillboardGui6 = Instance.new('BillboardGui')

                    _BillboardGui6.Name = 'ZombieLabel'
                    _BillboardGui6.Size = UDim2.new(0, 100, 0, 50)
                    _BillboardGui6.AlwaysOnTop = true
                    _BillboardGui6.MaxDistance = math.huge
                    _BillboardGui6.Parent = p214
                    _BillboardGui6.StudsOffset = Vector3.new(0, 3, 0)

                    local _TextLabel7 = Instance.new('TextLabel')

                    _TextLabel7.Size = UDim2.new(1, 0, 1, 0)
                    _TextLabel7.BackgroundTransparency = 1
                    _TextLabel7.TextScaled = true
                    _TextLabel7.Text = '1x1x1x1 Zombie'
                    _TextLabel7.TextColor3 = Color3.fromRGB(0, 255, 0)
                    _TextLabel7.Font = Enum.Font.Antique
                    _TextLabel7.Parent = _BillboardGui6
                end
            end

            (function()
                local v219 = _Ingame2:FindFirstChild(u212)

                if v219 then
                    u218(v219)
                end
            end)()
            _Ingame2.ChildAdded:Connect(function(p220)
                if p220.Name == u212 then
                    u218(p220)
                end
            end)
        end,
    })
    _Main:CreateButton({
        Name = 'John doe Spike esp',
        Callback = function()
            local _Ingame3 = workspace.Map.Ingame
            local u222 = 'Spike'
            local u223 = Color3.fromRGB(255, 140, 0)

            local function u226(p224)
                if p224 and not p224:FindFirstChildOfClass('Highlight') then
                    local _Highlight7 = Instance.new('Highlight')

                    _Highlight7.Parent = p224
                    _Highlight7.Adornee = p224
                    _Highlight7.FillTransparency = 0.75
                    _Highlight7.FillColor = u223
                    _Highlight7.OutlineColor = u223
                    _Highlight7.OutlineTransparency = 0
                end
            end

            (function()
                local v227 = _Ingame3:FindFirstChild(u222)

                if v227 then
                    u226(v227)
                end
            end)()
            _Ingame3.ChildAdded:Connect(function(p228)
                if p228.Name == u222 then
                    u226(p228)
                end
            end)
        end,
    })
    _Main:CreateButton({
        Name = 'Pizza Delivery Minion esp',
        Callback = function()
            local _Ingame4 = workspace.Map.Ingame
            local u230 = 'PizzaDeliveryRig'
            local u231 = Color3.fromRGB(139, 0, 0)

            local function u236(p232)
                if p232 and not p232:FindFirstChildOfClass('Highlight') then
                    local _Highlight8 = Instance.new('Highlight')

                    _Highlight8.Parent = p232
                    _Highlight8.Adornee = p232
                    _Highlight8.FillTransparency = 0.75
                    _Highlight8.FillColor = u231
                    _Highlight8.OutlineColor = u231
                    _Highlight8.OutlineTransparency = 0

                    local _BillboardGui7 = Instance.new('BillboardGui')

                    _BillboardGui7.Name = 'PizzaDeliveryMinionEsp'
                    _BillboardGui7.Size = UDim2.new(0, 100, 0, 50)
                    _BillboardGui7.AlwaysOnTop = true
                    _BillboardGui7.MaxDistance = math.huge
                    _BillboardGui7.Parent = p232
                    _BillboardGui7.StudsOffset = Vector3.new(0, 3, 0)

                    local _TextLabel8 = Instance.new('TextLabel')

                    _TextLabel8.Size = UDim2.new(1, 0, 1, 0)
                    _TextLabel8.BackgroundTransparency = 1
                    _TextLabel8.TextScaled = true
                    _TextLabel8.Text = 'Pizza Delivery Minion'
                    _TextLabel8.TextColor3 = Color3.fromRGB(139, 0, 0)
                    _TextLabel8.Font = Enum.Font.Antique
                    _TextLabel8.Parent = _BillboardGui7
                end
            end

            (function()
                local v237 = _Ingame4:FindFirstChild(u230)

                if v237 then
                    u236(v237)
                end
            end)()
            _Ingame4.ChildAdded:Connect(function(p238)
                if p238.Name == u230 then
                    u236(p238)
                end
            end)
        end,
    })
    _Main:CreateButton({
        Name = "Elliot's Pizza esp",
        Callback = function()
            local _Ingame5 = workspace.Map.Ingame
            local u240 = 'Pizza'
            local u241 = Color3.fromRGB(255, 165, 0)

            local function u246(p242)
                if p242 and not p242:FindFirstChildOfClass('Highlight') then
                    local _Highlight9 = Instance.new('Highlight')

                    _Highlight9.Parent = p242
                    _Highlight9.Adornee = p242
                    _Highlight9.FillTransparency = 0.75
                    _Highlight9.FillColor = u241
                    _Highlight9.OutlineColor = u241
                    _Highlight9.OutlineTransparency = 0

                    local _BillboardGui8 = Instance.new('BillboardGui')

                    _BillboardGui8.Name = 'PizzaLabel'
                    _BillboardGui8.Size = UDim2.new(0, 100, 0, 50)
                    _BillboardGui8.AlwaysOnTop = true
                    _BillboardGui8.MaxDistance = math.huge
                    _BillboardGui8.Parent = p242
                    _BillboardGui8.StudsOffset = Vector3.new(0, 3, 0)

                    local _TextLabel9 = Instance.new('TextLabel')

                    _TextLabel9.Size = UDim2.new(1, 0, 1, 0)
                    _TextLabel9.BackgroundTransparency = 1
                    _TextLabel9.TextScaled = true
                    _TextLabel9.Text = 'Pizza'
                    _TextLabel9.TextColor3 = Color3.fromRGB(255, 140, 0)
                    _TextLabel9.Font = Enum.Font.Antique
                    _TextLabel9.Parent = _BillboardGui8
                end
            end

            (function()
                local v247 = _Ingame5:FindFirstChild(u240)

                if v247 then
                    u246(v247)
                end
            end)()
            _Ingame5.ChildAdded:Connect(function(p248)
                if p248.Name == u240 then
                    u246(p248)
                end
            end)
        end,
    })
    _Main:CreateButton({
        Name = 'Builderman Sentry/Dispenser esp',
        Callback = function()
            local _Ingame6 = workspace.Map.Ingame
            local u250 = Color3.fromRGB(0, 0, 255)

            Color3.fromRGB(255, 0, 0)

            local u251 = Color3.fromRGB(0, 255, 0)

            local function u258(p252, p253, p254)
                if p252 and not p252:FindFirstChildOfClass('Highlight') then
                    local _Highlight10 = Instance.new('Highlight')

                    _Highlight10.Parent = p252
                    _Highlight10.Adornee = p252
                    _Highlight10.FillTransparency = 0.75
                    _Highlight10.FillColor = p253
                    _Highlight10.OutlineColor = p253
                    _Highlight10.OutlineTransparency = 0

                    local _BillboardGui9 = Instance.new('BillboardGui')

                    _BillboardGui9.Name = p254 .. 'Label'
                    _BillboardGui9.Size = UDim2.new(0, 100, 0, 50)
                    _BillboardGui9.AlwaysOnTop = true
                    _BillboardGui9.MaxDistance = math.huge
                    _BillboardGui9.Parent = p252
                    _BillboardGui9.StudsOffset = Vector3.new(0, 3, 0)

                    local _TextLabel10 = Instance.new('TextLabel')

                    _TextLabel10.Size = UDim2.new(1, 0, 1, 0)
                    _TextLabel10.BackgroundTransparency = 1
                    _TextLabel10.TextScaled = true
                    _TextLabel10.Text = p254
                    _TextLabel10.TextColor3 = p253
                    _TextLabel10.Font = Enum.Font.Antique
                    _TextLabel10.Parent = _BillboardGui9
                end
            end
            local function v267(p259, p260, p261)
                local v262, v263, v264 = ipairs(p259)

                while true do
                    local v265

                    v264, v265 = v262(v263, v264)

                    if v264 == nil then
                        break
                    end

                    local v266 = _Ingame6:FindFirstChild(v265)

                    if v266 then
                        u258(v266, p260, p261)
                    end
                end
            end

            v267({
                'BuildermanSentryEffectRange',
                'BuildermanSentry',
            }, u250, 'Sentry')
            v267({
                'BuildermanDispenserEffectRange',
                'BuildermanDispenser',
            }, u251, 'Dispenser')
            _Ingame6.ChildAdded:Connect(function(p268)
                if p268.Name == 'BuildermanSentry' or p268.Name == 'BuildermanSentryEffectRange' then
                    u258(p268, u250, 'Sentry')
                elseif p268.Name == 'BuildermanDispenser' or p268.Name == 'BuildermanDispenserEffectRange' then
                    u258(p268, u251, 'Dispenser')
                end
            end)
        end,
    })
    _Main:CreateButton({
        Name = 'Respawn point Esp',
        Callback = function()
            local _Ingame7 = workspace.Map.Ingame

            local function u274(p270)
                if p270 and not p270:FindFirstChildWhichIsA('BillboardGui') then
                    local v271 = p270.Name:match('^(.-)RespawnLocation') or 'Unknown'
                    local _BillboardGui10 = Instance.new('BillboardGui')

                    _BillboardGui10.Name = v271 .. 'Label'
                    _BillboardGui10.Size = UDim2.new(0, 150, 0, 50)
                    _BillboardGui10.AlwaysOnTop = true
                    _BillboardGui10.MaxDistance = math.huge
                    _BillboardGui10.Parent = p270
                    _BillboardGui10.StudsOffset = Vector3.new(0, 3, 0)

                    local _TextLabel11 = Instance.new('TextLabel')

                    _TextLabel11.Size = UDim2.new(1, 0, 1, 0)
                    _TextLabel11.BackgroundTransparency = 1
                    _TextLabel11.TextScaled = true
                    _TextLabel11.Text = v271 .. ' Respawn Point'
                    _TextLabel11.TextColor3 = Color3.fromRGB(80, 80, 80)
                    _TextLabel11.Font = Enum.Font.Antique
                    _TextLabel11.Parent = _BillboardGui10
                end
            end
            local function u276(p275)
                if p275 and p275.Name:find('RespawnLocation') then
                    u274(p275)
                end
            end

            local v277, v278, v279 = ipairs(_Ingame7:GetChildren())

            while true do
                local v280

                v279, v280 = v277(v278, v279)

                if v279 == nil then
                    break
                end

                u276(v280)
            end

            _Ingame7.ChildAdded:Connect(function(p281)
                u276(p281)
            end)
        end,
    })
    _Main:CreateSection('other')

    local _LocalPlayer2 = game.Players.LocalPlayer
    local u283 = nil
    local u284 = false

    local function v288(p285)
        local _Humanoid2 = p285:FindFirstChildOfClass('Humanoid')

        if _Humanoid2 then
            local _Animation = Instance.new('Animation')

            _Animation.AnimationId = 'rbxassetid://75804462760596'
            u283 = (_Humanoid2:FindFirstChildOfClass('Animator') or _Humanoid2:WaitForChild('Animator')):LoadAnimation(_Animation)

            if u284 then
                u283:Play()
                task.wait(0.00025)
                u283:AdjustSpeed(0)
            end
        end
    end

    _Main:CreateToggle({
        Name = 'Invisibility',
        CurrentValue = false,
        Callback = function(p289)
            u284 = p289

            if u283 then
                if p289 then
                    u283:Play()
                    task.wait(0.00025)
                    u283:AdjustSpeed(0)
                else
                    u283:Stop()
                end
            end
        end,
    })

    if _LocalPlayer2.Character then
        v288(_LocalPlayer2.Character)
    end

    _LocalPlayer2.CharacterAdded:Connect(v288)
    _Main:CreateButton({
        Name = 'Instant Proximity prompt (Instant interaction)',
        Callback = function()
            local v290 = next
            local v291, v292 = workspace:GetDescendants()

            while true do
                local u293

                v292, u293 = v290(v291, v292)

                if v292 == nil then
                    break
                end
                if u293:IsA('ProximityPrompt') then
                    u293.PromptButtonHoldBegan:Connect(function()
                        if u293.HoldDuration > 0 then
                            fireproximityprompt(u293, 0)
                        end
                    end)
                end
            end

            workspace.DescendantAdded:Connect(function(p294)
                if p294:IsA('ProximityPrompt') then
                    p294.PromptButtonHoldBegan:Connect(function()
                        if p294.HoldDuration > 0 then
                            fireproximityprompt(p294, 0)
                        end
                    end)
                end
            end)
        end,
    })

    local _Lighting = game:GetService('Lighting')

    _Main:CreateButton({
        Name = 'Fullbright',
        Callback = function()
            game.workspace.Map.Ingame.ChildAdded:Connect(function()
                _Lighting.TimeOfDay = '12:00:00'
                _Lighting.FogStart = 100000
                _Lighting.FogEnd = 300000
                _Lighting.FogColor = Color3.fromRGB(255, 255, 255)
                _Lighting.GlobalShadows = true
                _Lighting.Technology = Enum.Technology.Future
                _Lighting.Ambient = Color3.fromRGB(230, 230, 230)
                _Lighting.OutdoorAmbient = Color3.fromRGB(220, 220, 220)
                _Lighting.Brightness = 3
                _Lighting.EnvironmentDiffuseScale = 1.5
                _Lighting.EnvironmentSpecularScale = 2
                _Lighting.ClockTime = 12
            end)
        end,
    })

    local function u297()
        local _Stunned = game:GetService('ReplicatedStorage').Modules.StatusEffects.Stunned

        if _Stunned then
            _Stunned:Destroy()
        else
            u1:Notify({
                Title = 'Already unstunable',
                Content = 'Your already unstunable. no need to activate it again.',
                Duration = 3,
                Image = 'shield-off',
            })
        end
    end

    _Main:CreateButton({
        Name = 'Anti Stun',
        Callback = function()
            u297()
        end,
    })

    local u298 = false

    _Main:CreateToggle({
        Name = 'Item Aura',
        CurrentValue = false,
        Flag = 'ToggleItemAura',
        Callback = function(p299)
            u298 = p299

            task.spawn(function()
                while u298 do
                    local v300, v301, v302 = ipairs(workspace.Map.Ingame:GetChildren())

                    while true do
                        local v303

                        v302, v303 = v300(v301, v302)

                        if v302 == nil then
                            break
                        end
                        if v303:FindFirstChild('ItemRoot') and v303.ItemRoot:FindFirstChild('ProximityPrompt') then
                            fireproximityprompt(v303.ItemRoot.ProximityPrompt)
                        end
                    end

                    task.wait(1)
                end
            end)
        end,
    })
    _Stamina:CreateParagraph({
        Title = 'Note:',
        Content = 'Might not work on free executors.',
    })
    _Stamina:CreateToggle({
        Name = 'Infinite Stamina',
        CurrentValue = false,
        Flag = 'Toggleinfiuddynitestamina',
        Callback = function(p304)
            stam = p304

            local u305 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
            local u306 = nil

            u306 = game:GetService('RunService').Heartbeat:Connect(function()
                if stam then
                    function u305.StaminaLossDisabled() end
                else
                    u306:Disconnect()

                    u305.StaminaLossDisabled = nil
                end
            end)
        end,
    })

    local function u310()
        local _PlayerGui2 = game.Players.LocalPlayer:WaitForChild('PlayerGui')
        local _ScreenGui2 = Instance.new('ScreenGui')

        _ScreenGui2.Name = 'BobbyScreengui'
        _ScreenGui2.Parent = _PlayerGui2
        _ScreenGui2.ResetOnSpawn = false

        local _ImageButton2 = Instance.new('ImageButton')

        _ImageButton2.Name = 'ToggleButton'
        _ImageButton2.Parent = _ScreenGui2
        _ImageButton2.Position = UDim2.new(0.65, 0.3, -0.15, 0)
        _ImageButton2.Size = UDim2.new(0, 60, 0, 60)
        _ImageButton2.BackgroundTransparency = 1
        _ImageButton2.Image = 'rbxassetid://105780464700717'
        _ImageButton2.Draggable = true

        _ImageButton2.MouseButton1Click:Connect(function()
            u1:SetVisibility(true)
        end)
    end

    u310()
    _Effects:CreateButton({
        Name = 'Remove Subspaced effect',
        Callback = function()
            local _Subspaced = game:GetService('ReplicatedStorage').Modules.StatusEffects.SurvivorExclusive:FindFirstChild('Subspaced')

            if _Subspaced then
                _Subspaced:Destroy()
            else
                u1:Notify({
                    Title = 'Its already removed:',
                    Content = 'No need to remove it again',
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })
    _Effects:CreateButton({
        Name = 'Remove Glitched effect',
        Callback = function()
            local _Glitched = game:GetService('ReplicatedStorage').Modules.StatusEffects.KillerExclusive:FindFirstChild('Glitched')

            if _Glitched then
                _Glitched:Destroy()
            else
                u1:Notify({
                    Title = 'Its already removed:',
                    Content = 'No need to remove it again',
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })
    _Effects:CreateButton({
        Name = 'Remove Blindness effect',
        Callback = function()
            local _Blindness = game:GetService('ReplicatedStorage').Modules.StatusEffects:FindFirstChild('Blindness')

            if _Blindness then
                _Blindness:Destroy()
            else
                u1:Notify({
                    Title = 'its Already Removed',
                    Content = 'Blindness effect is Already removed, No need to do it again.',
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })
    _Effects:CreateButton({
        Name = 'Remove Slowness effect',
        Callback = function()
            local _Slowness = game:GetService('ReplicatedStorage').Modules.StatusEffects:FindFirstChild('Slowness')

            if _Slowness then
                game:GetService('ReplicatedStorage').Modules.StatusEffects.Slateskin:Destroy()
                _Slowness:Destroy()
            else
                u1:Notify({
                    Title = 'Its Already Removed',
                    Content = 'Slowness effect Already Removed, No need to do it again.',
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })
    _Effects:CreateButton({
        Name = 'Remove Nausea Effect',
        Callback = function()
            local _Nausea = game:GetService('ReplicatedStorage').Modules.StatusEffects:FindFirstChild('Nausea')

            if _Nausea then
                _Nausea:Destroy()
            else
                u1:Notify({
                    Title = 'Already Removed',
                    Content = 'Nausea effect is already removed.',
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })
    _Effects:CreateButton({
        Name = 'Remove Confusion Effect',
        Callback = function()
            local _Confusion = game:GetService('ReplicatedStorage').Modules.StatusEffects:FindFirstChild('Confusion')

            if _Confusion then
                _Confusion:Destroy()
            else
                u1:Notify({
                    Title = 'Already Removed',
                    Content = 'Confusion effect is already removed.',
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })
    _Generators:CreateToggle({
        Name = 'Auto generator Fix',
        CurrentValue = false,
        Flag = 'AutogeneratorFiCoooollx',
        Callback = function(p317)
            u9 = p317

            if u9 then
                while u9 do
                    local v318, v319, v320 = pairs(game.Workspace.Map.Ingame.Map:GetChildren())

                    while true do
                        local v321

                        v320, v321 = v318(v319, v320)

                        if v320 == nil then
                            break
                        end
                        if v321.Name == 'Generator' then
                            v321:WaitForChild('Remotes'):WaitForChild('RE'):FireServer()
                        end
                    end

                    wait(u8)
                end
            else
                u9 = false
            end
        end,
    })
    _Generators:CreateSlider({
        Name = 'Delay Range',
        Range = {3, 10},
        Increment = 0.5,
        Suffix = 'Seconds',
        CurrentValue = 2.5,
        Flag = 'SliderGeneratorCYcfjiuustom',
        Callback = function(p322)
            u8 = p322
        end,
    })
    _Generators:CreateDivider()

    local u323 = nil

    _Generators:CreateToggle({
        Name = 'Instant Fix generator (GUI button)',
        CurrentValue = false,
        Flag = 'Toggleihhgtuhinstan',
        Callback = function(p324)
            if p324 then
                u323 = Instance.new('ScreenGui')

                local _TextButton2 = Instance.new('TextButton')
                local _UICorner5 = Instance.new('UICorner')
                local _UIStroke3 = Instance.new('UIStroke')

                u323.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')
                u323.ResetOnSpawn = false
                _TextButton2.Size = UDim2.new(0, 100, 0, 50)
                _TextButton2.Font = Enum.Font.FredokaOne
                _TextButton2.Position = UDim2.new(0.5, -50, 0.8, 0)
                _TextButton2.Text = 'Instant fix'
                _TextButton2.BackgroundColor3 = Color3.fromRGB(0, 119, 255)
                _TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
                _TextButton2.Parent = u323
                _TextButton2.Draggable = true
                _TextButton2.TextSize = 15
                _UICorner5.CornerRadius = UDim.new(0, 20)
                _UICorner5.Parent = _TextButton2
                _UIStroke3.Thickness = 2
                _UIStroke3.Color = Color3.fromRGB(0, 0, 0)
                _UIStroke3.Parent = _TextButton2
                _UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local u328 = false
                local u329 = 2.5

                _TextButton2.MouseEnter:Connect(function()
                    _TextButton2.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
                end)
                _TextButton2.MouseLeave:Connect(function()
                    _TextButton2.BackgroundColor3 = Color3.fromRGB(0, 119, 255)
                end)
                _TextButton2.MouseButton1Click:Connect(function()
                    if not u328 then
                        u328 = true

                        local v330, v331, v332 = pairs(game.Workspace.Map.Ingame.Map:GetChildren())

                        while true do
                            local v333

                            v332, v333 = v330(v331, v332)

                            if v332 == nil then
                                break
                            end
                            if v333.Name == 'Generator' then
                                v333:WaitForChild('Remotes'):WaitForChild('RE'):FireServer()
                            end
                        end

                        local v334 = u329

                        while v334 > 0 do
                            _TextButton2.Text = string.format('%.1f', v334)

                            task.wait(0.1)

                            v334 = v334 - 0.1
                        end

                        u328 = false
                        _TextButton2.Text = 'Instant fix'
                    end
                end)
            elseif u323 then
                u323:Destroy()

                u323 = nil
            end
        end,
    })

    local u335 = false

    _Generators:CreateKeybind({
        Name = 'Instant Fix Generator Keybind',
        CurrentKeybind = 'Q',
        HoldToInteract = false,
        Flag = 'KeybindInstantfixgen',
        Callback = function()
            if not u335 then
                u335 = true

                local v336, v337, v338 = pairs(game.Workspace.Map.Ingame.Map:GetChildren())

                while true do
                    local v339

                    v338, v339 = v336(v337, v338)

                    if v338 == nil then
                        break
                    end
                    if v339.Name == 'Generator' then
                        v339:WaitForChild('Remotes'):WaitForChild('RE'):FireServer()
                    end
                end

                task.wait(2.5)

                u335 = false
            end
        end,
    })
    _AimbotPlayer:CreateParagraph({
        Title = 'Note:',
        Content = "if your brain is too small to understand the 'Survivor aimbot' and 'Killer aimbot' so the killer aimbot is aimbot but for killers and survivor aimbot is aimbot but for survivors i made them separate so you can choose.",
    })

    local u340 = false
    local u341 = {}
    local u342 = false
    local u343 = nil
    local _Players3 = game:GetService('Players')
    local _Workspace2 = game:GetService('Workspace')
    local _RunService = game:GetService('RunService')
    local _LocalPlayer3 = _Players3.LocalPlayer
    local u348 = 0.25
    local u349 = 0.1
    local u350 = {
        'rbxassetid://87259391926321',
        'rbxassetid://106014898528300',
        'rbxassetid://87259391926321',
        'rbxassetid://86545133269813',
        'rbxassetid://89448354637442',
        'rbxassetid://90499469533503',
        'rbxassetid://116618003477002',
        'rbxassetid://106086955212611',
        'rbxassetid://107640065977686',
        'rbxassetid://77124578197357',
        'rbxassetid://101771617803133',
        'rbxassetid://134958187822107',
        'rbxassetid://111313169447787',
        'rbxassetid://71685573690338',
        'rbxassetid://71685573690338',
        'rbxassetid://129843313690921',
        'rbxassetid://97623143664485',
        'rbxassetid://129843313690921',
        'rbxassetid://136007065400978',
        'rbxassetid://136007065400978',
        'rbxassetid://86096387000557',
        'rbxassetid://86096387000557',
        'rbxassetid://108807732150251',
        'rbxassetid://138040001965654',
        'rbxassetid://73502073176819',
        'rbxassetid://129843313690921',
        'rbxassetid://97623143664485',
        'rbxassetid://129843313690921',
        'rbxassetid://97623143664485',
        'rbxassetid://97623143664485',
        'rbxassetid://97623143664485',
        'rbxassetid://86709774283672',
        'rbxassetid://106014898528300',
        'rbxassetid://87259391926321',
        'rbxassetid://140703210927645',
        'rbxassetid://96173857867228',
        'rbxassetid://121255898612475',
        'rbxassetid://98031287364865',
        'rbxassetid://119462383658044',
        'rbxassetid://77448521277146',
        'rbxassetid://77448521277146',
        'rbxassetid://103741352379819',
        'rbxassetid://119462383658044',
        'rbxassetid://131696603025265',
        'rbxassetid://122503338277352',
        'rbxassetid://97648548303678',
        'rbxassetid://133491532453922',
    }

    local function u356(p351)
        local v352, v353, v354 = ipairs(u350)

        while true do
            local v355

            v354, v355 = v352(v353, v354)

            if v354 == nil then
                break
            end
            if p351 == v355 then
                return true
            end
        end

        return false
    end
    local function u361()
        local v357, v358, v359 = ipairs(_Workspace2.Players.Killers:GetChildren())

        while true do
            local v360

            v359, v360 = v357(v358, v359)

            if v359 == nil then
                break
            end
            if v360:FindFirstChild('HumanoidRootPart') then
                return v360
            end
        end

        return nil
    end
    local function u362()
        u343 = u361()

        if u343 then
            u342 = true

            task.delay(2, function()
                u342 = false
                u343 = nil
            end)
        end
    end
    local function u367(p363)
        local v364 = p363:FindFirstChild('Humanoid') or p363:WaitForChild('Humanoid', 5)

        if v364 then
            local v366 = v364.AnimationPlayed:Connect(function(p365)
                if u340 and (p365.Animation and u356(p365.Animation.AnimationId)) then
                    u362()
                end
            end)

            table.insert(u341, v366)
        end
    end
    local function u375()
        u340 = true

        local v372 = _RunService.RenderStepped:Connect(function()
            if u342 and u343 and u343:FindFirstChild('HumanoidRootPart') then
                local _HumanoidRootPart = u343.HumanoidRootPart
                local v369 = _HumanoidRootPart.Position + _HumanoidRootPart.Velocity * u348
                local _CurrentCamera = _Workspace2.CurrentCamera
                local v371 = CFrame.new(_CurrentCamera.CFrame.Position, v369)

                _CurrentCamera.CFrame = _CurrentCamera.CFrame:Lerp(v371, u349)
            end
        end)

        table.insert(u341, v372)

        if _LocalPlayer3.Character then
            u367(_LocalPlayer3.Character)
        end

        local v374 = _LocalPlayer3.CharacterAdded:Connect(function(p373)
            u367(p373)
        end)

        table.insert(u341, v374)
    end
    local function u380()
        u340 = false
        u342 = false
        u343 = nil

        local v376, v377, v378 = ipairs(u341)

        while true do
            local v379

            v378, v379 = v376(v377, v378)

            if v378 == nil then
                break
            end
            if v379.Connected then
                v379:Disconnect()
            end
        end

        u341 = {}
    end

    _AimbotPlayer:CreateToggle({
        Name = 'Survivor Aimbot',
        CurrentValue = false,
        Flag = 'ToggleSURGUGFHBIDCWVKO',
        Callback = function(p381)
            if p381 then
                u375()
            else
                u380()
            end
        end,
    })
    _AimbotPlayer:CreateSlider({
        Name = "Survivor's Aimbot Prediction",
        Range = {0.25, 1},
        Increment = 0.25,
        Suffix = 'Prediction',
        CurrentValue = 0.25,
        Flag = 'SliderSuvrivrolrlsider',
        Callback = function(p382)
            u348 = p382
        end,
    })
    _AimbotPlayer:CreateSlider({
        Name = "Survivor's Aimbot Smoothness",
        Range = {0.05, 1},
        Increment = 0.05,
        Suffix = 'Smoothness',
        CurrentValue = 0.1,
        Flag = 'CoolSmoothnessFlag',
        Callback = function(p383)
            u349 = p383
        end,
    })
    _AimbotPlayer:CreateDivider()

    local u384 = false
    local u385 = {}
    local u386 = false
    local u387 = nil
    local _Players4 = game:GetService('Players')
    local _Workspace3 = game:GetService('Workspace')
    local _RunService2 = game:GetService('RunService')
    local _LocalPlayer4 = _Players4.LocalPlayer
    local u392 = 0.25
    local u393 = 0.1
    local u394 = {
        'rbxassetid://131430497821198',
        'rbxassetid://83829782357897',
        'rbxassetid://126830014841198',
        'rbxassetid://126355327951215',
        'rbxassetid://121086746534252',
        'rbxassetid://105458270463374',
        'rbxassetid://127172483138092',
        'rbxassetid://18885919947',
        'rbxassetid://18885909645',
        'rbxassetid://94162446513587',
        'rbxassetid://84426150435898',
        'rbxassetid://93069721274110',
        'rbxassetid://114620047310688',
        'rbxassetid://97433060861952',
        'rbxassetid://82183356141401',
        'rbxassetid://100592913030351',
        'rbxassetid://121293883585738',
        'rbxassetid://100592913030351',
        'rbxassetid://121293883585738',
        'rbxassetid://100592913030351',
        'rbxassetid://121293883585738',
        'rbxassetid://70447634862911',
        'rbxassetid://92173139187970',
        'rbxassetid://106847695270773',
        'rbxassetid://125403313786645',
        'rbxassetid://81639435858902',
        'rbxassetid://137314737492715',
        'rbxassetid://120112897026015',
        'rbxassetid://82113744478546',
        'rbxassetid://118298475669935',
        'rbxassetid://82113744478546',
        'rbxassetid://118298475669935',
        'rbxassetid://126681776859538',
        'rbxassetid://129976080405072',
        'rbxassetid://109667959938617',
        'rbxassetid://74707328554358',
        'rbxassetid://133336594357903',
        'rbxassetid://86204001129974',
        'rbxassetid://82113744478546',
        'rbxassetid://118298475669935',
        'rbxassetid://124243639579224',
        'rbxassetid://70371667919898',
        'rbxassetid://131543461321709',
        'rbxassetid://136323728355613',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
        'rbxassetid://109230267448394',
    }

    local function u400(p395)
        local v396, v397, v398 = ipairs(u394)

        while true do
            local v399

            v398, v399 = v396(v397, v398)

            if v398 == nil then
                break
            end
            if p395 == v399 then
                return true
            end
        end

        return false
    end
    local function u411()
        local v401 = nil
        local _huge = math.huge
        local _Character = _LocalPlayer4.Character
        local v404 = _Character and _Character:FindFirstChild('HumanoidRootPart')

        if v404 then
            v404 = _Character.HumanoidRootPart.Position
        end
        if v404 then
            local v405 = _Players4
            local v406, v407, v408 = ipairs(v405:GetPlayers())

            while true do
                local v409

                v408, v409 = v406(v407, v408)

                if v408 == nil then
                    break
                end
                if v409 ~= _LocalPlayer4 and v409.Character and v409.Character:FindFirstChild('HumanoidRootPart') then
                    local _Magnitude = (v409.Character.HumanoidRootPart.Position - v404).Magnitude

                    if _Magnitude < _huge then
                        _huge = _Magnitude
                        v401 = v409
                    end
                end
            end
        end

        return v401
    end
    local function u412()
        u387 = u411()

        if u387 then
            u386 = true

            task.delay(2, function()
                u386 = false
                u387 = nil
            end)
        end
    end
    local function u417(p413)
        local _Humanoid3 = p413:WaitForChild('Humanoid')

        if _Humanoid3 then
            local v416 = _Humanoid3.AnimationPlayed:Connect(function(p415)
                if u384 and (p415.Animation and u400(p415.Animation.AnimationId)) then
                    u412()
                end
            end)

            table.insert(u385, v416)
        end
    end
    local function u425()
        u384 = true

        local v422 = _RunService2.RenderStepped:Connect(function()
            if u386 and (u387 and u387.Character) and u387.Character:FindFirstChild('HumanoidRootPart') then
                local _HumanoidRootPart2 = u387.Character.HumanoidRootPart
                local v419 = _HumanoidRootPart2.Position + _HumanoidRootPart2.Velocity * u392
                local _CurrentCamera2 = _Workspace3.CurrentCamera
                local v421 = CFrame.new(_CurrentCamera2.CFrame.Position, v419)

                _CurrentCamera2.CFrame = _CurrentCamera2.CFrame:Lerp(v421, u393)
            end
        end)

        table.insert(u385, v422)

        if _LocalPlayer4.Character then
            u417(_LocalPlayer4.Character)
        end

        local v424 = _LocalPlayer4.CharacterAdded:Connect(function(p423)
            u417(p423)
        end)

        table.insert(u385, v424)
    end
    local function u430()
        u384 = false
        u386 = false
        u387 = nil

        local v426, v427, v428 = ipairs(u385)

        while true do
            local v429

            v428, v429 = v426(v427, v428)

            if v428 == nil then
                break
            end
            if v429.Connected then
                v429:Disconnect()
            end
        end

        u385 = {}
    end

    _AimbotPlayer:CreateToggle({
        Name = 'Killer Aimbot',
        CurrentValue = false,
        Flag = 'SliderYgdyhbujkillerrrrS',
        Callback = function(p431)
            if p431 then
                u425()
            else
                u430()
            end
        end,
    })
    _AimbotPlayer:CreateSlider({
        Name = "Killer's Aimbot Prediction",
        Range = {0.25, 1},
        Increment = 0.25,
        Suffix = 'Prediction',
        CurrentValue = 0.25,
        Flag = 'SliderSyxfyr',
        Callback = function(p432)
            u392 = p432
        end,
    })
    _AimbotPlayer:CreateSlider({
        Name = "Killer's Aimbot Smoothness",
        Range = {0.05, 1},
        Increment = 0.05,
        Suffix = 'Smoothness',
        CurrentValue = 0.1,
        Flag = 'KillerSmoothnessFlag',
        Callback = function(p433)
            u393 = p433
        end,
    })
    _AimbotPlayer:CreateParagraph({
        Title = 'Note:',
        Content = 'Prediction from 0.25-0.5 is recommended.',
    })
    _AimbotPlayer:CreateDivider()
    _AimbotPlayer:CreateButton({
        Name = 'Dusekarr Switchable Aimbot',
        Callback = function()
            local _LocalPlayer5 = game.Players.LocalPlayer
            local _ScreenGui3 = Instance.new('ScreenGui')

            _ScreenGui3.Parent = _LocalPlayer5:WaitForChild('PlayerGui')

            local _TextButton3 = Instance.new('TextButton')

            _TextButton3.Parent = _ScreenGui3
            _TextButton3.Size = UDim2.new(0, 200, 0, 50)
            _TextButton3.Position = UDim2.new(0.5, -100, 0.1, 0)
            _TextButton3.Text = 'Target: Survivors'
            _TextButton3.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
            _TextButton3.TextColor3 = Color3.new(1, 1, 1)
            _TextButton3.Font = Enum.Font.SourceSansBold
            _TextButton3.TextSize = 24
            _TextButton3.Draggable = true

            local u437 = 'Survivor'
            local u438 = 0.25
            local _RunService3 = game:GetService('RunService')
            local _Humanoid4 = (_LocalPlayer5.Character or _LocalPlayer5.CharacterAdded:Wait()):WaitForChild('Humanoid')
            local v441 = _Humanoid4:FindFirstChildOfClass('Animator') or _Humanoid4:WaitForChild('Animator')

            local function u443()
                local _CurrentCamera3 = workspace.CurrentCamera

                return Vector2.new(_CurrentCamera3.ViewportSize.X / 2, _CurrentCamera3.ViewportSize.Y / 2)
            end
            local function u455()
                local _huge2 = math.huge
                local _CurrentCamera4 = workspace.CurrentCamera
                local v446 = u443()
                local v447, v448, v449 = pairs(game.Players:GetPlayers())
                local v450 = nil

                while true do
                    local v451

                    v449, v451 = v447(v448, v449)

                    if v449 == nil then
                        break
                    end
                    if v451 ~= _LocalPlayer5 and v451.Character and v451.Character:FindFirstChild('HumanoidRootPart') then
                        local v452, v453 = _CurrentCamera4:WorldToViewportPoint(v451.Character.HumanoidRootPart.Position)

                        if v453 then
                            local _magnitude = (v446 - Vector2.new(v452.X, v452.Y)).magnitude

                            if _magnitude < _huge2 then
                                v450 = v451
                                _huge2 = _magnitude
                            end
                        end
                    end
                end

                return v450
            end
            local function u467()
                local _Killers3 = workspace:WaitForChild('Players'):WaitForChild('Killers')
                local _huge3 = math.huge
                local _CurrentCamera5 = workspace.CurrentCamera
                local v459 = u443()
                local v460, v461, v462 = pairs(_Killers3:GetChildren())
                local v463 = nil

                while true do
                    local v464

                    v462, v464 = v460(v461, v462)

                    if v462 == nil then
                        break
                    end
                    if v464:IsA('Model') and v464:FindFirstChild('HumanoidRootPart') then
                        local v465 = _CurrentCamera5:WorldToScreenPoint(v464.HumanoidRootPart.Position)
                        local _magnitude2 = (v459 - Vector2.new(v465.X, v465.Y)).magnitude

                        if _magnitude2 < _huge3 then
                            v463 = v464
                            _huge3 = _magnitude2
                        end
                    end
                end

                return v463
            end

            local u468 = nil
            local u469 = nil

            local function u473()
                if u468 then
                    u468:Disconnect()

                    u468 = nil
                end

                local u470 = u455()

                if u470 and u470.Character and u470.Character:FindFirstChild('HumanoidRootPart') then
                    u468 = _RunService3.RenderStepped:Connect(function()
                        if u470 and u470.Character and u470.Character:FindFirstChild('HumanoidRootPart') then
                            local _HumanoidRootPart3 = u470.Character.HumanoidRootPart
                            local v472 = _HumanoidRootPart3.Position + _HumanoidRootPart3.Velocity * u438

                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, v472)
                        end
                    end)

                    task.delay(2, function()
                        if u468 then
                            u468:Disconnect()

                            u468 = nil
                        end
                    end)
                end
            end
            local function u477()
                if u469 then
                    u469:Disconnect()

                    u469 = nil
                end

                local u474 = u467()

                if u474 and u474:FindFirstChild('HumanoidRootPart') then
                    u469 = _RunService3.RenderStepped:Connect(function()
                        if u474 and u474:FindFirstChild('HumanoidRootPart') then
                            local _HumanoidRootPart4 = u474.HumanoidRootPart
                            local v476 = _HumanoidRootPart4.Position + _HumanoidRootPart4.Velocity * u438

                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, v476)
                        end
                    end)

                    task.delay(2, function()
                        if u469 then
                            u469:Disconnect()

                            u469 = nil
                        end
                    end)
                end
            end
            local function u478()
                if u468 then
                    u468:Disconnect()

                    u468 = nil
                end
                if u469 then
                    u469:Disconnect()

                    u469 = nil
                end
                if u437 ~= 'Survivor' then
                    u477()
                else
                    u473()
                end
            end

            _TextButton3.MouseButton1Click:Connect(function()
                if u437 ~= 'Survivor' then
                    u437 = 'Survivor'
                    _TextButton3.Text = 'Target: Survivors'
                    _TextButton3.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
                else
                    u437 = 'Killer'
                    _TextButton3.Text = 'Target: Killer'
                    _TextButton3.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
                end
            end)
            v441.AnimationPlayed:Connect(function(p479)
                if p479.Animation and p479.Animation.AnimationId == 'rbxassetid://77894750279891' then
                    u478()
                end
            end)
        end,
    })
    _AimbotPlayer:CreateSection('Auto / Experimental')
    _AimbotPlayer:CreateButton({
        Name = 'Auto chance coinflip',
        Callback = function()
            local _Charges = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('MainUI'):WaitForChild('AbilityContainer'):WaitForChild('Shoot'):WaitForChild('Charges')
            local v481 = {
                'UseActorAbility',
                'CoinFlip',
            }

            while tonumber(_Charges.Text) ~= u10 do
                game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Network'):WaitForChild('RemoteEvent'):FireServer(unpack(v481))
                wait(2)
            end
        end,
    })
    _AimbotPlayer:CreateSlider({
        Name = 'Choose the range',
        Range = {1, 3},
        Increment = 1,
        Suffix = 'Coinflips',
        CurrentValue = 3,
        Flag = 'SliderCoinflip',
        Callback = function(p482)
            u10 = p482
        end,
    })
    _AimbotPlayer:CreateDivider()
    _AimbotPlayer:CreateParagraph({
        Title = 'Note:',
        Content = "Don't use auto Slash killer when your the killer, it will cuase you to auto click (but if your c00lkid then nah)",
    })

    local u483 = 10

    _AimbotPlayer:CreateToggle({
        Name = 'Auto shedletsky slash killer',
        CurrentValue = false,
        Flag = 'ToggleAutoSlash',
        Callback = function(p484)
            if p484 then
                local _RunService4 = game:GetService('RunService')
                local u486 = {
                    'UseActorAbility',
                    'Slash',
                }

                local function v491()
                    local v487, v488, v489 = ipairs(workspace.Players.Killers:GetChildren())

                    while true do
                        local v490

                        v489, v490 = v487(v488, v489)

                        if v489 == nil then
                            break
                        end
                        if v490:IsA('Model') and (v490.PrimaryPart and (v490.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude <= u483) then
                            game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Network'):WaitForChild('RemoteEvent'):FireServer(unpack(u486))
                        end
                    end
                end

                _RunService4.Heartbeat:Connect(v491)
            else
                connection:Disconnect()
            end
        end,
    })
    _AimbotPlayer:CreateSlider({
        Name = 'Auto slash Distance',
        Range = {5, 20},
        Increment = 5,
        Suffix = 'Studs',
        CurrentValue = 10,
        Flag = 'sliderForAutoslash',
        Callback = function(p492)
            u483 = p492
        end,
    })
    _AimbotPlayer:CreateDivider()

    local u493 = false

    _AimbotPlayer:CreateToggle({
        Name = 'Auto Tp to Pizza',
        CurrentValue = false,
        Flag = 'PizzaTeleportToggle',
        Callback = function(p494)
            u493 = p494

            local _LocalPlayer6 = game:GetService('Players').LocalPlayer
            local _Ingame8 = workspace.Map.Ingame
            local u497 = 'Pizza'
            local u498 = 0.5
            local u499 = 1

            local function u504(p500)
                if p500 then
                    local _Character2 = _LocalPlayer6.Character

                    if _Character2 then
                        local _HumanoidRootPart5 = _Character2:FindFirstChild('HumanoidRootPart')

                        if _HumanoidRootPart5 then
                            local _Position = _HumanoidRootPart5.Position

                            wait(u499)

                            if p500 and p500:IsDescendantOf(_Ingame8) then
                                _HumanoidRootPart5.CFrame = p500.CFrame
                            end

                            wait(u498)

                            _HumanoidRootPart5.CFrame = CFrame.new(_Position)
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
            local function u506()
                while u493 do
                    local v505 = _Ingame8:FindFirstChild(u497)

                    if v505 then
                        u504(v505)
                    end

                    wait(1)
                end
            end

            if u493 then
                u506()
            end

            _Ingame8.ChildAdded:Connect(function(p507)
                if p507.Name == u497 and u493 then
                    u506()
                end
            end)
        end,
    })

    local u508 = nil
    local u509 = 5

    _AimbotPlayer:CreateToggle({
        Name = 'Auto Block as guest (experimental, Basically bad)',
        CurrentValue = false,
        Flag = 'ToggleAutoBlock',
        Callback = function(p510)
            if p510 then
                local _RunService5 = game:GetService('RunService')
                local u512 = {
                    'UseActorAbility',
                    'Block',
                }

                local function v517()
                    local v513, v514, v515 = ipairs(workspace.Players.Killers:GetChildren())

                    while true do
                        local v516

                        v515, v516 = v513(v514, v515)

                        if v515 == nil then
                            break
                        end
                        if v516:IsA('Model') and (v516.PrimaryPart and (v516.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude <= u509) then
                            game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Network'):WaitForChild('RemoteEvent'):FireServer(unpack(u512))
                        end
                    end
                end

                u508 = _RunService5.Heartbeat:Connect(v517)
            else
                u508:Disconnect()
            end
        end,
    })
    _AimbotPlayer:CreateSlider({
        Name = 'Guest block Distance',
        Range = {5, 30},
        Increment = 5,
        Suffix = 'Studs',
        CurrentValue = 10,
        Flag = 'GuestblockSlider',
        Callback = function(p518)
            u509 = p518
        end,
    })
    _AimbotPlayer:CreateToggle({
        Name = 'Auto 1x1x1x1 Popup',
        CurrentValue = false,
        Flag = 'Toggle1x1Popupboi',
        Callback = function(p519)
            local _VirtualInputManager = game:GetService('VirtualInputManager')
            local u521 = true

            local function v530()
                while u521 do
                    local _LocalPlayer7 = game:GetService('Players').LocalPlayer
                    local v523 = _LocalPlayer7.PlayerGui.TemporaryUI:GetChildren()
                    local v524, v525, v526 = ipairs(v523)

                    while true do
                        local v527

                        v526, v527 = v524(v525, v526)

                        if v526 == nil then
                            break
                        end
                        if v527.Name == '1x1x1x1Popup' then
                            local v528 = v527.AbsolutePosition.X + v527.AbsoluteSize.X / 2
                            local v529 = v527.AbsolutePosition.Y + v527.AbsoluteSize.Y / 2 + 50

                            _VirtualInputManager:SendMouseButtonEvent(v528, v529, Enum.UserInputType.MouseButton1.Value, true, _LocalPlayer7.PlayerGui, 1)
                            _VirtualInputManager:SendMouseButtonEvent(v528, v529, Enum.UserInputType.MouseButton1.Value, false, _LocalPlayer7.PlayerGui, 1)
                        end
                    end

                    task.wait(0.1)
                end
            end

            if p519 then
                u521 = true

                spawn(v530)
            else
                u521 = false
            end
        end,
    })

    local u531 = nil
    local u532 = nil

    _AimbotPlayer:CreateToggle({
        Name = 'Auto Ghostburger At lms',
        CurrentValue = false,
        Flag = 'ToggleAutoGhostBurger',
        Callback = function(p533)
            local u534 = {
                'UseActorAbility',
                'Ghostburger',
            }
            local _Survivors2 = workspace.Players:FindFirstChild('Survivors')

            if p533 then
                local function v536()
                    if _Survivors2 and #_Survivors2:GetChildren() == 1 then
                        game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Network'):WaitForChild('RemoteEvent'):FireServer(unpack(u534))
                    end
                end

                if _Survivors2 then
                    u531 = _Survivors2.ChildAdded:Connect(v536)
                    u532 = _Survivors2.ChildRemoved:Connect(v536)
                end
                if _Survivors2 then
                    v536()
                end
            else
                if u531 then
                    u531:Disconnect()

                    u531 = nil
                end
                if u532 then
                    u532:Disconnect()

                    u532 = nil
                end
            end
        end,
    })
    _AimbotPlayer:CreateSection('Other Blatant Stuff that are character Specific also')

    local _Players5 = game:GetService('Players')
    local _RunService6 = game:GetService('RunService')
    local _Workspace4 = game:GetService('Workspace')
    local _LocalPlayer8 = _Players5.LocalPlayer
    local u541 = false

    _AimbotPlayer:CreateToggle({
        Name = 'Homing Tripmine missiles',
        CurrentValue = false,
        Flag = 'SkibdiTripminetoggle',
        Callback = function(p542)
            u541 = p542
        end,
    })

    local function u548()
        local _Players6 = _Workspace4:FindFirstChild('Players')

        if _Players6 then
            _Players6 = _Workspace4.Players:FindFirstChild('Killers')
        end
        if not _Players6 then
            return nil
        end

        local v544, v545, v546 = ipairs(_Players6:GetChildren())

        while true do
            local v547

            v546, v547 = v544(v545, v546)

            if v546 == nil then
                break
            end
            if v547:FindFirstChildWhichIsA('Humanoid') then
                return v547
            end
        end

        return nil
    end

    _RunService6.Heartbeat:Connect(function()
        if u541 then
            local _Map = _Workspace4:FindFirstChild('Map')

            if _Map then
                local _Ingame9 = _Map:FindFirstChild('Ingame')

                if _Ingame9 then
                    local _SubspaceTripmine = _Ingame9:FindFirstChild('SubspaceTripmine')

                    if _SubspaceTripmine then
                        _SubspaceTripmine = _SubspaceTripmine:FindFirstChild('SubspaceCenter')
                    end
                    if _SubspaceTripmine and (_SubspaceTripmine:IsA('BasePart') and not _SubspaceTripmine:FindFirstChild('SetupComplete')) then
                        if _LocalPlayer8.Character and _LocalPlayer8.Character:IsAncestorOf(_SubspaceTripmine) then
                            return
                        end

                        local _BoolValue = Instance.new('BoolValue')

                        _BoolValue.Name = 'SetupComplete'
                        _BoolValue.Parent = _SubspaceTripmine

                        local _BodyPosition = Instance.new('BodyPosition')

                        _BodyPosition.MaxForce = Vector3.new(1000000, 1000000, 1000000)
                        _BodyPosition.D = 1000
                        _BodyPosition.P = 10000
                        _BodyPosition.Position = _SubspaceTripmine.Position + Vector3.new(0, 4, 0)
                        _BodyPosition.Parent = _SubspaceTripmine

                        local u554 = nil

                        u554 = _RunService6.Heartbeat:Connect(function()
                            if _SubspaceTripmine and _SubspaceTripmine.Parent then
                                local v555 = u548()
                                local v556 = v555 and (v555:FindFirstChild('Torso') or (v555:FindFirstChild('UpperTorso') or v555:FindFirstChild('HumanoidRootPart')))

                                if v556 then
                                    _BodyPosition.Position = v556.Position + Vector3.new(0, 2, 0)
                                end
                            else
                                u554:Disconnect()
                            end
                        end)
                    end
                end
            else
                return
            end
        else
            return
        end
    end)

    local function u578(p557, p558)
        local _LocalPlayer9 = game.Players.LocalPlayer
        local _PlayerGui3 = _LocalPlayer9:WaitForChild('PlayerGui')
        local _ScreenGui4 = _PlayerGui3:FindFirstChild('ScreenGui')

        if not _ScreenGui4 then
            _ScreenGui4 = Instance.new('ScreenGui')
            _ScreenGui4.Name = 'ScreenGui'
            _ScreenGui4.Parent = _PlayerGui3
        end

        local _ImageButton3 = Instance.new('ImageButton')

        _ImageButton3.Size = UDim2.new(0, 100, 0, 100)
        _ImageButton3.Position = UDim2.new(0.5, -50, 0.5, -50)
        _ImageButton3.Image = p557
        _ImageButton3.BackgroundTransparency = 1
        _ImageButton3.Parent = _ScreenGui4

        local _Animation2 = Instance.new('Animation')

        _Animation2.AnimationId = p558

        local u564 = _LocalPlayer9.Character or _LocalPlayer9.CharacterAdded:Wait()

        local function v566()
            local _Humanoid5 = u564:FindFirstChildOfClass('Humanoid')

            if _Humanoid5 then
                _Humanoid5:LoadAnimation(_Animation2):Play()
            else
                warn('Skibdi')
            end
        end

        _ImageButton3.MouseButton1Click:Connect(v566)

        local _UserInputService = game:GetService('UserInputService')
        local u568 = nil
        local u569 = nil
        local u570 = nil
        local u571 = nil

        local function u574(p572)
            local v573 = p572.Position - u570

            _ImageButton3.Position = UDim2.new(u571.X.Scale, u571.X.Offset + v573.X, u571.Y.Scale, u571.Y.Offset + v573.Y)
        end

        _ImageButton3.InputBegan:Connect(function(p575)
            if p575.UserInputType == Enum.UserInputType.MouseButton1 or p575.UserInputType == Enum.UserInputType.Touch then
                u568 = true
                u570 = p575.Position
                u571 = _ImageButton3.Position

                p575.Changed:Connect(function()
                    if p575.UserInputState == Enum.UserInputState.End then
                        u568 = false
                    end
                end)
            end
        end)
        _ImageButton3.InputChanged:Connect(function(p576)
            if p576.UserInputType == Enum.UserInputType.MouseMovement or p576.UserInputType == Enum.UserInputType.Touch then
                u569 = p576
            end
        end)
        _UserInputService.InputChanged:Connect(function(p577)
            if p577 == u569 and u568 then
                u574(p577)
            end
        end)
    end

    _Fun:CreateButton({
        Name = 'Fake Punch Button',
        Callback = function()
            u578('rbxassetid://110895402653848', 'rbxassetid://87259391926321')
        end,
    })
    _Fun:CreateButton({
        Name = 'Fake block button',
        Callback = function()
            u578('rbxassetid://85125497005042', 'rbxassetid://72722244508749')
        end,
    })
    _Fun:CreateSection('flip')
    _Fun:CreateButton({
        Name = 'Backflip Button',
        Callback = function()
            local _PlayerGui4 = game.Players.LocalPlayer:WaitForChild('PlayerGui')
            local _ScreenGui5 = _PlayerGui4:FindFirstChild('ScreenGui')

            if not _ScreenGui5 then
                _ScreenGui5 = Instance.new('ScreenGui')
                _ScreenGui5.Name = 'ScreenGui'
                _ScreenGui5.Parent = _PlayerGui4
            end

            local _ImageButton4 = Instance.new('ImageButton')

            _ImageButton4.Size = UDim2.new(0, 100, 0, 100)
            _ImageButton4.Position = UDim2.new(0.5, -50, 0.5, -50)
            _ImageButton4.Image = 'rbxassetid://108983136200755'
            _ImageButton4.BackgroundTransparency = 1
            _ImageButton4.Parent = _ScreenGui5

            _ImageButton4.MouseButton1Click:Connect(function()
                local _LocalPlayer10 = game.Players.LocalPlayer
                local v583 = _LocalPlayer10.Character or _LocalPlayer10.CharacterAdded:Wait()
                local _HumanoidRootPart6 = v583:WaitForChild('HumanoidRootPart')
                local _Humanoid6 = v583:WaitForChild('Humanoid')
                local v586 = _Humanoid6

                _Humanoid6.ChangeState(v586, Enum.HumanoidStateType.Physics)

                local v587 = _Humanoid6

                _Humanoid6.SetStateEnabled(v587, Enum.HumanoidStateType.FallingDown, false)

                local v588 = _Humanoid6

                _Humanoid6.SetStateEnabled(v588, Enum.HumanoidStateType.Freefall, false)

                local v589 = _Humanoid6

                _Humanoid6.SetStateEnabled(v589, Enum.HumanoidStateType.Running, false)

                local v590 = _Humanoid6

                _Humanoid6.SetStateEnabled(v590, Enum.HumanoidStateType.Seated, false)

                local v591 = _Humanoid6

                _Humanoid6.SetStateEnabled(v591, Enum.HumanoidStateType.Climbing, false);
                (function()
                    local u592 = 0.45
                    local u593 = 120
                    local _CFrame = _HumanoidRootPart6.CFrame
                    local u595 = -_CFrame.LookVector
                    local u596 = Vector3.new(0, 1, 0)

                    task.spawn(function()
                        local v597 = tick()

                        for v598 = 1, u593 do
                            local v599 = v598 / u593
                            local v600 = 4 * (v599 - v599 ^ 2) * 10
                            local v601 = _CFrame.Position + u595 * (35 * v599) + u596 * v600
                            local v602 = _CFrame.Rotation * CFrame.Angles(-math.rad(v598 * (360 / u593)), 0, 0)

                            _HumanoidRootPart6.CFrame = CFrame.new(v601) * v602

                            local v603 = tick() - v597
                            local v604 = u592 / u593 * v598 - v603

                            if v604 > 0 then
                                task.wait(v604)
                            end
                        end

                        _HumanoidRootPart6.CFrame = CFrame.new(_CFrame.Position + u595 * 35) * _CFrame.Rotation

                        _Humanoid6:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                        _Humanoid6:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                        _Humanoid6:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                        _Humanoid6:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                        _Humanoid6:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                        _Humanoid6:ChangeState(Enum.HumanoidStateType.Running)
                    end)
                end)()
            end)

            local _UserInputService2 = game:GetService('UserInputService')
            local u606 = nil
            local u607 = nil
            local u608 = nil
            local u609 = nil

            local function u612(p610)
                local v611 = p610.Position - u608

                _ImageButton4.Position = UDim2.new(u609.X.Scale, u609.X.Offset + v611.X, u609.Y.Scale, u609.Y.Offset + v611.Y)
            end

            _ImageButton4.InputBegan:Connect(function(p613)
                if p613.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
                    u606 = true
                    u608 = p613.Position
                    u609 = _ImageButton4.Position

                    p613.Changed:Connect(function()
                        if p613.UserInputState == Enum.UserInputState.End then
                            u606 = false
                        end
                    end)
                end
            end)
            _ImageButton4.InputChanged:Connect(function(p614)
                if p614.UserInputType == Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch then
                    u607 = p614
                end
            end)
            _UserInputService2.InputChanged:Connect(function(p615)
                if p615 == u607 and u606 then
                    u612(p615)
                end
            end)
        end,
    })
    _Fun:CreateButton({
        Name = 'FrontFlip Button',
        Callback = function()
            local _PlayerGui5 = game.Players.LocalPlayer:WaitForChild('PlayerGui')
            local _ScreenGui6 = _PlayerGui5:FindFirstChild('ScreenGui')

            if not _ScreenGui6 then
                _ScreenGui6 = Instance.new('ScreenGui')
                _ScreenGui6.Name = 'ScreenGui'
                _ScreenGui6.Parent = _PlayerGui5
            end

            local _ImageButton5 = Instance.new('ImageButton')

            _ImageButton5.Size = UDim2.new(0, 100, 0, 100)
            _ImageButton5.Position = UDim2.new(0.5, -50, 0.5, -50)
            _ImageButton5.Image = 'rbxassetid://106469685305878'
            _ImageButton5.BackgroundTransparency = 1
            _ImageButton5.Parent = _ScreenGui6

            _ImageButton5.MouseButton1Click:Connect(function()
                local _LocalPlayer11 = game.Players.LocalPlayer
                local v620 = _LocalPlayer11.Character or _LocalPlayer11.CharacterAdded:Wait()
                local _HumanoidRootPart7 = v620:WaitForChild('HumanoidRootPart')
                local _Humanoid7 = v620:WaitForChild('Humanoid')
                local v623 = _Humanoid7

                _Humanoid7.ChangeState(v623, Enum.HumanoidStateType.Physics)

                local v624 = _Humanoid7

                _Humanoid7.SetStateEnabled(v624, Enum.HumanoidStateType.FallingDown, false)

                local v625 = _Humanoid7

                _Humanoid7.SetStateEnabled(v625, Enum.HumanoidStateType.Freefall, false)

                local v626 = _Humanoid7

                _Humanoid7.SetStateEnabled(v626, Enum.HumanoidStateType.Running, false)

                local v627 = _Humanoid7

                _Humanoid7.SetStateEnabled(v627, Enum.HumanoidStateType.Seated, false)

                local v628 = _Humanoid7

                _Humanoid7.SetStateEnabled(v628, Enum.HumanoidStateType.Climbing, false);
                (function()
                    local u629 = 0.45
                    local u630 = 120
                    local _CFrame2 = _HumanoidRootPart7.CFrame
                    local _LookVector = _CFrame2.LookVector
                    local u633 = Vector3.new(0, 1, 0)

                    task.spawn(function()
                        local v634 = tick()

                        for v635 = 1, u630 do
                            local v636 = v635 / u630
                            local v637 = 4 * (v636 - v636 ^ 2) * 10
                            local v638 = _CFrame2.Position + _LookVector * (35 * v636) + u633 * v637
                            local v639 = _CFrame2.Rotation * CFrame.Angles(-math.rad(v635 * (360 / u630)), 0, 0)

                            _HumanoidRootPart7.CFrame = CFrame.new(v638) * v639

                            local v640 = tick() - v634
                            local v641 = u629 / u630 * v635 - v640

                            if v641 > 0 then
                                task.wait(v641)
                            end
                        end

                        _HumanoidRootPart7.CFrame = CFrame.new(_CFrame2.Position + _LookVector * 35) * _CFrame2.Rotation

                        _Humanoid7:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                        _Humanoid7:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                        _Humanoid7:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                        _Humanoid7:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                        _Humanoid7:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                        _Humanoid7:ChangeState(Enum.HumanoidStateType.Running)
                    end)
                end)()
            end)

            local _UserInputService3 = game:GetService('UserInputService')
            local u643 = nil
            local u644 = nil
            local u645 = nil
            local u646 = nil

            local function u649(p647)
                local v648 = p647.Position - u645

                _ImageButton5.Position = UDim2.new(u646.X.Scale, u646.X.Offset + v648.X, u646.Y.Scale, u646.Y.Offset + v648.Y)
            end

            _ImageButton5.InputBegan:Connect(function(p650)
                if p650.UserInputType == Enum.UserInputType.MouseButton1 or p650.UserInputType == Enum.UserInputType.Touch then
                    u643 = true
                    u645 = p650.Position
                    u646 = _ImageButton5.Position

                    p650.Changed:Connect(function()
                        if p650.UserInputState == Enum.UserInputState.End then
                            u643 = false
                        end
                    end)
                end
            end)
            _ImageButton5.InputChanged:Connect(function(p651)
                if p651.UserInputType == Enum.UserInputType.MouseMovement or p651.UserInputType == Enum.UserInputType.Touch then
                    u644 = p651
                end
            end)
            _UserInputService3.InputChanged:Connect(function(p652)
                if p652 == u644 and u643 then
                    u649(p652)
                end
            end)
        end,
    })
    _Fun:CreateKeybind({
        Name = 'Frontflip Keybind',
        CurrentKeybind = 'P',
        HoldToInteract = false,
        Flag = 'KeybindFrontflip',
        Callback = function()
            local _LocalPlayer12 = game.Players.LocalPlayer
            local v654 = _LocalPlayer12.Character or _LocalPlayer12.CharacterAdded:Wait()
            local _HumanoidRootPart8 = v654:WaitForChild('HumanoidRootPart')
            local _Humanoid8 = v654:WaitForChild('Humanoid')
            local v657 = _Humanoid8

            _Humanoid8.ChangeState(v657, Enum.HumanoidStateType.Physics)

            local v658 = _Humanoid8

            _Humanoid8.SetStateEnabled(v658, Enum.HumanoidStateType.FallingDown, false)

            local v659 = _Humanoid8

            _Humanoid8.SetStateEnabled(v659, Enum.HumanoidStateType.Freefall, false)

            local v660 = _Humanoid8

            _Humanoid8.SetStateEnabled(v660, Enum.HumanoidStateType.Running, false)

            local v661 = _Humanoid8

            _Humanoid8.SetStateEnabled(v661, Enum.HumanoidStateType.Seated, false)

            local v662 = _Humanoid8

            _Humanoid8.SetStateEnabled(v662, Enum.HumanoidStateType.Climbing, false);
            (function()
                local u663 = 0.45
                local u664 = 120
                local _CFrame3 = _HumanoidRootPart8.CFrame
                local _LookVector2 = _CFrame3.LookVector
                local u667 = Vector3.new(0, 1, 0)

                task.spawn(function()
                    local v668 = tick()

                    for v669 = 1, u664 do
                        local v670 = v669 / u664
                        local v671 = 4 * (v670 - v670 ^ 2) * 10
                        local v672 = _CFrame3.Position + _LookVector2 * (35 * v670) + u667 * v671
                        local v673 = _CFrame3.Rotation * CFrame.Angles(-math.rad(v669 * (360 / u664)), 0, 0)

                        _HumanoidRootPart8.CFrame = CFrame.new(v672) * v673

                        local v674 = tick() - v668
                        local v675 = u663 / u664 * v669 - v674

                        if v675 > 0 then
                            task.wait(v675)
                        end
                    end

                    _HumanoidRootPart8.CFrame = CFrame.new(_CFrame3.Position + _LookVector2 * 35) * _CFrame3.Rotation

                    _Humanoid8:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                    _Humanoid8:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                    _Humanoid8:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                    _Humanoid8:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    _Humanoid8:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                    _Humanoid8:ChangeState(Enum.HumanoidStateType.Running)
                end)
            end)()
        end,
    })
    _Fun:CreateKeybind({
        Name = 'Backflip Keybind',
        CurrentKeybind = 'L',
        HoldToInteract = false,
        Flag = 'KeybindBaxlflip',
        Callback = function()
            local _LocalPlayer13 = game.Players.LocalPlayer
            local v677 = _LocalPlayer13.Character or _LocalPlayer13.CharacterAdded:Wait()
            local _HumanoidRootPart9 = v677:WaitForChild('HumanoidRootPart')
            local _Humanoid9 = v677:WaitForChild('Humanoid')
            local v680 = _Humanoid9

            _Humanoid9.ChangeState(v680, Enum.HumanoidStateType.Physics)

            local v681 = _Humanoid9

            _Humanoid9.SetStateEnabled(v681, Enum.HumanoidStateType.FallingDown, false)

            local v682 = _Humanoid9

            _Humanoid9.SetStateEnabled(v682, Enum.HumanoidStateType.Freefall, false)

            local v683 = _Humanoid9

            _Humanoid9.SetStateEnabled(v683, Enum.HumanoidStateType.Running, false)

            local v684 = _Humanoid9

            _Humanoid9.SetStateEnabled(v684, Enum.HumanoidStateType.Seated, false)

            local v685 = _Humanoid9

            _Humanoid9.SetStateEnabled(v685, Enum.HumanoidStateType.Climbing, false);
            (function()
                local u686 = 0.45
                local u687 = 120
                local _CFrame4 = _HumanoidRootPart9.CFrame
                local u689 = -_CFrame4.LookVector
                local u690 = Vector3.new(0, 1, 0)

                task.spawn(function()
                    local v691 = tick()

                    for v692 = 1, u687 do
                        local v693 = v692 / u687
                        local v694 = 4 * (v693 - v693 ^ 2) * 10
                        local v695 = _CFrame4.Position + u689 * (35 * v693) + u690 * v694
                        local v696 = _CFrame4.Rotation * CFrame.Angles(-math.rad(v692 * (360 / u687)), 0, 0)

                        _HumanoidRootPart9.CFrame = CFrame.new(v695) * v696

                        local v697 = tick() - v691
                        local v698 = u686 / u687 * v692 - v697

                        if v698 > 0 then
                            task.wait(v698)
                        end
                    end

                    _HumanoidRootPart9.CFrame = CFrame.new(_CFrame4.Position + u689 * 35) * _CFrame4.Rotation

                    _Humanoid9:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                    _Humanoid9:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                    _Humanoid9:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                    _Humanoid9:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    _Humanoid9:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                    _Humanoid9:ChangeState(Enum.HumanoidStateType.Running)
                end)
            end)()

            local _UserInputService4 = game:GetService('UserInputService')
            local u700 = nil
            local u701 = nil
            local u702 = nil
            local u703 = nil

            local function u706(p704)
                local v705 = p704.Position - u702

                imageButton.Position = UDim2.new(u703.X.Scale, u703.X.Offset + v705.X, u703.Y.Scale, u703.Y.Offset + v705.Y)
            end

            imageButton.InputBegan:Connect(function(p707)
                if p707.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
                    u700 = true
                    u702 = p707.Position
                    u703 = imageButton.Position

                    p707.Changed:Connect(function()
                        if p707.UserInputState == Enum.UserInputState.End then
                            u700 = false
                        end
                    end)
                end
            end)
            imageButton.InputChanged:Connect(function(p708)
                if p708.UserInputType == Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch then
                    u701 = p708
                end
            end)
            _UserInputService4.InputChanged:Connect(function(p709)
                if p709 == u701 and u700 then
                    u706(p709)
                end
            end)
        end,
    })
    _Fun:CreateSection('Fe Animations')

    local u710 = nil

    _Fun:CreateToggle({
        Name = 'Masterbait',
        CurrentValue = false,
        Flag = 'MasterbaitToggle',
        Callback = function(p711)
            local _LocalPlayer14 = game.Players.LocalPlayer
            local _Humanoid10 = (_LocalPlayer14.Character or _LocalPlayer14.CharacterAdded:Wait()):FindFirstChildOfClass('Humanoid')

            if _Humanoid10 then
                if p711 then
                    if not (u710 and u710.IsPlaying) then
                        local _Animation3 = Instance.new('Animation')

                        _Animation3.AnimationId = 'rbxassetid://72042024'
                        u710 = _Humanoid10:LoadAnimation(_Animation3)
                        u710.Looped = true

                        u710:Play()
                    end
                elseif u710 and u710.IsPlaying then
                    u710:Stop()
                end
            end
        end,
    })
    _Fun:CreateToggle({
        Name = 'Arms-out Spin',
        CurrentValue = false,
        Flag = 'ArmsOutSpinToggle',
        Callback = function(p715)
            local _LocalPlayer15 = game.Players.LocalPlayer
            local _Humanoid11 = (_LocalPlayer15.Character or _LocalPlayer15.CharacterAdded:Wait()):FindFirstChildOfClass('Humanoid')

            if _Humanoid11 then
                if p715 then
                    if not (u710 and u710.IsPlaying) then
                        local _Animation4 = Instance.new('Animation')

                        _Animation4.AnimationId = 'rbxassetid://235542946'
                        u710 = _Humanoid11:LoadAnimation(_Animation4)

                        u710:Play()
                    end
                elseif u710 and u710.IsPlaying then
                    u710:Stop()
                end
            end
        end,
    })
    _Fun:CreateToggle({
        Name = 'Spinning Hands',
        CurrentValue = false,
        Flag = 'SpinningHandsToggle',
        Callback = function(p719)
            local _LocalPlayer16 = game.Players.LocalPlayer
            local _Humanoid12 = (_LocalPlayer16.Character or _LocalPlayer16.CharacterAdded:Wait()):FindFirstChildOfClass('Humanoid')

            if _Humanoid12 then
                if p719 then
                    if not (u710 and u710.IsPlaying) then
                        local _Animation5 = Instance.new('Animation')

                        _Animation5.AnimationId = 'rbxassetid://259438880'
                        u710 = _Humanoid12:LoadAnimation(_Animation5)
                        u710.Looped = true

                        u710:Play()
                    end
                elseif u710 and u710.IsPlaying then
                    u710:Stop()
                end
            end
        end,
    })
    _Fun:CreateToggle({
        Name = 'Jumping Jacks',
        CurrentValue = false,
        Flag = 'JumpingJacksToggle',
        Callback = function(p723)
            local _LocalPlayer17 = game.Players.LocalPlayer
            local _Humanoid13 = (_LocalPlayer17.Character or _LocalPlayer17.CharacterAdded:Wait()):FindFirstChildOfClass('Humanoid')

            if _Humanoid13 then
                if p723 then
                    if not (u710 and u710.IsPlaying) then
                        local _Animation6 = Instance.new('Animation')

                        _Animation6.AnimationId = 'rbxassetid://429681631'
                        u710 = _Humanoid13:LoadAnimation(_Animation6)
                        u710.Looped = true

                        u710:Play()
                    end
                elseif u710 and u710.IsPlaying then
                    u710:Stop()
                end
            end
        end,
    })
    _Fun:CreateButton({
        Name = 'slide button',
        Callback = function()
            local _LocalPlayer18 = game.Players.LocalPlayer
            local _PlayerGui6 = _LocalPlayer18:WaitForChild('PlayerGui')
            local _ScreenGui7 = _PlayerGui6:FindFirstChild('ScreenGui')

            if not _ScreenGui7 then
                _ScreenGui7 = Instance.new('ScreenGui')
                _ScreenGui7.Name = 'ScreenGui'
                _ScreenGui7.Parent = _PlayerGui6
            end

            local _ImageButton6 = Instance.new('ImageButton')

            _ImageButton6.Size = UDim2.new(0, 100, 0, 100)
            _ImageButton6.Position = UDim2.new(0.5, -50, 0.5, -50)
            _ImageButton6.Image = 'rbxassetid://110777561976075'
            _ImageButton6.BackgroundTransparency = 1
            _ImageButton6.Parent = _ScreenGui7
            _ImageButton6.Draggable = true

            _ImageButton6.MouseButton1Click:Connect(function()
                local v731 = _LocalPlayer18.Character or _LocalPlayer18.CharacterAdded:Wait()
                local _HumanoidRootPart10 = v731:WaitForChild('HumanoidRootPart')
                local _Humanoid14 = v731:WaitForChild('Humanoid')
                local _Animation7 = Instance.new('Animation')

                _Animation7.AnimationId = 'rbxassetid://182749109'

                local u735 = _Humanoid14:LoadAnimation(_Animation7)
                local v736 = u735

                u735.Play(v736)

                local _TweenService2 = game:GetService('TweenService')
                local v738 = _HumanoidRootPart10.CFrame * CFrame.new(0, 0, -20)
                local v739 = _TweenService2:Create(_HumanoidRootPart10, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = v738})

                v739:Play()
                v739.Completed:Connect(function()
                    u735:Stop()
                end)
            end)
        end,
    })
    _Fun:CreateSection('Animation Packs')

    local function u756(p740, p741, p742)
        local _LocalPlayer19 = game.Players.LocalPlayer
        local v744 = _LocalPlayer19.Character or _LocalPlayer19.CharacterAdded:Wait()
        local _Humanoid15 = v744:WaitForChild('Humanoid')
        local _HumanoidRootPart11 = v744:WaitForChild('HumanoidRootPart')
        local _Animator = _Humanoid15:WaitForChild('Animator')

        local function v750(p748)
            local _Animation8 = Instance.new('Animation')

            _Animation8.AnimationId = p748

            return _Animator:LoadAnimation(_Animation8)
        end

        local u751 = v750(p740)
        local u752 = v750(p741)
        local u753 = v750(p742)

        local function v755()
            local _Magnitude2 = _HumanoidRootPart11.Velocity.Magnitude

            if _Magnitude2 < 1 then
                if not u751.IsPlaying then
                    u751:Play()
                    u752:Stop(0.2)
                    u753:Stop(0.2)
                end
            elseif _Magnitude2 >= 20 then
                if not u753.IsPlaying then
                    u753:Play()
                    u751:Stop(0.2)
                    u752:Stop(0.2)
                end
            elseif not u752.IsPlaying then
                u752:Play()
                u751:Stop(0.2)
                u753:Stop(0.2)
            end
        end

        game:GetService('RunService').Heartbeat:Connect(v755)
    end

    _Fun:CreateButton({
        Name = '2017 animation Pack',
        Callback = function()
            u756('rbxassetid://124622205682529', 'rbxassetid://99127941563341', 'rbxassetid://99159420513149')
        end,
    })
    _Fun:CreateButton({
        Name = 'Stalker animation pack',
        Callback = function()
            u756('rbxassetid://135419935358802', 'rbxassetid://95469909855529', 'rbxassetid://109671225388655')
        end,
    })
    _Fun:CreateButton({
        Name = 'Chill animation pack',
        Callback = function()
            u756('rbxassetid://132811450080149', 'rbxassetid://90163253241107', 'rbxassetid://96194626828153')
        end,
    })
    _Fun:CreateButton({
        Name = "John doe's animation pack",
        Callback = function()
            u756('rbxassetid://105880087711722', 'rbxassetid://81193817424328', 'rbxassetid://132653655520682')
        end,
    })
    _Fun:CreateButton({
        Name = "C00lkid's animation pack",
        Callback = function()
            u756('rbxassetid://18885903667', 'rbxassetid://18885906143', 'rbxassetid://96571077893813')
        end,
    })
    _Fun:CreateButton({
        Name = "Noli's animation pack",
        Callback = function()
            u756('rbxassetid://83465205704188', 'rbxassetid://116353529220765', 'rbxassetid://117451341682452')
        end,
    })
    _Fun:CreateButton({
        Name = 'Cool animation pack',
        Callback = function()
            u756('rbxassetid://115268929362938', 'rbxassetid://123678890237669', 'rbxassetid://132086389849889')
        end,
    })
    _Fun:CreateButton({
        Name = "Bludude's animation pack",
        Callback = function()
            u756('rbxassetid://115268929362938I', 'rbxassetid://18885906143', 'rbxassetid://96571077893813')
        end,
    })
    _Fun:CreateButton({
        Name = 'Jeff the killer animation pack',
        Callback = function()
            local _LocalPlayer20 = game.Players.LocalPlayer
            local _Humanoid16 = (_LocalPlayer20.Character or _LocalPlayer20.CharacterAdded:Wait()):WaitForChild('Humanoid')
            local _Animation9 = Instance.new('Animation')

            _Animation9.AnimationId = 'rbxassetid://252557606'

            local u760 = nil
            local _Animation10 = Instance.new('Animation')

            _Animation10.AnimationId = 'rbxassetid://124622205682529'

            local u762 = nil

            _Humanoid16.Running:Connect(function(p763)
                if p763 > 0 then
                    if u762 and u762.IsPlaying then
                        u762:Stop()
                    end
                    if not (u760 and u760.IsPlaying) then
                        u760 = _Humanoid16:LoadAnimation(_Animation9)
                        u760.Looped = true

                        u760:Play()
                    end
                else
                    if u760 and u760.IsPlaying then
                        u760:Stop()
                    end
                    if not (u762 and u762.IsPlaying) then
                        u762 = _Humanoid16:LoadAnimation(_Animation10)
                        u762.Looped = true

                        u762:Play()
                    end
                end
            end)
        end,
    })
    _Credits:CreateParagraph({
        Title = 'Note:',
        Content = 'If you have any suggestions or to report smh, Please Suggest it on our discord.',
    })
    _Credits:CreateLabel('hiiamcool0066_17937: a special guy(helped through alot)', 81011198561140, Color3.fromRGB(90, 90, 90), false)
    _Credits:CreateLabel('Creator: Bob.47', 70727208556993, Color3.fromRGB(90, 90, 90), false)
    _Credits:CreateLabel('doitenroi_9941: helped me through setting up the discord server', 111385007873003, Color3.fromRGB(90, 90, 90), false)
    _Settings:CreateButton({
        Name = 'Unload the Gui ',
        Callback = function()
            u1:Destroy()

            local _EmoteGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild('EmoteGui')

            if _EmoteGui then
                _EmoteGui:Destroy()
            end

            local _BobbyScreengui = game.Players.LocalPlayer.PlayerGui:FindFirstChild('BobbyScreengui')

            if _BobbyScreengui then
                _BobbyScreengui:Destroy()
            end
        end,
    })
    _Settings:CreateSection('Themes')
    _Settings:CreateButton({
        Name = 'Set Default theme',
        Callback = function()
            u64.ModifyTheme('Default')
        end,
    })
    _Settings:CreateButton({
        Name = 'Set AmberGlow theme',
        Callback = function()
            u64.ModifyTheme('AmberGlow')
        end,
    })
    _Settings:CreateToggle({
        Name = "Remove 'B0bby' Button",
        CurrentValue = false,
        Flag = 'Toggle910',
        Callback = function(p766)
            if p766 then
                local _BobbyScreengui2 = game.Players.LocalPlayer.PlayerGui:FindFirstChild('BobbyScreengui')

                if _BobbyScreengui2 then
                    _BobbyScreengui2:Destroy()
                end
            else
                u310()
            end
        end,
    })

    local function u768()
        while true do
            game:GetService('TextChatService').ChatWindowConfiguration.Enabled = true

            wait(10)
        end
    end
end)()
