local BASE_API = "http://s.dicio.com.br/"

local function run(msg, matches)
	send_photo_from_url(get_receiver(msg), BASE_API .. matches[1] .. ".jpg")
end

return
{
	patterns = {
		"^[!/]qqe (.*)$",
		"^[!/]qqe@PintaoBot (.*)$",
		"^[!/]defina (.*)$"	},
	run = run
}