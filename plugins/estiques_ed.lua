local _file_values = './data/estiquesdb.lua'

local API_key = load_from_file("data/config.lua")

local step = 0
local current_update = 0
local who = nil
local sticker_id = nil

local global_msg = nil

local secs = 0

local can_skip = false

local BASE_URL = "https://api.telegram.org/" .. API_key.telegram_api .. "/"


function ok_cb(extra, success, result)
end

local function read_file_values( )
	
	local f = io.open(_file_values, "r+")

	if f == nil then
		print ('Crio os estique: '.._file_values)
		serialize_to_file({}, _file_values)
	else
		print ('Carrego os estique!!!!!: '.._file_values)
		f:close() 
	end
	
	return loadfile (_file_values)()
end

local _config_estiques = read_file_values()

local function save_value(chat, text, msg_id )
	estique_trigger = string.match(text, "(.+)")
	
	if _config_estiques[chat] == nil then
		_config_estiques[chat] = {}
	end
	_config_estiques[chat][msg_id] = estique_trigger

	serialize_to_file(_config_estiques, _file_values)
	
	return "ok salvei aqui o "..estique_trigger
end

local function sendSticker(to, sticker_input)
	local url = BASE_URL .. "sendSticker"
	local params = {
		chat_id = to,
		sticker = sticker_input
	}
	
	local query = format_http_params(params, true)
	local url = url..query
	
	https.request(url)
end

local function createStickerProcess(input, msg_global)
	if (msg_global.text == "novo estique" or msg_global.text == "/novoestique") and step == 0 then
		who = input.message.from.first_name
		step = 1
		print(who)
		send_msg(get_receiver(msg_global), 'ok esto esperadon qual o estiquers em ' .. who, ok_cb, false)	

	-- ------- START MOD  
	elseif (msg_global.text == "cancela" or msg_global.text == "Cancela") and step > 0 and input.message.from.first_name == who then
		send_msg(get_receiver(msg_global), "pora eu achava q ia fase 1 estique bem amssinha pro xet assimmas pelo visot fui decepsioanado?", ok_cb, false)
		step = 0
		who = nil	
	-- -------- END MOD	

	elseif step == 1 and input.message.from.first_name == who then 
		if input and input.message and input.message.sticker and input.message.sticker.file_id then
			sticker_id = input.message.sticker.file_id
			send_msg(get_receiver(msg_global), "VEI Q ESTIKERS MASSA!!! cual o comado pra ele em " ..who.. " to curiosa", ok_cb, false)
			step = 2
		else
			send_msg(get_receiver(msg_global), "ow vei q pora e essa iso nem e sticke vai se fode!!! camselei a criasao cusao", ok_cb, false)
			step = 0
			who = nil
		end
		
	elseif step == 2 and input.message.from.first_name == who then 
		save_value(tostring(input.message.chat.id), msg_global.text, sticker_id)
		send_msg(get_receiver(msg_global), "KKKKKKKK ke comado loko kkkkk \"" ..msg_global.text.. "\" kkkkk boa sauvei aki XD", ok_cb, false)
		who = nil
		step = 0
	end
end

local chat_id_n

local function findMessageInAPI(off, msg)
	--print("valor do current_update: " .. tostring(current_update))
	local url = BASE_URL .. "getUpdates"
	local params = {
		offset = tostring(off),
		timeout = "5"
	}
	
	local query = format_http_params(params, true)
	local url = url..query
	--print(url)
	
	local res, code = https.request(url)
	local resp = json:decode(res)
	
	for _,v in pairs(resp.result) do
		if current_update < v.update_id then
			current_update = v.update_id
		
			local file = io.open("./data/ed_reborn.txt", "w")
			file:write(tostring(v.update_id))
			file:close()
			
			--print("current_update agora é " .. tostring(current_update))
			
			chat_id_n = tostring(v.message.chat.id)
			createStickerProcess(v, msg)
		end
	end
end

function run(msg, matches)
	local msg_text = matches[1]
	local chat_id = "-" .. tostring(msg.to.id)	

	global_msg = msg

	local cu = io.open("./data/ed_reborn.txt", "r")
	current_update = tonumber(cu:read("*a"))
	cu:close()

	if (msg.text == "novo estique" or msg.text == "/novoestique") and can_skip == false then
		can_skip = true
		print(can_skip)
	end

	if can_skip then
		findMessageInAPI(current_update, msg)
	end

	if _config_estiques[chat_id] then
		for k, v in pairs(_config_estiques[chat_id]) do
			if msg_text == v then
				print('ACHEYTTTTTYYYYYY ' .. k .. ' é id da mensagem ' .. v)
				--fwd_msg(get_receiver(msg), k, ok_cb, false)
				sendSticker(tonumber(chat_id), k)
				print('forwardado pra ' ..get_receiver(msg).. ' o ' ..k)
			end
		end
	end
end

function cron()
	--print(secs)

	if step == 0 then
		secs = secs + 1

		if secs == 3 then
			
			if global_msg ~= nil then
				findMessageInAPI(current_update, global_msg)
			end

			secs = 0
		end
	else
		secs = 0
	end
end

return {
    description = "", 
    usage = "",
    patterns = {
	"^(.*)$"
	}, 
	cron = cron,
    run = run
}

