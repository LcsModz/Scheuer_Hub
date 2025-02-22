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
        Name = "ConfiguracoesFrame",
        Draggable = true -- Adicionando Draggable aqui
    })

    -- Criar o ImageButton (Botão Sólido)
    local button = criarElemento("TextButton", {
        Parent = frame,
        BackgroundTransparency = 0, -- Tornando o botão sólido
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0.5, 70, 0.5, -35),
        Text = "", -- Removendo o texto
        Draggable = true, -- Adicionando Draggable aqui
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })

    -- Adicionando evento para arrastar a GUI (opcional, mas recomendado)
    local dragging = false
    local startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = frame.Position
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input, gameProcessedEvent)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - input.Position
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

end

-- Chamar a função para criar a GUI
criarGUI()
