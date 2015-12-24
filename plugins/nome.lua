local function run(msg,matches)
	rename_chat(get_receiver(msg), matches[1], ok_cb, cb_extra)
end


return 
{
	descripiton="",
	patterns={"^[!/]nome (.*)"},
	run=run
}
