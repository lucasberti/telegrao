local url = "https://api.lootbox.eu/pc/us/"

function toEdLanguage(text)
  local translator = {
    { "&#xFA;", "ú" },
    { "&#xF6;", "ö" },
    { "hour", "ora" },
    { "hours", "oras" },
    { "minute", "mintuto" },
    { "minutes", "mintutos" },
    { "second", "scundo" },
    { "seconds", "scundos" },
    { "-", "_" },

  }

  for i=1, #translator do
    local cleans = translator[i]
    text = string.gsub(text, cleans[1], cleans[2])
  end
  return text

end

local function queryAllHeroes(who, mode)
	local url_ow = url .. who

	if mode ~= nil and string.find(mode, "comp") then
		url_ow = url_ow .. "/competitive-play/allHeroes/"
	else
		url_ow = url_ow .. "/quick-play/allHeroes/"
	end

	print(url_ow)

	local res, code = toEdLanguage(https.request(url_ow))
	local resp = json:decode(res)

	local multi = resp.Multikills or 0
	local multi_best = resp.Multikill_Best or 0

	local text = ""

	text = text .. "elimino:: " .. resp.Eliminations ..	" (record:: " .. resp.Eliminations_MostinGame .. " .... media:: " .. resp.Eliminations_Average ..
	")\n(na vdd mato sozinho so " .. resp.SoloKills .. " .... media:: " .. resp.SoloKills_Average ..
	")\nmutikils:: " .. multi .. "(o mas fera foi matano " .. multi_best .. " nobs d 1 ves kkkk)" ..
	")\nmiojos comido:: " .. resp.FinalBlows .. " .... media:: " .. resp.FinalBlows_Average ..
	"\nmoreu::: " .. resp.Deaths .. " .... media:: " .. resp.Deaths_Average .. " (" .. resp.EnvironmentalDeaths .. " foran suicdo no mudo kkk)" ..
	"\nasistss::: " .. resp.DefensiveAssists + resp.OffensiveAssists .. " (" .. resp.DefensiveAssists .. " na dfesa " .. resp.OffensiveAssists .. " n atacke)" ..
	"\ndano q ja deu:: " .. resp.DamageDone ..	" (record:: " .. resp.DamageDone_MostinGame .. " .... media:: " .. resp.DamageDone_Average .. 
	")\nkura q ja fes:: " .. resp.HealingDone ..	" (record:: " .. resp.HealingDone_MostinGame .. " .... media:: " .. resp.HealingDone_Average ..
	")\ntenpo n obetivo:: " .. resp.ObjectiveTime ..	" (record:: " .. resp.ObjectiveTime_MostinGame .. " .... media:: " .. resp.ObjectiveTime_Average ..
	")\ntenpo en xamas:: " .. resp.TimeSpentonFire .. " (record:: " .. resp.TimeSpentonFire_MostinGame .. " .... media:: " .. resp.TimeSpentonFire_Average ..
	")\ntepelortes dstruirdos:: " .. resp.TeleporterPadsDestroyed ..
	"\ncaritnhas no fin do jojo:: " .. resp.Cards ..
	"\nmedalias:: " .. resp.Medals .. " (" .. resp.Medals_Gold .. " d oro " .. resp.Medals_Silver .. " d silver " .. resp.Medals_Bronze .. " d brose)" .. "\n\n"

	return text
end

local function queryHeroes(who, mode)
	local url_ow = url .. who

	if mode ~= nil and string.find(mode, "comp") then
		url_ow = url_ow .. "/competitive-play/heroes"
	else
		url_ow = url_ow .. "/quick-play/heroes"
	end

	print(url_ow)

	local res, code = https.request(url_ow)
	local resp = json:decode(res)

	local text = ""
	local count = 0

	for _,v in pairs(resp) do
		if (v.playtime ~= "--" and count < 5) then
			text = text .. "eroi:: " .. toEdLanguage(v.name) .. 
			"\ntenpo d jogo::: " .. toEdLanguage(v.playtime) .. "\n\n"
			count = count + 1
		end
	end

	return text
end

local function queryProfile(who, mode)
	local url_ow = url .. who

	if mode ~= nil and string.find(mode, "comp") then
		url_ow = url_ow .. "/competitive-play/profile"
	else
		url_ow = url_ow .. "/quick-play/profile"
	end

	print(url_ow)

	local res, code = https.request(url_ow)
	local resp = json:decode(res)

	local text = resp.data.username

	if not string.find(mode, "comp") then
		text = text .. " jogo " .. toEdLanguage(resp.data.playtime) .. " i "
	end

	text = text .. " ten lelve " .. resp.data.level ..
	".\njogo " .. resp.data.games.played ..
	" pratidias perdeu " .. resp.data.games.lost ..
	" i ganho " .. resp.data.games.wins ..
	" entao tem %¨ di ganhagen de " .. resp.data.games.win_percentage .. "¨&¨%\n\n"

	return text .. queryAllHeroes(who, mode) .. queryHeroes(who, mode)
end

function run(msg, matches)
	user_id = tostring(msg.from.id)
	local mode = string.lower(matches[1]) or nil
	
	-- Eu
	if user_id == "14160874" then
		return queryProfile("berti-11937", mode)
	end

	-- Bea
	if user_id == "16631085" then
		return queryProfile("bea-11259", mode)
	end

	-- Retcha
	if user_id == "85867003" then
		return queryProfile("Retcha-11793", mode)
	end

	-- Tiko
	if user_id == "80048195" then
		return queryProfile("Tikomico-1650", mode)
	end

end


return {
	description = "Stats do overwatch", 
	usage = "!ow, /overwatch",
	patterns = {
		"^[!/]overwatch$",
		"^[!/]ow$",
		"^[!/]overwatch (.*)$",
		"^[!/]ow (.*)$",
		"^[!/]overwatch@PintaoBot$"
	}, 
	run = run 
}