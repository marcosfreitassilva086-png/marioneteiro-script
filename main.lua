-- ==========================================
-- 🎯 FUNÇÕES ADICIONADAS — MARIONETEIRO
-- ==========================================

-- 🔹 VARIÁVEIS DE CONFIGURAÇÃO
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

-- 🔹 FUNÇÃO: PEGAR ALVO PARA AIMBOT
local function PegarAlvo()
    local MelhorAlvo, MenorDist = nil, Config.FOV
    for _, Jogador in next, Players:GetPlayers() do
        if Jogador == LocalPlayer then continue end
        if Config.IgnorarAliados and Jogador.Team == LocalPlayer.Team then continue end
        local Personagem = Jogador.Character
        if not Personagem or not Personagem:FindFirstChild("HumanoidRootPart") or Personagem.Humanoid.Health <= 0 then continue end
        
        local PosicaoTela, Visivel = Camera:WorldToViewportPoint(Personagem.HumanoidRootPart.Position)
        if Visivel then
            local Distancia = (Vector2.new(PosicaoTela.X, PosicaoTela.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            if Distancia < MenorDist then
                MenorDist = Distancia
                MelhorAlvo = Personagem.HumanoidRootPart
            end
        end
    end
    return MelhorAlvo
end

-- 🔹 LOOP DO AIMBOT + FOV
CriarBotao("🎯 AIMBOT (LIGA/DESLIGA)", function()
    Config.AimbotLigado = not Config.AimbotLigado
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "🎭 MARIONETEIRO",
        Text = "Aimbot: "..(Config.AimbotLigado and "LIGADO" or "DESLIGADO"),
        Duration = 2
    })
end)

CriarBotao("🔼 AUMENTAR FOV", function()
    Config.FOV = math.min(Config.FOV + 10, 300)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 FOV", Text="Valor: "..Config.FOV, Duration=1.5})
end)

CriarBotao("🔽 DIMINUIR FOV", function()
    Config.FOV = math.max(Config.FOV - 10, 30)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 FOV", Text="Valor: "..Config.FOV, Duration=1.5})
end)

-- 🔹 LOOP PRINCIPAL DO AIMBOT E FOV
task.spawn(function()
    local CirculoFOV = Drawing.new("Circle")
    CirculoFOV.Radius = Config.FOV
    CirculoFOV.Thickness = 2
    CirculoFOV.Color = Color3.fromRGB(186, 85, 211)
    CirculoFOV.Filled = false
    CirculoFOV.Visible = true

    RunService.RenderStepped:Connect(function()
        CirculoFOV.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        CirculoFOV.Radius = Config.FOV

        if Config.AimbotLigado then
            local Alvo = PegarAlvo()
            if Alvo then
                local Direcao = (Alvo.Position - Camera.CFrame.Position).Unit
                local NovoCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Direcao)
                Camera.CFrame = Camera.CFrame:Lerp(NovoCFrame, Config.Suavidade)
            end
        end
    end)
end)

-- 🔹 FUNÇÕES DE VELOCIDADE E SALTO
CriarBotao("⚡ AUMENTAR VELOCIDADE", function()
    Config.Velocidade = math.min(Config.Velocidade + 2, Config.VelocidadeMax)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.WalkSpeed = Config.Velocidade end
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 VELOCIDADE", Text="Valor: "..Config.Velocidade, Duration=1.5})
end)

CriarBotao("🐢 DIMINUIR VELOCIDADE", function()
    Config.Velocidade = math.max(Config.Velocidade - 2, VelocidadeOriginal)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.WalkSpeed = Config.Velocidade end
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 VELOCIDADE", Text="Valor: "..Config.Velocidade, Duration=1.5})
end)

CriarBotao("🦘 AUMENTAR SALTO", function()
    Config.Salto = math.min(Config.Salto + 5, Config.SaltoMax)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.JumpPower = Config.Salto end
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 SALTO", Text="Valor: "..Config.Salto, Duration=1.5})
end)

CriarBotao("⬇️ DIMINUIR SALTO", function()
    Config.Salto = math.max(Config.Salto - 5, SaltoOriginal)
    local P = LocalPlayer.Character
    if P and P:FindFirstChild("Humanoid") then P.Humanoid.JumpPower = Config.Salto end
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="🎭 SALTO", Text="Valor: "..Config.Salto, Duration=1.5})
end)

-- 🔹 FUNÇÃO ESP
local ListaEtiquetas = {}
CriarBotao("👁️ ESP (LIGA/DESLIGA)", function()
    Config.ESPLigado = not Config.ESPLigado
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "🎭 MARIONETEIRO",
        Text = "ESP: "..(Config.ESPLigado and "LIGADO" or "DESLIGADO"),
        Duration = 2
    })
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
            Etiqueta.Parent = Config.ESPLigado and GuiPrincipal or nil

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
