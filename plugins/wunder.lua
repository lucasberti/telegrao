do

local BASE_CONDITIONS = "http://api.wunderground.com/api/dbcee4e7c140bb2d/lang:BR/conditions/q/"
local BASE_FORECAST = "http://api.wunderground.com/api/dbcee4e7c140bb2d/lang:BR/forecast/q/"
local BASE_SATELLITE = "http://api.wunderground.com/api/dbcee4e7c140bb2d/animatedsatellite/q/"

local function processConditions(conditions)
	if conditions == "" then
		return "pora n sei n da pra ve"

	elseif conditions == "Bruma" then
		return "VEI TA TD BRAMCO"
	
	elseif conditions == "Céu Limpo" then
		return "LINPIN LINPJIN"

	elseif conditions == "Céu Encoberto" then
		return "ceu coberto con 1 endredonm"

	elseif conditions == "Chuva" then
		return "i vai chove em"

	elseif conditions == "Chuva Fraca" then
		return "una chuvinia lvevina"

	elseif conditions == "Chuviscos Fracos" then
		return "una chuvinia fraquinia hummmmmmmmm"

	elseif conditions == "Muito Nublado" then
		return "muitas nuve"

	elseif conditions == "Neblina" then
		return "presemsa d esnop dog"

	elseif conditions == "Nuvens Dispersas" then
		return "umas nove espalhada"

	elseif conditions == "Parcialmente Nublado" then
		return "1as nuve por ai"

	elseif conditions == "Possibilidade de Chuva" then
		return "vix tauves vai cai umas agua"

	elseif conditions == "Possibilidade de Trovoada" then
		return "i tauves vai da us trovao em"

	elseif conditions == "Trovoada" then
		return "vei vai da ums trovao mASA"

	elseif conditions == "Trovoadas com Chuva" then
		return "1s trovao c chuv"

	elseif conditions == "Trovoadas Fracas e Chuva" then
		return "troamvãoiizn i xhuvaaaaa"
	
	else
		return conditions
	end
end

local function getForecast(city, country)
	local CURRENT_HOUR = tonumber(os.date("%H"))
	
	local url = BASE_FORECAST
	url = url..country..'/'..city..'.json'	

	local b, c, h = http.request(url)
	if c ~= 200 then return nil end
  
	local resp = json:decode(b)
	print(CURRENT_HOUR)

	if CURRENT_HOUR > 17 then
		local forecast_max = resp.forecast.simpleforecast.forecastday[2].high.celsius
		local forecast_min = resp.forecast.simpleforecast.forecastday[2].low.celsius

		local pop = resp.forecast.simpleforecast.forecastday[2].pop

		local conditions = processConditions(resp.forecast.simpleforecast.forecastday[2].conditions)

		return "\n\ni sera q vai chove amanh??????\n" .. conditions .. " con una prporlbindade d presiispatasao d " .. pop .. "\nmásima d " .. forecast_max .. " minim d " .. forecast_min
	else
		local forecast_max = resp.forecast.simpleforecast.forecastday[1].high.celsius
		local forecast_min = resp.forecast.simpleforecast.forecastday[1].low.celsius

		local pop = resp.forecast.simpleforecast.forecastday[1].pop

		local conditions = processConditions(resp.forecast.simpleforecast.forecastday[1].conditions)

		return "\n\ni sera q vai chove hj????\n" .. conditions .. " con una prporlbindade d presiispatasao d " .. pop .. "\nmásima d " .. forecast_max .. " minim d " .. forecast_min
	end
end

local function getWeather(city, country, msg)
	print("Finding weather in " .. city .. ' ' .. country)
	local url = BASE_CONDITIONS
	url = url..country..'/'..city..'.json'

	local b, c, h = http.request(url)
	if c ~= 200 then return nil end
  
	local resp = json:decode(b)

	local cityname = resp.current_observation.display_location.full
	local temp_c = tostring(resp.current_observation.temp_c)
	local feels_c = resp.current_observation.feelslike_c
	local weather = resp.current_observation.weather
	local station = resp.current_observation.observation_location.city
	local obs_time = resp.current_observation.observation_time_rfc822
	local humidity = resp.current_observation.relative_humidity
	local wind_vel = tostring(resp.current_observation.wind_kph)
	local wind_from = resp.current_observation.wind_dir

	local forecast_string = getForecast(city, country)

	-- Mapa a cores, horário das imagens, 5 frames, 500ms de delay, raio de 500km, bordas do país, satélite infravermelho
	local satellite_url = BASE_SATELLITE..country..'/'..city..'.gif?basemap=1&timelabel=1&timelabel.y=10&num=5&delay=50&radius=500&radunits=km&borders=1&key=sat_ir4'	
	send_document_from_url(get_receiver(msg), satellite_url) 


	local temp = 'EITA PORA a tenps em '..cityname..
	' eh d ' ..temp_c.. ' con uma sensasaosinha d ' ..feels_c ..'\n'..
	'a parti da estasao meteurolojics la em ' ..station..
	' em ' .. obs_time:sub(6, 25) ..'\n'..
	'umanidade di ' ..humidity ..'\n'..
	'uns veto vino a ' ..wind_vel.. ' narizes do retcha/h de ' ..wind_from ..'\n'..
	'atlamente la ta ó::::::: ' ..processConditions(weather)..forecast_string
 
	return temp .. '\n'
end

local function run(msg, matches)
	user_id = tostring(msg.from.id)

	if msg.text == "!wunder" or msg.text == "/wunder" or msg.text == "/wunder@PintaoBot" then

		-- Eu
		if user_id == "14160874" then
			return getWeather("presidente bernardes", "br", msg)
		end

		-- Bea
		if user_id == "16631085" then
			return getWeather("guaramirim", "br", msg)
		end

		-- Farinha
		if user_id == "16259040" then
			return getWeather("pws:INITERI3", "br", msg)
		end

		-- Geta
		if user_id == "25919148" then
			return getWeather("lages", "br", msg)
		end

		-- X
		if user_id == "52451934" then
			return getWeather("pws:ISOPAULO152", "br", msg)
		end

		-- Burn
		if user_id == "177436074" then
			return getWeather("sbur", "br", msg)
		end

		-- Tiko
		if user_id == "80048195" then
			return getWeather("pws:ICURITIB6", "br", msg)
		end

		-- Springles
		if user_id == "121326431" then
			return getWeather("bage", "br", msg)
			--return getWeather("pws:ISOPAULO61", "br", msg)
		end

		-- Arroz
		if user_id == "35072014" then
			return getWeather("pws:ISOPAULO141", "br", msg)
		end

		-- Tadeu
		if user_id == "49681384" then
			return getWeather("SBSP", "br", msg)
		end

		-- Fabio
		if user_id == "77677283" then
			return getWeather("lages", "br", msg)
		end

		-- Raul
		if user_id == "85867003" then
			return getWeather("marau", "br", msg)
		end

		-- Miojo
		if user_id == "43299772" then
			return getWeather("ilha solteira", "br", msg)
		end

		-- -> Aehoo <--
   	        -- Criativo (Pedro Lucas/PL)
			if user_id == "26867717" then
	  			return getWeather("SBMT", "br", msg)
			end

			-- Riogi
			if user_id == "71514705" then
	  			return getWeather("SBMT", "br", msg)
			end

			-- Matheus Santana
			if user_id == "82091383" then
	  			return getWeather("pws:ISOPAULO61", "br", msg)
			end

			-- Yama (Fernando Hideki Yamamoto)
			if user_id == "120788811" then
	  			return getWeather("SBSP", "br", msg)
			end

			-- 2berto (Humberto M. M. Duarte)
		    if user_id == "24975729" then
		      	return getWeather("SBSL", "br", msg)
		    end

			-- Ana
		    if user_id == "158330365" then
		      	return getWeather("pws:ISOPAULO143", "br", msg)
		    end

			-- Brendow
		    if user_id == "102544375" then
		      	return getWeather("SBMG", "br", msg)
		    end

			-- Monegat
		    if user_id == "52433246" then
		      	return getWeather("SBMG", "br", msg)
		    end

	end

	if #matches == 1 then
		local text = getWeather(matches[1], "br", msg)
		return text
	end

	if #matches == 2 then
		local text = getWeather(matches[1], matches[2], msg)
		return text
	end

end

return {
	description = "wunderground", 
	usage = "!wunder (cidade), (sigla do pais)",
	patterns = {
		"^!wunder (.*), (.*)$",
		"^!wunder (.*)$",
		"^!wunder$",
		"^/wunder$",
		"^/wunder@PintaoBot$",
		"^/wunder (.*), (.*)$",
		"^/wunder (.*)$"
	}, 
	run = run 
}

end
