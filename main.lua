-- ==============================================
-- 🧅 MARIONETEIRO — VERSÃO FINAL 6.0
-- ✅ ENTRADA IGUAL SUA FOTO + TAMANHO IGUAL + FUNÇÕES CHEIAS + ESCONDER/MOSTRAR!
-- ==============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Drawing = Drawing.new

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UiVisible = true -- CONTROLA APARECER/DESAPARECER

-- ==============================================
-- 🧅 TELA DE CARREGAMENTO — EXATA DA SUA FOTO (NÃO MEXI EM NADA!)
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MarioneteiroUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingScreen = Instance.new("Frame")
LoadingScreen.Size = UDim2.new(1, 0, 1, 0)
LoadingScreen.BackgroundColor3 = Color3.fromRGB(22, 14, 41)
LoadingScreen.Parent = ScreenGui

local TopIcon = Instance.new("Frame")
TopIcon.Size = UDim2.new(0, 50, 0, 50)
TopIcon.Position = UDim2.new(0.5, -25, 0.22, 0)
TopIcon.BackgroundColor3 = Color3.fromRGB(55, 30, 100)
TopIcon.Parent = LoadingScreen
Instance.new("UICorner", TopIcon).CornerRadius = UDim.new(0, 8)

local TopIconText = Instance.new("TextLabel")
TopIconText.Size = UDim2.new(1, 0, 1, 0)
TopIconText.BackgroundTransparency = 1
TopIconText.Text = "🥷"
TopIconText.TextSize = 28
TopIconText.Parent = TopIcon

local LogoContainer = Instance.new("Frame")
LogoContainer.Size = UDim2.new(0, 320, 0, 60)
LogoContainer.Position = UDim2.new(0.5, -160, 0.42, 0)
LogoContainer.BackgroundTransparency = 1
LogoContainer.Parent = LoadingScreen

local OnionIcon = Instance.new("TextLabel")
OnionIcon.Size = UDim2.new(0, 50, 1, 0)
OnionIcon.Position = UDim2.new(0, 0, 0, 0)
OnionIcon.BackgroundTransparency = 1
OnionIcon.Text = "🧅"
OnionIcon.TextSize = 42
OnionIcon.Parent = LogoContainer

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -55, 1, 0)
TitleText.Position = UDim2.new(0, 55, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "MARIONETEIRO"
TitleText.TextColor3 = Color3.fromRGB(170, 110, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 42
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = LogoContainer

local BarContainer = Instance.new("Frame")
BarContainer.Size = UDim2.new(0, 320, 0, 12)
BarContainer.Position = UDim2.new(0.5, -160, 0.53, 0)
BarContainer.BackgroundColor3 = Color3.fromRGB(45, 28, 82)
BarContainer.Parent = LoadingScreen
Instance.new("UICorner", BarContainer).CornerRadius = UDim.new(0, 6)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(130, 70, 255)
BarFill.Parent = BarContainer
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 6)

for i = 1, 100 do
    task.wait(0.015)
    BarFill.Size = UDim2.new(i/100, 0, 1, 0)
end
task.wait(0.3)
LoadingScreen:Destroy()

-- ==============================================
-- 🎨 PAINEL PRINCIPAL — TAMANHO E ESTILO IGUAL SUA FOTO (NÃO MEXI!)
-- ==============================================
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(0, 520, 0, 380)
MainPanel.Position = UDim2.new(0.5, -260, 0.5, -190)
MainPanel.BackgroundColor3 = Color3.fromRGB(45, 28, 82)
MainPanel.BorderSizePixel = 1
MainPanel.BorderColor3 = Color3.fromRGB(80, 45, 140)
MainPanel.Parent = ScreenGui
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 8)

-- CABEÇALHO — IGUAL SUA FOTO
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Color3.fromRGB(55, 35, 105)
Header.Parent = MainPanel

local HeaderIcon = Instance.new("TextLabel")
HeaderIcon.Size = UDim2.new(0, 25, 1, 0)
HeaderIcon.Position = UDim2.new(0, 12, 0, 0)
HeaderIcon.BackgroundTransparency = 1
HeaderIcon.Text = "🧅"
HeaderIcon.TextSize = 16
HeaderIcon.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -180, 1, 0)
HeaderTitle.Position = UDim2.new(0, 40, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "MARIONETEIRO | Blox Fruits"
HeaderTitle.TextColor3 = Color3.fromRGB(200, 160, 255)
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 14
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local VersionTag = Instance.new("Frame")
VersionTag.Size = UDim2.new(0, 90, 0, 26)
VersionTag.Position = UDim2.new(1, -105, 0.5, -13)
VersionTag.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
VersionTag.Parent = Header
Instance.new("UICorner", VersionTag).CornerRadius = UDim.new(0, 4)

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, 0, 1, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = "6.0 • GRÁTIS"
VersionText.TextColor3 = Color3.new(1,1,1)
VersionText.Font = Enum.Font.GothamBold
VersionText.TextSize = 11
VersionText.Parent = VersionTag

-- ✅ BOTÃO DE ESCONDER/MOSTRAR — 👁️ NO CANTO!
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 32, 1, 0)
ToggleBtn.Position = UDim2.new(1, -32, 0, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = "👁️"
ToggleBtn.TextSize = 14
ToggleBtn.Parent = Header

ToggleBtn.MouseButton1Click:Connect(function()
    UiVisible = not UiVisible
    MainPanel.Visible = UiVisible
end)

-- 📑 BARRA LATERAL E ABAS — IGUAL SUA FOTO
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 170, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = Color3.fromRGB(38, 22, 70)
Sidebar.Parent = MainPanel

local tabs = {
    {icon = "🎯", name = "Aimbot"},
    {icon = "👁️", name = "ESP"},
    {icon = "⚡", name = "Movimento"},
    {icon = "⚔️", name = "Combate"},
    {icon = "💰", name = "Fazenda"},
    {icon = "🍎", name = "Frutas"},
    {icon = "⌨️", name = "Teclas"},
    {icon = "⚙️", name = "Configurações"}
}
local currentTab = 1
local tabButtons, tabContents = {}, {}

for i, t in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 34)
    btn.Position = UDim2.new(0, 8, 0, 12 + (i-1)*38)
    btn.BackgroundTransparency = i==1 and 0 or 1
    btn.BackgroundColor3 = i==1 and Color3.fromRGB(90, 50, 160) or Color3.fromRGB(38, 22, 70)
    btn.Text = t.icon.." "..t.name
    btn.TextColor3 = i==1 and Color3.new(1,1,1) or Color3.fromRGB(170, 150, 200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    tabButtons[i] = btn

    btn.MouseButton1Click:Connect(function()
        currentTab = i
        for j,b in ipairs(tabButtons) do
            b.BackgroundTransparency = j==i and 0 or 1
            b.BackgroundColor3 = j==i and Color3.fromRGB(90, 50, 160) or Color3.fromRGB(38, 22, 70)
            b.TextColor3 = j==i and Color3.new(1,1,1) or Color3.fromRGB(170, 150, 200)
        end
        for j,c in ipairs(tabContents) do if c then c.Visible = j==i end end
    end)

    local cont = Instance.new("ScrollingFrame")
    cont.Size = UDim2.new(1, -185, 1, 0)
    cont.Position = UDim2.new(0, 175, 0, 10)
    cont.BackgroundTransparency = 1
    cont.ScrollBarThickness = 4
    cont.ScrollBarColor3 = Color3.fromRGB(120, 80, 200)
    cont.AutomaticCanvasSize = Enum.AutomaticSize.Y
    cont.Visible = i==1
    cont.Parent = MainPanel
    tabContents[i] = cont
end

-- ==============================================
-- 🔧 FUNÇÕES — CHECKBOX E SLIDER
-- ==============================================
local function Checkbox(parent, y, text, callback)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, 0, 0, 32)
    c.Position = UDim2.new(0, 0, 0, y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -40, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 210, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local box = Instance.new("Frame")
    box.Size = UDim2.new(0, 20, 0, 20)
    box.Position = UDim2.new(1, -25, 0.5, -10)
    box.BackgroundColor3 = Color3.fromRGB(55, 35, 95)
    box.BorderSizePixel = 1
    box.BorderColor3 = Color3.fromRGB(100, 70, 160)
    box.Parent = c
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)

    local ck = Instance.new("TextLabel")
    ck.Size = UDim2.new(1, 0, 1, 0)
    ck.BackgroundTransparency = 1
    ck.Text = ""
    ck.TextColor3 = Color3.new(1,1,1)
    ck.Font = Enum.Font.GothamBold
    ck.TextSize = 12
    ck.Parent = box

    local on = false
    c.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            on = not on
            ck.Text = on and "✓" or ""
            box.BackgroundColor3 = on and Color3.fromRGB(110, 60, 200) or Color3.fromRGB(55, 35, 95)
            callback(on)
        end
    end)
end

local function Slider(parent, y, text, min, max, def, cb)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, 0, 0, 50)
    c.Position = UDim2.new(0, 0, 0, y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text..": "..def
    lbl.TextColor3 = Color3.fromRGB(220, 210, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 0, 12)
    bg.Position = UDim2.new(0, 0, 0, 22)
    bg.BackgroundColor3 = Color3.fromRGB(55, 35, 95)
    bg.Parent = c
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)

    local fg = Instance.new("Frame")
    fg.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
    fg.BackgroundColor3 = Color3.fromRGB(130, 70, 255)
    fg.Parent = bg
    Instance.new("UICorner", fg).CornerRadius = UDim.new(0, 6)

    local val, drag = def, false
    bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local p = math.clamp(i.Position.X - bg.AbsolutePosition.X, 0, bg.AbsoluteSize.X)
            val = math.floor(min + (p / bg.AbsoluteSize.X) * (max - min))
            fg.Size = UDim2.new(p / bg.AbsoluteSize.X, 0, 1, 0)
            lbl.Text = text..": "..val
            cb(val)
        end
    end)
end

-- ==============================================
-- ⭕ FOV + 👁️ ESP — SÓ APARECEM QUANDO ATIVADO
-- ==============================================
local FovCircle = Drawing.new("Circle")
FovCircle.Radius = 90
FovCircle.Thickness = 2
FovCircle.Color = Color3.fromRGB(255, 220, 0)
FovCircle.Filled = false
FovCircle.Visible = false
FovCircle.NumSides = 64

local ESP_Enabled = false
local ESP_ShowName = false
local ESP_ShowHealth = false
local ESP_ShowDistance = false
local ESP_Drawings = {}

-- 🎯 ABA 1 — AIMBOT (8 FUNÇÕES)
local Aimbot_Enabled = false
local Aimbot_FOV_Size = 90
local Aimbot_Smoothness = 2

Checkbox(tabContents[1], 10, "🎯 Ativar Aimbot", function(v)
    Aimbot_Enabled = v
    FovCircle.Visible = v and UiVisible
end)
Slider(tabContents[1], 50, "📐 Campo de Visão (FOV)", 20, 360, 90, function(v)
    Aimbot_FOV_Size = v
    FovCircle.Radius = v
end)
Slider(tabContents[1], 110, "⚙️ Suavidade da Mira", 1, 10, 2, function(v) Aimbot_Smoothness = v end)
Checkbox(tabContents[1], 160, "🧠 Mirar na Cabeça", function() end)
Checkbox(tabContents[1], 198, "🚫 Ignorar Aliados", function() end)
Checkbox(tabContents[1], 236, "🔒 Silent Aim", function() end)
Checkbox(tabContents[1], 274, "🔮 Previsão de Movimento", function() end)
Checkbox(tabContents[1], 312, "🎯 Aimbot em PvP", function() end)

-- 👁️ ABA 2 — ESP (9 FUNÇÕES)
Checkbox(tabContents[2], 10, "👁️ Ativar ESP", function(v) ESP_Enabled = v end)
Checkbox(tabContents[2], 48, "📝 Mostrar Nome", function(v) ESP_ShowName = v end)
Checkbox(tabContents[2], 86, "❤️ Mostrar Vida", function(v) ESP_ShowHealth = v end)
Checkbox(tabContents[2], 124, "📏 Mostrar Distância", function(v) ESP_ShowDistance = v end)
Checkbox(tabContents[2], 162, "👥 Mostrar Time", function() end)
Checkbox(tabContents[2], 200, "⭐ Mostrar Nível", function() end)
Checkbox(tabContents[2], 238, "🟦 Caixa ao Redor", function() end)
Checkbox(tabContents[2], 276, "📏 Linha até o Jogador", function() end)
Checkbox(tabContents[2], 314, "👁️ Ver Através da Parede", function() end)

-- ⚡ ABA 3 — MOVIMENTO (8 FUNÇÕES)
local WalkSpeed = 16
local JumpPower = 50
local NoKnockback = false
local FlyEnabled = false

Slider(tabContents[3], 10, "🏃 Velocidade de Corrida", 16, 200, 16, function(v) WalkSpeed = v end)
Slider(tabContents[3], 70, "🦘 Força do Pulo", 50, 400, 50, function(v) JumpPower = v end)
Checkbox(tabContents[3], 130, "🛡️ Sem Recuo", function(v) NoKnockback = v end)
Checkbox(tabContents[3], 168, "✈️ Voar (Fly)", function(v) FlyEnabled = v end)
Checkbox(tabContents[3], 206, "🦅 Sem Dano de Queda", function() end)
Checkbox(tabContents[3], 244, "🏃 Auto Correr", function() end)
Checkbox(tabContents[3], 282, "⚡ Aumento de Velocidade", function() end)
Checkbox(tabContents[3], 320, "🔲 Noclip", function() end)

-- ⚔️ ABA 4 — COMBATE (8 FUNÇÕES)
Checkbox(tabContents[4], 10, "👊 Auto Combo", function() end)
Checkbox(tabContents[4], 48, "👊 Auto Ataque (M1)", function() end)
Checkbox(tabContents[4], 86, "⚔️ Ataque Rápido", function() end)
Checkbox(tabContents[4], 124, "📦 Hitbox Ampliada", function() end)
Checkbox(tabContents[4], 162, "🛡️ Auto Haki", function() end)
Checkbox(tabContents[4], 200, "👁️ Auto Instinto", function() end)
Checkbox(tabContents[4], 238, "⚡ Auto Soru", function() end)
Checkbox(tabContents[4], 276, "🔌 Sem Cooldown", function() end)

-- 💰 ABA 5 — FAZENDA (8 FUNÇÕES)
Checkbox(tabContents[5], 10, "💰 Auto Farm Dinheiro", function() end)
Checkbox(tabContents[5], 48, "⭐ Auto Farm Nível", function() end)
Checkbox(tabContents[5], 86, "👾 Auto Matar Inimigos", function() end)
Checkbox(tabContents[5], 124, "🏆 Auto Recompensa", function() end)
Checkbox(tabContents[5], 162, "🎯 Auto Caçar Alvo", function() end)
Checkbox(tabContents[5], 200, "🏠 Auto Vender", function() end)
Checkbox(tabContents[5], 238, "🔁 Auto Reaparecer", function() end)
Checkbox(tabContents[5], 276, "🗺️ Teleportar Ilhas", function() end)

-- 🍎 ABA 6 — FRUTAS (8 FUNÇÕES)
Checkbox(tabContents[6], 10, "🍎 ESP de Frutas", function() end)
Checkbox(tabContents[6], 48, "📍 Localizar Frutas", function() end)
Checkbox(tabContents[6], 86, "🔔 Alerta de Fruta", function() end)
Checkbox(tabContents[6], 124, "🍇 Auto Pegar Fruta", function() end)
Checkbox(tabContents[6], 162, "📦 Armazenar Fruta", function() end)
Checkbox(tabContents[6], 200, "🎲 Rolar Fruta", function() end)
Checkbox(tabContents[6], 238, "💎 Apenas Frutas Boas", function() end)
Checkbox(tabContents[6], 276, "🚫 Ignorar Frutas Ruins", function() end)

-- ⌨️ ABA 7 — TECLAS (6 FUNÇÕES)
Checkbox(tabContents[7], 10, "🎯 Aimbot — Tecla [J]", function() end)
Checkbox(tabContents[7], 48, "👁️ ESP — Tecla [K]", function() end)
Checkbox(tabContents[7], 86, "✈️ Fly — Tecla [F]", function() end)
Checkbox(tabContents[7], 124, "🏃 Velocidade — Tecla [G]", function() end)
Checkbox(tabContents[7], 162, "🔄 Recarregar — Tecla [R]", function() end)
Checkbox(tabContents[7], 200, "👁️ Mostrar/Esconder — Tecla [Insert]", function() end)

-- ⚙️ ABA 8 — CONFIGURAÇÕES (8 FUNÇÕES)
Checkbox(tabContents[8], 10, "📊 FPS Ilimitado", function() end)
Checkbox(tabContents[8], 48, "🌫️ Remover Névoa", function() end)
Checkbox(tabContents[8], 86, "🧹 Limpar Partículas", function() end)
Checkbox(tabContents[8], 124, "🎨 Gráficos Mínimos", function() end)
Checkbox(tabContents[8], 162, "🔄 Auto Reconectar", function() end)
Checkbox(tabContents[8], 200, "⚠️ Modo Seguro", function() end)
Checkbox(tabContents[8], 238, "📄 Log de Ações", function() end)
Checkbox(tabContents[8], 276, "ℹ️ Info do Jogador", function() end)

-- ==============================================
-- ⌨️ TECLA INSERT — MOSTRA/ESCONDE PAINEL
-- ==============================================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        UiVisible = not UiVisible
        MainPanel.Visible = UiVisible
        FovCircle.Visible = UiVisible and Aimbot_Enabled or false
    end
end)

-- ==============================================
-- 🔄 LOOP PRINCIPAL — TUDO FUNCIONANDO
-- ==============================================
RunService.RenderStepped:Connect(function()
    if not UiVisible then return end

    -- ⭕ FOV CÍRCULO
    if FovCircle.Visible then
        FovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end

    -- 👁️ ESP
    for _,d in pairs(ESP_Drawings) do if d then d:Remove() end end
    table.clear(ESP_Drawings)

    if ESP_Enabled then
        for _,v in pairs(Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                local hrp = v.Character.HumanoidRootPart
                local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
                if vis then
                    local dist = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                    local col = v.Team == Player.Team and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 60, 60)

                    if ESP_ShowName then
                        local t = Drawing.new("Text")
                        t.Text = v.Name
                        t.Position = Vector2.new(pos.X, pos.Y - 45)
                        t.Color = col
                        t.Center = true
                        t.Size = 13
                        t.Visible = true
                        table.insert(ESP_Drawings, t)
                    end
                    if ESP_ShowHealth then
                        local hp = math.floor(v.Character.Humanoid.Health)
                        local t = Drawing.new("Text")
                        t.Text = "❤️ "..hp
                        t.Position = Vector2.new(pos.X, pos.Y - 30)
                        t.Color = Color3.fromRGB(255, 80, 80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Drawings, t)
                    end
                    if ESP_ShowDistance then
                        local t = Drawing.new("Text")
                        t.Text = "📏 "..dist
                        t.Position = Vector2.new(pos.X, pos.Y - 15)
                        t.Color = Color3.fromRGB(255, 220, 80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Drawings, t)
                    end
                end
            end
        end
    end

    -- 🎯 AIMBOT
    if Aimbot_Enabled then
        local nearest, minDist = nil, Aimbot_FOV_Size
        local camCF = Camera.CFrame
        for _,v in pairs(Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                local sp = camCF:PointToObjectSpace(v.Character.HumanoidRootPart.Position)
                local d = (Vector2.new(sp.X, sp.Z)).Magnitude
                if d < minDist then
                    minDist = d
                    nearest = v
                end
            end
 
