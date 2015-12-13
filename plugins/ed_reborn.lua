local current_update = 0

local BASE_URL = "https://api.telegram.org/bot98532395:AAElq7dN0mDnvsj26-Bs2H4RzeEpLbSsTyE/"

function loadUpdatesFromFile( )
	local cu = io.open("./data/ed_reborn.txt", "r")
	current_update = tonumber(cu:read("*a"))
	cu:close()
end

function getUpdate()
	local url = BASE_URL .. "getUpdates"
	local params = {
		offset = tostring(current_update),
		timeout = "5"
	}
	
	local query = format_http_params(params, true)
	local url = url..query
	print("Pollando a API por updates usando offset " .. tostring(current_update))
	
	local res, code = https.request(url)
	local resp = json:decode(res)
	
	local current_msg

	for _,v in pairs(resp.result) do
		if current_update < v.update_id then
			current_update = v.update_id
			local file = io.open("./data/ed_reborn.txt", "w")
			file:write(tostring(v.update_id))
			file:close()
			v.message.text = current_msg -- .. " com update " ..tostring(current_update)
		end
	end

	return current_msg
end

function run(msg, matches)	
	loadUpdatesFromFile()
	local message = getUpdate()
	print(message)
end

return {
    description = nil,
    usage = "",
    patterns = {"^(.*)$"},
    run = run,
}

