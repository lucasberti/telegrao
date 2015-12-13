local _file_values = './data/lista_cs.lua'
local maximum = nil
local current = 0
local game = nil
local who = nil

function ok_cb(extra, success, result)
end

local function read_file_values( )

	local f = io.open(_file_values, "r+")

	if f == nil then
		print ('Crio os troxa do CS: '.._file_values)
		serialize_to_file({}, _file_values)
	else
		print ('Carrego os troxa do CS!!!!!: '.._file_values)
		f:close() 
	end
	
	return loadfile (_file_values)()
end

local _troxas_list = read_file_values()

local function save_value(chat, player, id )
	--estique_trigger = string.match(text, "(.+)")
	
	if _troxas_list[chat] == nil then
		_troxas_list[chat] = {}
	end
	_troxas_list[chat][id] = player

	serialize_to_file(_troxas_list, _file_values)
	
	return "ok salvei aqui o "..player
end

function run(msg, matches)
	chatid = tostring(msg.to.id)
	if string.find(matches[1], "!partida") then
		local newgame = matches[2]
		local num_slots = matches[3]
		maximum = tonumber(num_slots)
		current = 1
		save_value(chatid, msg.from.print_name, current)
		return 'NOAV PARITDA::: ' ..newgame.. ' com ' ..maximum - current.. ' eslots disponiveus!!!!!!!'
	end
end

return {
	description = "Lista de confirmados pro CS", 
	usage = {
		"!partida [jogo] [slots]",
		"!confirma",
		"!player [jogo] [nome]",
	},
	patterns = {
		"^(!partida) (.*) (d+)$",
		"^(!confirma)$",
		"^(!player) (.*)$",
	}, 
	run = run 
}