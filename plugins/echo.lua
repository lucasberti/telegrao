-- Checka se o usuário é membro do Xet
-- Acredito que esta lista não esteja completa, pois me baseei no Wunder

function isXetUser(uid)
	-- Na exata ordem vista no plugin do Wunderground
	local xetUsers = {"14160874", "16631085", "16259040", "25919148", "52451934", "177436074", "80048195", "121326431", "35072014", "49681384", "77677283", "85867003", "43299772"}

	for _,u in pairs(xetUsers) do
		if u == uid then
			return true
		else
			return false
		end
	end

end

function run(msg, matches)
  	--user_id = tostring(msg.from.id)
  	--xetUser = isXetUser(user_id)

  	--if (xetUser) then
  		send_msg("chat#id11672208", matches[1], cb_ok, false)
  	--end

  send_msg("user#id14160874", get_name(msg).. ' disse: ' ..matches[1], cb_ok, false)
  --return "oops, temporariamente desativado!"
end

return {
    description = "echoes the msg", 
    usage = "!echo [whatever]",
    patterns = {"^!echo (.*)$"}, 
    run = run 
}
