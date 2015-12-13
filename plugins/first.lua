function cron()
	hora = tonumber(os.date("!%H"))
	minuto = tonumber(os.date("!%M"))
	segundo = tonumber(os.date("!%S"))
	dia = tostring(os.date("%a"))
	mes = tostring(os.date("%b"))

	if hora == 03 and minuto == 00 and segundo == 00 then
		send_msg("chat#id11672208", "FIRST", cb_ok, false)
	end
end

return {
    description = nil,
    usage = "",
    patterns = {},
    run = nil,
    cron = cron
}