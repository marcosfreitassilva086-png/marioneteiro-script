-- ==========================================
-- 🎭 MARIONETEIRO — VERSÃO PVP COMPLETA
-- AIMBOT OTIMIZADO + PREVISÃO + MIRA SELECIONÁVEL + ESP + MOVIMENTO + UTILIDADES
-- ==========================================

-- ✅ Espera o jogo carregar completamente
repeat task.wait(0.1) until game:IsLoaded() and game.Players.LocalPlayer
print("🎭 MARIONETEIRO — PVP PRONTO!")

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "🎭 MARIONETEIRO",
    Text = "Todas as funções PVP integradas!",
    Duration = 3
})

-- 🔹 Serviços essenciais
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GuiPrincipal = game.CoreGui

-- 🔹 Proteção contra erros
local function Tentar(funcao) pcall(funcao) end

-- ⚙️ TODAS AS CONFIGURAÇÕES UNIFICADAS
local Config = {
    -- Aimbot PvP
    Aimbot = false,
    AlvoParte = "Cabeça", -- Cabeça / Peito / Raiz
    PrevisaoMovimento = true,
    ForcaPrevisao = 0.25,
    Suavidade = 0.3,
    FOV = 120,
    DistanciaMaxima = 80,
    IgnorarAliados = true,
    IgnorarMortos = true,
    -- Movimento
    Velocidade = 16,
    VelocidadeMax = 32,
    Salto = 50,
    SaltoMax = 120,
    SemRecuo = false,
    -- ESP
    ESP = false,
    ESP_Caixa = true,
    ESP_Nome = true,
    ESP_Vida = true,
    ESP_Distancia = true,
    -- Utilidades
    AntiAFK = false
}
local ListaEtiquetas = {}

-- 🔹 Aplica velocidade e salto ao renascer
local function AtualizarMovimento()
    local Personagem = LocalPlayer.Character
    if Personagem and Personagem:FindFirstChild("Humanoid") then
        Personagem.Humanoid.WalkSpeed = Config.Velocidade
        Personagem.Humanoid.JumpPower = Config.Salto
    end
end
LocalPlayer.CharacterAdded:Connect(AtualizarMovimento)
task.wait(1)
AtualizarMovimento()

-- 🔹 Interface principal — Tema roxo, painel centralizado
local Tela = Instance.new("ScreenGui")
Tela.Name = "MarioneteiroPvP"
Tela.Parent = GuiPrincipal
Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Tela.ResetOnSpawn = false

-- Botão flutuante para abrir/fechar
local BtnAbrir = Instance.new("TextButton")
BtnAbrir.Parent = Tela
BtnAbrir.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
BtnAbrir.Position = UDim2.new(0.02, 0, 0.4, 0)
BtnAbrir.Size = UDim2.new(0, 55, 0, 55)
BtnAbrir.Font = Enum.Font.GothamBold
BtnAbrir.Text = "🎭"
BtnAbrir.TextColor3 = Color3.new(1, 1, 1)
BtnAbrir.TextScaled = true
BtnAbrir.Active = true
BtnAbrir.Draggable = true

-- Painel principal
local Painel = Instance.new("Frame")
Painel.Parent = Tela
Painel.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
Painel.BorderColor3 = Color3.fromRGB(138, 43, 226)
Painel.Position = UDim2.new(0.5, -180, 0.5, -220)
Painel.Size = UDim2.new(0, 360, 0, 440)
Painel.Visible = false
Painel.Active = true
Painel.Draggable = true

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Parent = Painel
Titulo.BackgroundTransparency = 1
Titulo.Position = UDim2.new(0, 0, 0, 10)
Titulo.Size = UDim2.new(1, 0, 0, 35)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "🎭 MARIONETEIRO — PVP BLOX FRUITS"
Titulo.TextColor3 = Color3.fromRGB(200, 140, 255)
Titulo.TextScaled = true

-- Menu de abas
local MenuAbas = Instance.new("Frame")
MenuAbas.Parent = Painel
MenuAbas.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
MenuAbas.Position = UDim2.new(0, 10, 0, 55)
MenuAbas.Size = UDim2.new(0, 90, 1, -65)

local AreaConteudo = Instance.new("Frame")
AreaConteudo.Parent = Painel
AreaConteudo.BackgroundTransparency = 1
AreaConteudo.Position = UDim2.new(0, 110, 0, 55)
AreaConteudo.Size = UDim2.new(1, -120, 1, -65)

local NomesAbas = {"Geral", "Aimbot PvP", "ESP", "Utilidades"}
local BotoesAbas = {}
local Conteudos = {}

-- 🔹 Funções auxiliares para criar controles
local function CriarInterruptor(Pai, Texto, ValorInicial, Acao)
    local Linha = Instance.new("Frame")
    Linha.Parent = Pai
    Linha.BackgroundTransparency = 1
    Linha.Size = UDim2.new(1, 0, 0, 35)

    local Rotulo = Instance.new("TextLabel")
    Rotulo.Parent = Linha
    Rotulo.BackgroundTransparency = 1
    Rotulo.Position = UDim2.new(0, 5, 0, 0)
    Rotulo.Size = UDim2.new(0.7, 0, 1, 0)
    Rotulo.Font = Enum.Font.Gotham
    Rotulo.Text = Texto
    Rotulo.TextColor3 = Color3.fromRGB(220, 180, 255)
    Rotulo.TextScaled = true
    Rotulo.TextXAlignment = Enum.TextXAlignment.Left

    local Caixa = Instance.new("TextButton")
    Caixa.Parent = Linha
    Caixa.BackgroundColor3 = ValorInicial and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(60, 40, 90)
    Caixa.Position = UDim2.new(0.82, 0, 0.2, 0)
    Caixa.Size = UDim2.new(0, 22, 0, 18)
    Caixa.Text = ""

    local Ligado = ValorInicial
    Caixa.MouseButton1Click:Connect(function()
        Ligado = not Ligado
        Caixa.BackgroundColor3 = Ligado and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(60, 40, 90)
        Acao(Ligado)
    end)
end

local function CriarAjusteValor(Pai, Texto, Minimo, Maximo, ValorInicial, Acao)
    local Linha = Instance.new("Frame")
    Linha.Parent = Pai
    Linha.BackgroundTransparency = 1
    Linha.Size = UDim2.new(1, 0, 0, 40)

    local ValorAtual = ValorInicial
    local Rotulo = Instance.new("TextLabel")
    Rotulo.Parent = Linha
    Rotulo.BackgroundTransparency = 1
    Rotulo.Position = UDim2.new(0, 5, 0, 0)
    Rotulo.Size = UDim2.new(0.6, 0, 1, 0)
    Rotulo.Font = Enum.Font.Gotham
    Rotulo.Text = Texto..": "..ValorAtual
    Rotulo.TextColor3 = Color3.fromRGB(220, 180, 255)
    Rotulo.TextScaled = true

    local BotaoMenos = Instance.new("TextButton")
    BotaoMenos.Parent = Linha
    BotaoMenos.BackgroundColor3 = Color3.fromRGB(55, 35, 85)
    BotaoMenos.Position = UDim2.new(0.65, 0, 0.1, 0)
    BotaoMenos.Size = UDim2.new(0, 25, 0, 25)
    BotaoMenos.Font = Enum.Font.GothamBold
    BotaoMenos.Text = "-"
    BotaoMenos.TextColor3 = Color3.new(1, 1, 1)
    BotaoMenos.TextScaled = true

    local BotaoMais = Instance.new("TextButton")
    BotaoMais.Parent = Linha
    BotaoMais.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    BotaoMais.Position = UDim2.new(0.9, 0, 0.1, 0)
    BotaoMais.Size = UDim2.new(0, 25, 0, 25)
    BotaoMais.Font = Enum.Font.GothamBold
    BotaoMais.Text = "+"
    BotaoMais.TextColor3 = Color3.new(1, 1, 1)
    BotaoMais.TextScaled = true

    BotaoMenos.MouseButton1Click:Connect(function()
        ValorAtual = math.max(Minimo, ValorAtual - 1)
        Rotulo.Text = Texto..": "..ValorAtual
        Acao(ValorAtual)
        AtualizarMovimento()
    end)

    BotaoMais.MouseButton1Click:Connect(function()
        ValorAtual = math.min(Maximo, ValorAtual + 1)
        Rotulo.Text = Texto..": "..ValorAtual
        Acao(ValorAtual)
        AtualizarMovimento()
    end)
end

-- 🔹 Montar as abas
for Indice, NomeAba in ipairs(NomesAbas) do
    local BotaoAba = Instance.new("TextButton")
    BotaoAba.Parent = MenuAbas
    BotaoAba.BackgroundColor3 = Indice == 1 and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(40, 28, 60)
    BotaoAba.Position = UDim2.new(0, 5, 0, (Indice - 1) * 40 + 5)
    BotaoAba.Size = UDim2.new(1, -10, 0, 32)
    BotaoAba.Font = Enum.Font.Gotham
    BotaoAba.Text = NomeAba
    BotaoAba.TextColor3 = Color3.fromRGB(220, 180, 255)
    BotaoAba.TextScaled = true

    BotaoAba.MouseButton1Click:Connect(function()
        for K, V in pairs(BotoesAbas) do
            V.BackgroundColor3 = K == Indice and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(40, 28, 60)
        end
        for K, V in pairs(Conteudos) do
            V.Visible = K == Indice
        end
    end)
    BotoesAbas[Indice] = BotaoAba

    local ConteudoAba = Instance.new("ScrollingFrame")
    ConteudoAba.Parent = AreaConteudo
    ConteudoAba.BackgroundTransparency = 1
    ConteudoAba.Size = UDim2.new(1, 0, 1, 0)
    ConteudoAba.ScrollBarThickness = 5
    ConteudoAba.Visible = Indice == 1
    ConteudoAba.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = ConteudoAba
    Layout.Padding = UDim.new(0, 12)
    Conteudos[Indice] = ConteudoAba
end

-- 🔹 Preencher aba Geral
CriarAjusteValor(Conteudos[1], "⚡ Velocidade", 16, Config.VelocidadeMax, Config.Velocidade, function(V) Config.Velocidade = V end)
CriarAjusteValor(Conteudos[1], "🦘 Força do Salto", 50, Config.SaltoMax, Config.Salto, function(V) Config.Salto = V end)
CriarInterruptor(Conteudos[1], "🔫 Sem Recuo", Config.SemRecuo, function(V) Config.SemRecuo = V end)

-- 🔹 Preencher aba Aimbot PvP
CriarInterruptor(Conteudos[2], "🎯 Aimbot", Config.Aimbot, function(V) Config.Aimbot = V end)
CriarInterruptor(Conteudos[2], "🎯 Mira em Cabeça", true, function(V) Config.AlvoParte = V and "Cabeça" or "Peito" end)
CriarInterruptor(Conteudos[2], "📈 Previsão de Movimento", Config.PrevisaoMovimento, function(V) Config.PrevisaoMovimento = V end)
CriarInterruptor(Conteudos[2], "🚫 Ignorar Aliados", Config.IgnorarAliados, function(V) Config.IgnorarAliados = V end)
CriarInterruptor(Conteudos[2], "💀 Ignorar Mortos", Config.IgnorarMortos, function(V) Config.IgnorarMortos = V end)
CriarAjusteValor(Conteudos[2], "📏 Campo de Visão (FOV)", 30, 200, Config.FOV, function(V) Config.FOV = V end)
CriarAjusteValor(Conteudos[2], "📏 Distância Máxima", 20, 150, Config.DistanciaMaxima, function(V) Config.DistanciaMaxima = V end)
CriarAjusteValor(Conteudos[2], "🎚️ Suavidade da Mira", 10, 90, Config.Suavidade * 100, function(V) Config.Suavidade = V / 100 end)

-- 🔹 Preencher aba ESP
CriarInterruptor(Conteudos[3], "👁️ Mostrar ESP", Config.ESP, function(V)
    Config.ESP = V
    if not V then
        for _, Etiqueta in pairs(ListaEtiquetas) do
            if Etiqueta then Etiqueta:Destroy() end
        end
        ListaEtiquetas = {}
    end
end)
CriarInterruptor(Conteudos[3], "📦 Caixa ao Redor", Config.ESP_Caixa, function(V) Config.ESP_Caixa = V end)
CriarInterruptor(Conteudos[3], "🏷️ Nome do Jogador", Config.ESP_Nome, function(V) Config.ESP_Nome = V end)
CriarInterruptor(Conteudos[3], "❤️ Vida e Escudo", Config.ESP_Vida, function(V) Config.ESP_Vida = V end)
CriarInterruptor(Conteudos[3], "📏 Distância até Você", Config.ESP_Distancia, function(V) Config.ESP_Distancia = V end)

-- 🔹 Preencher aba Utilidades
CriarInterruptor(Conteudos[4], "🛡️ Anti‑AFK", Config.AntiAFK, function(V) Config.AntiAFK = V end)

-- 🔹 Abrir/fechar painel
BtnAbrir.MouseButton1Click:Connect(function()
    Painel.Visible = not Painel.Visible
end)

-- 🔹 Sistema completo de busca de alvo para PvP
local function PegarParteAlvo(Personagem)
    if Config.AlvoParte == "Cabeça" and Personagem:FindFirstChild("Head") then
        return Personagem.Head
    elseif Config.AlvoParte == "Peito" and Personagem:FindFirstChild("Torso") then
        return Personagem.Torso
    end
    return Personagem:FindFirstChild("HumanoidRootPart")
end

local function PegarMelhorAlvoPvP()
    local MelhorAlvo, MenorDistanciaTela = nil, Config.FOV
    for _, Jogador in next, Players:GetPlayers() do
        if Jogador == LocalPlayer then goto Pular end
        if Config.IgnorarAliados and Jogador.Team == LocalPlayer.Team then goto Pular end

        local Personagem = Jogador.Character
        if not Personagem or not Personagem:FindFirstChild("HumanoidRootPart") then goto Pular end
        if Config.IgnorarMortos and Personagem.Humanoid.Health <= 0 then goto Pular end

        local ParteAlvo = PegarParteAlvo(Personagem)
        if not ParteAlvo then goto Pular end

        local DistanciaReal = (ParteAlvo.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if DistanciaReal > Config.DistanciaMaxima then goto Pular end

        local PosicaoTela, Visivel = Camera:WorldToViewportPoint(ParteAlvo.Position)
        if not Visivel then goto Pular end

        local DistanciaTela = (Vector2.new(PosicaoTela.X, PosicaoTela.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
        if DistanciaTela < MenorDistanciaTela then
            MenorDistanciaTela = DistanciaTela
            MelhorAlvo = ParteAlvo
        end

        ::Pular::
    end
    return MelhorAlvo
end

-- 🔹 Loop principal do aimbot e sem recuo
RunService.RenderStepped:Connect(function()
    if Config.Aimbot then
        local Alvo = PegarMelhorAlvoPvP()
        if Alvo then
            local PosicaoFinal = Alvo.Position
            if Config.PrevisaoMovimento then
                PosicaoFinal += Alvo.Velocity * Config.ForcaPrevisao
            end
            local Direcao = (PosicaoFinal - Camera.CFrame.Position).Unit
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Direcao), Config.Suavidade)
        end
    end

    if Config.SemRecuo then
        Camera.CFrame = Camera.CFrame * CFrame.Angles(0, 0, 0)
    end
end)

-- 🔹 Sistema ESP completo
task.spawn(function()
    while task.wait(0.7) do
        if not Config.ESP then continue end
        for _, Jogador in next, Players:GetPlayers() do
            if Jogador == LocalPlayer then goto PularESP end
            local Personagem = Jogador.Character
            if not Personagem or not Personagem:FindFirstChild("HumanoidRootPart") or Personagem.Humanoid.Health <= 0 then
                if ListaEtiquetas[Jogador.UserId] then
                    ListaEtiquetas[Jogador.UserId]:Destroy()
                    ListaEtiquetas[Jogador.UserId] = nil
                end
                goto PularESP
            end

            local Etiqueta = ListaEtiquetas[Jogador.UserId] or Instance.new("BillboardGui")
            Etiqueta.Adornee = Personagem.HumanoidRootPart
            Etiqueta.AlwaysOnTop = true
            Etiqueta.Size = UDim2.new(0, 200, 0, 100)
            Etiqueta.StudsOffset = Vector3.new(0, 5, 0)
            Etiqueta.Parent = GuiPrincipal

            local RotuloTexto = Etiqueta:FindFirstChild("TextoESP") or Instance.new("TextLabel")
            RotuloTexto.Name = "TextoESP"
            RotuloTexto.BackgroundTransparency = 1
            RotuloTexto.Size = UDim2.new(1, 0, 1, 0)
            RotuloTexto.Font = Enum.Font.GothamBold
            RotuloTexto.TextColor3 = Color3.fromRGB(255, 120, 255)
            RotuloTexto.TextStrokeTransparency = 0
            RotuloTexto.TextScaled = true

            local Distancia = math.floor((Personagem.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
            local Conteudo = ""
            if Config.ESP_Nome then Conteudo = Conteudo..Jogador.Name.."\n" end
            if Config.ESP_Vida then Conteudo = Conteudo.."❤️ "..math.floor(Personagem.Humanoid.Health).."/"..Personagem.Humanoid.MaxHealth.."\n" end
            if Config.ESP_Distancia then Conteudo = Conteudo.."📏 "..Distancia.."m" end
            RotuloTexto.Text = Conteudo
            RotuloTexto.Parent = Etiqueta

            ListaEtiquetas[Jogador.UserId] = Etiqueta
            ::PularESP::
        end
    end
end)

-- 🔹 Anti‑AFK funcional
task.spawn(function()
    while task.wait(1.5) do
        if Config.AntiAFK then
            Tentar(function()
                local P = LocalPlayer.Character
                if P and P:FindFirstChild("Humanoid") then
                    P.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
end)
