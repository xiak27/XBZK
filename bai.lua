local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local authUserUrl = "https://pastebin.com/raw/n2y94cnE"
local scriptUrl = "https://raw.githubusercontent.com/xiak27/637/refs/heads/main/small%20empty%20script.lua"

local function createAlert(message)
    local screenGui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local textLabel = Instance.new("TextLabel")
    local closeButton = Instance.new("TextButton")
    
    screenGui.Parent = player.PlayerGui
    screenGui.Name = "AccessAlert"
    
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    textLabel.Size = UDim2.new(0.9, 0, 0.7, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 18
    textLabel.TextWrapped = true
    textLabel.Parent = frame
    
    closeButton.Size = UDim2.new(0.5, 0, 0.2, 0)
    closeButton.Position = UDim2.new(0.25, 0, 0.8, -20)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    closeButton.Text = "关闭"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = Color3.white
    closeButton.TextSize = 16
    closeButton.Parent = frame
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
end

local function checkAccess()
    local success, response = pcall(function()
        return HttpService:GetAsync(authUserUrl, true)
    end)
    
    if not success then
        createAlert("无法获取授权列表\n错误: " .. response)
        return
    end
    
    local authorizedUsers = {}
    for username in string.gmatch(response, "[^\r\n]+") do
        table.insert(authorizedUsers, username:lower())
    end
    
    local currentUser = player.Name:lower()
    local isAuthorized = false
    
    for _, username in ipairs(authorizedUsers) do
        if username == currentUser then
            isAuthorized = true
            break
        end
    end
    
    if isAuthorized then
        loadstring(game:HttpGet(scriptUrl))()
    else
        createAlert("⚠️ 访问被拒绝 ⚠️\n\n" ..
                   player.Name .. " 未在授权列表中\n" ..
                   "请联系管理员获取权限")
    end
end

task.wait(2)
checkAccess()
