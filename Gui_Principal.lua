local ScreenGuiPrincipal = Instance.new("ScreenGui")
ScreenGuiPrincipal.Name = "GUI_Principal"
ScreenGuiPrincipal.Parent = game.Players.LocalPlayer.PlayerGui
ScreenGuiPrincipal.Enabled = false

local ScreenGuiBotao = Instance.new("ScreenGui")
ScreenGuiBotao.Name = "GUI_Botao"
ScreenGuiBotao.Parent = game.Players.LocalPlayer.PlayerGui

local TweenService = game:GetService("TweenService")

local criarElemento

-- Função para criar elementos da GUI
criarElemento = function(tipo, propriedades)
    local elemento = Instance.new(tipo)
    if not elemento then
        warn("Erro ao criar elemento")
        return nil
    end
    if propriedades then
        for nome, valor in pairs(propriedades) do
            elemento[nome] = valor
        end
    end
    return elemento
end

local criarGUI

-- Função principal para criar a GUI
criarGUI = function()
    -- Obter o tamanho da tela do jogador
    local player = game.Players.LocalPlayer
    if not player then
        warn("Player não encontrado")
        return
    end
    local playerGui = player.PlayerGui
    if not playerGui then
        warn("PlayerGui não encontrado")
        return
    end

    local telaX = playerGui.ScreenGui.AbsoluteSize.X
    local telaY = playerGui.ScreenGui.AbsoluteSize.Y

    -- Calcular o tamanho e a posição da GUI
    local larguraGUI = telaX * 0.75
    local alturaGUI = telaY * 0.75
    local posX = (telaX - larguraGUI) / 2
    local posY = (telaY - alturaGUI) / 2

    -- Criar a GUI de Carregamento
    local loadingGui = criarElemento("ScreenGui", {
        Name = "LoadingGui",
        Parent = playerGui,
    })
    if not loadingGui then return end

    local loadingFrame = criarElemento("Frame", {
        Parent = loadingGui,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, 0, 0.3, 0),
        Position = UDim2.new(0.25, 0, 0.35, 0),
    })
    if not loadingFrame then return end

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
    if not loadingText then return end

    local progressBarBackground = criarElemento("Frame", {
        Parent = loadingFrame,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Size = UDim2.new(0.9, 0, 0.3, 0),
        Position = UDim2.new(0.05, 0, 0.5, 0),
    })
    if not progressBarBackground then return end

    local progressBar = criarElemento("Frame", {
        Parent = progressBarBackground,
        BackgroundColor3 = Color3.fromRGB(0, 200, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
    })
	if not progressBar then return end

    -- Criar o Frame (Caixa Principal)
    local frame = criarElemento("Frame", {
        Parent = ScreenGuiPrincipal,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0, posX, 0, posY),
        Size = UDim2.new(0, larguraGUI, 0, alturaGUI),
        Name = "ConfiguracoesFrame",
    })
	if not frame then return end

    -- Criar o Frame (Menu Lateral)
    local menuLateralLargura = larguraGUI * 0.2
    local menuLateral = criarElemento("Frame", {
        Parent = frame,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, menuLateralLargura, 1, 0),
        Name = "MenuLateral",
    })
	if not menuLateral then return end

    -- Criar o ScrollingFrame
    local scrollingFrame = criarElemento("ScrollingFrame", {
        Parent = menuLateral,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 2, 0),
        ScrollBarThickness = 12,
        Name = "ScrollingFrameMenu",
    })
	if not scrollingFrame then return end

    -- Opções do Menu Lateral
    local opcoes = {
        {nome = "Créditos"},
        {nome = "Main"},
        {nome = "Farm"},
        {nome = "V4"},
        {nome = "Raid"},
        {nome = "Teleport"},
        {nome = "Config"},
        {nome = "Server Hop"}
    }

    local alturaOpcao = 1 / #opcoes
    local espacamento = 0.02
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
            TextXAlignment = Enum.TextXAlignment.Left,
        })
		if not botao then return end
    end

    -- Criar o TextButton (Botão Sólido)
    local button = criarElemento("TextButton", {
        Parent = ScreenGuiBotao,
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, frame.Position.X.Offset - 25, 0.5, -10),
        Text = "",
        Draggable = true,
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })
	if not button then return end

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

	-- Animação de carregamento e transição
	local function iniciarCarregamento()
		local duracaoTotalCarregamento = 3 -- Tempo total de carregamento em segundos

		-- Função para atualizar a barra de progresso
		local function atualizarBarraDeProgresso(progresso)
			progressBar:TweenSize(
				UDim2.new(progresso, 0, 1, 0),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quad,
				duracaoTotalCarregamento / 100 * 1,
				true
			)
		end

		-- Loop para simular o carregamento
		for i = 1, 100 do
			wait(duracaoTotalCarregamento / 100)
			atualizarBarraDeProgresso(i / 100)
		end

		-- Animação de esmaecimento da tela de carregamento
		TweenService:Create(loadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
		TweenService:Create(loadingText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()

		wait(0.5)

		-- Desabilitar a tela de carregamento
		loadingGui.Enabled = false

		-- Animação de esmaecimento da GUI principal
		ScreenGuiPrincipal.Enabled = true
		TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0}):Play()
	end

	iniciarCarregamento()
end

criarGUI()
