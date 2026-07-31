-- ==============================================
-- 🧅 MARIONETEIRO — VERSÃO FINAL 2.2
-- ✅ FOV + ESP = SÓ ATIVAM QUANDO VOCÊ CLICA!
-- ==============================================

-- ✅ SERVIÇOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Drawing = Drawing.new

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==============================================
-- 🟣 TELA DE CARREGAMENTO
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MarioneteiroUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingScreen = Instance.new("Frame")
LoadingScreen.Size = UDim2.new(1, 0, 1, 0)
LoadingScreen.BackgroundColor3 = Color3.fromRGB(12, 6, 25)
LoadingScreen.Parent = ScreenGui

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1, 0, 0, 90)
LoadingTitle.Position = UDim2.new(0, 0, 0.33, 0)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "🧅 MARIONETEIRO"
LoadingTitle.TextColor3 = Color3.fromRGB(170, 110, 255)
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.TextSize = 48
LoadingTitle.Parent = LoadingScreen

local BarBox = Instance.new("Frame")
BarBox.Size = UDim2.new(0, 300, 0, 18)
BarBox.Position = UDim2.new(0.5, -150, 0.5, -9)
BarBox.BackgroundColor3 = Color3.fromRGB(35, 18, 70)
BarBox.Parent = LoadingScreen
Instance.new("UICorner", BarBox).CornerRadius = UDim.new(0, 9)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(130, 65, 255)
BarFill.Parent = BarBox
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 9)

for i = 1, 100 do task.wait(0.015) BarFill.Size = UDim2.new(i/100, 0, 1, 0) end
LoadingScreen:Destroy()

-- ==============================================
-- 🎨 PAINEL — CENTRALIZADO, ABAS ESQUERDA, CONTEÚDO DIREITA
-- ==============================================
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(0, 520, 0, 380)
MainPanel.Position = UDim2.new(0.5, -260, 0.5, -190)
MainPanel.BackgroundColor3 = Color3.fromRGB(26, 14, 46)
MainPanel.BorderSizePixel = 1
MainPanel.BorderColor3 = Color3.fromRGB(80, 45, 140)
MainPanel.Parent = ScreenGui
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 8)

-- CABEÇALHO
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(40, 20, 75)
Header.Parent = MainPanel

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🧅 MARIONETEIRO | Blox Fruits"
Title.TextColor3 = Color3.fromRGB(200, 160, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local FreeTag = Instance.new("Frame")
FreeTag.Size = UDim2.new(0, 85, 0, 24)
FreeTag.Position = UDim2.new(1, -180, 0.5, -12)
FreeTag.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
FreeTag.Parent = Header
Instance.new("UICorner", FreeTag).CornerRadius = UDim.new(0, 4)

local FreeText = Instance.new("TextLabel")
FreeText.Size = UDim2.new(1, 0, 1, 0)
FreeText.BackgroundTransparency = 1
FreeText.Text = "0.8 • GRÁTIS"
FreeText.TextColor3 = Color3.fromRGB(255, 255, 255)
FreeText.Font = Enum.Font.GothamBold
FreeText.TextSize = 11
FreeText.Parent = FreeTag

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = Header

-- 📑 BARRA LATERAL ESQUERDA
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(34, 18, 60)
Sidebar.Parent = MainPanel

local SearchBox = Instance.new("Frame")
SearchBox.Size = UDim2.new(1, -16, 0, 32)
SearchBox.Position = UDim2.new(0, 8, 0, 10)
SearchBox.BackgroundColor3 = Color3.fromRGB(45, 25, 80)
SearchBox.Parent = Sidebar
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

local SearchText = Instance.new("TextLabel")
SearchText.Size = UDim2.new(1, -10, 1, 0)
SearchText.BackgroundTransparency = 1
SearchText.Text = "Pesquisar..."
SearchText.TextColor3 = Color3.fromRGB(120, 100, 150)
SearchText.Font = Enum.Font.Gotham
SearchText.TextSize = 12
SearchText.Parent = SearchBox

-- ABAS
local tabs = {
    {icon = "🎯", name = "Aimbot"},
    {icon = "👁️", name = "ESP"},
    {icon = "⚡", name = "Movimento"},
    {icon = "⚔️", name = "Combate"},
    {icon = "💰", name = "Caça Recompensa"},
    {icon = "🗡️", name = "Habilidades"},
    {icon = "⌨️", name = "Teclas"},
    {icon = "⚙️", name = "Diversos"}
}
local currentTab = 2
local tabButtons, tabContents = {}, {}

for i, t in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 32)
    btn.Position = UDim2.new(0, 8, 0, 10 + (i-1)*36)
    btn.BackgroundTransparency = i==2 and 0 or 1
    btn.BackgroundColor3 = i==2 and Color3.fromRGB(75, 38, 140) or Color3.fromRGB(34, 18, 60)
    btn.Text = t.icon.."  "..t.name
    btn.TextColor3 = i==2 and Color3.new(1,1,1) or Color3.fromRGB(160,140,190)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    tabButtons[i] = btn

    btn.MouseButton1Click:Connect(function()
        currentTab = i
        for j,b in ipairs(tabButtons) do
            b.BackgroundTransparency = j==i and 0 or 1
            b.TextColor3 = j==i and Color3.new(1,1,1) or Color3.fromRGB(160,140,190)
        end
        for j,c in ipairs(tabContents) do if c then c.Visible = j==i end end
    end)

    local cont = Instance.new("ScrollingFrame")
    cont.Size = UDim2.new(1, -175, 1, 0)
    cont.Position = UDim2.new(0, 170, 0, 45)
    cont.BackgroundTransparency = 1
    cont.ScrollBarThickness = 3
    cont.ScrollBarColor3 = Color3.fromRGB(100, 60, 170)
    cont.AutomaticCanvasSize = Enum.AutomaticSize.Y
    cont.Visible = i==2
    cont.Parent = MainPanel
    tabContents[i] = cont
end

-- ==============================================
-- 🔧 FUNÇÃO CHECKBOX — SÓ ATIVA QUANDO CLICA!
-- ==============================================
local function Checkbox(parent, y, text, default, callback)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, 0, 0, 30)
    c.Position = UDim2.new(0, 0, 0, y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -35, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(210,210,210)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local box = Instance.new("Frame")
    box.Size = UDim2.new(0, 18, 0, 18)
    box.Position = UDim2.new(1, -22, 0.5, -9)
    box.BackgroundColor3 = default and Color3.fromRGB(110,60,200) or Color3.fromRGB(50,30,90)
    box.BorderSizePixel = 1
    box.BorderColor3 = Color3.fromRGB(90,60,150)
    box.Parent = c
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,3)

    local ck = Instance.new("TextLabel")
    ck.Size = UDim2.new(1,0,1,0)
    ck.BackgroundTransparency = 1
    ck.Text = default and "✓" or ""
    ck.TextColor3 = Color3.new(1,1,1)
    ck.Font = Enum.Font.GothamBold
    ck.TextSize = 11
    ck.Parent = box

    local on = default
    c.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            on = not on
            ck.Text = on and "✓" or ""
            box.BackgroundColor3 = on and Color3.fromRGB(110,60,200) or Color3.fromRGB(50,30,90)
            callback(on)
        end
    end)
    return on
end

local function Slider(parent, y, text, min, max, def, cb)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1,0,0,48)
    c.Position = UDim2.new(0,0,0,y)
    c.BackgroundTransparency = 1
    c.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,0,18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text..": "..def
    lbl.TextColor3 = Color3.fromRGB(210,210,210)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,0,10)
    bg.Position = UDim2.new(0,0,0,22)
    bg.BackgroundColor3 = Color3.fromRGB(50,30,90)
    bg.Parent = c
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0,5)

    local fg = Instance.new("Frame")
    fg.Size = UDim2.new((def-min)/(max-min),0,1,0)
    fg.BackgroundColor3 = Color3.fromRGB(130,70,220)
    fg.Parent = bg
    Instance.new("UICorner", fg).CornerRadius = UDim.new(0,5)

    local val, drag = def, false
    bg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local p = math.clamp(i.Position.X-bg.AbsolutePosition.X,0,bg.AbsoluteSize.X)
            val = math.floor(min + (p/bg.AbsoluteSize.X)*(max-min))
            fg.Size = UDim2.new(p/bg.AbsoluteSize.X,0,1,0)
            lbl.Text = text..": "..val
            cb(val)
        end
    end)
end

-- ==============================================
-- ⭕ CÍRCULO DE FOV — COMEÇA INVISÍVEL! SÓ APARECE QUANDO CLICAR!
-- ==============================================
local FovCircle = Drawing.new("Circle")
FovCircle.Radius = 90
FovCircle.Thickness = 2
FovCircle.Color = Color3.fromRGB(255, 220, 0)
FovCircle.Filled = false
FovCircle.Visible = false -- ✅ COMEÇA ESQUECIDO! SÓ APARECE QUANDO ATIVAR!
FovCircle.NumSides = 64

-- ==============================================
-- 👁️ ESP — TODAS AS OPÇÕES COMEÇAM DESATIVADAS!
-- ==============================================
local ESP_Enabled = false -- ✅ COMEÇA DESLIGADO!
local ESP_ShowName = false
local ESP_ShowSkeleton = false
local ESP_ShowHealth = false
local ESP_ShowDistance = false
local ESP_ShowTeam = false
local ESP_ShowLevel = false
local ESP_Drawings = {}

-- ✅ ABA ESP — TODAS DESMARCADAS NO INÍCIO! SÓ ATIVA QUANDO VOCÊ CLICA!
Checkbox(tabContents[2], 10, "Ativar ESP", false, function(v) ESP_Enabled = v end)
Checkbox(tabContents[2], 45, "Mostrar o nome do jogador", false, function(v) ESP_ShowName = v end)
Checkbox(tabContents[2], 80, "Mostrar o esqueleto do jogador", false, function(v) ESP_ShowSkeleton = v end)
Checkbox(tabContents[2], 115, "Mostrar a vida do jogador", false, function(v) ESP_ShowHealth = v end)
Checkbox(tabContents[2], 150, "Mostrar a distância do jogador", false, function(v) ESP_ShowDistance = v end)
Checkbox(tabContents[2], 185, "Mostrar o time do jogador", false, function(v) ESP_ShowTeam = v end)
Checkbox(tabContents[2], 220, "Mostrar o nível do jogador", false, function(v) ESP_ShowLevel = v end)

-- 🎯 ABA AIMBOT — FOV CÍRCULO SÓ APARECE QUANDO ATIVAR AIMBOT!
local Aimbot_On = false -- ✅ COMEÇA DESLIGADO!
local Aimbot_FOV = 90
local Aimbot_Smooth = 2

Checkbox(tabContents[1], 10, "Ativar Aimbot", false, function(v)
    Aimbot_On = v
    FovCircle.Visible = v -- ✅ CÍRCULO AMARELO APARECE SÓ QUANDO ATIVA AIMBOT!
end)
Slider(tabContents[1], 50, "Campo de Visão (FOV)", 20, 360, 90, function(v)
    Aimbot_FOV = v
    FovCircle.Radius = v
end)
Slider(tabContents[1], 110, "Suavidade da Mira", 1, 10, 2, function(v) Aimbot_Smooth = v end)
Checkbox(tabContents[1], 170, "Mirar na Cabeça", false, function() end)
Checkbox(tabContents[1], 200, "Ignorar Aliados", false, function() end)

-- ⚡ MOVIMENTO
local Speed = 16
local Jump = 50
local NoKB = false
local Fly = false
Slider(tabContents[3], 10, "Velocidade", 16, 120, 16, function(v) Speed = v end)
Slider(tabContents[3], 70, "Força do Pulo", 50, 300, 50, function(v) Jump = v end)
Checkbox(tabContents[3], 130, "Sem Recuo", false, function(v) NoKB = v end)
Checkbox(tabContents[3], 165, "Voar (Fly)", false, function(v) Fly = v end)

-- ⚔️ COMBATE
Checkbox(tabContents[4], 10, "Auto Combo", false, function() end)
Checkbox(tabContents[4], 45, "Auto Ataque", false, function() end)
Checkbox(tabContents[4], 80, "Ataque Rápido", false, function() end)

-- ==============================================
-- 🔄 LOOP PRINCIPAL
-- ==============================================
RunService.RenderStepped:Connect(function()
    -- ⭕ FOV CÍRCULO — SÓ ATUALIZA SE ESTIVER VISÍVEL
    if FovCircle.Visible then
        FovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    end

    -- 👁️ ESP — LIMPA TUDO PRIMEIRO
    for _,d in pairs(ESP_Drawings) do if d then d:Remove() end end
    table.clear(ESP_Drawings)

    -- ✅ SÓ DESENHA ESP SE ESTIVER ATIVADO!
    if ESP_Enabled then
        for _,v in pairs(Players:GetPlayers()) do
            if v~=Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health>0 then
                local hrp = v.Character.HumanoidRootPart
                local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
                if vis then
                    local dist = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                    local col = v.Team==Player.Team and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,60,60)

                    -- NOME
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

                    -- VIDA
                    if ESP_ShowHealth then
                        local hp = math.floor(v.Character.Humanoid.Health)
                        local t = Drawing.new("Text")
                        t.Text = "Vida: "..hp
                        t.Position = Vector2.new(pos.X, pos.Y - 30)
                        t.Color = Color3.fromRGB(255,80,80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Drawings, t)
                    end

                    -- DISTÂNCIA
                    if ESP_ShowDistance then
                        local t = Drawing.new("Text")
                        t.Text = "Dist: "..dist
                        t.Position = Vector2.new(pos.X, pos.Y - 15)
                        t.Color = Color3.fromRGB(255,220,80)
                        t.Center = true
                        t.Size = 11
                        t.Visible = true
                        table.insert(ESP_Drawings, t)
                    end

                    -- TIME
                    if ESP_ShowTeam then
                        local t = Drawing.new("Text")
                        t.Text = "Time: "..v.Team.Name
                        t.Position = Vector2.new(pos.X, pos.Y + 5)
                        t.Color = col
                        t.Center = true
                        t.Size = 10
                        t.Visible = true
                        table.insert(ESP_Drawings, t)
                    end

                    -- NÍVEL
                    if ESP_ShowLevel then
                        local t = Drawing.new("Text")
                        t.Text = "Nível: ??"
                        t.Position = Vector2.new(pos.X, pos.Y + 20)
                        t.Color = Color3.fromRGB(120,200,255)
                        t.Center = true
                        t.Size = 10
                        t.Visible = true
                        table.insert(ESP_Drawings, t)
                    end
                end
            end
        end
    end

    -- 🎯 AIMBOT
    if Aimbot_On then
        local near, minD = nil, Aimbot_FOV
        local camCF = Camera.CFrame
        for _,v in pairs(Players:GetPlayers()) do
            if v~=Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health>0 then
                local sp = camCF:PointToObjectSpace(v.Character.HumanoidRootPart.Position)
                local d = (Vector2.new(sp.X, sp.Z)).Magnitude
                if d<minD then minD=d near=v end
            end
        end
        if near then
            local pos, vis = Camera:WorldToViewportPoint(near.Character.HumanoidRootPart.Position)
            if vis then
                local tgt = CFrame.new(Camera.CFrame.Position, near.Character.HumanoidRootPart.Position)
                Camera.CFrame = Camera.CFrame:Lerp(tgt, 1/Aimbot_Smooth)
            end
        end
    end

    -- ⚡ MOVIMENTO
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = Speed
        Player.Character.Humanoid.JumpPower = Jump
    end

    -- ✈️ FLY
    if Fly and Player.Character then
        Player.Character.Humanoid.PlatformStand = true
        local spd = 0.5
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Player.Character:TranslateBy(Vector3.new(0,spd,0)) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Player.Character:TranslateBy(Vector3.new(0,-spd,0)) end
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Player.Character:TranslateBy(Camera.CFrame.LookVector*spd) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Player.Character:TranslateBy(-Camera.CFrame.LookVector*spd) end
    end

    -- 🛡️ NO KNOCKBACK
    if NoKB and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.AssemblyLinearVelocity *= Vector3.new(0.98,1,0.98)
    end
end)

-- ✅ FECHAR
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    FovCircle:Remove()
    for _,d in pairs(ESP_Drawings) do if d then d:Remove() end end
end)

-- ✅ ARRASTAR PAINEL
local drag, dStart, pStart
Header.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true dStart=i.Position pStart=MainPanel.Position end
end)
UserInputService.InputChanged:Connect(function(i)
    if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
        local d = i.Position - dStart
        MainPanel.Position = UDim2.new(pStart.X.Scale, pStart.X.Offset+d.X, pStart.Y.Scale, pStart.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)

-- ✅ NOTIFICAÇÃO
StarterGui:SetCore("SendNotification", {Title="🧅 MARIONETEIRO", Text="✅ Pronto! Marque a caixa pra ativar FOV e ESP!", Duration=4})
