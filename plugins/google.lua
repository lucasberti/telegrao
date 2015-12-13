function googlethat(query)
  local api        = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&"
  local parameters = "&lr=lang_pt&q=".. (URL.escape(query) or "")

  -- Do the request
  local res, code = https.request(api..parameters)
  if code ~=200 then return nil  end
  local data = json:decode(res)
  local results={}
  for key,result in ipairs(data.responseData.results) do
    table.insert(results,{result.titleNoFormatting, result.url})
  end
  return results
end

function stringlinks(results)
  local stringresults=""
  for key,val in ipairs(results) do
	cleanup_html(val[1])
	cleanup_html(val[2])
    stringresults=stringresults..cleanup_html(val[1]).." - "..cleanup_html(val[2]).."\n"
  end
  return stringresults
end

function cleanup_html(text)

  local cleaner = {
    { "&nbsp;", " " },
    { "&amp;", "&" }, 
	{ "&quot;", "\"" },
    { "&#151;", "-" }, 
    { "&#146;", "'" }, 
    { "&#147;", "\"" }, 
    { "&#148;", "\"" }, 
    { "&#150;", "-" }, 
    { "&#160;", " " }, 
    { "<br ?/?>", "\n" }, 
    { "</p>", "\n" }, 
    { "(%b<>)", "" }, 
    { "\r", "\n" }, 
    { "[\n\n]+", "\n" }, 
    { "^\n*", "" }, 
	{ "%%3F", "?" },
	{ "%%3D", "=" },
    { "\n*$", "" }, 
  }

  
  for i=1, #cleaner do
    local cleans = cleaner[i]
    text = string.gsub(text, cleans[1], cleans[2])
  end

  return text
end

function run(msg, matches)
  vardump(matches)
  local results = googlethat(matches[1])
  return stringlinks(results)
end

return {
  description = "Searches Google and send results",
  usage = "!google [terms]: Searches Google and send results",
  patterns = {
    "^!google (.*)$",
    "^%.[g|G]oogle (.*)$"
  },
  run = run
}
