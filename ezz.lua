--// Modern NoxLera Hack Menu - Kenara Yapışan, Otomatik Gizlenen, Animasyonlu
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoxLeraGui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame (Ana Menü)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 220)
Frame.Position = UDim2.new(1, -190, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BackgroundTransparency = 0
Frame.Active = true
Frame.ClipsDescendants = true
Frame.BorderSizePixel = 0
Frame.Name = "MainFrame"

local corner = Instance.new("UICorner", Frame)
corner.CornerRadius = UDim.new(0, 10)

local hiddenPosition = UDim2.new(1, 0, 0.2, 0)
local shownPosition = UDim2.new(1, -190, 0.2, 0)
Frame.Position = hiddenPosition

-- Sürüklenirken şeffaflaşma
Frame.Draggable = true
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
    end
end)
Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end
end)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "NoxLeraX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- Layout
local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Ses
local function createClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9118821992"
    sound.Volume = 0.5
    sound.Parent = Frame
    return sound
end
local clickSound = createClickSound()

-- Buton oluşturma
local function createButton(name, callback)
    local btn = Instance.new("Frame", Frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0

    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel", btn)
    label.Size = UDim2.new(1, -35, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("Frame", btn)
    box.Size = UDim2.new(0, 20, 0, 20)
    box.Position = UDim2.new(1, -25, 0.5, -10)
    box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    local border = Instance.new("UIStroke", box)
    border.Color = Color3.fromRGB(0, 0, 0)
    border.Thickness = 2
    local boxCorner = Instance.new("UICorner", box)
    boxCorner.CornerRadius = UDim.new(0, 4)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)

    local state = false
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -12, 0, 28)}):Play()
            clickSound:Play()
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -10, 0, 30)}):Play()
            state = not state
            if state then
                box.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
            callback(state)
        end
    end)
end

----------------------------------------------------------------
-- Hile Fonksiyonları
----------------------------------------------------------------

-- Player ESP
local function toggleESP(state)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if state then
                if not plr.Character:FindFirstChild("NoxLera_HL") then
                    local highlight = Instance.new("Highlight", plr.Character)
                    highlight.Name = "NoxLera_HL"
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.FillTransparency = 0.7
                    highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                    highlight.Adornee = plr.Character
                end

                -- Billboard ismi beyaz, stroke siyah
                local head = plr.Character:FindFirstChild("Head")
                if head and not head:FindFirstChild("NoxLera_BB") then
                    local billboard = Instance.new("BillboardGui", head)
                    billboard.Name = "NoxLera_BB"
                    billboard.Size = UDim2.new(0, 120, 0, 30)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    billboard.AlwaysOnTop = true

                    local label = Instance.new("TextLabel", billboard)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = plr.Name
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.TextScaled = true
                    label.Font = Enum.Font.GothamBold
                    label.TextStrokeTransparency = 0
                    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    label.TextXAlignment = Enum.TextXAlignment.Center
                end
            else
                if plr.Character:FindFirstChild("NoxLera_HL") then plr.Character.NoxLera_HL:Destroy() end
                local head = plr.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("NoxLera_BB") then head.NoxLera_BB:Destroy() end
            end
        end
    end
end

-- Speed Hack
local speedEnabled = false
local speedValue = 100
local speedConn
local function toggleSpeed(state)
    speedEnabled = state
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if state then
        if humanoid then humanoid.WalkSpeed = speedValue end
        speedConn = RunService.RenderStepped:Connect(function()
            if speedEnabled and humanoid and humanoid.WalkSpeed ~= speedValue then
                humanoid.WalkSpeed = speedValue
            end
        end)
    else
        if humanoid then humanoid.WalkSpeed = 16 end
        if speedConn then speedConn:Disconnect() end
    end
end

-- Infinity Jump (Geliştirilmiş)
local infJumpEnabled = false
local function toggleInfJump(state)
    infJumpEnabled = state
end

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoid and hrp then
            if humanoid.Health <= 1 then humanoid.Health = 20 end
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
            humanoid:ChangeState("Jumping")
        end
    end
end)

----------------------------------------------------------------
-- Butonlar
----------------------------------------------------------------
createButton("Player ESP", toggleESP)
createButton("Speed Hack", toggleSpeed)
createButton("Infinity Jump", toggleInfJump)

-- Menü aç/kapa tuşu (sağ Ctrl)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        if Frame.Position == hiddenPosition then
            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = shownPosition}):Play()
        else
            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = hiddenPosition}):Play()
        end
    end
end)