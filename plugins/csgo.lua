do

local function queryPersona( who )
	local url_cs = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/"
	local params_cs = {
		key = "7FC65C447B2A30442CE1C6933540C705",
		steamids = who
	}

	local query_cs = format_http_params(params_cs, true)
	local url_cs = url_cs..query_cs
	print(url_cs)
	
	local res_cs, code = http.request(url_cs)
	local resp_cs = json:decode(res_cs)

	for _,v in pairs(resp_cs.response.players) do
		return v.personaname
	end

end


local function queryAPI(who, msg)
	local url_cs = "http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/"
	local params_cs = {
		appid = "730",
		key = "7FC65C447B2A30442CE1C6933540C705",
		steamid = who
	}

	local query_cs = format_http_params(params_cs, true)
	local url_cs = url_cs..query_cs
	print(url_cs)
	
	local res_cs, code = http.request(url_cs)
	local resp_cs = json:decode(res_cs)

	local shots_m4 = 0
	local shots_ak = 0
	local shots_awp = 0
	local shots_negev = 0
	local shots_mag7 = 0 
	local shots_nova = 0
	local shots_xm = 0
	local hits_m4 = 0
	local hits_ak = 0
	local hits_awp = 0
	local hits_negev = 0
	local hits_mag7 = 0
	local hits_nova = 0
	local hits_xm = 0
	local kills_m4 = 0
	local kills_ak = 0
	local kills_awp = 0
	local kills_negev = 0
	local kills_mag7 = 0
	local kills_nova = 0
	local kills_xm = 0
	local kills_molotov = 0
	local last_kills = 0
	local last_deaths = 0
	local last_mvps = 0
	local last_rounds = 0
	local last_max_players = 0
	local total_windows = 0


	for _,v in pairs(resp_cs.playerstats.stats) do
		if v.name == "total_shots_m4a1" then
			shots_m4 = v.value
		end

		if v.name == "total_hits_m4a1" then
			hits_m4 = v.value
		end

		if v.name == "total_kills_m4a1" then
			kills_m4 = v.value
		end

		if v.name == "total_shots_ak47" then
			shots_ak = v.value
		end

		if v.name == "total_hits_ak47" then
			hits_ak = v.value
		end

		if v.name == "total_kills_ak47" then
			kills_ak = v.value
		end

		if v.name == "total_shots_awp" then
			shots_awp = v.value
		end

		if v.name == "total_hits_awp" then
			hits_awp = v.value
		end

		if v.name == "total_kills_awp" then
			kills_awp = v.value
		end

		if v.name == "total_shots_negev" then
			shots_negev = v.value
		end

		if v.name == "total_hits_negev" then
			hits_negev = v.value
		end

		if v.name == "total_kills_negev" then
			kills_negev = v.value
		end

		if v.name == "total_shots_negev" then
			shots_negev = v.value
		end

		if v.name == "total_hits_negev" then
			hits_negev = v.value
		end

		if v.name == "total_kills_negev" then
			kills_negev = v.value
		end


		if v.name == "last_match_mvps" then
			last_mvps = v.value
		end

		if v.name == "last_match_kills" then
			last_kills = v.value
		end

		if v.name == "last_match_deaths" then
			last_deaths = v.value
		end

		if v.name == "last_match_wins" then
			last_rounds = v.value
		end

		if v.name == "last_match_max_players" then
			last_max_players = v.value
		end

		if v.name == "total_kills_molotov" then
			kills_molotov = v.value
		end

		if v.name == "total_broken_windows" then
			total_broken_windows = v.value
		end

		if v.name == "total_mvps" then
			total_mvps = v.value
		end
	end

	local total_kills = resp_cs.playerstats.stats[1].value
	local total_deaths = resp_cs.playerstats.stats[2].value
	local bombs_planted = resp_cs.playerstats.stats[4].value
	local bombs_defused = resp_cs.playerstats.stats[5].value
	local rounds_won = resp_cs.playerstats.stats[6].value
	local kills_knife = resp_cs.playerstats.stats[10].value
	local persona = queryPersona(who)

	local text = persona .. " nob ja........."..
	"\n>mato " ..total_kills.. " veses"..
	"\n>moreu " ..total_deaths.. " veses"..
	"\n>ten kd d " ..total_kills / total_deaths..
	"\n>planto " ..bombs_planted.. " i defuso " ..bombs_defused.. " bonbas"..
	"\n>ganho " ..rounds_won.. " hounds"..
	"\n>mato " ..kills_knife.. " na faca (PASA A MANTEGA PASA NELA PASA PASA A MATEGNA KKKK"..
	"\n>deu " ..shots_m4.. " tiros d M4 (as duas ok), acerto " ..hits_m4.. " i mato " ..kills_m4..
	"\n>deu " ..shots_ak.. " tiros d AK(melh amar do jogo ok, acerto " ..hits_ak.. " i mato " ..kills_ak..
	"\n>deu " ..shots_awp.. " tiros d AWP, acerto " ..hits_awp.. " i mato " ..kills_awp..
	"\n>deu " ..shots_negev .. " tiros de negev, acerto " ..hits_negev.. " i mato " ..kills_negev..
	"\n>ganho " ..total_mvps.. " mvps no total"..
	"\n>quebro " ..total_broken_windows.. " janelas eh um vandalo msm"

	if last_max_players == 10 then
		text = text .. "\n\nna utima partida............"..
		"\n>mato " ..last_kills.. " i moreu " ..last_deaths.. " veses (inclui warmup hehe)"..
		"\n>pego " ..last_mvps.. " mvps"


		if last_rounds < 16 then
			return text .. "\n>o time perdeu de " ..last_rounds.. " a 16 kkkkk\n>mcq"
		else
			return text .. "\n>o time ganho oloco em\n>mcq"
		end
	else
		return text
	end

end

function run(msg, matches)
	user_id = tostring(msg.from.id)

	if msg.text == "!csgo" or msg.text == "/csgo" or msg.text == "/csgo@PintaoBot" then

		-- Eu
		if user_id == "14160874" then
			return queryAPI("76561198040339223", msg)
		end

		-- Bea
		if user_id == "16631085" then
			return queryAPI("76561198079217921", msg)
		end

		-- Farinha
		if user_id == "16259040" then
			return queryAPI("76561198025591944", msg)
		end

		-- Geta
		if user_id == "25919148" then
			return queryAPI("76561198025591944", msg)
		end

		-- X
		if user_id == "52451934" then
			return queryAPI("76561198009059027", msg)
		end

		-- Burn
		if user_id == "177436074" then
			return queryAPI("76561197995141031", msg)
		end

		-- Tiko
		if user_id == "80048195" then
			return queryAPI("76561198028549779", msg)
		end

		-- Tadeu
		if user_id == "49681384" then
			return queryAPI("76561198204991992", msg)
		end

		-- Springles
		if user_id == "121326431" then
			return queryAPI("76561198017789007", msg)
		end

		-- Fabio
		if user_id == "77677283" then
			return queryAPI("76561198035308628", msg)
		end

		-- Retcha
		if user_id == "85867003" then
			return queryAPI("76561198051743480", msg)
		end

		-- Miojo
		if user_id == "43299772" then
			return queryAPI("76561198043606048", msg)
		end

	else
		return queryAPI(matches[1], msg)
	end

end


return {
	description = "Stats do CSGO", 
	usage = "!csgo, /csgo",
	patterns = {
		"^!csgo$",
		"^!csgo (.*)$",
		"^/csgo$",
		"^/csgo@PintaoBot$",
		"^/csgo (.*)$"
	}, 
	run = run 
}

end
