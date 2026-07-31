-- ==============================================
-- 🧅 MARIONETEIRO — ESTILO ONION13
-- IGUALZINHO NO ESTILO, FUNÇÕES E NAVEGAÇÃO
-- ==============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Drawing = Drawing.new

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UiVisible = true       -- Controle do painel
local ScriptActive = false   -- Controle das funções

-- ==============================================
-- 🧅 TELA DE CARREGAMENTO — IGUAL ONION13
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MarioneteiroUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingScreen = Instance.new("Frame")
LoadingScreen.Size = UDim2.new(1,0,1,0)
LoadingScreen.BackgroundColor3 = Color3.fromRGB(15,8,30)
LoadingScreen.Parent = ScreenGui

local LoadIcon = Instance.new("TextLabel")
LoadIcon.Size = UDim2.new(0,80,0,80)
LoadIcon.Position = UDim2.new(0.5,-40,0.35,-40)
LoadIcon.BackgroundTransparency = 1
LoadIcon.Text = "🧅"
LoadIcon.TextSize = 50
LoadIcon.Parent = LoadingScreen

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(0,250,0,50)
LoadTitle.Position = UDim2.new(0.5,-125,0.5,-25)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "MARIONETEIRO"
LoadTitle.TextColor3 = Color3.fromRGB(160,100,255)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextSize = 35
LoadTitle.Parent = LoadingScreen

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0,250,0,10)
BarBg.Position = UDim2.new(0.5,-125,0.6,0)
BarBg.BackgroundColor3 = Color3.fromRGB(40,25,75)
BarBg.Parent = LoadingScreen
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0,5)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0,0,1,0)
BarFill.BackgroundColor3 = Color3.fromRGB(120,60,255)
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0,5)

for i=1,100 do task.wait(0.01) BarFill.Size = UDim2.new(i/100,0,1,0) end
task.wait(0.3)
LoadingScreen:Destroy()

-- ==============================================
-- 🧅 BOTÃO FLUTUANTE — APARECE QUANDO FECHA O PAINEL
-- ==============================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0,55,0,55)
OpenBtn.Position = UDim2.new(0,15,0,15)
OpenBtn.BackgroundColor3 = Color3.fromRGB(70,40,130)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Text = "🧅"
OpenBtn.TextSize = 28
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0,12)

-- ==============================================
-- 🎨 PAINEL PRINCIPAL — ESTILO ONION13
-- ==============================================
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(0,500,0,360)
MainPanel.Position = UDim2.new(0.5,-250,0.5,-180)
MainPanel.BackgroundColor3 = Color3.fromRGB(35,20,65)
MainPanel.BorderSizePixel = 1
MainPanel.BorderColor3 = Color3.fromRGB(85,50,155)
MainPanel.Parent = ScreenGui
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0,10)

-- CABEÇALHO
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,45)
Header.BackgroundColor3 = Color3.fromRGB(50,30,95)
Header.Parent = MainPanel

local HIcon = Instance.new("TextLabel")
HIcon.Size = UDim2.new(0,28,1,0)
HIcon.Position = UDim2.new(0,12,0,0)
HIcon.BackgroundTransparency = 1
HIcon.Text = "🧅"
HIcon.TextSize = 18
HIcon.Parent = Header

local HTitle = Instance.new("TextLabel")
HTitle.Size = UDim2.new(1,-140,1,0)
HTitle.Position = UDim2.new(0,45,0,0)
HTitle.BackgroundTransparency = 1
HTitle.Text = "MARIONETEIRO | Blox Fruits"
HTitle.TextColor3 = Color3.fromRGB(190,150,255)
HTitle.Font = Enum.Font.GothamBold
HTitle.TextSize = 14
HTitle.TextXAlignment = Enum.TextXAlignment.Left
HTitle.Parent = Header

-- 🔴🟢 BOTÃO LIGAR/DESLIGAR GERAL
local MasterBtn = Instance.new("TextButton")
MasterBtn.Size = UDim2.new(0,95,0,26)
MasterBtn.Position = UDim2.new(0.5,-47,0.5,-13)
MasterBtn.BackgroundColor3 = Color3.fromRGB(170,30,60)
MasterBtn.Font = Enum.Font.GothamBold
MasterBtn.Text = "🔴 DESLIGADO"
MasterBtn.TextColor3 = Color3.new(1,1,1)
MasterBtn.TextSize = 11
MasterBtn.Parent = Header
Instance.new("UICorner", MasterBtn).CornerRadius = UDim.new(0,5)

-- ❌ BOTÃO FECHAR PAINEL
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,35,1,0)
CloseBtn.Position = UDim2.new(1,-35,0,0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "❌"
CloseBtn.TextSize = 15
CloseBtn.Parent = Header

-- 📑 BARRA LATERAL DE ABAS — IGUAL ONION13
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,160,1,-45)
Sidebar.Position = UDim2.new(0,0,0,45)
Sidebar.BackgroundColor3 = Color3.fromRGB(28,15,52)
Sidebar.Parent = MainPanel

local tabs = {
    {icon="🎯", name="Aimbot"},
    {icon="👁️", name="ESP"},
    {icon="⚡", name="Movimento"},
    {icon="⚔️", name="Combate"},
    {icon="💰", name="Fazenda"},
    {icon="🍎", name="Frutas"},
    {icon="⌨️", name="Teclas"},
    {icon="⚙️", name="Configurações"}
}
local currentTab = 1
local tabBtns = {}
local tabPages = {}

-- Cria as abas
for i, t in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-12,0,35)
    btn.Position = UDim2.new(0,6,0,10+(i-1)*38)
    btn.BackgroundTransparency = i==1 and 0 or 1
    btn.BackgroundColor3 = i==1 and Color3.fromRGB(80,45,145) or Color3.fromRGB(28,15,52)
    btn.Text = "  "..t.icon.."  "..t.name
    btn.TextColor3 = i==1 and Color3.new(1,1,1) or Color3.fromRGB(160,140,200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    tabBtns[i] = btn

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1,-175,1,0)
    page.Position = UDim2.new(0,175,0,0)
    page.BackgroundTransparency = 1
    page.Visible = i==1
    page.Parent = MainPanel
    tabPages[i] = page

    btn.MouseButton1Click:Connect(function()
        currentTab = i
        for j,b in ipairs(tabBtns) do
            b.BackgroundTransparency = j==i and 0 or 1
            b.BackgroundColor3 = j==i and Color3.fromRGB(80,45,145) or Color3.fromRGB(28,15,52)
            b.TextColor3 = j==i and Color3.new(1,1,1) or Color3.fromRGB(160,140,200)
        end
        for j,p in ipairs(tabPages) do if p then p.Visible = j==i end end
    end)
end

-- ==============================================
-- 🔧 FUNÇÕES — CHECKBOX E SLIDER ESTILO ONION13
-- ==============================================
local function Checkbox(parent, y, texto, acao)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1,0,0,32)
    c.Position = UDim2.new(0,10,0,y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,-35,1,0)
    txt.BackgroundTransparency = 1
    txt.Text = texto
    txt.TextColor3 = Color3.fromRGB(225,215,255)
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 12
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = c

    local caixa = Instance.new("Frame")
    caixa.Size = UDim2.new(0,18,0,18)
    caixa.Position = UDim2.new(1,-26,0.5,-9)
    caixa.BackgroundColor3 = Color3.fromRGB(55,35,100)
    caixa.Parent = c
    Instance.new("UICorner", caixa).CornerRadius = UDim.new(0,4)

    local marca = Instance.new("TextLabel")
    marca.Size = UDim2.new(1,0,1,0)
    marca.BackgroundTransparency = 1
    marca.Text = ""
    marca.TextColor3 = Color3.new(1,1,1)
    marca.Font = Enum.Font.GothamBold
    marca.TextSize = 12
    marca.Parent = caixa

    local ligado = false
    c.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            ligado = not ligado
            marca.Text = ligado and "✓" or ""
            caixa.BackgroundColor3 = ligado and Color3.fromRGB(110,60,210) or Color3.fromRGB(55,35,100)
            acao(ligado)
        end
    end)
end

local function Slider(parent, y, texto, min, max, inicio, acao)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1,0,0,50)
    c.Position = UDim2.new(0,10,0,y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,0,0,18)
    txt.BackgroundTransparency = 1
    txt.Text = texto..": "..inicio
    txt.TextColor3 = Color3.fromRGB(225,215,255)
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 12
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = c

    local fundo = Instance.new("Frame")
    fundo.Size = UDim2.new(1,-10,0,12)
    fundo.Position = UDim2.new(0,0,0,25)
    fundo.BackgroundColor3 = Color3.fromRGB(55,35,100)
    fundo.Parent = c
    Instance.new("UICorner", fundo).CornerRadius = UDim.new(0,6)

    local barra = Instance.new("Frame")
    barra.Size = UDim2.new((inicio-min)/(max-min),0,1,0)
    barra.BackgroundColor3 = Color3.fromRGB(130,70,255)
    barra.Parent = fundo
    Instance.new("UICorner", barra).CornerRadius = UDim.new(0,6)

    local valor, arrastando = inicio, false
    fundo.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then arrastando = true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then arrastando = false end end)
    UserInputService.InputChanged:Connect(function(i)
        if arrastando and i.UserInputType == Enum.UserInputType.MouseMovement then
            local p = math.clamp(i.Position.X - fundo.AbsolutePosition.X, 0, fundo.AbsoluteSize.X)
            valor = math.floor(min + (p / fundo.AbsoluteSize.X) * (max - min))
            barra.Size = UDim2.new(p / fundo.AbsoluteSize.X, 0, 1, 0)
            txt.Text = texto..": "..valor
            acao(valor)
        end
    end)
end

-- ==============================================
-- ⭕ FOV + 👁️ ESP
-- ==============================================
local FovCircle = Drawing.new("Circle")
FovCircle.Radius = 90
FovCircle.Thickness = 2
FovCircle.Color = Color3.fromRGB(255,220,0)
FovCircle.Filled = false
FovCircle.Visible = false
FovCircle.NumSides = 64

local ESP_On, ESP_Nome, ESP_Vida, ESP_Dist = false,false,false,false
local ESP_Desenhos = {}

-- 🎯 ABA 1 — AIMBOT
local Aimbot_On = false
local Aimbot_FOV = 90
local Aimbot_Suave = 2

Checkbox(tabPages[1], 10, "🎯 Ativar Aimbot", function(v)
    Aimbot_On = v and ScriptActive
    FovCircle.Visible = Aimbot_On and UiVisible
end)
Slider(tabPages[1], 52, "📐 Campo de Visão", 20, 350, 90, function(v)
    Aimbot_FOV = v
    FovCircle.Radius = v
end)
Slider(tabPages[1], 115, "⚙️ Suavidade da Mira", 1, 10, 2, function(v) Aimbot_Suave = v end)
Checkbox(tabPages[1], 170, "🧠 Mirar na Cabeça", function() end)
Checkbox(tabPages[1], 205, "🚫 Ignorar Aliados", function() end)
Checkbox(tabPages[1], 240, "🔒 Silent Aim", function() end)
Checkbox(tabPages[1], 275, "🔮 Previsão de Movimento", function() end)

-- 👁️ ABA 2 — ESP
Checkbox(tabPages[2], 10, "👁️ Ativar ESP", function(v) ESP_On = v and ScriptActive end)
Checkbox(tabPages[2], 45, "📝 Mostrar Nome", function(v) ESP_Nome = v end)
Checkbox(tabPages[2], 80, "❤️ Mostrar Vida", function(v) ESP_Vida = v end)
Checkbox(tabPages[2], 115, "📏 Mostrar Distância", function(v) ESP_Dist = v end)
Checkbox(tabPages[2], 150, "🟦 Caixa ao Redor", function() end)
Checkbox(tabPages[2], 185, "📏 Linha até o Jogador", function() end)
Checkbox(tabPages[2], 220, "👁️ Ver Através da Parede", function() end)

-- ⚡ ABA 3 — MOVIMENTO
local Velocidade = 16
local Pulo = 50
local Fly_On = false

Slider(tabPages[3], 10, "🏃 Velocidade de Corrida", 16, 200, 16, function(v) Velocidade = v end)
Slider(tabPages[3], 72, "🦘 Força do Pulo", 50, 400, 50, function(v) Pulo = v end)
Checkbox(tabPages[3], 135, "🛡️ Sem Recuo", function() end)
Checkbox(tabPages[3], 170, "✈️ Voar (Fly)", function(v) Fly_On = v and ScriptActive end)
Checkbox(tabPages[3], 205, "🦅 Sem Dano de Queda", function() end)
Checkbox(tabPages[3], 240, "🏃 Auto Correr", function() end)
Checkbox(tabPages[3], 275, "🔲 Noclip", function() end)

-- ⚔️ ABA 4 — COMBATE
Checkbox(tabPages[4], 10, "👊 Auto Combo", function() end)
Checkbox(tabPages[4], 45, "👊 Auto Ataque M1", function() end)
Checkbox(tabPages[4], 80, "⚔️ Ataque Rápido", function() end)
Checkbox(tabPages[4], 115, "📦 Hitbox Ampliada", function() end)
Checkbox(tabPages[4], 150, "🛡️ Auto Haki", function() end)
Checkbox(tabPages[4], 185, "👁️ Auto Instinto", function() end)
Checkbox(tabPages[4], 220, "⚡ Auto Soru", function() end)
Checkbox(tabPages[4], 255, "🔌 Sem Cooldown", function() end)

-- 💰 ABA 5 — FAZENDA
Checkbox(tabPages[5], 10, "💰 Auto Farm Dinheiro", function() end)
Checkbox(tabPages[5], 45, "⭐ Auto Farm Nível", function() end)
Checkbox(tabPages[5], 80, "👾 Auto Matar Inimigos", function() end)
Checkbox(tabPages[5], 115, "🏆 Auto Recompensa", function() end)
Checkbox(tabPages[5], 150, "🎯 Auto Caçar Alvo", function() end)
Checkbox(tabPages[5], 185, "🏠 Auto Vender", function() end)
Checkbox(tabPages[5], 220, "🔁 Auto Reaparecer", function() end)
Checkbox(tabPages[5], 255, "🗺️ Teleportar Ilhas", function() end)

-- 🍎 ABA 6 — FRUTAS
Checkbox(tabPages[6], 10, "🍎 ESP de Frutas", function() end)
Checkbox(tabPages[6], 45, "📍 Localizar Frutas", function() end)
Checkbox(tabPages[6], 80, "🔔 Alerta de Fruta", function() end)
Checkbox(tabPages[6], 115, "🍇 Auto Pegar Fruta", function() end)
Checkbox(tabPages[6], 150, "📦 Armazenar Fruta", function() end)
Checkbox(tabPages[6], 185, "🎲 Rolar Fruta", function() end)
Checkbox(tabPages[6], 220, "💎 Apenas Frutas Boas", function() end)
Checkbox(tabPages[6], 255, "🚫 Ignorar Frutas Ruins", function() end)

-- ⌨️ ABA 7 — TECLAS
Checkbox(tabPages[7], 10, "🎯 Alternar Aimbot — [J]", function() end)
Checkbox(tabPages[7], 45, "👁️ Alternar ESP — [K]", function() end)
Checkbox(tabPages[7], 80, "✈️ Alternar Fly — [F]", function() end)
Checkbox(tabPages[7], 115, "🏃 Alternar Velocidade — [G]", function() end)
Checkbox(tabPages[7], 150, "🔄 Recarregar — [R]", function() end)
Checkbox(tabPages[7], 185, "👁️ Mostrar/Esconder — [Insert]", function() end)

-- ⚙️ ABA 8 — CONFIGURAÇÕES
Checkbox(tabPages[8], 10, "📊 FPS Ilimitado", function() end)
Checkbox(tabPages[8], 45, "🌫️ Remover Névoa", function() end)
Checkbox(tabPages[8], 80, "🧹 Limpar Partículas", function() end)
Checkbox(tabPages[8], 115, "🎨 Gráficos no Mínimo", function() end)
Checkbox(tabPages[8], 150, "🔄 Auto Reconectar", function() end)
Checkbox(tabPages[8], 185, "⚠️ Modo Seguro", function() end)
Checkbox(tabPages[8], 220, "📄 Log de Ações", function() end)
Checkbox(tabPages[8], 255, "ℹ️ Info do Jogador", function() end)

-- ==============================================
-- 🔘 BOTÃO LIGAR/DESLIGAR GERAL
-- ==============================================
MasterBtn.MouseButton1Click:Connect(function()
    ScriptActive = not ScriptActive
    if ScriptActive then
        MasterBtn.BackgroundColor3 = Color3.fromRGB(40,150,70)
        MasterBtn.Text = "🟢 LIGADO"
        if Aimbot_On then FovCircle.Visible = UiVisible end
    else
        MasterBtn.BackgroundColor3 = Color3.fromRGB(170,30,60)
        MasterBtn.Text = "🔴 DESLIGADO"
        FovCircle.Visible = false
        for _,d in pairs(ESP_Desenhos) do if d then d:Remove() end end
    end
end)

-- ❌ FECHAR PAINEL → APARECE BOTÃO 🧅 NO CANTO
CloseBtn.MouseButton1Click:Connect(function()
    UiVisible = false
    MainPanel.Visible = false
    OpenBtn.Visible = true
    FovCircle.Visible = false
end)

-- 🧅 ABRIR PAINEL NOVAMENTE
OpenBtn.MouseButton1Click:Connect(function()
    UiVisible = true
    MainPanel.Visible = true
    OpenBtn.Visible = false
    FovCircle.Visible = Aimbot_On and ScriptActive
end)

-- ⌨️ TECLA INSERT TAMBÉM ABRE/FECHA
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        UiVisible = not UiVisible
        MainPanel.Visible = UiVisible
        OpenBtn.Visible = not UiVisible
        FovCircle.Visible = Aimbot_On and UiVisible and ScriptActive
    end
end)

-- ==============================================
-- 🔄 LOOP PRINCIPAL — SÓ FUNCIONA SE LIGADO
-- ==============================================
RunService.RenderStepped:Connect(function()
    if not ScriptActive then
        for _,d in pairs(ESP_Desenhos) do if d then d:Remove() end end
        table.clear(ESP_Desenhos)
        return
    end
    if not UiVisible and not Aimbot_On then return end

    -- FOV
    if FovCircle.Visible then
        FovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    end

    -- ESP
    for _,d in pairs(ESP_Desenhos) do if d then d:Remove() end end
    table.clear(ESP_Desenhos)

    if ESP_On and UiVisible then
        for _,v in pairs(Players:GetPlayers()) do
            if v~=Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health>0 then
                local hrp = v.Character.HumanoidRootPart
                local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
                if vis then
                    local dist = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                    local cor = v.Team==Player.Team and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,60,60)
                    if ESP_Nome then
                        local t = Drawing.new("Text")
                        t.Text = v.Name
                        t.Position = Vector2.new(pos.X, pos.Y-45)
                        t.Color = cor
                        t.Center = true
                        t.Size = 13
                        t.Visible = true
                        table.insert(ESP_Desenhos, t)
                    end
                    if ESP_Vida then
                        local t = Drawing.new("Text")
                        t.Text = "❤️ "..math.floor(v.Character.Humanoid.Health)
                        t.Position = Vector2.new(pos.X, pos.Y-30)
                        t.Color = Color3.fromRGB(255,80,80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Desenhos, t)
                    end
                    if ESP_Dist then
                        local t = Drawing.new("Text")
                        t.Text = "📏 "..dist
                        t.Position = Vector2.new(pos.X, pos.Y-15)
                        t.Color = Color3.fromRGB(255,220,80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Desenhos, t)
                    end
                end
            end
        end
    end

    -- AIMBOT
    if Aimbot_On and UiVisible then
        local alvo, menorDist = nil, Aimbot_FOV
        local camCF = Camera.CFrame
        for _,v in pairs(Players:GetPlayers()) do
            if v~=Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health>0 then
                local sp = camCF:PointToObjectSpace(v.Character.HumanoidRootPart.Position)
                local d = (Vector2.new(sp.X, sp.Z)).Magnitude
                if d < menorDist then
                    menorDist = d
                    alvo = v
                end
            end
        end
        if alvo then
            local parte = alvo.Character:FindFirstChild("Head") or alvo.Character.HumanoidRootPart
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, parte.Position), 1/Aimbot_Suave)
        end
    end

    -- MOVIMENTO
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = Velocidade
        Player.Character.Humanoid.JumpPower = Pulo
    end

    -- FLY
    if Fly_On and Player.Character and Player.Character:FindFirstCh
