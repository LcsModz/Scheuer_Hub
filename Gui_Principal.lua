local ScreenGuiPrincipal = Instance.new("ScreenGui")
ScreenGuiPrincipal.Name = "GUI_Principal"
ScreenGuiPrincipal.Parent = game.Players.LocalPlayer.PlayerGui
ScreenGuiPrincipal.Enabled = false -- Desabilitar inicialmente

local ScreenGuiBotao = Instance.new("ScreenGui")
ScreenGuiBotao.Name = "GUI_Botao"
ScreenGuiBotao.Parent = game.Players.LocalPlayer.PlayerGui

local TweenService = game:GetService("TweenService")

local function criarElemento(tipo, propriedades)
    local elemento = Instance.new(tipo)
    if propriedades then
        for nome, valor in pairs(propriedades) do
            elemento[nome] = valor
        end
    end
    return elemento
end

local function criarGUI()
    -- Obter o tamanho da tela do jogador
    local player = game.Players.LocalPlayer
    if not player or not player.PlayerGui then
        warn("Player or PlayerGui not found")
        return
    end

    local telaX = player.PlayerGui.ScreenGui.AbsoluteSize.X
    local telaY = player.PlayerGui.ScreenGui.AbsoluteSize.Y

    -- Calcular o tamanho e a posição da GUI
    local larguraGUI = telaX * 0.75
    local alturaGUI = telaY * 0.75
    local posX = (telaX - larguraGUI) / 2
    local posY = (telaY - alturaGUI) / 2 -- Centralizando verticalmente

    -- Criar a GUI de Carregamento
    local loadingGui = criarElemento("ScreenGui", {
        Name = "LoadingGui",
        Parent = player.PlayerGui,
    })

    local loadingFrame = criarElemento("Frame", {
        Parent = loadingGui,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, 0, 0.3, 0),
        Position = UDim2.new(0.25, 0, 0.35, 0),
    })

    local loadingText = criarElemento("TextLabel", {
        Parent = loadingFrame,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0.3, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20,
        Text = "Carregando...",
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Center,
    })

    local progressBarBackground = criarElemento("Frame", {
        Parent = loadingFrame,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Size = UDim2.new(0.9, 0, 0.3, 0),
        Position = UDim2.new(0.05, 0, 0.5, 0),
    })

    local progressBar = criarElemento("Frame", {
        Parent = progressBarBackground,
        BackgroundColor3 = Color3.fromRGB(0, 200, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
    })

    -- Criar o Frame (Caixa Principal)
    local frame = criarElemento("Frame", {
        Parent = ScreenGuiPrincipal,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30), -- Fundo escuro
        BorderSizePixel = 0,
        Position = UDim2.new(0, posX, 0, posY),
        Size = UDim2.new(0, larguraGUI, 0, alturaGUI),
        Name = "ConfiguracoesFrame",
        --Transparency = 1, -- Inicialmente transparente
    })

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

    -- Criar o ScrollingFrame (Tela de Rolagem)
    local scrollingFrame = criarElemento("ScrollingFrame", {
        Parent = menuLateral,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50), -- Tom de cinza mais escuro
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
	CanvasSize = UDim2.new(0, 0, 2, 0), -- Ajustar a altura conforme necessário
        ScrollBarThickness = 12,
        Name = "ScrollingFrameMenu",
    })

    -- Opções do Menu Lateral
    local opcoes = {
        {nome = "Créditos", icone = "rbxassetid://0"}, -- Substituir "rbxassetid://0" pelo ID do ícone
        {nome = "Main", icone = "rbxassetid://0"},
        {nome = "Farm", icone = "rbxassetid://0"},
        {nome = "V4", icone = "rbxassetid://0"},
        {nome = "Raid", icone = "rbxassetid://0"},
        {nome = "Teleport", icone = "rbxassetid://0"},
        {nome = "Config", icone = "rbxassetid://0"},
        {nome = "Server Hop", icone = "rbxassetid://0"}
    }

    local alturaOpcao = 1 / #opcoes
    local espacamento = 0.02 -- Espaçamento entre os botões
    for i, opcao in ipairs(opcoes) do
        local botao = criarElemento("TextButton", {
            Parent = scrollingFrame,
            BackgroundColor3 = Color3.fromRGB(70, 70, 70),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, alturaOpcao * (i - 1) + espacamento * (i - 1), 0),
            Size = UDim2.new(1, 0, alturaOpcao - espacamento, 0),
            Font = Enum.Font.SourceSansBold,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            Text = opcao.nome,
            Name = "Opcao" .. opcao.nome,
            TextXAlignment = Enum.TextXAlignment.Left, -- Alinhar o texto à esquerda
            --Image = opcao.icone -- Adicionar imagem do ícone (se tiver)
        })
    end

    -- Criar o TextButton (Botão Sólido)
    local button = criarElemento("TextButton", {
        Parent = ScreenGuiBotao,
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, frame.Position.X.Offset - 25, 0.5, -10), -- Posicionado à esquerda da GUI principal
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

    -- Animação de Carregamento
    local function animateLoadingBar()
        local tweenInfo = TweenInfo.new(
            5, -- Duração da animação
            Enum.EasingStyle.Linear, -- Estilo de animação
            Enum.EasingDirection.Out, -- Direção da animação
            0, -- Quantidade de repetições (0 = não repetir)
            false, -- Inverter (não inverter)
            0 -- Atraso (sem atraso)
        )

        local tween = TweenService:Create(progressBar, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})

        tween.Completed:Connect(function()
            -- Esmaecer a GUI principal
            ScreenGuiPrincipal.Enabled = true
            local tweenInfoFadeIn = TweenInfo.new(
                1, -- Duração da animação
                Enum.EasingStyle.Linear, -- Estilo de animação
                Enum.EasingDirection.Out, -- Direção da animação
                0, -- Quantidade de repetições (0 = não repetir)
                false, -- Inverter (não inverter)
		0 -- Atraso (sem atraso)
            )

            local tweenFadeIn = TweenService:Create(frame, tweenInfoFadeIn, {Transparency = 0})

            tweenFadeIn:Play()

            -- Remover a GUI de carregamento
            loadingGui:Destroy()
        end)

        tween:Play()
    end

    animateLoadingBar()
end

-- Chamar a função para criar a GUI
criarGUI()
