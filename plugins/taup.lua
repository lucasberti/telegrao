hour = tonumber(os.date("!%H"))
minute = tonumber(os.date("!%M"))
second = tonumber(os.date("!%S"))
day = tostring(os.date("%a"))
month = tostring(os.date("%b"))

local secs = 0

function run(msg, matches)
	local receiver = get_receiver(msg)

	if string.find(matches[1], "tá up") or string.find(matches[1], "tá ligado") or string.find(matches[1], "vc esta ai") then
		return 'SIM, TÔ AQUI PORA'
	end
	
	if string.find(matches[1], "@todomundo") then
		return '@berti @beaea @getulhao @rauzao @xisteaga @oburnao @tikomico'
	end

	if msg.text == "!historia" then
		return 'https://www.youtube.com/watch?v=ZkwdNcrIbxs'
	end
	
	if msg.text == "xisrico" then
		send_document(receiver, "./data/misc/xisrico.gif", ok_cb, cb_extra)
	end

	if msg.text == "XisOHomemDaNoite" then
		send_document(receiver, "./data/misc/XisOHomemDaNoite.gif", ok_cb, cb_extra)
	end

	--[[if msg.text == "xischupano" then
		send_audio(receiver, "./data/misc/xis chupano.mp3", ok_cb, cb_extra)
	end

	if msg.text == "retchagemendo" then
		send_audio(receiver, "./data/misc/retchagemendo.mp3", ok_cb, cb_extra)
	end
	
	if msg.text == "trevah" then
		send_audio(receiver, "./data/misc/trevah.mp3", ok_cb, cb_extra)
	end--]]
	
	if msg.text == "calma" then
		return 'ok esto mais calmo obrigada'
	end

	if msg.text == "!ip" then
		return '162.252.243.88'
	end

	if string.find(string.lower(matches[1]), "reloada") then
		reload_plugins(msg)
	end
	
	if string.find(string.lower(matches[1]), "!mps") then
		mps = math.random(500,10000)
		return 'ok to calculando aki q esistem ' ..mps .. '/s por segundo de SUPER MAEMES NESNTE CHAT1'
	end
	
	if msg.text == "rau" or msg.text == "Rau" then
		return 'meu pau no seu cu'
	end
	
	if msg.text == "quanto tempo falta" then		
		if hour >= 20 and minute >= 40 or hour < 5 or day == 'Sat' or day == 'Sun' then
			send_msg(get_receiver(msg), 'calma ne nao da pra usa', ok_cb, false)
		else
			if hour < 19 and hour > 5 then
				send_msg(get_receiver(msg), 'ok faltam ' ..tostring(20 - hour).. ' horas e ' ..tostring(40 - minute).. ' minutos e ' ..tostring(60 - second).. ' segundos ok', ok_cb, false)
			end
			
			if hour == 19 then
				send_msg(get_receiver(msg), 'ok faltam ' ..tostring(20 - hour).. ' horas e ' ..tostring(40 - minute).. ' minutos e ' ..tostring(60 - second).. ' segundos ok', ok_cb, false)
			end
			
			if hour == 20 and minute <= 38 then
				send_msg(get_receiver(msg), 'ok faltam ' ..tostring(39 - minute).. ' minutos e ' ..tostring(60 - second).. ' segundos ok', ok_cb, false)
			end

			if hour == 20 and minute == 39 then
				send_msg(get_receiver(msg), 'ok faltam ' ..tostring(39 - minute).. ' minuto e ' ..tostring(60 - second).. ' segundos ok', ok_cb, false)
			end
			
			if hour >= 20 and minute >= 40 or hour < 5 or day == 'Sat' or day == 'Sun' then
				send_msg(get_receiver(msg), 'calma ne nao da pra usa', ok_cb, false)
			end
		end
	end

	if string.find(matches[1], "Kappa") then
		send_document(get_receiver(msg), "/root/telegram-bot/etc/W0QgS4N.webp", ok_cb, false)
	end
end

function cron()
	secs = secs + 1

	if secs == 5 then
		status_offline()
		secs = 0
	end
end

return {
	description = "Checa se o bot tá up ou down", 
	usage = "",
	patterns = { "^(.*)$" }, 
	cron = cron,
	run = run
}
