-- ==========================================
-- 🎭 SCRIPT: MARIONETEIRO
-- VERSÃO LIMPA, SEM DADOS PESSOAIS
-- PARA BLOX FRUITS — ESTRUTURA PRONTA
-- ==========================================

-- ✅ AVISO DE CARGA
print("🎭 MARIONETEIRO CARREGOU COM SUCESSO!")
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "🎭 MARIONETEIRO",
    Text = "Painel carregado — adicione funções!",
    Duration = 4
})

-- 🔹 SERVIÇOS OBRIGATÓRIOS
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- 🔹 SEGURANÇA BÁSICA
local function Tentar(funcao)
    pcall(funcao)
end

-- 🔹 INTERFACE PRINCIPAL
local Tela = Instance.new("ScreenGui")
Tela.Name = "MarioneteiroMenu"
Tela.Parent = game.CoreGui
Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- BOTÃO FLUTUANTE
local BotaoAbrir = Instance.new("TextButton")
BotaoAbrir.Parent = Tela
BotaoAbrir.BackgroundColor3 = Color3.fromRGB(120, 40, 180)
BotaoAbrir.Position = UDim2.new(0.02,0,0.45,0)
BotaoAbrir.Size = UDim2.new(0, 60, 0, 60)
BotaoAbrir.Font = Enum.Font.GothamBold
BotaoAbrir.Text = "🎭"
BotaoAbrir.TextColor3 = Color3.new(1,1,1)
BotaoAbrir.TextScaled = true
BotaoAbrir.Active = true
BotaoAbrir.Draggable = true

-- PAINEL PRINCIPAL
local Painel = Instance.new("Frame")
Painel.Parent = Tela
Painel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Painel.BorderColor3 = Color3.fromRGB(90, 30, 140)
Painel.Position = UDim2.new(0.1,0,0.15,0)
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
Titulo.TextColor3 = Color3.fromRGB(180, 120, 255)
Titulo.TextScaled = true

-- ÁREA DE FUNÇÕES COM ROLAGEM
local AreaFuncoes = Instance.new("ScrollingFrame")
AreaFuncoes.Parent = Painel
AreaFuncoes.BackgroundTransparency = 1
AreaFuncoes.Position = UDim2.new(0,10,0,55)
AreaFuncoes.Size = UDim2.new(1,-20,1,-65)
AreaFuncoes.ScrollBarThickness = 6
AreaFuncoes.CanvasSize = UDim2.new(0,0,0,0)

local Layout = Instance.new("UIListLayout")
Layout.Parent = AreaFuncoes
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- 🔹 FUNÇÃO PARA CRIAR BOTÕES NOVOS
local function CriarBotao(Nome, Funcao)
    Tentar(function()
        local Botao = Instance.new("TextButton")
        Botao.Parent = AreaFuncoes
        Botao.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        Botao.Size = UDim2.new(0, 260, 0, 38)
        Botao.Font = Enum.Font.Gotham
        Botao.Text = Nome
        Botao.TextColor3 = Color3.new(1,1,1)
        Botao.TextScaled = true
        
        Botao.MouseButton1Click:Connect(Funcao)
        
        task.wait(0.1)
        AreaFuncoes.CanvasSize = UDim2.new(0,0,0, Layout.AbsoluteContentSize.Y + 20)
    end)
end

-- 🔹 ABRIR/FECHAR MENU
BotaoAbrir.MouseButton1Click:Connect(function()
    Painel.Visible = not Painel.Visible
end)

-- ==========================================
-- 📌 COLOQUE SUAS FUNÇÕES ABAIXO AQUI DEPOIS
-- ==========================================
-- EXEMPLO:
-- CriarBotao("🛡️ Anti‑AFK", function()
--     -- SEU CÓDIGO AQUI
-- end)
