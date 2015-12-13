function cron()
	hora = tonumber(os.date("%H"))
	minuto = tonumber(os.date("%M"))
	segundo = tonumber(os.date("%S"))
	dia = tonumber(os.date("%d"))
	text_msg = nil
	text_title = nil

	--Horas do dia 11
	if minuto == 00 and segundo == 00 and dia == 11 then
		
		--faltando 2 dias
		if hora == 20 then
			text_msg = "2   D A Y S   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = "2 DAYS BOYSSSS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
		
		--até 1 hora antes
		if hora <= 19 then
			text_msg = "2   D A Y S   A N D   " .. tostring(20 - hora).. "   H O U R S   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = "2 DAYS AND " .. tostring(20 - hora) .. " HOURS BOYS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
		
		if hora >= 21 then
			text_msg = "1   D A Y   A N D   " .. tostring(44 - hora).. "   H O U R S   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = "1 DAY AND " .. tostring(44 - hora) .. " HOURS BOYS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
	end
	
	--Horas do dia 12
	if minuto == 00 and segundo == 00 and dia == 12 then
		if hora == 20 then
			text_msg = "1   D A Y   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = "1 DAY BOYSSSSS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
	
		if hora < 20 then
			text_msg = "1   D A Y   A N D   " .. tostring(20 - hora).. "   H O U R S   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = "1 DAY AND " ..tostring(20 - hora).. " HOURS BOYS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
		
		if hora > 20 then
			text_msg = tostring(44 - hora).. "   H O U R S   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = tostring(44 - hora) .. " HOURS BOYS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
	end
	
	--Dia do lançamento
	if dia == 13 then
		if minuto == 00 and segundo == 00 and hora <= 18 then
			text_msg = "É   H O J E !   " .. tostring(20 - hora).. "   H O U R S   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = tostring(20 - hora) .. " HOURS REMAINING BOYSSSS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
		
		if minuto == 00 and segundo == 00 and hora == 19 then
			text_msg = "T Á   C H E G A N D O!   1   H O U R   R E M A I N I N G   2   G T A   V   B O Y S"
			text_title = "1 HOUR BOYSSSS"
			send_msg("chat#id11672208", text_msg, cb_ok, false)
			rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
		end
		
		if hora == 19 then
			if (minuto == 10 or minuto == 20 or minuto == 30 or minuto == 40) and segundo == 00 then
				text_msg = tostring(60 - minuto).. "   M I N U T E S   R E M A I N I N G   2   G T A   V   B O Y S"
				text_title = tostring(59 - minuto + 1) .. " MINUTES BOYSSSS"
				send_msg("chat#id11672208", text_msg, cb_ok, false)
				rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)
			end
			
			if (minuto == 45 or minuto == 50 or minuto == 55 or minuto == 56 or minuto == 57 or minuto == 58) and segundo == 00 then
				text_msg = tostring(59 - minuto + 1).. "   M I N U T E S   R E M A I N I N G   2   G T A   V   B O Y S"
				text_title = tostring(59 - minuto + 1) .. " MINUTES BOYSSSS"
				send_msg("chat#id11672208", text_msg, cb_ok, false)
				rename_chat("chat#id11672208", text_title, ok_cb, cb_extra)				
			end
			
			if minuto == 59 then
				if segundo == 00 then
					send_msg("chat#id11672208", "1   M I N U T E   R E M A I N I N G   2   G T A   V   B O Y S", cb_ok, false)
					rename_chat("chat#id11672208", "1 FOCKEN MINUTE", ok_cb, cb_extra)	
				end
				
				if segundo == 30 or segundo == 40 or segundo == 45 or segundo == 50 or segundo == 55 or segundo == 56 or segundo == 57 or segundo == 58 then
					send_msg("chat#id11672208", tostring(59 - segundo + 1).. "   S E C O N D S   R E M A I N I N G   2   G T A   V   B O Y S", cb_ok, false)
					rename_chat("chat#id11672208", tostring(59 - segundo + 1).. " SECONDS", ok_cb, cb_extra)
				end
				
				if segundo == 59 then
					send_msg("chat#id11672208", "1   S E C O N D   R E M A I N I N G   2   G T A   V   B O Y S", cb_ok, false)
					rename_chat("chat#id11672208", "1 SECONDDDDD", ok_cb, cb_extra)
				end
			end
		end
		
		if hora == 20 and minuto == 00 and segundo == 00 then
			send_msg("chat#id11672208", "CORRE PRA STEAM QUE LANÇOU RAPASIADA (e o x vai pra social club)", cb_ok, false)
			rename_chat("chat#id11672208", "GTA V IS FOCKEN HERE", ok_cb, cb_extra)
		end
	end
end

return {
    description = nil,
    usage = "",
    patterns = {},
    run = nil,
    cron = cron
}