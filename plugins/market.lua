do

function searchMarket(st, weap, skin, qual, msg)
	local path = "http://steamcommunity.com/market/priceoverview/"
	local params = {
		country = "BR", 
		currency = "7",
		appid = "730",
		market_hash_name = st .. URL.escape(weap .. ' | ' .. skin .. ' (' .. qual ..')')
	}

	local query = format_http_params(params, true)
	local url = path..query

	print(url)
	local res, code = https.request(url)
	--if code > 200 then return 'pora deu ero' end
	
	print("decode")
	local resp = json:decode(res)
	
	local success = resp.success
	
	if success == 'false' then
		print("1")
		send_msg(get_receiver(msg), 'ow nao deu serto nao', ok_cb, false)
	end
	
	if not resp.lowest_price then
		print("2")
		send_msg(get_receiver(msg), 'ou nao esiste ou a api eh troxa -_-', ok_cb, false)
	end
	
	return 'Existem ' .. resp.volume .. ' ' .. weap .. 's. A mais barata custa ' .. resp.lowest_price:sub(11) .. ' e a média é ' .. resp.median_price:sub(11)
end

function titleCase( first, rest )
   return first:upper()..rest:lower()
end

local function clearChar(text)
	local cleaner = {
		{ "&#82;", "R" },
		{ "&#36;", "$" },
		{ "Flip", "★ Flip Knife" },
		{ "Butterfly", "★ Butterfly Knife" },
		{ "Karambit", "★ Karambit" },
		{ "Huntsman", "★ Huntsman Knife" },
		{ "Bayonet", "★ Bayonet" },
		{ "M9 Bayonet", "★ M9 Bayonet" },
		{ "Gut", "★ Gut Knife" },
		{ "Falchion", "★ Falchion Knife" },
	}
	
	for i=1, #cleaner do
		local cleans = cleaner[i]
		text = string.gsub(text, cleans[1], cleans[2])
	end

	return text
end

function run(msg, matches)
	print("print")
	if #matches == 3 then
		local weapon = matches[1]
		local skin = string.gsub(matches[2], "(%a)([%w_']*)", titleCase)
		local quality = string.gsub(matches[3], "(%a)([%w_']*)", titleCase)
		print("searchMarket sem ST")
		return searchMarket("", clearChar(weapon), skin, quality, msg)
	end
	
	if #matches == 4 then
		local StarTrek = matches[1]
		local weapon = matches[2]
		local skin = string.gsub(matches[3], "(%a)([%w_']*)", titleCase)
		local quality = string.gsub(matches[4], "(%a)([%w_']*)", titleCase)
		
		if string.lower(StarTrek) == "st" then
			print("searchMarket com ST")
			return searchMarket("StatTrak%E2%84%A2%20", clearChar(weapon), skin, quality, msg)
		end
	end
	
	print("searchMarket")
	--return searchMarket(matches[1], matches[2], matches[3])
end

return {
	description = "MARKETISINHA", 
	usage = {
		"!market [arma], [skin], [qualidade]",
		"!market (ST), [arma], [skin], [qualidade]",
	},
	patterns = {
		"^!market (.*), (.*), (.*), (.*)$",
		"^!market (.*), (.*), (.*)$",
	}, 
	run = run 
}

end