do

local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"

local function get_weather(location)
  print("Finding weather in ", location)
  local url = BASE_URL
  url = url..'?q='..location
  url = url..'&units=metric'

  local b, c, h = http.request(url)
  if c ~= 200 then return nil end
  
  local weather = json:decode(b)
  local city = weather.name
  local country = weather.sys.country
  local temp = 'EITA PORA a tenps em '..city
    ..' (' ..country..')'
    ..' eh de '..weather.main.temp..'°C'
  local conditions = 'lá tá asim oh ::::: '
  
  if weather.weather[1].main == 'Clear' then
    conditions = conditions .. 'CLARIN CLARIN ☀'
  elseif weather.weather[1].main == 'Clouds' then
    conditions = conditions .. 'umas nuve ☁☁'
  elseif weather.weather[1].main == 'Rain' then
    conditions = conditions .. 'EITA TA CHOVENO ☔'
  elseif weather.weather[1].main == 'Thunderstorm' then
    conditions = conditions .. 'TA CHOVENO KNIVET CORRE BERG ☔☔☔☔'
  end

  return temp .. '\n' .. conditions
end

local function run(msg, matches)
  local city = 'Madrid,ES'

  if matches[1] ~= '!weather' then 
    city = matches[1]
  end
  local text = get_weather(city)
  if not text then
    text = 'Can\'t get weather from that city.'
  end
  return text
end

return {
  description = "weather in that city (Madrid is default)", 
  usage = "!weather (city)",
  patterns = {
    "^!weather$",
    "^!weather (.*)$",
    "^/weather$",
    "^/weather (.*)$"
  }, 
  run = run 
}

end