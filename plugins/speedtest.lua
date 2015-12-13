local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    print(result)
    cmd:close()
    return result
end

local function run(msg, matches)
	return run_bash("speedtest-cli --share")
end

return {
	description = "",
	usage = "",
	patterns = {
		"^[!|/]speedtest$"
	},
	run = run
}