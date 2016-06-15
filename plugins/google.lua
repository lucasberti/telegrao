do
local mime = require("mime")

local cache = {}

local api_keys = _config.google_apis

function get_google_data(text)
	local url = "https://www.googleapis.com/customsearch/v1?"
	url = url.."cx=006518944303354753471:drpbskdyusc"
	url = url.."&hl=pt-BR"
	url = url.."&q="..URL.escape(text)

	local i = math.random(#api_keys)

	if api_keys then
		url = url.."&key="..api_keys[i]
	end

	print(url)

	local res, code = https.request(url)

	if code ~= 200 then
		print("HTTP Error code:", code)
		return nil
	end

	local google = json:decode(res)
	return google
end


function process_google_data(google, receiver, query)
	local text = ""

	if not google or not google.items or #google.items == 0 then
		return "n achei"
	end

	text = text .. "axei " .. google.searchInformation.formattedTotalResults .. " resultraods!!!! mas ta aki o top 5??\n\n"

	for i=1,5 do
		text = text .. google.items[i].title .. "\n" .. google.items[i].snippet .. "\n" .. google.items[i].link .. "\n\n"
	end

	return text

end

function run(msg, matches)
	if is_from_original_chat(msg) or is_from_somewhere(msg) then
		local receiver = get_receiver(msg)
		local text = matches[1]
		local data = get_google_data(text)
		return process_google_data(data, receiver, text)
  	end
end

return {
	description = "Searches Google and send results",
	usage = "!google [terms]: Searches Google and send results",
	patterns = {
		"^[!/]google (.*)$",
		"^[!/]google@PintaoBot (.*)$"
	},
	run = run
}

end