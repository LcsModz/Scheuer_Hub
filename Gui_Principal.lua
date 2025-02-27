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
        BackgroundTransparency = 1, -- Inicialmente transparente
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
        BackgroundTransparency = 1, -- Inicialmente transparente
    })

    -- Adicionar borda arredondada ao Menu Lateral
    local menuLateralCorner = Instance.new("UICorner")
    menuLateralCorner.CornerRadius = UDim.new(0, 10)
    menuLateralCorner.Parent = menuLateral

    -- Criar o TextButton (Botão Sólido)
    local button = criarElemento("TextButton", {
        Parent = ScreenGuiBotao,
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 30, 0, 30), -- Aumenta o tamanho do botão
        Position = UDim2.new(0, frame.Position.X.Offset - 35, 0.5, -15), -- Ajusta a posição do botão
        Text = "",
        Draggable = true,
        Name = "BotaoImagem",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    })

    -- Adicionar bordas arredondadas ao botão
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 15)
    buttonCorner.Parent = button

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
        BackgroundColor3 = Color3.fromRGB(100, 100, 100), -- Fundo cinza
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0), -- Ocupa toda a tela
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
    local tempoTotal = 8 -- Tempo total de carregamento (segundos)
    local tempoDecorrido = 0
    local progresso = 0

    game:GetService("RunService").Heartbeat:Connect(function(delta)
        tempoDecorrido = tempoDecorrido + delta
        progresso = math.min(tempoDecorrido / tempoTotal, 1)
        progressoCarregamento.Size = UDim2.new(progresso, 0, 1, 0)

        if progresso == 1 then
            carregamentoGui:Destroy()
            frame.Visible = true

            -- Animação de Transparência da GUI Principal e Lateral
            local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local tweenFrame = game:GetService("TweenService"):Create(frame, tweenInfo, {BackgroundTransparency = 0})
            local tweenMenuLateral = game:GetService("TweenService"):Create(menuLateral, tweenInfo, {BackgroundTransparency = 0})

            tweenFrame:Play()
            tweenMenuLateral:Play()
        end
    end)

    -- Adicionando botões laterais
    local margem = 10
    local alturaBotao = 30
    local espacamento = 5
    local larguraBotao = menuLateralLargura - (margem * 2)

    local botoesLaterais = {}
    local nomesBotoes = {"Farm", "Server Hop", "Teleport", "Raid", "Players", "Fruit"}

    -- Adicionar texto inicial no retângulo amarelo
    local textoInicial1 = criarElemento("TextLabel", {
        Parent = frame,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.6, -150, 0.4, -25), -- Ajustado para o retângulo amarelo, movido para a direita
        Size = UDim2.new(0, 300, 0, 50),
        Font = Enum.Font.SourceSansBold,
        Text = "Desenvolvido unica e exclusivamente por: LcsDevs",
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Center,
    })

    local textoInicial2 = criarElemento("TextLabel", {
        Parent = frame,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.6, -150, 0.4, 25), -- Ajustado para o retângulo amarelo, movido para a direita
        Size = UDim2.new(0, 300, 0, 50),
        Font = Enum.Font.SourceSansBold,
        Text = "Bem Vindos Scheuer Hub",
        TextColor3 = Color3.new(1, 0, 0), -- Vermelho
        TextStrokeColor3 = Color3.new(0, 0, 0), -- Borda preta
        TextStrokeTransparency = 0,
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Center,
    })

    local abaAberta = nil -- Variável para rastrear a aba aberta

    for i, nomeBotao in ipairs(nomesBotoes) do
        local botaoLateral = criarElemento("TextButton", {
            Parent = menuLateral,
            BackgroundColor3 = Color3.fromRGB(135, 206, 250), -- Azul claro
            Size = UDim2.new(0, larguraBotao, 0, alturaBotao),
            Position = UDim2.new(0, margem, 0, margem + ((alturaBotao + espacamento) * (i - 1))),
            Text = nomeBotao,
            TextColor3 = Color3.new(1, 1, 1), -- Branco
            TextScaled = true,
            BorderSizePixel = 2,
            BorderColor3 = Color3.fromRGB(255, 0, 0), -- Vermelho
        })

        local botaoCorner = Instance.new("UICorner")
        botaoCorner.CornerRadius = UDim.new(0, 10)
        botaoCorner.Parent = botaoLateral

        table.insert(botoesLaterais, botaoLateral)

        -- Adicionar funcionalidade aos botões laterais
        botaoLateral.MouseButton1Click:Connect(function()
            if abaAberta then
                abaAberta:Destroy() -- Fecha a aba aberta anteriormente
            end

            -- Criar nova GUI dentro do retângulo verde com margem de 10 pixels
            local novaFrame = criarElemento("Frame", {
                Parent = frame,
                BackgroundColor3 = Color3.fromRGB(80, 80, 80), -- Cor de fundo diferente
                BorderSizePixel = 0,
                Position = UDim2.new(0.22, 10, 0.03, 10), -- Ajustado para o retângulo verde com margem
                Size = UDim2.new(0.77, -20, 0.95, -20), -- Ajustado para o retângulo verde com margem
            })

            local novaFrameCorner = Instance.new("UICorner")
            novaFrameCorner.CornerRadius = UDim.new(0, 10)
            novaFrameCorner.Parent = novaFrame

            -- Adicionar um botão de fechar
            local botaoFechar = criarElemento("TextButton", {
                Parent = novaFrame,
                BackgroundColor3 = Color3.fromRGB(200, 0, 0), -- Vermelho
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(1, -35, 0, 5),
                Text = "X",
                TextColor3 = Color3.new(1, 1, 1),
                Font = Enum.Font.SourceSansBold,
                BorderSizePixel = 0,
            })

            local botaoFecharCorner = Instance.new("UICorner")
            botaoFecharCorner.CornerRadius = UDim.new(0, 15)
            botaoFecharCorner.Parent = botaoFechar

            botaoFechar.MouseButton1Click:Connect(function()
                novaFrame:Destroy()
                abaAberta = nil -- Limpa a variável de aba aberta
            end)

            -- Remover o texto de fundo
            -- local conteudo = criarElemento("TextLabel", {
            --     Parent = novaFrame,
            --     BackgroundColor3 = Color3.new(0, 0, 0),
            --     BackgroundTransparency = 1,
            --     Size = UDim2.new(1, 0, 1, 0),
            --     Font = Enum.Font.SourceSansBold,
            --     Text = "Conteúdo do botão " .. nomeBotao,
            --     TextColor3 = Color3.new(1, 1, 1),
            --     TextScaled = true,
            --     TextXAlignment = Enum.TextXAlignment.Center,
            --     TextYAlignment = Enum.TextYAlignment.Center,
            -- })

            abaAberta = novaFrame -- Define a aba aberta

            -- Adicionar botões de teleporte para Sea 1, 2 e 3
            if nomeBotao == "Teleport" then
                local botaoSea1 = criarElemento("TextButton", {
                    Parent = novaFrame,
                    BackgroundColor3 = Color3.fromRGB(135, 206, 250),
                    Size = UDim2.new(0, 150, 0, 30),
                    Position = UDim2.new(0, (novaFrame.AbsoluteSize.X - 150) / 2, 0, 50), -- Centralizado horizontalmente
                    Text = "Ir para o Mar 1",
                    TextColor3 = Color3.new(1, 1, 1),
                    TextScaled = true,
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(255, 0, 0),
                })

                local botaoSea2 = criarElemento("TextButton", {
                    Parent = novaFrame,
                    BackgroundColor3 = Color3.fromRGB(135, 206, 250),
                    Size = UDim2.new(0, 150, 0, 30),
                    Position = UDim2.new(0, (novaFrame.AbsoluteSize.X - 150) / 2, 0, 90), -- Centralizado horizontalmente
                    Text = "Ir para o Mar 2",
                    TextColor3 = Color3.new(1, 1, 1),
                    TextScaled = true,
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(255, 0, 0),
                })

                local botaoSea3 = criarElemento("TextButton", {
                    Parent = novaFrame,
                    BackgroundColor3 = Color3.fromRGB(135, 206, 250),
                    Size = UDim2.new(0, 150, 0, 30),
                    Position = UDim2.new(0, (novaFrame.AbsoluteSize.X - 150) / 2, 0, 130), -- Centralizado horizontalmente
                    Text = "Ir para o Mar 3",
                    TextColor3 = Color3.new(1, 1, 1),
                    TextScaled = true,
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(255, 0, 0),
                })

                -- Adicionar menu de seleção de ilhas
                local botaoTeleportar = criarElemento("TextButton", {
                    Parent = novaFrame,
                    BackgroundColor3 = Color3.fromRGB(135, 206, 250),
                    Size = UDim2.new(0, 150, 0, 30),
                    Position = UDim2.new(0, (novaFrame.AbsoluteSize.X - 320) / 2, 0, 170), -- Ajustado para centralizar
                    Text = "Teleportar para:",
                    TextColor3 = Color3.new(1, 1, 1),
                    TextScaled = true,
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(255, 0, 0),
                })

                local botaoSelecionarIlha = criarElemento("TextButton", {
                    Parent = novaFrame,
                    BackgroundColor3 = Color3.fromRGB(135, 206, 250),
                    Size = UDim2.new(0, 150, 0, 30),
                    Position = UDim2.new(0, (novaFrame.AbsoluteSize.X + 20) / 2, 0, 170), -- Ajustado para centralizar e ficar ao lado do botão Teleportar
                    Text = "...",
                    TextColor3 = Color3.new(1, 1, 1),
                    TextScaled = true,
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(255, 0, 0),
                })

                local menuIlhas = criarElemento("Frame", {
                    Parent = novaFrame,
                    BackgroundColor3 = Color3.fromRGB(80, 80, 80),
                    BorderSizePixel = 1,
                    BorderColor3 = Color3.fromRGB(200, 200, 200),
                    Position = UDim2.new(0, (novaFrame.AbsoluteSize.X - 150) / 2, 0, 210), -- Centralizado horizontalmente
                    Size = UDim2.new(0, 150, 0, 0), -- Altura inicial 0
                    Visible = false,
                })

                local ilhas = {"Café", "Mansão", "Green Zone"}
                local botoesIlhas = {}
                local ilhaSelecionada = nil

                for i, ilha in ipairs(ilhas) do
                    local botaoIlha = criarElemento("TextButton", {
                        Parent = menuIlhas,
                        BackgroundColor3 = Color3.fromRGB(135, 206, 250),
                        Size = UDim2.new(1, 0, 0, 30),
                        Position = UDim2.new(0, 0, 0, (i - 1) * 30),
                        Text = ilha,
                        TextColor3 = Color3.new(1, 1, 1),
                        TextScaled = true,
                        BorderSizePixel = 1,
                        BorderColor3 = Color3.fromRGB(255, 0, 0),
                    })

                    botaoIlha.MouseButton1Click:Connect(function()
                        ilhaSelecionada = ilha
                        botaoSelecionarIlha.Text = ilha
                        menuIlhas.Visible = false
                        menuIlhas.Size = UDim2.new(0, 150, 0, 0)
                    end)

                    table.insert(botoesIlhas, botaoIlha)
                end

                botaoSelecionarIlha.MouseButton1Click:Connect(function()
                    menuIlhas.Visible = not menuIlhas.Visible
                    if menuIlhas.Visible then
                        menuIlhas.Size = UDim2.new(0, 150, 0, #ilhas * 30)
                    else
                        menuIlhas.Size = UDim2.new(0, 150, 0, 0)
                    end
                end)

                botaoTeleportar.MouseButton1Click:Connect(function()
                    if ilhaSelecionada then
                        if ilhaSelecionada == "Café" then
                            local player = game.Players.LocalPlayer
                            local character = player.Character
                            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

                            if character and humanoidRootPart then
                                local targetPosition = Vector3.new(-382.072509765625, 73.06132507324219, 356.9813537597656)
                                local alturaFixa = 250
                                local speed = 200

                                -- Guarda o estado de colisão original das partes do personagem
                                local originalCollisionStates = {}
                                for _, part in ipairs(character:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        originalCollisionStates[part] = part.CanCollide
                                        part.CanCollide = false
                                    end
                                end

                                -- Teleporta para a altura fixa
                                humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position.X, alturaFixa, humanoidRootPart.Position.Z)
                                humanoidRootPart.Velocity = Vector3.new(0, 0, 0) -- zera a velocidade para prevenir queda

                                local direction = (Vector3.new(targetPosition.X, alturaFixa, targetPosition.Z) - humanoidRootPart.Position).Unit
                                local distance = (Vector3.new(targetPosition.X, alturaFixa, targetPosition.Z) - humanoidRootPart.Position).Magnitude

                                local connection
                                connection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
                                    if distance > 0 then
                                        local moveDistance = math.min(speed * deltaTime, distance)
                                        humanoidRootPart.CFrame = humanoidRootPart.CFrame + direction * moveDistance
                                        distance = distance - moveDistance
                                        humanoidRootPart.Velocity = Vector3.new(0, 0, 0) -- mantém a velocidade zerada
                                    else
                                        connection:Disconnect()

                                        -- Teleporte instantâneo para a posição final
                                        humanoidRootPart.CFrame = CFrame.new(targetPosition)

                                        -- Restaura o estado de colisão original das partes do personagem
                                        for part, canCollide in pairs(originalCollisionStates) do
                                            if part and part.Parent == character then
                                                part.CanCollide = canCollide
                                            end
                                        end
                                    end
                                end)
                            end
                        elseif ilhaSelecionada == "Mansão" then
                            -- Adicione aqui o código para teleporte para a Mansão
                            print("Teleportando para a Mansão")
                        elseif ilhaSelecionada == "Green Zone" then
                            -- Adicione aqui o código para teleporte para a Green Zone
                            print("Teleportando para a Green Zone")
                        end
                    end
                end)

                -- Adicionar funcionalidade aos botões de teleporte para Sea 1, 2 e 3
                botaoSea1.MouseButton1Click:Connect(function()
                    -- Adicione aqui o código para teleporte para o Sea 1
                    print("Teleportando para o Sea 1")
                end)

                botaoSea2.MouseButton1Click:Connect(function()
                    -- Adicione aqui o código para teleporte para o Sea 2
                    print("Teleportando para o Sea 2")
                end)

                botaoSea3.MouseButton1Click:Connect(function()
                    -- Adicione aqui o código para teleporte para o Sea 3
                    print("Teleportando para o Sea 3")
                end)
            end
        end)
    end
end

-- Chamar a função para criar a GUI
criarGUI()
