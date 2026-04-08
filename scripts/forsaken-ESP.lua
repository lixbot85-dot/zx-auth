-- <-Deobfuscated if get deleted-> --
-- <-MoonSecV3-> --
local _Players = game:GetService('Players')
local _RunService = game:GetService('RunService')
local _CurrentCamera = workspace.CurrentCamera
local _LocalPlayer = _Players.LocalPlayer
local u5 = true
local u6 = {
    'Killers',
    'Survivors',
    'Spectating',
}
local u7 = {
    'View Health',
    'View Distance',
    'Show if One Hit',
}
local u8 = {
    Killers = Color3.fromRGB(255, 0, 0),
    Survivors = Color3.fromRGB(0, 255, 0),
    Spectating = Color3.fromRGB(128, 128, 128),
}
local u9 = {}

local function u14(p10)
    local _Square = Drawing.new('Square')

    _Square.Visible = false
    _Square.Color = p10
    _Square.Thickness = 1
    _Square.Filled = false

    local _Square2 = Drawing.new('Square')

    _Square2.Visible = false
    _Square2.Color = Color3.new(0, 0, 0)
    _Square2.Thickness = 3
    _Square2.Filled = false

    local _Text = Drawing.new('Text')

    _Text.Visible = false
    _Text.Size = 13
    _Text.Center = true
    _Text.Outline = true
    _Text.Font = 2
    _Text.Color = p10

    return _Square, _Square2, _Text
end
local function u17(p15)
    local v16 = u9[p15]

    if v16 then
        v16.conn:Disconnect()
        v16.box:Remove()
        v16.outline:Remove()
        v16.label:Remove()

        u9[p15] = nil
    end
end
local function u24(p18, p19)
    local v20, v21, v22 = pairs(p18)

    while true do
        local v23

        v22, v23 = v20(v21, v22)

        if v22 == nil then
            break
        end
        if v23 == p19 then
            return true
        end
    end

    return false
end
local function u31(p25)
    local v26 = _Players
    local v27, v28, v29 = ipairs(v26:GetPlayers())

    while true do
        local v30

        v29, v30 = v27(v28, v29)

        if v29 == nil then
            break
        end
        if v30.Character == p25 then
            return v30
        end
    end

    return nil
end
local function u33(p32)
    return p32 == 'Killers' and 'Killer' or (p32 == 'Survivors' and 'Survivor' or (p32 == 'Spectating' and 'Spectating' or 'Player'))
end
local function u43(p34, p35, p36, p37, p38)
    local v39 = u33(p35)
    local v40

    if p35 == 'Survivors' and p36 <= 20 then
        v40 = u24(p38, 'Show if One Hit')
    else
        v40 = false
    end

    local v41 = u24(p38, 'View Health')
    local v42 = u24(p38, 'View Distance')

    if v40 then
        if v41 and v42 then
            return ('%s: %s | Health: %d | Distance: %d [ONE HIT] [%s]'):format(v39, p34.Name, p36, p37, v39)
        elseif v41 then
            return ('%s: %s | Health: %d [ONE HIT] [%s]'):format(v39, p34.Name, p36, v39)
        elseif v42 then
            return ('%s: %s | Distance: %d [ONE HIT] [%s]'):format(v39, p34.Name, p37, v39)
        else
            return ('%s: %s [ONE HIT] [%s]'):format(v39, p34.Name, v39)
        end
    elseif v41 and v42 then
        return ('%s: %s | Health: %d | Distance: %d [%s]'):format(v39, p34.Name, p36, p37, v39)
    elseif v41 then
        return ('%s: %s | Health: %d [%s]'):format(v39, p34.Name, p36, v39)
    elseif v42 then
        return ('%s: %s | Distance: %d [%s]'):format(v39, p34.Name, p37, v39)
    else
        return ('%s: %s [%s]'):format(v39, p34.Name, v39)
    end
end
local function u65(p44, p45, p46)
    local _HumanoidRootPart = p45:FindFirstChild('HumanoidRootPart')
    local _Humanoid = p45:FindFirstChildOfClass('Humanoid')

    if _HumanoidRootPart and _Humanoid then
        local u49, u50, u51 = u14(u8[p46])

        u9[p44] = {
            box = u49,
            outline = u50,
            label = u51,
            conn = _RunService.RenderStepped:Connect(function()
                if p45 and (p45.Parent and (_HumanoidRootPart and _Humanoid)) then
                    local v52 = u31(p45)

                    if v52 then
                        if u5 and u24(u6, p46) then
                            local v53, v54 = _CurrentCamera:WorldToViewportPoint(_HumanoidRootPart.Position)

                            if v54 then
                                local _Character = _LocalPlayer.Character

                                if _Character then
                                    _Character = _LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                                end

                                local v56 = _Character and math.floor((_Character.Position - _HumanoidRootPart.Position).Magnitude) or 0
                                local v57 = math.floor(_Humanoid.Health)
                                local v58 = u43(v52, p46, v57, v56, u7)
                                local v59 = 1 / (v53.Z * math.tan(math.rad(_CurrentCamera.FieldOfView * 0.5)) * 2) * 1000
                                local v60 = math.floor(4.5 * v59)
                                local v61 = math.floor(6 * v59)
                                local v62 = math.floor(v53.X - v60 / 2)
                                local v63 = math.floor(v53.Y - v61 / 2)
                                local v64 = p46 == 'Survivors' and (v57 <= 20 and (u24(u7, 'Show if One Hit') and Color3.fromRGB(189, 144, 23))) or u8[p46]

                                u49.Size = Vector2.new(v60, v61)
                                u49.Position = Vector2.new(v62, v63)
                                u49.Color = v64
                                u49.Visible = true
                                u50.Size = u49.Size
                                u50.Position = u49.Position
                                u50.Visible = true
                                u51.Position = Vector2.new(v62 + v60 / 2, v63 - 14)
                                u51.Text = v58
                                u51.Color = v64
                                u51.Visible = true
                            else
                                u49.Visible = false
                                u50.Visible = false
                                u51.Visible = false
                            end
                        else
                            u49.Visible = false
                            u50.Visible = false
                            u51.Visible = false
                        end
                    else
                        u17(p44)

                        return
                    end
                else
                    u17(p44)

                    return
                end
            end),
        }
    end
end
local function u80()
    local v66, v67, v68 = pairs({
        'Killers',
        'Survivors',
        'Spectating',
    })
    local v69 = {}

    while true do
        local v70

        v68, v70 = v66(v67, v68)

        if v68 == nil then
            break
        end
        if u24(u6, v70) then
            local _Players2 = workspace:FindFirstChild('Players')

            if _Players2 then
                _Players2 = workspace.Players:FindFirstChild(v70)
            end
            if _Players2 then
                local v72, v73, v74 = ipairs(_Players2:GetChildren())

                while true do
                    local v75

                    v74, v75 = v72(v73, v74)

                    if v74 == nil then
                        break
                    end

                    local v76 = v70 .. '_' .. tostring(v75)

                    v69[v76] = true

                    if not u9[v76] then
                        u65(v76, v75, v70)
                    end
                end
            end
        end
    end

    local v77, v78, v79 = pairs(u9)

    while true do
        v79 = v77(v78, v79)

        if v79 == nil then
            break
        end
        if not v69[v79] then
            u17(v79)
        end
    end
end

task.spawn(function()
    while true do
        if u5 then
            u80()
        else
            local v81, v82, v83 = pairs(u9)

            while true do
                v83 = v81(v82, v83)

                if v83 == nil then
                    break
                end

                u17(v83)
            end
        end

        task.wait(0.1)
    end
end)
