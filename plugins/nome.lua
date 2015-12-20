local function run(msg,matches)
	rename_chat("chat#id11672208", matches[1], ok_cb, cb_extra)
end


return 
{
	descripiton="",
	patterns={"^[!/]nome (.*)"},
	run=run
}