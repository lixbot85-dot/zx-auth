-- <-Json Loader V1-> --
-- <-Simple Code-> --
-- Made by zxrealm in scriptblox :> --
local JsonLoader = {}

function JsonLoader.Load(url)
    local HttpService = game:GetService("HttpService")
    
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then
        warn("[JsonLoader] Não foi possível acessar URL:", response)
        return {}
    end

    local data = {}
    local decodeSuccess, res = pcall(function()
        return HttpService:JSONDecode(response)
    end)
    if decodeSuccess then
        data = res
    else
        warn("[JsonLoader] Erro ao decodificar JSON:", res)
        return {}
    end

    local list = {}
    if type(data) == "table" then
        for _, item in pairs(data) do
            table.insert(list, item)
        end
    end

    return list
end

return JsonLoader
