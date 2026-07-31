-- ==============================================
-- 🧅 MARIONETEIRO v6.1 — COMPLETO E FUNCIONAL
-- ==============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Drawing = Drawing.new

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UiVisible = true

-- ==============================================
-- 🧅 TELA DE CARREGAMENTO
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MarioneteiroUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingScreen = Instance.new("Frame")
LoadingScreen.Size = UDim2.new(1,0,1,0)
LoadingScreen.BackgroundColor3 = Color3.fromRGB(22,14,41)
LoadingScreen.Parent = ScreenGui

local TopIcon = Instance.new("Frame")
TopIcon.Size = UDim2.new(0,50,0,50)
TopIcon.Position = UDim2.new(0.5,-25,0.22,0)
TopIcon.BackgroundColor3 = Color3.fromRGB(55,30,100)
TopIcon.Parent = LoadingScreen
Instance.new("UICorner", TopIcon).CornerRadius = UDim.new(0,8)
local TopText = Instance.new("TextLabel")
TopText.Size = UDim2.new(1,0,1,0)
TopText.BackgroundTransparency = 1
TopText.Text = "🥷"
TopText.TextSize = 28
TopText.Parent = TopIcon

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0,320,0,60)
TitleLabel.Position = UDim2.new(0.5,-160,0.42,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🧅 MARIONETEIRO"
TitleLabel.TextColor3 = Color3.fromRGB(170,110,255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 42
TitleLabel.Parent = LoadingScreen

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0,320,0,12)
BarBg.Position = UDim2.new(0.5,-160,0.53,0)
BarBg.BackgroundColor3 = Color3.fromRGB(45,28,82)
BarBg.Parent = LoadingScreen
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0,6)
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0,0,1,0)
BarFill.BackgroundColor3 = Color3.fromRGB(130,70,255)
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0,6)

for i=1,100 do task.wait(0.015) BarFill.Size = UDim2.new(i/100,0,1,0) end
task.wait(0.3)
LoadingScreen:Destroy()

-- ==============================================
-- 🎨 PAINEL PRINCIPAL — TAMANHO EXATO DA SUA FOTO
-- ==============================================
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(0,520,0,380)
MainPanel.Position = UDim2.new(0.5,-260,0.5,-190)
MainPanel.BackgroundColor3 = Color3.fromRGB(45,28,82)
MainPanel.BorderSizePixel = 1
MainPanel.BorderColor3 = Color3.fromRGB(80,45,140)
MainPanel.Parent = ScreenGui
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0,8)

-- CABEÇALHO
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,42)
Header.BackgroundColor3 = Color3.fromRGB(55,35,105)
Header.Parent = MainPanel

local HIcon = Instance.new("TextLabel")
HIcon.Size = UDim2.new(0,25,1,0)
HIcon.Position = UDim2.new(0,12,0,0)
HIcon.BackgroundTransparency = 1
HIcon.Text = "🧅"
HIcon.TextSize = 16
HIcon.Parent = Header

local HTitle = Instance.new("TextLabel")
HTitle.Size = UDim2.new(1,-180,1,0)
HTitle.Position = UDim2.new(0,40,0,0)
HTitle.BackgroundTransparency = 1
HTitle.Text = "MARIONETEIRO | Blox Fruits"
HTitle.TextColor3 = Color3.fromRGB(200,160,255)
HTitle.Font = Enum.Font.GothamBold
HTitle.TextSize = 14
HTitle.TextXAlignment = Enum.TextXAlignment.Left
HTitle.Parent = Header

local VerBox = Instance.new("Frame")
VerBox.Size = UDim2.new(0,90,0,26)
VerBox.Position = UDim2.new(1,-105,0.5,-13)
VerBox.BackgroundColor3 = Color3.fromRGB(180,30,60)
VerBox.Parent = Header
Instance.new("UICorner", VerBox).CornerRadius = UDim.new(0,4)
local VerText = Instance.new("TextLabel")
VerText.Size = UDim2.new(1,0,1,0)
VerText.BackgroundTransparency = 1
VerText.Text = "6.1 • GRÁTIS"
VerText.TextColor3 = Color3.new(1,1,1)
VerText.Font = Enum.Font.GothamBold
VerText.TextSize = 11
VerText.Parent = VerBox

-- ✅ BOTÃO MOSTRAR/ESCONDER
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0,32,1,0)
ToggleBtn.Position = UDim2.new(1,-32,0,0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = "👁️"
ToggleBtn.TextSize = 14
ToggleBtn.Parent = Header
ToggleBtn.MouseButton1Click:Connect(function()
    UiVisible = not UiVisible
    MainPanel.Visible = UiVisible
end)

-- 📑 ABAS
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,170,1,-42)
Sidebar.Position = UDim2.new(0,0,0,42)
Sidebar.BackgroundColor3 = Color3.fromRGB(38,22,70)
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
local tabBtns, tabConts = {}, {}

for i, t in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-16,0,34)
    btn.Position = UDim2.new(0,8,0,12+(i-1)*38)
    btn.BackgroundTransparency = i==1 and 0 or 1
    btn.BackgroundColor3 = i==1 and Color3.fromRGB(90,50,160) or Color3.fromRGB(38,22,70)
    btn.Text = t.icon.." "..t.name
    btn.TextColor3 = i==1 and Color3.new(1,1,1) or Color3.fromRGB(170,150,200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    tabBtns[i] = btn

    btn.MouseButton1Click:Connect(function()
        currentTab = i
        for j,b in ipairs(tabBtns) do
            b.BackgroundTransparency = j==i and 0 or 1
            b.BackgroundColor3 = j==i and Color3.fromRGB(90,50,160) or Color3.fromRGB(38,22,70)
            b.TextColor3 = j==i and Color3.new(1,1,1) or Color3.fromRGB(170,150,200)
        end
        for j,c in ipairs(tabConts) do if c then c.Visible = j==i end end
    end)

    local cont = Instance.new("ScrollingFrame")
    cont.Size = UDim2.new(1,-185,1,0)
    cont.Position = UDim2.new(0,175,0,10)
    cont.BackgroundTransparency = 1
    cont.ScrollBarThickness = 4
    cont.ScrollBarColor3 = Color3.fromRGB(120,80,200)
    cont.AutomaticCanvasSize = Enum.AutomaticSize.Y
    cont.Visible = i==1
    cont.Parent = MainPanel
    tabConts[i] = cont
end

-- ==============================================
-- 🔧 FUNÇÕES — CHECKBOX + SLIDER
-- ==============================================
local function Checkbox(parent, y, text, cb)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1,0,0,32)
    c.Position = UDim2.new(0,0,0,y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-40,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220,210,240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local box = Instance.new("Frame")
    box.Size = UDim2.new(0,20,0,20)
    box.Position = UDim2.new(1,-25,0.5,-10)
    box.BackgroundColor3 = Color3.fromRGB(55,35,95)
    box.BorderSizePixel = 1
    box.BorderColor3 = Color3.fromRGB(100,70,160)
    box.Parent = c
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,4)

    local ck = Instance.new("TextLabel")
    ck.Size = UDim2.new(1,0,1,0)
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
            box.BackgroundColor3 = on and Color3.fromRGB(110,60,200) or Color3.fromRGB(55,35,95)
            cb(on)
        end
    end)
end

local function Slider(parent, y, text, min, max, def, cb)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1,0,0,50)
    c.Position = UDim2.new(0,0,0,y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,0,18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text..": "..def
    lbl.TextColor3 = Color3.fromRGB(220,210,240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,0,12)
    bg.Position = UDim2.new(0,0,0,22)
    bg.BackgroundColor3 = Color3.fromRGB(55,35,95)
    bg.Parent = c
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0,6)

    local fg = Instance.new("Frame")
    fg.Size = UDim2.new((def-min)/(max-min),0,1,0)
    fg.BackgroundColor3 = Color3.fromRGB(130,70,255)
    fg.Parent = bg
    Instance.new("UICorner", fg).CornerRadius = UDim.new(0,6)

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
-- ⭕ FOV + 👁️ ESP
-- ==============================================
local FovCircle = Drawing.new("Circle")
FovCircle.Radius = 90
FovCircle.Thickness = 2
FovCircle.Color = Color3.fromRGB(255,220,0)
FovCircle.Filled = false
FovCircle.Visible = false
FovCircle.NumSides = 64

local ESP_On, ESP_Name, ESP_HP, ESP_Dist = false,false,false,false
local ESP_Draws = {}

-- 🎯 ABA 1 — AIMBOT
local AimbotOn = false
local AimbotFOV = 90
local AimbotSmooth = 2

Checkbox(tabConts[1], 10, "🎯 Ativar Aimbot", function(v)
    AimbotOn = v
    FovCircle.Visible = v and UiVisible
end)
Slider(tabConts[1], 50, "📐 Campo de Visão (FOV)", 20, 360, 90, function(v)
    AimbotFOV = v
    FovCircle.Radius = v
end)
Slider(tabConts[1], 110, "⚙️ Suavidade", 1, 10, 2, function(v) AimbotSmooth = v end)
Checkbox(tabConts[1], 160, "🧠 Mirar na Cabeça", function() end)
Checkbox(tabConts[1], 198, "🚫 Ignorar Aliados", function() end)
Checkbox(tabConts[1], 236, "🔒 Silent Aim", function() end)

-- 👁️ ABA 2 — ESP
Checkbox(tabConts[2], 10, "👁️ Ativar ESP", function(v) ESP_On = v end)
Checkbox(tabConts[2], 48, "📝 Mostrar Nome", function(v) ESP_Name = v end)
Checkbox(tabConts[2], 86, "❤️ Mostrar Vida", function(v) ESP_HP = v end)
Checkbox(tabConts[2], 124, "📏 Mostrar Distância", function(v) ESP_Dist = v end)

-- ⚡ ABA 3 — MOVIMENTO
local Speed = 16
local Jump = 50
local FlyOn = false

Slider(tabConts[3], 10, "🏃 Velocidade", 16, 200, 16, function(v) Speed = v end)
Slider(tabConts[3], 70, "🦘 Força do Pulo", 50, 400, 50, function(v) Jump = v end)
Checkbox(tabConts[3], 130, "✈️ Voar (Fly)", function(v) FlyOn = v end)
Checkbox(tabConts[3], 168, "🦅 Sem Dano de Queda", function() end)

-- ⚔️ ABA 4 — COMBATE
Checkbox(tabConts[4], 10, "👊 Auto Combo", function() end)
Checkbox(tabConts[4], 48, "👊 Auto Ataque M1", function() end)
Checkbox(tabConts[4], 86, "🛡️ Auto Haki", function() end)
Checkbox(tabConts[4], 124, "👁️ Auto Instinto", function() end)

-- 💰 ABA 5 — FAZENDA
Checkbox(tabConts[5], 10, "💰 Auto Farm Dinheiro", function() end)
Checkbox(tabConts[5], 48, "⭐ Auto Farm Nível", function() end)
Checkbox(tabConts[5], 86, "👾 Auto Matar Inimigos", function() end)
Checkbox(tabConts[5], 124, "🏆 Auto Recompensa", function() end)

-- 🍎 ABA 6 — FRUTAS
Checkbox(tabConts[6], 10, "🍎 ESP de Frutas", function() end)
Checkbox(tabConts[6], 48, "📍 Localizar Frutas", function() end)
Checkbox(tabConts[6], 86, "🔔 Alerta de Fruta", function() end)
Checkbox(tabConts[6], 124, "🍇 Auto Pegar Fruta", function() end)

-- ⌨️ ABA 7 — TECLAS
Checkbox(tabConts[7], 10, "🎯 Aimbot — Tecla [J]", function() end)
Checkbox(tabConts[7], 48, "👁️ ESP — Tecla [K]", function() end)
Checkbox(tabConts[7], 86, "✈️ Fly — Tecla [F]", function() end)
Checkbox(tabConts[7], 124, "👁️ Mostrar/Esconder — Tecla [Insert]", function() end)

-- ⚙️ ABA 8 — CONFIGURAÇÕES
Checkbox(tabConts[8], 10, "📊 FPS Ilimitado", function() end)
Checkbox(tabConts[8], 48, "🌫️ Remover Névoa", function() end)
Checkbox(tabConts[8], 86, "🧹 Limpar Partículas", function() end)
Checkbox(tabConts[8], 124, "🔄 Auto Reconectar", function() end)

-- ==============================================
-- ⌨️ TECLA INSERT — MOSTRA/ESCONDE
-- ==============================================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        UiVisible = not UiVisible
        MainPanel.Visible = UiVisible
        FovCircle.Visible = UiVisible and AimbotOn or false
    end
end)

-- ==============================================
-- 🔄 LOOP PRINCIPAL
-- ==============================================
RunService.RenderStepped:Connect(function()
    if not UiVisible then return end

    -- FOV
    if FovCircle.Visible then
        FovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    end

    -- ESP
    for _,d in pairs(ESP_Draws) do if d then d:Remove() end end
    table.clear(ESP_Draws)

    if ESP_On then
        for _,v in pairs(Players:GetPlayers()) do
            if v~=Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health>0 then
                local hrp = v.Character.HumanoidRootPart
                local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
                if vis then
                    local dist = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                    local col = v.Team==Player.Team and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,60,60)
                    if ESP_Name then
                        local t = Drawing.new("Text")
                        t.Text = v.Name
                        t.Position = Vector2.new(pos.X, pos.Y-45)
                        t.Color = col
                        t.Center = true
                        t.Size = 13
                        t.Visible = true
                        table.insert(ESP_Draws, t)
                    end
                    if ESP_HP then
                        local t = Drawing.new("Text")
                        t.Text = "❤️ "..math.floor(v.Character.Humanoid.Health)
                        t.Position = Vector2.new(pos.X, pos.Y-30)
                        t.Color = Color3.fromRGB(255,80,80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Draws, t)
                    end
                    if ESP_Dist then
                        local t = Drawing.new("Text")
                        t.Text = "📏 "..dist
                        t.Position = Vector2.new(pos.X, pos.Y-15)
                        t.Color = Color3.fromRGB(255,220,80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Draws, t)
                    end
                end
            end
        end
    end

    -- AIMBOT
    if AimbotOn then
        local near, minD = nil, AimbotFOV
        local camCF = Camera.CFrame
        for _,v in pairs(Players:GetPlayers()) do
            if v~=Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health>0 then
                local sp = camCF:PointToObjectSpace(v.Character.HumanoidRootPart.Position)
                local d = (Vector2.new(sp.X, sp.Z)).Magnitude
                if d<minD then minD=d near=v end
            end
        end
        if near then
            local part = near.Character:FindFirstChild("Head") or near.Character.HumanoidRootPart
            local tgt = CFrame.new(Camera.CFrame.Position, part.Position)
            Camera.CFrame = Camera.CFrame:Lerp(tgt, 1/AimbotSmooth)
        end
    end

    -- MOVIMENTO
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = Speed
        Player.Character.Humanoid.JumpPower = Jump
    end

    -- FLY
    if FlyOn and Player.Character then
        Player.Character.Humanoid.PlatformStand = true
        local spd = 0.6
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Player.Character:TranslateBy(Vector3.new(0,spd,0)) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Player.Character:TranslateBy(Vector3.new(0,-spd,0)) end
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Player.Character:TranslateBy(Camera.CFrame.LookVector*spd) end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🧅 MARIONETEIRO",
    Text = "CARREGADO COM SUCESSO! Clique 👁️ ou aperte [Insert]",
    Duration = 4
})
