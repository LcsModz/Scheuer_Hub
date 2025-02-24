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
    local posY = (telaY - alturaGUI) / 2 -- Centralizando verticalmente

    -- Criar o Frame (Caixa Verde)
    local frame = criarElemento("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = Color3.fromRGB(0, 255, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, posX, 0, posY),
        Size = UDim2.new(0, larguraGUI, 0, alturaGUI),
        CornerRadius = UDim.new(0, 10),
        Name = "ConfiguracoesFrame",
    })

    -- Criar o TextButton (Botão Sólido)
    local button = criarElemento("TextButton", {
        Parent = frame,
        BackgroundTransparency = 0, 
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0.5, 70, 0.5, -35),
        Text = "", 
        Draggable = true, 
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })

    local dragging = false
    local startPos
    local mousePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = frame.Position
            mousePos = input.Position
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input, gameProcessedEvent)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
            mousePos = input.Position
        end
    end)

end

-- Chamar a função para criar a GUI
criarGUI()
