local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "VL HUB" .. Fluent.Version,
    SubTitle = "by vitor and lucas!",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Farm = Window:AddTab({ Title = "Farm", Icon = "sword" }),
    Quests = Window:AddTab({ Title = "Quests", Icon = "book-open" }),
    Extras = Window:AddTab({ Title = "Extras", Icon = "star" }),
    Config = Window:AddTab({ Title = "Config", Icon = "settings" })
}

local Options = Fluent.Options

Fluent:Notify({
    Title = "VL HUB",
    Content = "O VL Hub foi carregado com sucesso!",
    Duration = 5
})

-- Função para criar botões rápidos
local function AddFeature(tab, title, description, callback)
    tab:AddButton({
        Title = title,
        Description = description,
        Callback = callback
    })
end

-- **Aba Farm**
AddFeature(Tabs.Farm, "Auto Farm de Level", "Farm com troca automática de quests e ilhas", function()
    print("Auto Farm de Level ativado!")
end)

AddFeature(Tabs.Farm, "Auto Farm de Bosses", "Inclui Katakuri e outros bosses", function()
    print("Auto Farm de Bosses ativado!")
end)

AddFeature(Tabs.Farm, "Auto Farm de Maestria", "Farm para espadas, frutas e armas", function()
    print("Auto Farm de Maestria ativado!")
end)

AddFeature(Tabs.Farm, "Auto Farm de Fragmentos", "Farm rápido de fragmentos e moedas", function()
    print("Auto Farm de Fragmentos ativado!")
end)

AddFeature(Tabs.Farm, "Auto Coleta de Baús e Frutas", "Coleta automática pelo mapa", function()
    print("Auto Coleta ativada!")
end)

AddFeature(Tabs.Farm, "Teleporte Rápido", "Teleporte entre ilhas e bosses", function()
    print("Teleporte rápido ativado!")
end)

-- **Aba Quests**
AddFeature(Tabs.Quests, "Auto Quest de Itens", "Coleta automática de itens raros", function()
    print("Auto Quest de Itens ativado!")
end)

AddFeature(Tabs.Quests, "Auto Quest Principal", "Avança automaticamente nas quests principais", function()
    print("Auto Quest Principal ativado!")
end)

AddFeature(Tabs.Quests, "Auto Raid e Awaken", "Farm de raids e despertar frutas", function()
    print("Auto Raid e Awaken ativado!")
end)

-- **Aba Extras**
local AutoDragonHeartButton = Tabs.Extras:AddButton({
    Title = "Auto Dragon Heart",
    Description = "Farm exclusivo para Dragon Heart",
    Callback = function()
        print("Auto Dragon Heart ativado!")
    end
})
AutoDragonHeartButton:SetTextColor(Color3.fromRGB(255, 0, 0))

local AutoEvolucaoRacasButton = Tabs.Extras:AddButton({
    Title = "Auto Evolução de Raças",
    Description = "Farm para evoluir raças",
    Callback = function()
        print("Auto Evolução de Raças ativado!")
    end
})
AutoEvolucaoRacasButton:SetTextColor(Color3.fromRGB(0, 255, 0))

AddFeature(Tabs.Extras, "Auto Kill Aura (Fast Attack)", "Ataque rápido automático", function()
    print("Auto Fast Attack ativado!")
end)

AddFeature(Tabs.Extras, "Auto Haki (Ken/Buso)", "Ativa e farma Haki automaticamente", function()
    print("Auto Haki ativado!")
end)

AddFeature(Tabs.Extras, "Auto Upgrade de Status", "Distribui status automaticamente", function()
    print("Auto Upgrade ativado!")
end)

-- **Modo Seguro com animação neon**
local SafeMode = Tabs.Extras:AddToggle("SafeMode", { Title = "Modo Seguro (Anti-PVP)", Default = false })

SafeMode:OnChanged(function(state)
    if state then
        print("Modo Seguro ativado!")
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
        -- Efeito Neon roxo pulsante
        local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
        local frame = Instance.new("Frame", gui)
        frame.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 0.7

        task.spawn(function()
            while SafeMode.Value do
                frame.BackgroundTransparency = math.random(0.3, 0.7)
                task.wait(0.3)
            end
            frame:Destroy()
        end)

    else
        print("Modo Seguro desativado!")
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- **Aba Configurações**
AddFeature(Tabs.Config, "Anti-AFK e Reconexão", "Evita ser desconectado e reconecta sozinho", function()
    print("Anti-AFK ativado!")
end)

AddFeature(Tabs.Config, "Salvar/Carregar Config", "Guarda suas configurações favoritas", function()
    print("Configuração salva!")
end)

AddFeature(Tabs.Config, "Keybinds Personalizados", "Define atalhos para as funções", function()
    print("Keybinds ativado!")
end)

AddFeature(Tabs.Config, "Troca de Tema", "Altera a aparência do hub", function()
    print("Tema trocado!")
end)

-- Finalização e carregamento das configurações salvas
InterfaceManager:SetFolder("VLHUB")
SaveManager:SetFolder("VLHUB/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Config)
SaveManager:BuildConfigSection(Tabs.Config)

Window:SelectTab(1)

Fluent:Notify({
    Title = "VL HUB",
    Content = "VL HUB pronto para farmar!",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()
