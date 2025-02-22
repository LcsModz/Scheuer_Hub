local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

local function criarElemento(tipo, propriedades)
    local elemento = Instance.new(tipo)
    for nome, valor in pairs(propriedades) do
        elemento[nome] = valor
    end
    return elemento
end

local function criarGUI()
    -- Obter o tamanho da tela do jogador
    local telaX = game.Players.LocalPlayer.PlayerGui.ScreenGui.AbsoluteSize.X
    local telaY = game.Players.LocalPlayer.PlayerGui.ScreenGui.AbsoluteSize.Y

    -- Calcular o tamanho e a posição da GUI
    local larguraGUI = telaX * 0.75
    local alturaGUI = telaY * 0.75
    local posX = (telaX - larguraGUI) / 2
    local posY = 180

    -- Criar o Frame (Caixa Verde)
    local frame = criarElemento("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = Color3.fromRGB(0, 255, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, posX, 0, posY),
        Size = UDim2.new(0, larguraGUI, 0, alturaGUI),
        Name = "ConfiguracoesFrame"
    })

    -- Criar o ImageButton (Botão Vermelho)
    local imageButton = criarElemento("ImageButton", {
        Parent = frame, -- Mudança: agora o botão é filho do frame
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0.5, 70, 0.5, -35),
        Image = "SEU_LINK_DA_IMAGEM_AQUI", -- Substitua pelo link da sua imagem
        Draggable = true,
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })
end

-- Chamar a função para criar a GUI
criarGUI()
