-- 🛠️ SPOCK HUB - FRUIT FARM ULTIMATE V6
-- By Spock

-- 🔧 Serviços e Variáveis
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleportService = game:GetService("TeleportService")
local virtualUser = game:GetService("VirtualUser")
local userInputService = game:GetService("UserInputService")
local httpService = game:GetService("HttpService")

-- 🔍 Função para carregar configuração do arquivo TXT
local function loadConfig()
    local configFile = "spockhub_config.txt"
    local configData = {
        autoRandomFruit = true,
        autoFindFruit = true,
        autoChestFarm = true,
        teamChoice = "Pirates",
        scanInterval = 5
    }

    if isfile(configFile) then
        for line in readfile(configFile):gmatch("[^\r\n]+") do
            local key, value = line:match("([^=]+)=([^=]+)")
            if key and value then
                configData[key] = (value == "true" and true) or (value == "false" and false) or tonumber(value) or value
            end
        end
    else
        writefile(configFile, httpService:JSONEncode(configData))
        print("🔧 Arquivo de configuração criado!")
    end

    return configData
end

local config = loadConfig()

-- 🎯 Criando Interface
local ui = Instance.new("ScreenGui", player.PlayerGui)
ui.Name = "SPOCK_HUB_UI"

local mainFrame = Instance.new("Frame", ui)
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderColor3 = Color3.fromRGB(170, 0, 255)
mainFrame.Visible = true

local title = Instance.new("TextLabel", mainFrame)
title.Text = "🔥 SPOCK HUB - FRUIT FARM ULTIMATE 🔥"
title.Size = UDim2.new(0, 400, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true

-- 🌟 Botão de abrir/fechar com imagem e efeito neon
local toggleButton = Instance.new("ImageButton", ui)
toggleButton.Size = UDim2.new(0, 80, 0, 80)
toggleButton.Position = UDim2.new(0, 10, 0.5, -40)
toggleButton.Image = "https://media.discordapp.net/attachments/1350186554496258098/1350189912732733582/1_122851d5-90ff-4543-897e-a75660f9bd3b.jpg"
toggleButton.BackgroundTransparency = 1

toggleButton.MouseEnter:Connect(function()
    toggleButton.ImageColor3 = Color3.fromRGB(170, 0, 255)
    toggleButton.Size = UDim2.new(0, 90, 0, 90)
end)

toggleButton.MouseLeave:Connect(function()
    toggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Size = UDim2.new(0, 80, 0, 80)
end)

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- 🔥 Funções de Auto Farm
local function autoRandomFruit()
    while config.autoRandomFruit do
        replicatedStorage.Remotes.Redeem:InvokeServer("Cousin")
        wait(5)
    end
end

local function autoFindFruit()
    while config.autoFindFruit do
        for _, fruit in pairs(workspace:GetChildren()) do
            if fruit:IsA("Tool") then
                player.Character.HumanoidRootPart.CFrame = fruit.Handle.CFrame
                wait(1)
                break
            end
        end
        wait(config.scanInterval)
    end
end

local function autoChestFarm()
    while config.autoChestFarm do
        for _, chest in pairs(workspace:GetChildren()) do
            if chest.Name:find("Chest") then
                player.Character.HumanoidRootPart.CFrame = chest.Position
                wait(1)
                break
            end
        end
        wait(config.scanInterval)
    end
end

-- 🏴‍☠️ Auto Join Pirate ou Marine
if config.teamChoice == "Pirates" then
    replicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
elseif config.teamChoice == "Marines" then
    replicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end

-- 🔄 Auto Rejoin
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    wait(2)
    teleportService:Teleport(game.PlaceId, player)
end)

-- 💤 Anti AFK
player.Idled:Connect(function()
    virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    print("💤 Anti AFK ativado")
end)

-- 🚀 Rodando funções
spawn(function()
    while true do
        if config.autoRandomFruit then autoRandomFruit() end
        if config.autoFindFruit then autoFindFruit() end
        if config.autoChestFarm then autoChestFarm() end
        wait(1)
    end
end)

print("✅ SPOCK HUB V6 carregado com tudo integrado e otimizado!")
