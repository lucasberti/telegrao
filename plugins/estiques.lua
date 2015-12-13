function run(msg, matches)

	local rootpath = "./data/estiques/"

	if messageToAllowed(msg.to.id) == false then

		return ""

	end

	local receiver = get_receiver(msg)
	local file_path = rootpath .. matches[1] .. ".webp"

	if file_exists(file_path) == true then


		local cb_extra = {
			file_path = file_path,
			cb_function = cb_function,
			cb_extra = cb_extra
		}
		send_document(receiver, file_path, ok_cb, cb_extra)
	end

end

function messageToAllowed(id)
	local response = true

	return response
end

function get_personal_receiver(msg)
  if msg.to.type == 'user' then
    return 'user#id'..msg.to.id
  end
  if msg.to.type == 'chat' then
    return 'chat#id'..msg.to.id
  end
end

return {
    description = "load custom stickers", 
    usage = "/sticker [sticker-name]",
    patterns = {
    		"^(.*)$"
    	}, 
    run = run 
}