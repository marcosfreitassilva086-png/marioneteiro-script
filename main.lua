-- ==========================================
-- 🎭 MARIONETEIRO — VERSÃO CORRIGIDA DELTA
-- ABAS / INTERRUPTORES / BARRAS / FUNCIONANDO
-- ==========================================

-- ✅ ESPERA CARREGAR
repeat task.wait(0.1) until game:IsLoaded() and game.Players.LocalPlayer
print("🎭 MARIONETEIRO CARREGOU!")

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "🎭 MARIONETEIRO",
    Text = "Painel atualizado — funções aparecendo!",
    Duration = 3
})

-- 🔹 SERVIÇOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GuiPrincipal = game.CoreGui

-- 🔹 PROTEÇÃO
local function Tentar(f) pcall(f) end

-- 🔹 CONFIGURAÇÕES
local Config = {
    AbaAtual = 1,
    Aimbot = false,
    Suavidade = 0.25,
    FOV = 120,
    Velocidade = 16,
    Salto = 50,
    ESP = false,
    ESP_Nome = true,
    ESP_Vida = true,
    ESP_Distancia = true
}
local OrigemVel = 16
local OrigemSalto = 50
local ListaEtiquetas = {}

-- 🔹 TELA PRINCIPAL
local Tela = Instance.new("ScreenGui")
Tela.Name = "Marioneteiro"
Tela.Parent = GuiPrincipal
Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Tela.ResetOnSpawn = false

-- BOTÃO ABRIR/FECHAR
local BtnAbrir = Instance.new("TextButton")
BtnAbrir.Parent = Tela
BtnAbrir.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
BtnAbrir.Position = UDim2.new(0.02,0,0.4,0)
BtnAbrir.Size = UDim2.new(0,55,0,55)
BtnAbrir.Font = Enum.Font.GothamBold
BtnAbrir.Text = "🎭"
BtnAbrir.TextColor3 = Color3.new(1,1,1)
BtnAbrir.TextScaled = true
BtnAbrir.Active = true
BtnAbrir.Draggable = true

-- PAINEL PRINCIPAL
local Painel = Instance.new("Frame")
Painel.Parent = Tela
Painel.BackgroundColor3 = Color3.fromRGB(18,12,28)
Painel.BorderColor3 = Color3.fromRGB(138,43,226)
Painel.Position = UDim2.new(0.5,-180,0.5,-200)
Painel.Size = UDim2.new(0,360,0,400)
Painel.Visible = false
Painel.Active = true
Painel.Draggable = true

-- TÍTULO
local Titulo = Instance.new("TextLabel")
Titulo.Parent = Painel
Titulo.BackgroundTransparency = 1
Titulo.Position = UDim2.new(0,0,0,10)
Titulo.Size = UDim2.new(1,0,0,35)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "🎭 MARIONETEIRO — BLOX FRUITS"
Titulo.TextColor3 = Color3.fromRGB(200,140,255)
Titulo.TextScaled = true

-- MENU DE ABAS LATERAL
local MenuAbas = Instance.new("Frame")
MenuAbas.Parent = Painel
MenuAbas.BackgroundColor3 = Color3.fromRGB(30,20,45)
MenuAbas.Position = UDim2.new(0,10,0,55)
MenuAbas.Size = UDim2.new(0,90,1,-65)

local AreaConteudo = Instance.new("Frame")
AreaConteudo.Parent = Painel
AreaConteudo.BackgroundTransparency = 1
AreaConteudo.Position = UDim2.new(0,110,0,55)
AreaConteudo.Size = UDim2.new(1,-120,1,-65)

local ListaAbas = {"Geral", "Combate", "ESP", "Mais"}
local BotoesAbas = {}
local Conteudos = {}

-- 🔹 FUNÇÃO CRIAR INTERRUPTOR (GARANTIDO)
local function CriarSwitch(Pai, Texto, ValorInicial, Callback)
    local Linha = Instance.new("Frame")
    Linha.Parent = Pai
    Linha.BackgroundTransparency = 1
    Linha.Size = UDim2.new(1,0,0,35)

    local TextoLbl = Instance.new("TextLabel")
    TextoLbl.Parent = Linha
    TextoLbl.BackgroundTransparency = 1
    TextoLbl.Position = UDim2.new(0,5,0,0)
    TextoLbl.Size = UDim2.new(0.7,0,1,0)
    TextoLbl.Font = Enum.Font.Gotham
    TextoLbl.Text = Texto
    TextoLbl.TextColor3 = Color3.fromRGB(220,180,255)
    TextoLbl.TextScaled = true
    TextoLbl.TextXAlignment = Enum.TextXAlignment.Left

    local Caixa = Instance.new("TextButton")
    Caixa.Parent = Linha
    Caixa.BackgroundColor3 = ValorInicial and Color3.fromRGB(138,43,226) or Color3.fromRGB(60,40,90)
    Caixa.Position = UDim2.new(0.82,0,0.2,0)
    Caixa.Size = UDim2.new(0,22,0,18)
    Caixa.Text = ""

    local Ligado = ValorInicial
    Caixa.MouseButton1Click:Connect(function()
        Ligado = not Ligado
        Caixa.BackgroundColor3 = Ligado and Color3.fromRGB(138,43,226) or Color3.fromRGB(60,40,90)
        Callback(Ligado)
    end)
end

-- 🔹 FUNÇÃO CRIAR AJUSTE COM BOTÕES (COMPATÍVEL COM DELTA)
local function CriarAjuste(Pai, Texto, Min, Max, ValorInicial, Callback)
    local Linha = Instance.new("Frame")
    Linha.Parent = Pai
    Linha.BackgroundTransparency = 1
    Linha.Size = UDim2.new(1,0,0,40)

    local ValorAtual = ValorInicial
    local TextoLbl = Instance.new("TextLabel")
    TextoLbl.Parent = Linha
    TextoLbl.BackgroundTransparency = 1
    TextoLbl.Position = UDim2.new(0,5,0,0)
    TextoLbl.Size = UDim2.new(0.6,0,1,0)
    TextoLbl.Font = Enum.Font.Gotham
    TextoLbl.Text = Texto..": "..ValorAtual
    TextoLbl.TextColor3 = Color3.fromRGB(220,180,255)
    TextoLbl.TextScaled = true
    TextoLbl.TextXAlignment = Enum.TextXAlignment.Left

    local BtnMenos = Instance.new("TextButton")
    BtnMenos.Parent = Linha
    BtnMenos.BackgroundColor3 = Color3.fromRGB(55,35,85)
    BtnMenos.Position = UDim2.new(0.65,0,0.1,0)
    BtnMenos.Size = UDim2.new(0,25,0,25)
    BtnMenos.Font = Enum.Font.GothamBold
    BtnMenos.Text = "-"
    BtnMenos.TextColor3 = Color3.new(1,1,1)
    BtnMenos.TextScaled = true

    local BtnMais = Instance.new("TextButton")
    BtnMais.Parent = Linha
    BtnMais.BackgroundColor3 = Color3.fromRGB(138,43,226)
    BtnMais.Position = UDim2.new(0.9,0,0.1,0)
    BtnMais.Size = UDim2.new(0,25,0,25)
    BtnMais.Font = Enum.Font.GothamBold
    BtnMais.Text = "+"
    BtnMais.TextColor3 = Color3.new(1,1,1)
    BtnMais.TextScaled = true

    BtnMenos.MouseButton1Click:Connect(function()
        ValorAtual = math.max(Min, ValorAtual - 1)
        TextoLbl.Text = Texto..": "..ValorAtual
        Callback(ValorAtual)
    end)

    BtnMais.MouseButton1Click:Connect(function()
        ValorAtual = math.min(Max, ValorAtual + 1)
        TextoLbl.Text = Texto..": "..ValorAtual
        Callback(ValorAtual)
    end)
end

-- 🔹 CRIAR ABAS E CONTEÚDO
for i, Nome in ipairs(ListaAbas) do
    local Btn = Instance.new("TextButton")
    Btn.Parent = MenuAbas
    Btn.BackgroundColor3 = i == 1 and Color3.fromRGB(138,43,226) or Color3.fromRGB(40,28,60)
    Btn.Position = UDim2.new(0,5,0,(i-1)*40+5)
    Btn.Size = UDim2.new(1,-10,0,32)
    Btn.Font = Enum.Font.Gotham
    Btn.Text = Nome
    Btn.TextColor3 = Color3.fromRGB(220,180,255)
    Btn.TextScaled = true
    Btn.MouseButton1Click:Connect(function()
        Config.AbaAtual = i
        for k,v in pairs(BotoesAbas) do v.BackgroundColor3 = k == i and Color3.fromRGB(138,43,226) or Color3.fromRGB(40,28,60) end
        for k,v in pairs(Conteudos) do v.Visible = k == i end
    end)
    BotoesAbas[i] = Btn

    local Conteudo = Instance.new("ScrollingFrame")
    Conteudo.Parent = AreaConteudo
    Conteudo.BackgroundTransparency = 1
    Conteudo.Size = UDim2.new(1,0,1,0)
    Conteudo.ScrollBarThickness = 5
    Conteudo.Visible = i == 1
    Conteudo.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Conteudo
    Layout.Padding = UDim.new(0,12)
    Conteudos[i] = Conteudo
end

-- 🔹 PREENCHER ABA 1: GERAL
CriarAjuste(Conteudos[1], "⚡ Velocidade", 16,32, Config.Velocidade, function(v)
    Config.Velocidade = v
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.WalkSpeed = v end
end)
CriarAjuste(Conteudos[1], "🦘 Força do Salto", 50,120, Config.Salto, function(v)
    Config.Salto = v
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.JumpPower = v end
end)

-- 🔹 PREENCHER ABA 2: COMBATE
CriarSwitch(Conteudos[2], "🎯 Aimbot", Config.Aimbot, function(v) Config.Aimbot = v end)
CriarAjuste(Conteudos[2], "📏 Campo de Visão (FOV)", 30,300, Config.FOV, function(v) Config.FOV = v end)
CriarAjuste(Conteudos[2], "🎚️ Suavidade da Mira", 5,100, Config.Suavidade*100, function(v) Config.Suavidade = v/100 end)

-- 🔹 PREENCHER ABA 3: ESP
CriarSwitch(Conteudos[3], "👁️ Mostrar ESP", Config.ESP, function(v)
    Config.ESP = v
    if not v then for _,e in pairs(ListaEtiquetas) do e:Destroy() end ListaEtiquetas={} end
end)
CriarSwitch(Conteudos[3], "🏷️ Nome do Jogador", Config.ESP_Nome, function(v) Config.ESP_Nome = v end)
CriarSwitch(Conteudos[3], "❤️ Barra de Vida", Config.ESP_Vida, function(v) Config.ESP_Vida = v end)
CriarSwitch(Conteudos[3], "📏 Distância", Config.ESP_Distancia, function(v) Config.ESP_Distancia = v end)

-- 🔹 PREENCHER ABA 4: MAIS
CriarSwitch(Conteudos[4], "🛡️ Anti‑AFK", false, function(v) end)

-- 🔹 ABRIR/FECHAR PAINEL
BtnAbrir.MouseButton1Click:Connect(function() Painel.Visible = not Painel.Visible end)

-- 🔹 SISTEMA AIMBOT
local function PegarAlvo()
    local Melhor, Menor = nil, Config.FOV
    for _,J in pairs(Players:GetPlayers()) do
        if J == LocalPlayer then continue end
        local P = J.Character
        if not P or not P:FindFirstChild("HumanoidRootPart") or P.Humanoid.Health<=0 then continue end
        local Tela, Vis = Camera:WorldToViewportPoint(P.HumanoidRootPart.Position)
        if Vis then
            local D = (Vector2.new(Tela.X,Tela.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            if D < Menor then Menor = D Melhor = P.HumanoidRootPart end
        end
    end
    return Melhor
end

RunService.RenderStepped:Connect(function()
    if Config.Aimbot then
        local Alvo = PegarAlvo()
        if Alvo then
            local Dir = (Alvo.Position - Camera.CFrame.Position).Unit
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position+Dir), Config.Suavidade)
        end
    end
end)

-- 🔹 SISTEMA ESP
task.spawn(function()
    while task.wait(0.7) do
        if not Config.ESP then continue end
        for _,J in pairs(Players:GetPlayers()) do
            if J == LocalPlayer then continue end
            local P = J.Character
            if not P or not P:FindFirstChild("HumanoidRootPart") or P.Humanoid.Health<=0 then continue end

            local Tag = ListaEtiquetas[J.UserId] or Instance.new("BillboardGui")
            Tag.Adornee = P.HumanoidRootPart
            Tag.AlwaysOnTop = true
            Tag.Size = UDim2.new(0,180,0,80)
            Tag.StudsOffset = Vector3.new(0,4,0)
            Tag.Parent = GuiPrincipal

            local Texto = Tag:FindFirstChild("Texto") or Instance.new("TextLabel")
            Texto.Name = "Texto"
            Texto.BackgroundTransparency = 1
            Texto.Size = UDim2.new(1,0,1,0)
            Texto.Font = Enum.Font.GothamBold
            Texto.TextColor3 = Color3.fromRGB(255,120,255)
            Texto.TextStrokeTransparency = 0
            Texto.TextScaled = true
            local Dist = math.floor((P.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
            local Txt = ""
            if Config.ESP_Nome then Txt = Txt..J.Name.."\n" end
            if Config.ESP_Vida then Txt = Txt.."❤️ "..math.floor(P.Humanoid.Health).."/"..P.Humanoid.MaxHealth.."\n" end
            if Config.ESP_Distancia then Txt = Txt.."📏 "..Dist.."m" end
            Texto.Text = Txt
            Texto.Parent = Tag

            ListaEtiquetas[J.UserId] = Tag
        end
    end
end)
