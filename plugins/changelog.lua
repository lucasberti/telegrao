local function run(msg, matches)
	return "aooowwww taew o cehngelog::: https://github.com/lucasberti/telegrao/commits/master \n\ne o otro::::: https://github.com/lucasberti/telegrinho/commits/master"
end

return {
	description = "",
	usage = "",
	patterns = {
		"^[!/]changelog",
		"^[!/]changelog@PintaoBot",
	},
	run = run
}
