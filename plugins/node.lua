curr = 0
isEnabled = false

local msg_global = nil

function cron()

	if isEnabled then
		curr = curr + 1

		if curr == 10 then
			local cu = io.open("/root/node_modules/csgo/example/mm.txt", "r")
			message = cu:read("*a")
			print(message)
			send_msg(msg_global, message, ok_cb, false)
			cu:close()
			isEnabled = false
			curr = 0
		end
	end
end

function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    print(result)
    cmd:close()
end

function run(msg, matches)
	msg_global = get_receiver(msg)

	--run_bash("cd /root/node_modules/csgo/example && node so_mm.js")
	run_bash("/home/bot/.linuxbrew/bin/node /root/node_modules/csgo/example/so_mm.js")
	isEnabled = true

	return "perai der segundo"
end

return {
	description = "shows cpuinfo", 
	usage = "!steam",
	patterns = {"^!steam"}, 
	run = run,
	cron = cron
}
