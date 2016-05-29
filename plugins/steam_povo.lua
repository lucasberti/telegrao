local function personaState( state )
	if state == 0 then
		return "oflain"
	elseif state == 1 then
		return "omlain"
	elseif state == 2 then
		return "o cu paod"
	elseif state == 3 then
		return "auei"
	elseif state == 4 then
		return "durmino MAS Q DORMINHIOC"
	elseif state == 5 then
		return "kereno troka"
	elseif state == 6 then
		return "kereno joga"
	else
		return "alguam coisa q n sei"
	end
end

local function queryPersonas()
	local url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/"
	local params = {
		key = "7FC65C447B2A30442CE1C6933540C705",
		steamids = "76561198040339223,76561198079217921,76561198051743480,76561198028549779,76561198025591944,76561198009059027,76561198043784982"
		-- 					EU,				 BEA, 				RETCHA, 		TIKO, 				GETA, 				X			FARINHA
	}

	local query = format_http_params(params, true)
	local url = url..query
	print(url)
	
	local res, code = http.request(url)
	local resp = json:decode(res)

	local text = ""

	for _,v in pairs(resp.response.players) do
		local currentGame = v.gameextrainfo or "nada"

		if v.personastate ~= 0 then
			text = text .. v.personaname .. " ta " .. personaState(v.personastate) .. " i jogno " .. currentGame.. "\n"
		else			
			text = text .. v.personaname .. " ta oflain afff\n"
		end
	end
	print(text)

	return text
end

local function run (msg, matches)
	return queryPersonas()
end

return {
	description = "",
	usage = "",
	patterns = {
		"^[!/]steam$",
		"^[!/]steam@PintaoBot$",
	},
	run = run,
	cron = cron
}