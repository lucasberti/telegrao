local _file_values = './data/estiquesdb.lua'
local step = 0
local who = nil

function ok_cb(extra, success, result)
end

local function read_file_values( )
	chat_info("chat#id11672208")
	chat_info("chat#id9841772")
	
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

function run(msg, matches)
	local chat_id = tostring(msg.to.id)	
	local msg_text = matches[1]
	
	if msg.text == '!forcaestiques' then
		read_file_values( )
	end
	
	if string.find(string.lower(matches[1]), "novo estique") and step == 0 then
		who = msg.from.print_name
		step = 1
		return 'ok esto esperadon qual o estiquers em ' .. who
	end
	
	if string.find(string.lower(matches[1]), "carrega os estique") then 
		read_file_values( )
		return 'belesinha'
	end
	
	if string.find(string.lower(matches[1]), "cancela") and (step == 1 or step == 2) and msg.from.print_name == who then
		who = nil
		step = 0
		return 'pora eu achava q ia fase 1 estique bem amssinha pro xet assimmas pelo visot fui decepsioanado?'
	end
	
	if msg.from.print_name == who and step == 1 then
		step = 2
		estique_id = tostring(msg.id)
		return 'belesinha agr qual o comando pro estike' 	
	end
	
	if msg.from.print_name == who and step == 2 then
		save_value(chat_id, msg.text, estique_id)
		step = 0
		who = nil
		return 'ok sauvei o estike!!!!!!!!'
	end
		
	for k, v in pairs(_config_estiques[chat_id]) do
		if msg_text == v then
			print('ACHEYTTTTTYYYYYY ' .. k .. ' é id da mensagem ' .. v)
			fwd_msg(get_receiver(msg), k, ok_cb, false)
			print('forwardado pra ' ..get_receiver(msg).. ' o ' ..k)
		end
	end
end

return {
    description = "", 
    usage = "",
    patterns = {
	"^(.*)$"
	}, 
    run = run 
}

