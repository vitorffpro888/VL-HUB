--// Note: This is WindUI, not a custom gui library by phantom flux.

local Library = {}
Library.__index = Library
Library.Async = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local UI = Library.Async --// Shortened

local Window = nil

function Library:Setup()
	local version = LRM_ScriptVersion and "v" .. table.concat(LRM_ScriptVersion:split(""), ".") or "Dev Version"
	Window = UI:CreateWindow({
		Title = "Xesteer Hub",
		Icon = "rbxassetid://106551949032970",
		Author = (premium and "Premium" or " Grow a Graden") .. " | " .. version,
		Folder = "XesteerHub",
		Size = UDim2.fromOffset(580, 460),
		Transparent = true,
		Theme = "Dark",
		Resizable = true,
		SideBarWidth = 200,
		Background = "",
		BackgroundImageTransparency = 0.42,
		HideSearchBar = true,
		ScrollBarEnabled = false,
		User = {
			Enabled = true,
			Anonymous = false,
			Callback = function()
				print("clicked")
			end,
		},
	})

	return Window
end

function Library:CreateTab(Name, Icon)
	local Window = Window or self:Setup()

	if not Window then
		error("[Library]: Failed to find Window")
		return
	end

	local Tab = Window:Tab({
		Title = Name,
		Icon = Icon,
		Locked = false,
	})

	return Tab
end

function Library:CreateSection(Tab, Title, Size)
	local Section = Tab:Section({
		Title = Title,
		TextXAlignment = "Left",
		TextSize = Size or 17,
	})

	return Section
end

function Library:CreateToggle(Tab, Table)
	local Toggle = Tab:Toggle(Table)

	return Toggle
end

function Library:CreateButton(Tab, Table)
	local Button = Tab:Button(Table)

	return Button
end

function Library:CreateSlider(Tab, Table)
	local Slider = Tab:Slider(Table)

	return Slider
end

function Library:CreateDropdown(Tab, Table)
	local Dropdown = Tab:Dropdown(Table)

	return Dropdown
end

function Library:CreateInput(Tab, Table)
	local Input = Tab:Input(Table)

	return Input
end

--// Special Setups
function Library:SetupAboutUs(AboutUs)
	local Window = Window or self:Setup()

	if not Window then
		error("[Library]: Failed to find Window")
		return
	end

	-- AboutUs:Paragraph({
	-- 	Title = "Who Are We?",
	-- 	Icon = "user-circle",
	-- 	Desc = "Xesteer Hub, um hub de script flexível e poderoso para Roblox, projetado para aprimorar sua experiência de jogo com uma variedade de recursos e ferramentas.",
	-- })

	AboutUs:Paragraph({
		Title = "Discord Invites",
		Icon = "discord",
		Desc = "Join our communities for updates and support!",
	})

	AboutUs:Button({
		Title = "Discord Link (Click to Copy)",
		Icon = "link",
		Callback = function()
			setclipboard("https://discord.gg/QjtkE8gW")
			Library:Notify({ Title = "Copied!", Content = "Discord link copied!", Duration = 3 })
		end,
	})
end

return Library
