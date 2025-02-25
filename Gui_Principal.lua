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
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -larguraGUI / 2, 0.5, -alturaGUI / 2),
        Size = UDim2.new(0, larguraGUI, 0, alturaGUI),
        Name = "ConfiguracoesFrame",
        Visible = false, -- Inicialmente invisível
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
        BorderSizePixel = 0,
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
        Size = UDim2.new(0, 20, 0, 20),
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

    -- GUI de Carregamento
    local carregamentoGui = criarElemento("ScreenGui", {
        Parent = game.Players.LocalPlayer.PlayerGui,
        Name = "CarregamentoGUI",
    })

    local carregamentoFrame = criarElemento("Frame", {
        Parent = carregamentoGui,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
    })

    local carregamentoTexto = criarElemento("TextLabel", {
        Parent = carregamentoFrame,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, -100, 0.4, 0),
        Size = UDim2.new(0, 200, 0, 50),
        Font = Enum.Font.SourceSansBold,
        Text = "Carregando...",
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = true,
    })

    local barraCarregamento = criarElemento("Frame", {
        Parent = carregamentoFrame,
        BackgroundColor3 = Color3.fromRGB(100, 100, 100),
        BorderSizePixel = 1,
        BorderColor3 = Color3.fromRGB(200, 200, 200),
        Position = UDim2.new(0.5, -200, 0.5, -25),
        Size = UDim2.new(0, 400, 0, 20),
    })

    local progressoCarregamento = criarElemento("Frame", {
        Parent = barraCarregamento,
        BackgroundColor3 = Color3.fromRGB(0, 255, 0),
        Size = UDim2.new(0, 0, 1, 0),
    })

    -- Animação de Carregamento
    local tempoTotal = 5 -- Tempo total de carregamento (segundos)
    local tempoDecorrido = 0
    local progresso = 0

    game:GetService("RunService").Heartbeat:Connect(function(delta)
        tempoDecorrido = tempoDecorrido + delta
        progresso = math.min(tempoDecorrido / tempoTotal, 1)
        progressoCarregamento.Size = UDim2.new(progresso, 0, 1, 0)

        if progresso == 1 then
            carregamentoGui:Destroy()
            frame.Visible = true

            -- Animação de Entrada da GUI Principal
            frame.Position = UDim2.new(0.5, -larguraGUI / 2, 1.5, -alturaGUI / 2) -- Posição inicial fora da tela
            local tweenInfoPrincipal = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local tweenPrincipal = game:GetService("TweenService"):Create(frame, tweenInfoPrincipal, {Position = UDim2.new(0.5, -larguraGUI / 2, 0.5, -alturaGUI / 2)}) -- Posição centralizada
            tweenPrincipal:Play()
        end
    end)
end

-- Chamar a função para criar a GUI
criarGUI()
