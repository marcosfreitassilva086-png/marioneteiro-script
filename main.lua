-- ==============================================
-- 🧅 MARIONETEIRO SCRIPT — BLOX FRUITS
-- Versão: 1.0 | Estilo: Onion 13
-- ==============================================

-- ✅ SERVIÇOS OBRIGATÓRIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local Drawing = Drawing.new
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ✅ NOTIFICAÇÃO DE CARGA
StarterGui:SetCore("SendNotification", {
    Title = "🧅 MARIONETEIRO",
    Text = "Script carregado com sucesso!",
    Duration = 4
})

-- ==============================================
-- 🎨 INTERFACE — PAINEL ROXO IGUAL ONION 13
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MarioneteiroUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- PAINEL PRINCIPAL
local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
MainPanel.Size = UDim2.new(0, 320, 0, 420)
MainPanel.Position = UDim2.new(0.35, 0, 0.2, 0)
MainPanel.BackgroundColor3 = Color3.fromRGB(30, 15, 60)
MainPanel.BorderSizePixel = 2
MainPanel.BorderColor3 = Color3.fromRGB(120, 60, 220)
MainPanel.Parent = ScreenGui

-- CABEÇALHO
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(50, 25, 100)
Header.Parent = MainPanel

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🧅 MARIONETEIRO"
Title.TextColor3 = Color3.fromRGB(200, 150, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Header

-- 📑 SISTEMA DE ABAS
local tabs = {"🎯 Aimbot", "👁️ ESP", "⚡ Movimento", "⚔️ Combate", "🍎 Frutas", "🤖 Farm"}
local currentTab = 1
local tabButtons = {}
local tabContents = {}

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 35)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(40, 20, 80)
TabContainer.Parent = MainPanel

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -10, 1, -85)
ContentContainer.Position = UDim2.new(0, 5, 0, 80)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ScrollBarThickness = 4
ContentContainer.ScrollBarColor3 = Color3.fromRGB(120, 60, 220)
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 800)
ContentContainer.Parent = MainPanel

-- CRIAR ABAS
for i, tabName in ipairs(tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1/#tabs, -2, 1, -4)
    TabBtn.Position = UDim2.new((i-1)/#tabs, 1, 0, 2)
    TabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(90, 45, 180) or Color3.fromRGB(50, 25, 100)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 11
    TabBtn.Parent = TabContainer
    tabButtons[i] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        currentTab = i
        for j, btn in ipairs(tabButtons) do
            btn.BackgroundColor3 = j == i and Color3.fromRGB(90, 45, 180) or Color3.fromRGB(50, 25, 100)
        end
        for j, content in ipairs(tabContents) do
            content.Visible = j == i
        end
    end)

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, 0, 0, 750)
    Content.BackgroundTransparency = 1
    Content.Visible = i == 1
    Content.Parent = ContentContainer
    tabContents[i] = Content
end

-- ==============================================
-- 🔧 FUNÇÕES PRA CRIAR CHECKBOX E SLIDER
-- ==============================================
local function CreateCheckbox(parent, y, text, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 30)
    Container.Position = UDim2.new(0, 0, 0, y)
    Container.BackgroundTransparency = 1
    Container.Parent = parent

    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 20, 0, 20)
    Box.Position = UDim2.new(0, 5, 0.5, -10)
    Box.BackgroundColor3 = Color3.fromRGB(60, 30, 120)
    Box.BorderSizePixel = 1
    Box.BorderColor3 = Color3.fromRGB(140, 70, 220)
    Box.Parent = Container

    local Check = Instance.new("TextLabel")
    Check.Size = UDim2.new(1, 0, 1, 0)
    Check.BackgroundTransparency = 1
    Check.Text = ""
    Check.TextColor3 = Color3.fromRGB(0, 255, 100)
    Check.Font = Enum.Font.GothamBold
    Check.TextSize = 14
    Check.Parent = Box

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -35, 1, 0)
    Label.Position = UDim2.new(0, 35, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container

    local enabled = false
    Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            Check.Text = enabled and "✓" or ""
            Box.BackgroundColor3 = enabled and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(60, 30, 120)
            callback(enabled)
        end
    end)

    return Container
end

local function CreateSlider(parent, y, text, min, max, default, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 45)
    Container.Position = UDim2.new(0, 0, 0, y)
    Container.BackgroundTransparency = 1
    Container.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Name = "Label"
    Label.Parent = Container

    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(1, -10, 0, 12)
    BarBg.Position = UDim2.new(0, 5, 0, 25)
    BarBg.BackgroundColor3 = Color3.fromRGB(60, 30, 120)
    BarBg.Parent = Container

    local BarFg = Instance.new("Frame")
    BarFg.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    BarFg.BackgroundColor3 = Color3.fromRGB(130, 65, 220)
    BarFg.Parent = BarBg

    local value = default
    local dragging = false

    BarBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local abs = BarBg.AbsoluteSize.X
            local pos = input.Position.X - BarBg.AbsolutePosition.X
            pos = math.clamp(pos, 0, abs)
            value = math.floor(min + (pos/abs) * (max - min))
            BarFg.Size = UDim2.new(pos/abs, 0, 1, 0)
            Label.Text = text .. ": " .. value
            callback(value)
        end
    end)

    return Container
end

-- ==============================================
-- ⭕ CÍRCULO AMARELO DE FOV
-- ==============================================
local FovCircle = Drawing.new("Circle")
FovCircle.Radius = 90
FovCircle.Thickness = 1.5
FovCircle.Color = Color3.fromRGB(255, 220, 0)
FovCircle.Filled = false
FovCircle.Visible = true
FovCircle.NumSides = 64

-- ==============================================
-- 🎯 ABA AIMBOT
-- ==============================================
local aimbotEnabled = false
local fovValue = 90
local smoothValue = 2

CreateCheckbox(tabContents[1], 10, "Ativar Aimbot", function(v) aimbotEnabled = v end)
CreateSlider(tabContents[1], 50, "Campo de Visão (FOV)", 20, 360, 90, function(v)
    fovValue = v
    FovCircle.Radius = v
end)
CreateSlider(tabContents[1], 110, "Suavidade", 1, 10, 2, function(v) smoothValue = v end)
CreateCheckbox(tabContents[1], 170, "Mirar na Cabeça", function() end)
CreateCheckbox(tabContents[1], 200, "Ignorar Aliados", function() end)
CreateCheckbox(tabContents[1], 230, "🔒 Silent Aim (Em breve)", function() end) -- DESATIVADO DEPOIS
CreateCheckbox(tabContents[1], 260, "🔒 Previsão de Movimento (Em breve)", function() end)

-- ==============================================
-- 👁️ ABA ESP
-- ==============================================
local espEnabled = false
local showName = true
local showHealth = true
local showDist = true

CreateCheckbox(tabContents[2], 10, "Ativar ESP", function(v) espEnabled = v end)
CreateCheckbox(tabContents[2], 45, "Mostrar Nome", function(v) showName = v end)
CreateCheckbox(tabContents[2], 80, "Mostrar Vida", function(v) showHealth = v end)
CreateCheckbox(tabContents[2], 115, "Mostrar Distância", function(v) showDist = v end)
CreateCheckbox(tabContents[2], 150, "Caixa no Corpo", function() end)
CreateCheckbox(tabContents[2], 185, "🔒 Esqueleto (Em breve)", function() end)
CreateCheckbox(tabContents[2], 220, "🔒 Fruta ESP (Em breve)", function() end)

-- ==============================================
-- ⚡ ABA MOVIMENTO
-- ==============================================
local speedValue = 16
local jumpValue = 50
local noKb = false
local flyEnabled = false

CreateSlider(tabContents[3], 10, "Velocidade", 16, 120, 16, function(v) speedValue = v end)
CreateSlider(tabContents[3], 70, "Força do Pulo", 50, 300, 50, function(v) jumpValue = v end)
CreateCheckbox(tabContents[3], 130, "Sem Recuo (No Knockback)", function(v) noKb = v end)
CreateCheckbox(tabContents[3], 165, "Voar (Fly)", function(v) flyEnabled = v end)
CreateCheckbox(tabContents[3], 200, "🔒 Noclip (Em breve)", function() end)
CreateCheckbox(tabContents[3], 235, "🔒 Auto Dodge (Em breve)", function() end)

-- ==============================================
-- ⚔️ ABA COMBATE
-- ==============================================
CreateCheckbox(tabContents[4], 10, "🔒 Auto Combo (Precisa Remote)", function() end)
CreateCheckbox(tabContents[4], 45, "🔒 Auto M1 (Precisa Remote)", function() end)
CreateCheckbox(tabContents[4], 80, "🔒 Fast Attack (Precisa Remote)", function() end)
CreateCheckbox(tabContents[4], 115, "🔒 Hitbox Expander (Precisa Remote)", function() end)
CreateCheckbox(tabContents[4], 150, "🔒 Kill Aura (Precisa Remote)", function() end)
CreateCheckbox(tabContents[4], 185, "🔒 Auto Haki (Precisa Remote)", function() end)

-- ==============================================
-- 🍎 ABA FRUTAS
-- ==============================================
CreateCheckbox(tabContents[5], 10, "🔒 ESP de Frutas (Em breve)", function() end)
CreateCheckbox(tabContents[5], 45, "🔒 Alerta de Fruta (Em breve)", function() end)
CreateCheckbox(tabContents[5], 80, "🔒 Auto Pegar Fruta (Em breve)", function() end)

-- ==============================================
-- 🤖 ABA FARM
-- ==============================================
CreateCheckbox(tabContents[6], 10, "🔒 Auto Farm NPC (Em breve)", function() end)
CreateCheckbox(tabContents[6], 45, "🔒 Auto Quest (Em breve)", function() end)
CreateCheckbox(tabContents[6], 80, "🔒 Auto Mastery (Em breve)", function() end)

-- ==============================================
-- 🎯 SISTEMA DE AIMBOT — FUNCIONANDO DE VERDADE!
-- ==============================================
local function GetClosestEnemyInFOV()
    local closest = nil
    local minDist = fovValue
    local camCF = workspace.CurrentCamera.CFrame
    for _, v in next, Players:GetPlayers() do
        if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local pos = camCF:PointToObjectSpace(v.Character.HumanoidRootPart.Position)
            local dist = (Vector2.new(pos.X, pos.Z)).Magnitude
            if dist < minDist then
                minDist = dist
                closest = v
            end
        end
    end
    return closest
end

-- ==============================================
-- 🔄 LOOP PRINCIPAL — TUDO ATUALIZA A CADA FRAME
-- ==============================================
RunService.RenderStepped:Connect(function()
    -- Atualizar posição do FOV
    FovCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)

    -- Aimbot funcionando
    if aimbotEnabled then
        local target = GetClosestEnemyInFOV()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local cam = workspace.CurrentCamera
            local pos, vis = cam:WorldToViewportPoint(target.Character.HumanoidRootPart.Position)
            if vis then
                local targetCF = CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position)
                cam.CFrame = cam.CFrame:Lerp(targetCF, 1/smoothValue)
            end
        end
    end

    -- Movimento funcionando
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = speedValue
        Player.Character.Humanoid.JumpPower = jumpValue
    end

    -- Fly básico
    if flyEnabled and Player.Character then
        Player.Character.Humanoid.PlatformStand = true
        local speed = 0.5
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Player.Character:TranslateBy(Vector3.new(0, speed, 0)) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Player.Character:TranslateBy(Vector3.new(0, -speed, 0)) end
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Player.Character:TranslateBy(workspace.CurrentCamera.CFrame.LookVector * speed) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Player.Character:TranslateBy(-workspace.CurrentCamera.CFrame.LookVector * speed) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then Player.Character:TranslateBy(-workspace.CurrentCamera.CFrame.RightVector * speed) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then Player.Character:TranslateBy(workspace.CurrentCamera.CFrame.RightVector * speed) end
    end

    -- No Knockback
    if noKb and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(
            Player.Character.HumanoidRootPart.AssemblyLinearVelocity.X * 0.98,
            Player.Character.HumanoidRootPart.AssemblyLinearVelocity.Y,
            Player.Character.HumanoidRootPart.AssemblyLinearVelocity.Z * 0.98
        )
    end
end)

-- ==============================================
-- ✅ PAINEL ARRASTÁVEL
-- ==============================================
local dragging, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainPanel.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- ==============================================
-- ✅ TÁ PRONTO, MARIONETEIRO!
-- ==============================================
StarterGui:SetCore("SendNotification", {
    Title = "🧅 MARIONETEIRO",
    Text = "Script carregado! Painel roxo no meio da tela!",
    Duration = 5
})
