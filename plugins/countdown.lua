function cron()
	hora = tonumber(os.date("!%H"))
	minuto = tonumber(os.date("!%M"))
	segundo = tonumber(os.date("!%S"))
	dia = tostring(os.date("%a"))

	if dia == 'Sun' or dia == 'Sat' then
		meupintao = grandao
	else
		if hora >= 9 and hora <= 18 and minuto == 40 and segundo == 00 then
			send_msg("chat#id11672208", tostring(20 - hora).. "   H O U R S   R E M A I N I N G   B O Y S", cb_ok, false)
		end
		
		if hora == 19 and minuto == 40 and segundo == 00 then
			send_msg("chat#id11672208", "1   H O U R  R E M A I N I N G   B O Y S", cb_ok, false)
		end
		
		if hora == 20 then
			if minuto == 00 and segundo == 00 or minuto == 10 and segundo == 00 or minuto == 20 and segundo == 00 then
				send_msg("chat#id11672208", tostring(40 - minuto).. "   M I N U T E S   R E M A I N I N G   B O Y S", cb_ok, false)
			end
			
			if minuto == 25 and segundo == 00 or minuto == 30 and segundo == 00 or minuto == 35 and segundo == 00 then
				send_msg("chat#id11672208", tostring(40 - minuto).. "   M I N U T E S   R E M A I N I N G   B O Y S", cb_ok, false)
			end
			
			if minuto == 39 then
				if segundo == 00 then
					send_msg("chat#id11672208", "1   M I N U T E   R E M A I N I N G   B O Y S", cb_ok, false)
				end
				
				if segundo == 30 or segundo == 40 or segundo == 45 or segundo == 50 or segundo == 55 or segundo == 56 or segundo == 57 or segundo == 58 then
					send_msg("chat#id11672208", tostring(60 - segundo).. "   S E C O N D S   R E M A I N I N G   B O Y S", cb_ok, false)
				end
				
				if segundo == 59 then
					send_msg("chat#id11672208", "1   S E C O N D   R E M A I N I N G   B O Y S", cb_ok, false)
				end
					
			end
			
			if minuto == 40 and segundo == 00 then
				send_msg("chat#id11672208", "F R E E D O M   B O Y S mas agora tem faculdade entao nao e fredom", cb_ok, false)
			end
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