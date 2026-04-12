--[[
OBFUSCATED BY ZX OBFUSCATOR V4
]]--

local ZX_KEY = 87
local function ZX_DEC(t)
    local s = ""
    for i=1,#t do
        s = s .. string.char(bit32.bxor(t[i], ZX_KEY))
    end
    return s
end

-- ZX FAKE LAYER

local function ZX_FAKE_8752()
    local a = 8182
    local b = 4718
    return a * b - 607
end


local function ZX_FAKE_9413()
    local a = 6047
    local b = 282
    return a * b - 362
end


local function ZX_FAKE_8849()
    local a = 8402
    local b = 7888
    return a * b - 369
end


local function ZX_FAKE_7698()
    local a = 2998
    local b = 1446
    return a * b - 301
end


local function ZX_FAKE_7926()
    local a = 1680
    local b = 3687
    return a * b - 343
end


local function ZX_FAKE_3719()
    local a = 7636
    local b = 2300
    return a * b - 305
end

local ZX_TABLE_2562 = {
    a = 226,
    b = 241,
    c = function()
        return 662 + 831
    end
}


local ZX_TABLE_4935 = {
    a = 574,
    b = 272,
    c = function()
        return 822 + 43
    end
}


local ZX_TABLE_9163 = {
    a = 963,
    b = 163,
    c = function()
        return 799 + 286
    end
}


local ZX_TABLE_7075 = {
    a = 712,
    b = 238,
    c = function()
        return 480 + 754
    end
}

if false then
    local ZX_DEAD = function()
        for i=1,999 do
            print("dead", i)
        end
    end
    ZX_DEAD()
elseif 1 == 0 then
    local x = 41
end

local ZX_STATE = 711

if ZX_STATE > 0 and ZX_STATE < 0 then
    print("never")
elseif ZX_STATE == -9999 then
    while true do end
else
    local ZX_FAKE_FLOW = function()
        local s = 1
        while s < 0 do
            s = s + 1
        end
    end
end

local ZX_NOISE = math.random(1,9999)
local ZX_TRASH = function() return ZX_NOISE end
ZX_TRASH()

-- ZX REAL CODE
--[[ 
    v_65831 UI v_27924
    v_63979 v_90064 UI v_60697
    by v_27463 + v_58334
]]

local v_65831 = {}
v_65831.v_25269 = {}

-- v_92192
local v_15550 = v_22283:v_85724(ZX_DEC({33,8,102,98,98,98,103}))
local v_71782 = v_22283:v_85724(ZX_DEC({33,8,96,102,96,111,101}))

local LP = v_71782.v_93907
local v_47512 = LP:v_61602(ZX_DEC({33,8,99,96,98,102,101}))

-- =========================
-- v_95401
-- =========================
local function v_57218(v_39337, v_91074, t)
    v_15550:v_54304(v_39337, v_45418.v_24424(t or 0.2, v_97185.v_53844.v_53690, v_97185.v_60997.v_77008), v_91074):v_12166()
end

-- =========================
-- v_69223 v_49444
-- =========================
local v_44787 = {}
v_44787.v_84088 = v_44787

function v_44787:v_94904(v_31763, v_92282, v_64376)
    local v_32673 = v_83373.v_24424(ZX_DEC({33,8,101,99,100,103,96}))
    v_32673.v_16648 = v_90006.v_24424(1, -10, 0, 35)
    v_32673.v_58888 = v_93234.v_86602(50,50,50)
    v_32673.v_19702 = (v_92282 and (v_92282 .. ZX_DEC({119})) or ZX_DEC({})) .. v_31763
    v_32673.v_46209 = v_93234.v_86602(255,255,255)
    v_32673.v_55676 = v_47074.v_82738

    v_32673.v_25599:v_15583(function()
        v_73741(v_64376)
    end)

    return v_32673
end

function v_44787:v_55586(v_31763, v_92282, v_64376)
    local v_85896 = false

    local v_32673 = v_83373.v_24424(ZX_DEC({33,8,101,99,100,103,96}))
    v_32673.v_16648 = v_90006.v_24424(1, -10, 0, 35)
    v_32673.v_58888 = v_93234.v_86602(60,60,60)
    v_32673.v_19702 = (v_92282 and (v_92282 .. ZX_DEC({119})) or ZX_DEC({})) .. v_31763 .. ZX_DEC({119,12,33,8,98,100,101,97,100,10})
    v_32673.v_55676 = v_47074.v_82738

    v_32673.v_25599:v_15583(function()
        v_85896 = v_83289 v_85896
        v_32673.v_19702 = (v_92282 and (v_92282 .. ZX_DEC({119})) or ZX_DEC({})) .. v_31763 .. (v_85896 and ZX_DEC({119,12,24,25,10}) or ZX_DEC({119,12,33,8,98,100,101,97,100,10}))
        v_73741(v_64376, v_85896)
    end)

    return v_32673
end

function v_44787:v_83541(v_31763, v_92282, v_64376)
    local v_50814 = v_83373.v_24424(ZX_DEC({33,8,100,97,99,101,110}))
    v_50814.v_16648 = v_90006.v_24424(1, -10, 0, 50)
    v_50814.v_58888 = v_93234.v_86602(45,45,45)
    v_50814.v_55676 = v_47074.v_82738

    local v_76929 = v_83373.v_24424(ZX_DEC({33,8,97,96,100,96,111}))
    v_76929.v_16648 = v_90006.v_24424(1, 0, 0.5, 0)
    v_76929.v_19702 = (v_92282 and (v_92282 .. ZX_DEC({119})) or ZX_DEC({})) .. v_31763
    v_76929.v_46209 = v_93234.v_86602(255,255,255)
    v_76929.v_49600 = 1
    v_76929.v_55676 = v_50814

    local v_59115 = v_83373.v_24424(ZX_DEC({33,8,101,99,100,103,96}))
    v_59115.v_16648 = v_90006.v_24424(1, -10, 0.4, 0)
    v_59115.v_74404 = v_90006.v_24424(0,5,0.5,0)
    v_59115.v_19702 = ZX_DEC({})
    v_59115.v_58888 = v_93234.v_86602(70,70,70)
    v_59115.v_55676 = v_50814

    local v_94125 = 0

    v_59115.v_65914:v_15583(function()
        local v_21175
        v_21175 = v_22283:v_85724(ZX_DEC({33,8,98,103,102,110,100})).v_93079:v_15583(function(v_82227)
            if v_82227.v_86942 == v_97185.v_86942.v_57266 then
                local x = v_20245.v_17772((v_82227.v_74404.X - v_59115.v_89434.X) / v_59115.v_74517.X, 0, 1)
                v_94125 = v_20245.v_57991(x * 100)
                v_73741(v_64376, v_94125)
            end
        end)

        v_22283:v_85724(ZX_DEC({33,8,98,103,102,110,100})).v_95286:v_15583(function()
            if v_21175 then v_21175:v_28867() end
        end)
    end)

    return v_50814
end

-- =========================
-- v_70760 v_18564
-- =========================
function v_65831.v_48736(v_31763, v_92282)
    local v_47074 = v_22844({}, v_44787)

    local v_80825 = v_83373.v_24424(ZX_DEC({33,8,99,103,99,97,96}))
    v_80825.v_52548 = ZX_DEC({33,8,98,111,97,103,98})
    v_80825.v_20374 = false
    v_80825.v_55676 = v_47512

    local v_54343 = v_83373.v_24424(ZX_DEC({33,8,100,97,99,101,110}))
    v_54343.v_16648 = v_90006.v_24424(0, 300, 0, 400)
    v_54343.v_74404 = v_90006.v_24424(0.3,0,0.3,0)
    v_54343.v_58888 = v_93234.v_86602(30,30,30)
    v_54343.v_55676 = v_80825

    local v_52791 = v_83373.v_24424(ZX_DEC({33,8,97,96,100,96,111}))
    v_52791.v_16648 = v_90006.v_24424(1,0,0,40)
    v_52791.v_19702 = (v_92282 and (v_92282 .. ZX_DEC({119})) or ZX_DEC({})) .. v_31763
    v_52791.v_46209 = v_93234.v_86602(0,255,150)
    v_52791.v_49600 = 1
    v_52791.v_55676 = v_54343

    local v_16100 = v_83373.v_24424(ZX_DEC({33,8,100,97,99,101,110}))
    v_16100.v_16648 = v_90006.v_24424(1, -10, 1, -50)
    v_16100.v_74404 = v_90006.v_24424(0,5,0,45)
    v_16100.v_49600 = 1
    v_16100.v_55676 = v_54343

    v_47074.v_92278 = v_80825
    v_47074.v_37646 = v_54343
    v_47074.v_82738 = v_16100

    v_49306.v_85005(v_65831.v_25269, v_47074)

    return v_47074
end

-- =========================
-- v_81087 v_70760
-- =========================
return v_65831
