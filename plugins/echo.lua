function run(msg, matches)
  if is_from_original_chat(msg) then
    send_msg("chat#id11672208", matches[1], cb_ok, false)
  end

  send_msg("user#id14160874", get_name(msg).. ' disse: ' ..matches[1], cb_ok, false)
  --return "oops, temporariamente desativado!"
end

return {
    description = "echoes the msg", 
    usage = "!echo [whatever]",
    patterns = {"^!echo (.*)$"}, 
    run = run 
}
