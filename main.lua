-- ==========================================
-- 🎭 MARIONETEIRO — VERSÃO COMPATÍVEL COM DELTA
-- SEM DRAWING | AIMBOT + FOV + ESP + MOVIMENTO
-- ==========================================

-- ✅ ESPERA O JOGO CARREGAR COMPLETO
repeat task.wait(0.1) until game:IsLoaded() and game.Players.LocalPlayer
print("🎭 MARIONETEIRO CARREGOU COM SUCESSO!")

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "🎭 MARIONETEIRO",
    Text = "Painel pronto — compatível com Delta!",
    Duration = 4
})

-- 🔹 SERVIÇOS OBRIGATÓRIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GuiPrincipal = game.CoreGui

-- 🔹 PROTEÇÃO BÁSICA
local function Tentar(funcao) pcall(funcao) end

-- 🔹 CONFIGURAÇÕES
local Config = {
    AimbotLigado = false,
    Suavidade = 0.25,
    FOV = 120,
    Velocidade = 16,
    VelocidadeMax = 32,
    Salto = 50,
    SaltoMax = 120,
    ESPLigado = false,
    IgnorarAliados = true
}
local VelocidadeOriginal = 16
local SaltoOriginal = 50
local ListaEtiquetas = {}

-- 🔹 INTERFACE
local Tela = Instance.new("ScreenGui")
Tela.Name = "MarioneteiroMenu"
Tela.Parent = GuiPrincipal
Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- BOTÃO FLUTUANTE ROXO
local BotaoAbrir = Instance.new("TextButton")
BotaoAbrir.Parent = Tela
BotaoAbrir.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
BotaoAbrir.Position = UDim2.new(0.02,0,0.45,0)
BotaoAbrir.Size = UDim2.new(0, 60, 0, 60)
BotaoAbrir.Font = Enum.Font.GothamBold
BotaoAbrir.Text = "🎭"
BotaoAbrir.TextColor3 = Color3.new(1,1,1)
BotaoAbrir.TextScaled = true
BotaoAbrir.Active = true
BotaoAbrir.Draggable = true

-- PAINEL NO MEIO
local Painel = Instance.new("Frame")
Painel.Parent = Tela
Painel.BackgroundColor3 = Color3.fromRGB(22, 16, 32)
Painel.BorderColor3 = Color3.fromRGB(138, 43, 226)
Painel.Position = UDim2.new(0.5, -150, 0.5, -210)
Painel.Size = UDim2.new(0, 300, 0, 420)
Painel.Visible = false
Painel.Active = true
Painel.Draggable = true

-- TÍTULO
local Titulo = Instance.new("TextLabel")
Titulo.Parent = Painel
Titulo.BackgroundTransparency = 1
Titulo.Position = UDim2.new(0,10,0,10)
Titulo.Size = UDim2.new(1,-20,0,35)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "🎭 MARIONETEIRO — BLOX FRUITS"
Titulo.TextColor3 = Color3.fromRGB(186, 85, 211)
Titulo.TextScaled = true

-- ÁREA DE BOTÕES
local AreaFuncoes = Instance.new("ScrollingFrame")
AreaFuncoes.Parent = Painel
AreaFuncoes.BackgroundTransparency = 1
AreaFuncoes.Position = UDim2.new(0,10,0,55)
AreaFuncoes.Size = UDim2.new(1,-20,1,-65)
AreaFuncoes.ScrollBarThickness = 6

local Layout = Instance.new("UIListLayout")
Layout.Parent = AreaFuncoes
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- 🔹 CRIAR BOTÃO
local function CriarBotao(Nome, Funcao)
    Tentar(function()
        local Botao = Instance.new("TextButton")
        Botao.Parent = AreaFuncoes
        Botao.BackgroundColor3 = Color3.fromRGB(55, 35, 85)
        Botao.Size = UDim2.new(0, 260, 0, 38)
        Botao.Font = Enum.Font.Gotham
        Botao.Text = Nome
        Botao.TextColor3 = Color3.fromRGB(220, 180, 255)
        Botao.TextScaled = true
        Botao.MouseButton1Click:Connect(Funcao)
        task.wait(0.1)
        AreaFuncoes.CanvasSize = UDim2.new(0,0,0, Layout.AbsoluteContentSize.Y + 20)
    end)
end

-- 🔹 ABRIR/FECHAR
BotaoAbrir.MouseButton1Click:Connect(function()
    Painel.Visible = not Painel.Visible
end)

-- 🔹 PEGAR ALVO DO AIMBOT
local function PegarAlvo()
    local MelhorAlvo, MenorDist = nil, Config.FOV
    for _, Jogador in next, Players:GetPlayers() do
        if Jogador == LocalPlayer then continue end
        if Config.IgnorarAliados and Jogador.Team == LocalPlayer.Team then continue end
        local P = Jogador.Character
        if not P or not P:FindFirstChild("HumanoidRootPart") or P.Humanoid.Health <= 0 then continue end

        local Tela, Visivel = Camera:WorldToViewportPoint(P.HumanoidRootPart.Position)
        if Visivel then
            local Dist = (Vector2.new(Tela.X, Tela.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            if Dist < MenorDist then
                MenorDist = Dist
                MelhorAlvo = P.HumanoidRootPart
            end
        end
    end
    return MelhorAlvo
end

-- 🔹 AIMBOT E FOV
CriarBotao("🎯 AIMBOT (LIGA/DESLIGA)", function()
    Config.AimbotLigado = not Config.AimbotLigado
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭", Text="Aimbot: "..(Config.AimbotLigado and "LIGADO" or "DESLIGADO"), Duration=2})
end)
CriarBotao("🔼 AUMENTAR FOV", function()
    Config.FOV = math.min(Config.FOV + 10, 300)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 FOV", Text="Valor: "..Config.FOV, Duration=1.5})
end)
CriarBotao("🔽 DIMINUIR FOV", function()
    Config.FOV = math.max(Config.FOV - 10, 30)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 FOV", Text="Valor: "..Config.FOV, Duration=1.5})
end)

RunService.RenderStepped:Connect(function()
    if Config.AimbotLigado then
        local Alvo = PegarAlvo()
        if Alvo then
            local Dir = (Alvo.Position - Camera.CFrame.Position).Unit
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Dir), Config.Suavidade)
        end
    end
end)

-- 🔹 VELOCIDADE E SALTO
CriarBotao("⚡ AUMENTAR VELOCIDADE", function()
    Config.Velocidade = math.min(Config.Velocidade + 2, Config.VelocidadeMax)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.WalkSpeed = Config.Velocidade end
end)
CriarBotao("🐢 DIMINUIR VELOCIDADE", function()
    Config.Velocidade = math.max(Config.Velocidade - 2, VelocidadeOriginal)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.WalkSpeed = Config.Velocidade end
end)
CriarBotao("🦘 AUMENTAR SALTO", function()
    Config.Salto = math.min(Config.Salto + 5, Config.SaltoMax)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.JumpPower = Config.Salto end
end)
CriarBotao("⬇️ DIMINUIR SALTO", function()
    Config.Salto = math.max(Config.Salto - 5, SaltoOriginal)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.JumpPower = Config.Salto end
end)

-- 🔹 ESP
CriarBotao("👁️ ESP (LIGA/DESLIGA)", function()
    Config.ESPLigado = not Config.ESPLigado
    if not Config.ESPLigado then
        for _, v in next, ListaEtiquetas do if v then v:Destroy() end end
        ListaEtiquetas = {}
    end
end)

task.spawn(function()
    while task.wait(0.8) do
        if not Config.ESPLigado then continue end
        for _, Jogador in next, Players:GetPlayers() do
            if Jogador == LocalPlayer then continue end
            local P = Jogador.Character
            if not P or not P:FindFirstChild("HumanoidRootPart") or P.Humanoid.Health <=0 then continue end

            local Etiqueta = ListaEtiquetas[Jogador.UserId] or Instance.new("BillboardGui")
            Etiqueta.Adornee = P.HumanoidRootPart
            Etiqueta.AlwaysOnTop = true
            Etiqueta.Size = UDim2.new(0, 150, 0, 50)
            Etiqueta.StudsOffset = Vector3.new(0, 3, 0)
            Etiqueta.Parent = GuiPrincipal

            local Texto = Etiqueta:FindFirstChild("TextoESP") or Instance.new("TextLabel")
            Texto.Name = "TextoESP"
            Texto.BackgroundTransparency = 1
            Texto.Size = UDim2.new(1,0,1,0)
            Texto.Font = Enum.Font.GothamBold
            Texto.TextColor3 = Color3.fromRGB(255, 100, 255)
            Texto.TextStrokeTransparency = 0
            Texto.TextScaled = true
            Texto.Text = Jogador.Name.."\n❤️ "..math.floor(P.Humanoid.Health).."/"..P.Humanoid.MaxHealth
            Texto.Parent = Etiqueta

            ListaEtiquetas[Jogador.UserId] = Etiqueta
        end
    end
end)
