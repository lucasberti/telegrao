local function queryHeroes(who)
	local url = "https://api.lootbox.eu/pc/us/"

	local url_ow = url .. who .. "/heroes"
	print(url_ow)

	local res, code = https.request(url_ow)
	local resp = json:decode(res)

	local text = ""

	for _,v in pairs(resp) do
		if (v.playtime ~= "--") then
			text = text .. "eroi:: " .. v.name .."\ntenpo d jogo::: " .. v.playtime .. "\nbct::: " .. v.percentage .. "%%\n\n"
		end
	end

	return text
end

local function queryProfile(who)
	local url = "https://api.lootbox.eu/pc/us/"

	local url_ow = url .. who .. "/profile"
	print(url_ow)

	local res, code = https.request(url_ow)
	local resp = json:decode(res)

	local text = resp.data.username .. " jogo " .. resp.data.playtime .. " i ten lelve " .. resp.data.level .. ".\njogo " .. resp.data.games.played .. " pratidias perdeu " .. resp.data.games.lost .. " i ganho " .. resp.data.games.wins .. " entao tem %%¨ di ganhagen de " .. resp.data.games.win_percentage .. "¨&¨%%%\n\n"

	return text .. queryHeroes(who)
end

function run(msg, matches)
	user_id = tostring(msg.from.id)

	if msg.text == "!overwatch" or msg.text == "!ow" or msg.text == "/overwatch" or msg.text == "/overwatch@PintaoBot" then

		-- Eu
		if user_id == "14160874" then
			return queryProfile("berti-11937")
		end

		-- Bea
		if user_id == "16631085" then
			return queryProfile("bea-11259")
		end

		-- Retcha
		if user_id == "85867003" then
			return queryProfile("retcha-11793")
		end

	else
		return queryProfile(matches[1])
	end

end


return {
	description = "Stats do overwatch", 
	usage = "!ow, /overwatch",
	patterns = {
		"^!overwatch$",
		"^!ow$",
		"^!overwatch (.*)$",
		"^!ow (.*)$",
		"^/overwatch$",
		"^/overwatch@PintaoBot$",
		"^/overwatch (.*)$"
	}, 
	run = run 
}