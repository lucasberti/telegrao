
--[[
-- Translate text using Google Translate.
-- http://translate.google.com/translate_a/t?client=z&ie=UTF-8&oe=UTF-8&hl=en&tl=en&text=hello
--]]
do

function translate(source_lang, target_lang, query)
  local path = "https://translate.yandex.net/api/v1.5/tr.json/translate?"
  -- URL query parameters


  local params = {
    lang = "pt",
    key = _config.yandex_api,
    text = URL.escape(query)
  }

  local query = format_http_params(params, true)
  local url = path..query

  local res, code = https.request(url)
  -- Return nil if error
  if tonumber(code) > 200 then return nil end
  
  local trans = json:decode(res)
  print(trans)
  
  --[[local sentences = ""
  -- Join multiple sencentes
  for k,translatedResults in pairs(trans.text) do
    sentences = sentences .. translatedResults..'\n'
  end--]]

  return trans.text[0]
end

function run(msg, matches)
  -- Third pattern
  if #matches == 1 then
    print("First")
    local text = matches[1]
    return translate(nil, nil, text)
  end

  -- Second pattern
  if #matches == 2 then
    print("Second")
    local target = matches[1]
    local text = matches[2]
    return translate(nil, target, text)
  end

  -- Frist pattern
  if #matches == 3 then
    print("Third")
    local source = matches[1]
    local target = matches[2]
    local text = matches[3]
    return translate(source, target, text)
  end

end

return {
  description = "Translate some text", 
  usage = {
    "!translate text. Translate to english the text.",
    "!translate target_lang text.",
    "!translate source,target text",
  },
  patterns = {
    "^!translate ([%w]+),([%a]+) (.+)",
    "^!translate ([%w]+) (.+)",
    "^!translate (.+)",
  }, 
  run = run 
}

end