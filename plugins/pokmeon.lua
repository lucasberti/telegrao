inprogress = false
pick = 0
lasthit = 0
primeirodono = nil
segundodono = nil

function doPoke(nomezinho, user)
	pick = 0

	local porcemao = {}
	
	porcemao.nome = nomezinho
	porcemao.HP = 1000
	porcemao.dono = user
	
	function porcemao:setName(nm)
		porcemao.nome = nm
	end
	
	function porcemao:getName()
		return porcemao.nome
	end
	
	function porcemao:setHP(vl)
		porcemao.HP = vl
	end
	
	function porcemao:getHP()
		return porcemao.HP
	end

	function porcemao:setOwner(ow)
		porcemao.dono = ow
	end
	
	function porcemao:getOwner()
		return porcemao.dono
	end
	
	return porcemao
end


function run(msg, matches)
	receiver = get_receiver(msg)
	nome = msg.from.print_name

	--if not inprogress then	

		if matches[1] == '!pokemon' then
			print 'oi porra'
			return 'Use !pokemon [pick] [nome] e depois !pokemon [use] [qualquer ataque]'
		end

	  	if matches[1] == 'pick' then
			if pick == 0 then
				pokeUm = doPoke(matches[2], nome)
				pick = 1
				return '' ..nome.. ' escolheu o primeiro pokemon! O nome é ' ..pokeUm:getName().. ' e tem ' ..tostring(pokeUm:getHP()).. ' HP!'
			end
			if pick == 1 then
				pokeDois = doPoke(matches[2], nome)
				pick = 2
				return '' ..nome.. ' escolheu o segundo pokemon! O nome é ' ..pokeDois:getName().. ' e tem ' ..tostring(pokeDois:getHP()).. ' HP!'
			end
	  	end
		
		if matches[1] == 'use' then
			if pokeUm:getOwner() == msg.from.print_name or pokeDois:getOwner() == msg.from.print_name then
				if pokeUm:getOwner() == msg.from.print_name and (lasthit == 0 or lasthit == 2) then
					doAtaque(pokeUm:getName(), matches[2], 'poke2')
					lasthit = 1
				end				
				if pokeDois:getOwner() == msg.from.print_name and lasthit == 1 then
					doAtaque(pokeDois:getName(), matches[2], 'poke1')
					lasthit = 2
				end
			else
				return 'qual ' ..pokeUm:getOwner().. ' quem ' ..msg.from.print_name.. ' SAI DAQUI TU NAO PERTENCE A ESSA BATALHA!!!!1!11'
			end
		end
		
		if matches[1] == 'debug' then
			return 'Poke1 ' .. pokeUm:getOwner() ..' poke2 ' .. pokeDois:getOwner() .. ' print ' .. msg.from.print_name
		end

		if matches[1] == 'hp1' then
			return tostring(pokeUm:getHP())
		end
		
		if matches[1] == 'hp2' then
			return tostring(pokeDois:getHP())
		end
		
		if matches[1] == 'cancela' then
			doRestart()
			return 'resetadinho belesinha'
		end
			
	--else
	--	return 'Uma partida já está em progresso!'
	--end
end

function doAtaque(quem, atk, target)	
	dano = math.random(20, 400)
	if checkFinal() == 0 then
		if target == 'poke2' then
			print("1")
			pokeDois:setHP(pokeDois:getHP() - dano)
			print("2")
			--return '' .. 'A'
			send_msg(receiver, '' ..pokeUm:getName().. ' (' ..tostring(pokeUm:getHP()).. ' HP) usou ' ..atk.. ' e deu ' ..tostring(dano).. ' de dano em ' ..pokeDois:getName().. ' (' ..tostring(pokeDois:getHP()).. ' HP)!', ok_cb, false)
		end

		if target == 'poke1' then
			print("21")
			pokeUm:setHP(pokeUm:getHP() - dano)
			checkFinal()
			print("22")
			send_msg(receiver, '' ..pokeDois:getName().. ' (' ..tostring(pokeDois:getHP()).. ' HP) usou ' ..atk.. ' e deu ' ..tostring(dano).. ' de dano em ' ..pokeUm:getName().. ' (' ..tostring(pokeUm:getHP()).. ' HP)!', ok_cb, false)
		end
	end
end

function checkFinal()
	if pokeUm:getHP() <= 0 and pokeDois:getHP() > 0 then
		send_msg(receiver, 'aprabens ' ..pokeDois:getOwner().. ' o ' ..pokeDois:getName().. ' ganhou com ' ..pokeDois:getHP().. ' HP!', ok_cb, false)
		doRestart()
		return 2
	end
	if pokeDois:getHP() <= 0 and pokeUm:getHP() > 0 then
		send_msg(receiver, 'aprabens' ..pokeUm:getOwner().. ' o ' ..pokeUm:getName().. ' ganhou com ' ..pokeUm:getHP().. ' HP!', ok_cb, false)
		doRestart()
		return 1
	end
	if pokeDois:getHP() > 0 and pokeUm:getHP() > 0 then
		return 0
	end
end

function doRestart()
	pokeUm:setHP(1000)
	pokeUm:setName(nil)
	pokeUm:setOwner(nil)
	
	pokeDois:setHP(1000)
	pokeDois:setName(nil)
	pokeDois:setOwner(nil)
	
	pick = 0
	lasthit = 0
end
---

return {
	description = "POKEMOOOON", 
	usage = "!pokemon pick1/2 [whatever], !pokemon use1/2 [whatever]",
	patterns = {
		"^!pokemon$",
		"^!pokemon (pick) (.*)$",
		"^!pokemon (pick1) (.*)$",
		"^!pokemon (pick2) (.*)$",
		"^!pokemon (use) (.*)$",
		"^!pokemon (use1) (.*)$",
		"^!pokemon (use2) (.*)$",
		"^!pokemon (hp1)$",
		"^!pokemon (hp2)$",
		"^!pokemon (debug)$",
		"^!pokemon (cancela)$" }, 
	run = run 
}