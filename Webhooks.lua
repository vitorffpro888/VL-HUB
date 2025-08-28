local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local placeId = game.PlaceId
local jobId = game.JobId

-- 🎯 Danh sách Brainrot theo độ hiếm
local brainrotList = {
	["cocofanto elefanto"] = "God",
	["gattatino nyanino"] = "God",
	["girafa celestre"] = "God",
	["matteo"] = "God",
	["tralalero tralala"] = "God",
	["odin din din dun"] = "God",
	["unclito samito"] = "God",
	["trenostruzzo turbo 3000"] = "God",
	["tigroligre frutonni"] = "God",
	["orcalero orcala"] = "God",
	["la vacca saturno saturnita"] = "Secret",
	["sammyni spiderini"] = "Secret",
	["torrtuginni dragonfrutini"] = "Secret",
	["los tralaleritos"] = "Secret",
	["las tralaleritas"] = "Secret",
	["graipuss medussi"] = "Secret",
	["pot hotspot"] = "Secret",
	["la grande combinazione"] = "Secret",
	["garama and madundung"] = "Secret"
}

-- 🧠 Ghi lại những con đã gửi rồi
local alreadySent = {}

-- 🧠 Hàm scan toàn map và lọc brainrot mới
local function getNewBrainrots()
	local newFound = {}
	for _, obj in ipairs(workspace:GetDescendants()) do
		local objName = obj.Name:lower()
		for brainrotName, rarity in pairs(brainrotList) do
			if objName:find(brainrotName) and not alreadySent[brainrotName] then
				newFound[brainrotName] = rarity
				alreadySent[brainrotName] = true -- đánh dấu là đã gửi rồi
			end
		end
	end
	return newFound
end

-- 📨 Hàm gửi webhook
local function sendWebhook(brainrots)
	local lines = {}
	for name, rarity in pairs(brainrots) do
		table.insert(lines, "**" .. name .. "** → `" .. rarity .. "`")
	end

	local embedText = table.concat(lines, "\n")
	local playerCount = tostring(#Players:GetPlayers()) .. "/8"

	local Data = {
		["username"] = "Notify Brainrot | Xesteer Hub",
		["avatar_url"] = "https://cdn.discordapp.com/attachments/1404537831350734888/1410411501017239602/PNG_03.png?ex=68b0eb92&is=68af9a12&hm=6351ccd0583b9cc4b80f92b1468663ab82d3be47d854d05049412e21e8f2dc6f&",
		["embeds"] = {{
			["title"] = "🧠 New Brainrot(s) Detected!",
			["color"] = tonumber("0xff00ff"),
			["fields"] = {
				{["name"] = "🧠 Name(s)", ["value"] = embedText, ["inline"] = false},
				{["name"] = "👥 Players", ["value"] = "**" .. playerCount .. "**", ["inline"] = true},
				{["name"] = "🌍 Job ID", ["value"] = "`" .. jobId .. "`", ["inline"] = true},
				{
					["name"] = "📦 Join Script",
					["value"] = "```lua\ngame:GetService(\"TeleportService\"):TeleportToPlaceInstance("..placeId..", \""..jobId.."\", game.Players.LocalPlayer)```",
					["inline"] = false
				}
			},
			["footer"] = {
				["text"] = "Script By Vitorzz07. | " .. os.date("%d/%m/%Y • %H:%M:%S"),
				["icon_url"] = "https://cdn.discordapp.com/attachments/1404537831350734888/1410411501017239602/PNG_03.png?ex=68b0eb92&is=68af9a12&hm=6351ccd0583b9cc4b80f92b1468663ab82d3be47d854d05049412e21e8f2dc6f&"
			},
			["thumbnail"] = {
				["url"] = "https://cdn.discordapp.com/attachments/1404537831350734888/1410411501017239602/PNG_03.png?ex=68b0eb92&is=68af9a12&hm=6351ccd0583b9cc4b80f92b1468663ab82d3be47d854d05049412e21e8f2dc6f&"
			}
		}}
	}

	local Headers = {["Content-Type"] = "application/json"}
	local Encoded = HttpService:JSONEncode(Data)
	local WebhookURL = "https://discord.com/api/v10/webhooks/1410417020247478478/nPSQTXaNK9TtnmVF4qnSsbcjNH47RrYQKTQTvq4oqYOCffJ0ox6xXB3kMpnCjioNCx97"
	local Request = http_request or request or syn and syn.request

	if Request then
		pcall(function()
			Request({
				Url = WebhookURL,
				Body = Encoded,
				Method = "POST",
				Headers = Headers
			})
		end)
	end
end

-- 🔁 Theo dõi liên tục mỗi 1 giây
while true do
	local newOnes = getNewBrainrots()
	if next(newOnes) then
		sendWebhook(newOnes)
	end
	task.wait(1)
end
