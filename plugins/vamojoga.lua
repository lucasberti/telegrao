local SECS = 0 -- timeout start
local MAX_SECS = 60*3 -- 3 min timeout
local TIMER_ENABLED = false

local TOTAL = 1
local CONFIRMED = 0
local WHICHGAME = ""

local GLOBAL_CHATID = nil

local API_key = load_from_file("data/config.lua")

local API_BASE = "https://api.telegram.org/" .. API_key.telegram_api .. "/sendMessage?"


-- Mensagem inicial via API: exibe teclado
local function sendMessage(origin, text)
	local API_TOCALL = API_BASE .. "chat_id=-" .. origin
	.."&text=" .. URL.escape(text) .. "&reply_markup={\"keyboard\": [[\"EU VO\"], [\"nemvo\"]],\"one_time_keyboard\": true}"

	local ok, code, headers, status = https.request(API_TOCALL)

end


-- Mensagem final ---- Variação: mensagem padrão
local function sendMessageNoKeyboardNoGame(origin)
	local API_TOCALL = API_BASE .. "chat_id=-" .. origin
	.."&text=ok kbo entam vo esconde os telclado ok&parse_mode=Markdown&reply_markup={\"hide_keyboard\": true}"

	local ok, code, headers, status = https.request(API_TOCALL)
end


-- Mensagem final ---- Variação: mensagem com link (/var/www/html)
local function sendMessageNoKeyboard(origin, link)
	local API_TOCALL = API_BASE .. "chat_id=-" .. origin
	.."&text=belesinha vcs ja pode i joga [clicano aki](" .. link ..") &parse_mode=Markdown&reply_markup={\"hide_keyboard\": true}"

	local ok, code, headers, status = https.request(API_TOCALL)
end


-- "Constructor" da table
local WHO_CONFIRMED = { ["14160874"]= "false",
						["16631085"]= "false",
						["16259040"]= "false",
						["25919148"]= "false",
						["52451934"]= "false",
						["177436074"] = "false",
						["80048195"]= "false",				-- CHECK: wunder.lua         
						["121326431"] = "false",
						["35072014"]= "false", 
						["49681384"]= "false",
						["77677283"]= "false",
						["85867003"]= "false",
						["43299772"]= "false",
						["82017295"]= "false" }

-- Todas as vars globais resetadas + tabela desconstruída
local function resetEverything(link)

	TIMER_ENABLED = false
	SECS = 0
	TOTAL = 1
	CONFIRMED = 0

	WHO_CONFIRMED = { 	["14160874"]= "false",
						["16631085"]= "false",
						["16259040"]= "false",
						["25919148"]= "false",
						["52451934"]= "false",
						["177436074"] = "false",
						["80048195"]= "false",			        
						["121326431"] = "false",
						["35072014"]= "false", 
						["49681384"]= "false",
						["77677283"]= "false",
						["85867003"]= "false",
						["43299772"]= "false",
						["82017295"]= "false" }

	-- Avalia qual mensagem final enviar
	if link ~= nil then	sendMessageNoKeyboard(GLOBAL_CHATID, link) else sendMessageNoKeyboardNoGame(GLOBAL_CHATID) end
end

-- Chamado a cada voto. Identifica se deve ou não terminar e resetar.
local function hasEnded(target)
	print(WHICHGAME)

	if CONFIRMED == TOTAL then
		send_msg(target, WHICHGAME .. " " .. CONFIRMED .. "/" .. TOTAL, ok_cb, false) -- Contagem a cada voto recebido

		if string.find(WHICHGAME, "CSGO") or string.find(WHICHGAME, "CS") or string.find(WHICHGAME, "CONTER") or string.find(WHICHGAME, "COUNTER STRIKE") then
			resetEverything("http://peido.xyz/csgo")

		elseif string.find(WHICHGAME, "RL") or string.find(WHICHGAME, "ROCKET LEAGUE") or string.find(WHICHGAME, "ROCKET") then
			resetEverything("http://peido.xyz/rocketleague")

		elseif string.find(WHICHGAME, "GTA") or string.find(WHICHGAME, "GRAND THEFT AUTO") or string.find(WHICHGAME, "GTAV") or string.find(WHICHGAME, "GTA V") or string.find(WHICHGAME, "GTA5") or string.find(WHICHGAME, "GTA 5") then 
			resetEverything("http://peido.xyz/gta")

		elseif string.find(WHICHGAME, "ETS2") or string.find(WHICHGAME, "EUROTRUCK") or string.find(WHICHGAME, "EURO TRUCK") then
			resetEverything("http://peido.xyz/eurotruck")

		elseif string.find(WHICHGAME, "DOTA") or string.find(WHICHGAME, "DOTA2") or string.find(WHICHGAME, "DOTA 2") or string.find(WHICHGAME, "DOTINHA") then
			resetEverything("http://peido.xyz/dota")

		elseif string.find(WHICHGAME, "OW") or string.find(WHICHGAME, "OVERWATCH") or string.find(WHICHGAME, "OVER") then
			resetEverything("http://peido.xyz/over")

		else
			resetEverything(nil)
		end
	else
		send_msg(target, WHICHGAME .. " " .. CONFIRMED .. "/" .. TOTAL, ok_cb, false) -- Escape
	end
end

local function run(msg, matches)
	if is_from_original_chat(msg) then
		local chatid = get_receiver(msg)
		chatid = tostring(chatid):gsub('chat#id', '')

		GLOBAL_CHATID = chatid

		local whoisit = tostring(msg.from.id)

		-- Evita que seja iniciado por engano e que tenha mais de 2 convites ao mesmo tempo
		if #matches == 2 and TIMER_ENABLED == false then
			--WHO_CONFIRMED[whoisit] = "true"

			TOTAL = tonumber(matches[2])	
			WHICHGAME = string.upper(matches[1])
			TIMER_ENABLED = true
			
			hasEnded(get_receiver(msg))
			
			sendMessage(chatid, WHICHGAME)

		-- Só é válido caso o convite não tenha chego ao máximo
		elseif matches[1] == "EU VO" and CONFIRMED < TOTAL and TIMER_ENABLED then
			if WHO_CONFIRMED[whoisit] == "false" then

				WHO_CONFIRMED[whoisit] = "true"
				CONFIRMED = 1 + CONFIRMED

				hasEnded(get_receiver(msg))
			else
				return "mas veio vc ja vai :("
			end

		elseif matches[1] == "nemvo" and CONFIRMED < TOTAL and TIMER_ENABLED then
			if WHO_CONFIRMED[whoisit] == "true" then

				WHO_CONFIRMED[whoisit] = "false"
				CONFIRMED = CONFIRMED - 1

				hasEnded(get_receiver(msg))
			end
		end

		-- Override manual
		if matches[1] == "hide" and is_sudo(msg) then
			resetEverything()
		end
	end
end

-- Função chamada a cada segundo
local function cron()
	if TIMER_ENABLED then
		SECS = SECS + 1

		if SECS == MAX_SECS then
			resetEverything()
		end

	end
end

return {
	description = "",
	usage = "",
	patterns = {
		"^[!|/]vamojoga (.*) ([2-9])$",
		"^(EU VO)$",
		"^(nemvo)$",
		"^!(hide)$"
	},
	run = run,
	cron = cron
}
