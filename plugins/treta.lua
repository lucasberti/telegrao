local filename='data/treta_history.lua'
local cronned = load_from_file(filename)

local function saveCron(date)
	local origin = "chat#id11672208"

	if not cronned[origin] then
		cronned[origin] = { date }
	end

	cronned[origin] = { date }

	serialize_to_file(cronned, filename)
end

local function getSinceDate(msg)
	local saved = cronned["chat#id11672208"]
	local result = os.time() - tonumber(table.concat(saved))
	local real_result = os.time() - result

	return real_result
end

local function getElapsedTime(msg)
	local diff = os.difftime(getSinceDate(msg), os.time()) / (-86400)
	local diffString = string.format("%4.1d dias", diff)

	print(diffString)
	send_msg(get_receiver(msg), "meus aparabes vocs jae stao 100 trta dsd " .. os.date("%d/%m/%y as %H:%M:%S",getSinceDate(msg)) .. ", iso da....... " .. diffString .. "!!!", cb_ok, false)
end

local function run(msg, matches)
	if matches[1] == "reset" and is_sudo(msg) then
		saveCron(os.time())
		return 'pora mas q desepcsao ja teve treta de novo'
	else
		getElapsedTime(msg)
	end
end


return {
    description = "",
    usage = "",
    patterns = {
        "^!treta$",
        "^!treta (reset)$",
        "^/treta$",
        "^/treta@PintaoBot$"
    },
    run = run
}
