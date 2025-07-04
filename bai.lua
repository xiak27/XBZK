local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- 设置白名单URL和远程脚本URL
local WHITELIST_URL = "https://pastebin.com/raw/n2y94cnE"
local REMOTE_SCRIPT_URL = "https://raw.githubusercontent.com/xiak27/637/refs/heads/main/small%20empty%20script.lua"

-- 创建弹窗UI的函数（确保在PlayerGui存在时创建）
local function createPopup()
    -- 确保PlayerGui存在
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        playerGui = Instance.new("PlayerGui")
        playerGui.Name = "PlayerGui"
        playerGui.Parent = player
    end
    
    -- 创建UI元素
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WhitelistPopup"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    
    -- 背景遮罩
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.new(0, 0, 0)
    background.BackgroundTransparency = 0.5
    background.Parent = screenGui
    
    -- 弹窗主体
    local popupFrame = Instance.new("Frame")
    popupFrame.Size = UDim2.new(0, 300, 0, 200)
    popupFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    popupFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    popupFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    popupFrame.BorderSizePixel = 0
    popupFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = popupFrame
    
    -- 标题
    local title = Instance.new("TextLabel")
    title.Text = "白名单验证失败"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Parent = popupFrame
    
    -- 内容
    local content = Instance.new("TextLabel")
    content.Text = "抱歉，你不在白名单中\n无法使用此功能\n请联系管理员获取权限"
    content.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    content.Font = Enum.Font.Gotham
    content.TextSize = 16
    content.TextWrapped = true
    content.Size = UDim2.new(1, -40, 0, 80)
    content.Position = UDim2.new(0, 20, 0, 50)
    content.BackgroundTransparency = 1
    content.Parent = popupFrame
    
    -- 按钮
    local button = Instance.new("TextButton")
    button.Text = "确定 (5)"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.Size = UDim2.new(0, 120, 0, 40)
    button.Position = UDim2.new(0.5, -60, 1, -60)
    button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    button.Parent = popupFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    -- 倒计时功能
    local counter = 5
    local function updateButton()
        button.Text = "确定 (" .. counter .. ")"
        counter -= 1
        
        if counter < 0 then
            player:Kick("请获取白名单后再尝试")
        else
            wait(1)
            updateButton()
        end
    end
    
    -- 按钮点击事件
    button.MouseButton1Click:Connect(function()
        player:Kick("请获取白名单后再尝试")
    end)
    
    -- 启动倒计时
    updateButton()
end

-- 安全获取白名单函数（添加重试机制）
local function fetchWhitelist()
    local retries = 3
    local delay = 2
    
    for i = 1, retries do
        local success, response = pcall(function()
            return HttpService:GetAsync(WHITELIST_URL, true)
        end)
        
        if success then
            local whitelist = {}
            for username in response:gmatch("[^\r\n]+") do
                whitelist[username:lower()] = true
            end
            return whitelist
        else
            warn("获取白名单失败 (尝试 " .. i .. "/" .. retries .. "): " .. tostring(response))
            if i < retries then
                wait(delay)
            end
        end
    end
    
    warn("无法获取白名单列表")
    return {}
end

-- 主执行逻辑（添加更多错误处理）
local function main()
    -- 等待玩家加载完成
    repeat
        player:WaitForChild("Name")
        wait(0.5)
    until player:IsLoaded() or wait(5)
    
    if not player:IsLoaded() then
        warn("玩家加载超时")
        return
    end
    
    local whitelist = fetchWhitelist()
    local currentUsername = player.Name:lower()
    
    if whitelist[currentUsername] then
        -- 白名单用户：加载远程脚本
        local success, err = pcall(function()
            local scriptContent = game:HttpGet(REMOTE_SCRIPT_URL, true)
            loadstring(scriptContent)()
        end)
        
        if not success then
            warn("远程脚本加载失败: " .. tostring(err))
            player:Kick("脚本加载失败，请重试")
        end
    else
        -- 非白名单用户：显示弹窗
        local success, err = pcall(createPopup)
        if not success then
            warn("弹窗创建失败: " .. tostring(err))
            player:Kick("白名单验证失败")
        end
    end
end

-- 安全启动主函数
local success, err = pcall(main)
if not success then
    warn("脚本执行失败: " .. tostring(err))
    player:Kick("初始化错误")
end