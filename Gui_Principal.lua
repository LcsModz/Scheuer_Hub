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

    -- Calcular o tamanho e a posição da GUI
    local larguraGUI = telaX * 0.75
    local alturaGUI = telaY * 0.75
    local posX = (telaX - larguraGUI) / 2
    local posY = (telaY - alturaGUI) / 2 -- Centralizando verticalmente

    -- Criar o Frame (Caixa Verde)
    local frame = criarElemento("Frame", {
        Parent = ScreenGuiPrincipal,
        BackgroundColor3 = Color3.fromRGB(200, 200, 200), -- Tons de cinza
        BorderSizePixel = 0,
        Position = UDim2.new(0, posX, 0, posY),
        Size = UDim2.new(0, larguraGUI, 0, alturaGUI),
        Name = "ConfiguracoesFrame",
        BackgroundTransparency = 1, -- Inicialmente transparente para a animação
    })

    -- Animação de fade-in
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(
        1, -- Duração da animação em segundos
        Enum.EasingStyle.Quad, -- Estilo de animação
        Enum.EasingDirection.Out, -- Direção da animação
        0, -- Número de repetições (0 para uma vez)
        false, -- Reverter ao final?
        0 -- Atraso (em segundos)
    )

    local tween = tweenService:Create(frame, tweenInfo, {BackgroundTransparency = 0})
    tween:Play()

    -- Criar o TextButton (Botão Sólido) - em uma ScreenGui separada
    local button = criarElemento("TextButton", {
        Parent = ScreenGuiBotao,
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 50, 0.5, -35), -- Lado esquerdo com 50 pixels de distância
        Text = "",
        Draggable = true,
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })

    -- Criar divisórias visuais (frames)
    local divisorias = {}
    local numDivisorias = 3
    local espacamento = larguraGUI / numDivisorias

    for i = 1, numDivisorias do
        local divisoria = criarElemento("Frame", {
            Parent = frame,
            BackgroundColor3 = Color3.fromRGB(150, 150, 150), -- Tom de cinza mais escuro
            BorderSizePixel = 0,
            Position = UDim2.new(0, espacamento * (i - 1), 0, 0),
            Size = UDim2.new(0, 2, 1, alturaGUI),
            Name = "Divisoria" .. i,
            AnchorPoint = Vector2.new(0, 0)
        })
        table.insert(divisorias, divisoria)
    end

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

-- Chamar a função para criar a GUI
criarGUI()
