do


local function queryAPI(who, msg)
	local url = "http://signature.rocketleaguestats.com/normal/steam/" .. who .. ".png"
	local receiver = get_receiver(msg)

	print(url)
	
	send_photo_from_url(receiver, url)
end

function run(msg, matches)
	user_id = tostring(msg.from.id)

	if msg.text == "!rl" or msg.text == "/rl" or msg.text == "/rl@PintaoBot" then

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

		-- Tomate
		if user_id == "24975729" then
			return queryAPI("76561198119720218", msg)
		end

	else
		return queryAPI(matches[1], msg)
	end

end


return {
	description = "Stats do RL", 
	usage = "!rl, /rl",
	patterns = {
		"^[!/]rl$",
		"^[!/]rl (.*)$",
		"^/rl@PintaoBot$",
		"^/rl@PintaoBot$ (.*)"
	}, 
	run = run 
}

end
