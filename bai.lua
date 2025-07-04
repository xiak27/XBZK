-- 请将此脚本放入 StarterPlayerScripts 或 StarterPack 中的 LocalScript 文件夹
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local function main()
    -- 配置参数
    local PASTEBIN_URL = "https://pastebin.com/raw/n2y94cnE"  -- 允许的用户名存储地址
    local SCRIPT_URL = "https://raw.githubusercontent.com/xiak27/637/refs/heads/main/small empty script.lua"  -- 要执行的脚本地址

    -- 获取当前玩家信息
    local LocalPlayer = Players.LocalPlayer
    local CurrentUsername = LocalPlayer.Name

    -- 从Pastebin获取允许的用户名（去除首尾空白）
    local AllowedUsername = HttpService:GetAsync(PASTEBIN_URL):gsub("^%s*(.-)%s*$", "%1")

    -- 权限验证
    if CurrentUsername == AllowedUsername then
        -- 执行远程脚本
        local Success, Result = pcall(function()
            local ScriptContent = HttpService:GetAsync(SCRIPT_URL)
            loadstring(ScriptContent)()
        end)

        -- 错误处理
        if not Success then
            warn("脚本执行失败: " .. tostring(Result))
            showWarning("脚本执行失败\n错误信息: " .. tostring(Result))
        end
    else
        -- 显示警告UI
        showWarning("禁止使用！\n当前用户: " .. CurrentUsername .. "\n允许用户: " .. AllowedUsername)
    end
end

-- 警告UI显示函数
local function showWarning(Message)
    local LocalPlayer = game.Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    -- 创建GUI容器
    local WarningGui = Instance.new("ScreenGui")
    WarningGui.Name = "AntiCheatWarning"
    WarningGui.Parent = PlayerGui

    -- 背景面板
    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(0, 400, 0, 200)
    Background.Position = UDim2.new(0.5, -200, 0.5, -100)
    Background.BorderSizePixel = 0
    Background.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Background.Parent = WarningGui

    -- 文本标签
    local WarningText = Instance.new("TextLabel")
    WarningText.Size = UDim2.new(1, 0, 1, -40)
    WarningText.Position = UDim2.new(0, 0, 0, 20)
    WarningText.BackgroundTransparency = 1
    WarningText.Font = Enum.Font.GothamBold
    WarningText.TextColor3 = Color3.new(1, 0, 0)
    WarningText.TextSize = 18
    WarningText.Text = Message
    WarningText.TextWrapped = true
    WarningText.TextXAlignment = Enum.TextXAlignment.Center
    WarningText.Parent = Background

    -- 确认按钮
    local ConfirmButton = Instance.new("TextButton")
    ConfirmButton.Size = UDim2.new(0, 150, 0, 40)
    ConfirmButton.Position = UDim2.new(0.5, -75, 1, -20)
    ConfirmButton.BorderSizePixel = 0
    ConfirmButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    ConfirmButton.Font = Enum.Font.Gotham
    ConfirmButton.TextColor3 = Color3.new(1, 1, 1)
    ConfirmButton.TextSize = 16
    ConfirmButton.Text = "确认"
    ConfirmButton.Parent = Background

    -- 按钮点击效果
    ConfirmButton.MouseEnter:Connect(function()
        ConfirmButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end)
    
    ConfirmButton.MouseLeave:Connect(function()
        ConfirmButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
end

-- 启动主程序
main()
