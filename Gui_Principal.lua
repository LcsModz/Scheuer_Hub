local ScreenGuiPrincipal = Instance.new("ScreenGui")
ScreenGuiPrincipal.Name = "GUI_Principal"
ScreenGuiPrincipal.Parent = game.Players.LocalPlayer.PlayerGui

local ScreenGuiBotao = Instance.new("ScreenGui")
ScreenGuiBotao.Name = "GUI_Botao"
ScreenGuiBotao.Parent = game.Players.LocalPlayer.PlayerGui

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

    -- Calcular o tamanho e a posição da GUI
    local larguraGUI = telaX * 0.75
    local alturaGUI = telaY * 0.75
    local posX = (telaX - larguraGUI) / 2
    local posY = (telaY - alturaGUI) / 2 -- Centralizando verticalmente

    -- Criar o Frame (Caixa Principal)
    local frame = criarElemento("Frame", {
        Parent = ScreenGuiPrincipal,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30), -- Fundo escuro
        BorderSizePixel = 3,
        Position = UDim2.new(0, posX, 0, posY),
        Size = UDim2.new(0, larguraGUI, 0, alturaGUI),
        Name = "ConfiguracoesFrame",
    })

    -- Adicionar borda arredondada ao Frame principal
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame

    -- Criar o Frame (Menu Lateral)
    local menuLateralLargura = larguraGUI * 0.2 -- 20% da largura da GUI
    local menuLateral = criarElemento("Frame", {
        Parent = frame,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50), -- Tom de cinza mais escuro
        BorderSizePixel = 3,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, menuLateralLargura, 1, 0),
        Name = "MenuLateral",
    })

    -- Adicionar borda arredondada ao Menu Lateral
    local menuLateralCorner = Instance.new("UICorner")
    menuLateralCorner.CornerRadius = UDim.new(0, 10)
    menuLateralCorner.Parent = menuLateral

    -- Criar o TextButton (Botão Sólido)
    local button = criarElemento("TextButton", {
        Parent = ScreenGuiBotao,
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, frame.Position.X.Offset - 25, 0.5, -10), -- Posicionado à esquerda da GUI principal
        Text = "",
        Draggable = true,
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })

    local function arrastarElemento(elemento)
        local dragging = false
        local startPos
        local mouseOffset
        local mouse = game.Players.LocalPlayer:GetMouse()

        elemento.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                startPos = elemento.Position
                mouseOffset = Vector2.new(mouse.X - elemento.AbsolutePosition.X, mouse.Y - elemento.AbsolutePosition.Y)
            end
        end)

        elemento.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input, gameProcessedEvent)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                elemento.Position = UDim2.new(0, mouse.X - mouseOffset.X, 0, mouse.Y - mouseOffset.Y)
            end
        end)
    end

    arrastarElemento(frame)
    arrastarElemento(button)
end

-- Chamar a função para criar a GUI
criarGUI()
