do
local mime = require("mime")

local cache = {}

local api_keys = _config.google_apis

function get_google_data(text)

  local url = "https://www.googleapis.com/customsearch/v1?"
  url = url.."cx=006518944303354753471:um8whdniwke"
  url = url.."&searchType=image"
  url = url.."&q="..URL.escape(text)

  local i = math.random(#api_keys)

  if api_keys then
    url = url.."&key="..api_keys[i]
  end

  print(url)

  local res, code = https.request(url)

  if code ~= 200 then
    print("HTTP Error code:", code)
    return nil
  end

  local google = json:decode(res)
  return google
end

-- Returns only the useful google data to save on cache
function simple_google_table(google)
  local new_table = {}
  new_table.responseData = {}
  new_table.responseDetails = google.responseDetails
  new_table.responseStatus = google.responseStatus
  new_table.responseData.results = {}
  local results = google.responseData.results
  for k,result in pairs(results) do
    new_table.responseData.results[k] = {}
    new_table.responseData.results[k].unescapedUrl = result.unescapedUrl
    new_table.responseData.results[k].url = result.url
  end
  return new_table
end

function save_to_cache(query, data)
  -- Saves result on cache
  if string.len(query) <= 7 then
    local text_b64 = mime.b64(query)
    if not cache[text_b64] then
--      local simple_google = simple_google_table(data)
      cache[text_b64] = data
    end
  end
end

function process_google_data_dont_send(google, receiver, query)

  if not google or not google.items or #google.items == 0 then
    local text = 'n achei'
    send_msg(receiver, text, ok_cb, false)
    return false
  end

  local i = math.random(#google.items)
  local url = google.items[i].link

  return url
  --[[local old_timeout = https.TIMEOUT or 10
  http.TIMEOUT = 10
  send_photo_from_url(receiver, url)
  http.TIMEOUT = old_timeout

  save_to_cache(query, google)--]]

end

function process_google_data(google, receiver, query)

  if not google or not google.items or #google.items == 0 then
    local text = 'n achei'
    send_msg(receiver, text, ok_cb, false)
    return false
  end

  local i = math.random(#google.items)
  local url = google.items[i].link
  local old_timeout = https.TIMEOUT or 10
  http.TIMEOUT = 10
  send_msg(receiver, "AE pora ta aki a imag......", ok_cb, false)
  send_photo_from_url(receiver, url)
  http.TIMEOUT = old_timeout

  save_to_cache(query, google)

end

function run(msg, matches)
  if is_from_original_chat(msg) then
    local receiver = get_receiver(msg)
    local text = matches[1]
    local text_b64 = mime.b64(text)
    local cached = cache[text_b64]
    if cached then
      process_google_data(cached, receiver, text)
    else
      local data = get_google_data(text)
      process_google_data(data, receiver, text)
    end
  end
end

return {
  description = "Search image with Google API and sends it.",
  usage = "!img [term]: Random search an image with Google API.",
  patterns = {
    "^!img (.*)$"
  },
  run = run
}

end
