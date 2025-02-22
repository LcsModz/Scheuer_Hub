local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

local function criarElemento(tipo, propriedades)
    local elemento = Instance.new(tipo)
    for nome, valor in pairs(propriedades) do
        elemento[nome] = valor
    end
    return elemento
end

-- Função para criar a GUI iterativamente
local function criarGUI()
    -- Criar o Frame (Caixa Verde)
    local frame = criarElemento("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = Color3.fromRGB(0, 255, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -50, 0.5, -35),
        Size = UDim2.new(0, 100, 0, 70),
        CornerRadius = UDim.new(0, 10),
        Name = "ConfiguracoesFrame"
    })

    -- Criar o ImageButton (Botão Vermelho)
    local imageButton = criarElemento("ImageButton", {
        Parent = ScreenGui,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0.5, 70, 0.5, -35),
        Image = "SEU_LINK_DA_IMAGEM_AQUI", -- Substitua pelo link da sua imagem
        Draggable = true,
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })

    -- Adicionar eventos (opcional)
    -- ...
end

-- Chamar a função para criar a GUI
criarGUI()

