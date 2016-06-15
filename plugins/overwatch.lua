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

  }

  for i=1, #translator do
    local cleans = translator[i]
    text = string.gsub(text, cleans[1], cleans[2])
  end
  return text

end

local function queryAllHeroes(who)
	local url_ow = url .. who .. "/allHeroes/"
	print(url_ow)

	local res, code = https.request(url_ow)
	local resp = json:decode(res)

	local text = ""

	text = text .. "elimino:: " .. resp.Eliminations ..
	" (na vdd mato so " .. resp.SoloKills ..
	"))\nmoreu::: " .. resp.Deaths ..
	"\nscor:: " .. resp.Score ..
	"\ndano q ja deu:: " .. resp.DamageDone .. 
	"\nkura q ja fes:: " .. resp.HealingDone .. 
	"\ntenpo n obetivo:: " .. resp.ObjectiveTime .. 
	"\ntenpo en xamas:: " .. resp.TimeSpentonFire .. "\n\n"

	return text
end

local function queryHeroes(who)
	local url_ow = url .. who .. "/heroes"
	print(url_ow)

	local res, code = https.request(url_ow)
	local resp = json:decode(res)

	local text = ""
	local count = 0

	for _,v in pairs(resp) do
		if (v.playtime ~= "--" and count < 5) then
			text = text .. "eroi:: " .. toEdLanguage(v.name) .. 
			"\ntenpo d jogo::: " .. toEdLanguage(v.playtime) .. 
			"\n¨% d prgresso::: " .. string.format("%.1f", v.percentage * 100) .. "%\n\n"
			count = count + 1
		end
	end

	return text
end

local function queryProfile(who)
	local url_ow = url .. who .. "/profile"
	print(url_ow)

	local res, code = https.request(url_ow)
	local resp = json:decode(res)

	local text = resp.data.username .. " jogo " .. toEdLanguage(resp.data.playtime) ..
	" i ten lelve " .. resp.data.level ..
	".\njogo " .. resp.data.games.played ..
	" pratidias perdeu " .. resp.data.games.lost ..
	" i ganho " .. resp.data.games.wins ..
	" entao tem %¨ di ganhagen de " .. resp.data.games.win_percentage .. "¨&¨%\n\n"

	return text .. queryAllHeroes(who) .. queryHeroes(who)
end

function run(msg, matches)
	user_id = tostring(msg.from.id)
	local who = matches[1]

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
			return queryProfile("Retcha-11793")
		end

		-- Tiko
		if user_id == "80048195" then
			return queryProfile("Tikomico-1650")
		end

	else
		return queryProfile(who)
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