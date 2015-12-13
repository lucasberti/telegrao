local quotes_file = './data/quotes.lua'
local quotes_table

function read_quotes_file()
    local f = io.open(quotes_file, "r+")

    if f == nil then
        print ('Created a new quotes file on '..quotes_file)
        serialize_to_file({}, quotes_file)
    else
        print ('Quotes loaded: '..quotes_file)
        f:close()
    end
    return loadfile (quotes_file)()
end

function get_quote(msg)
    local to_id = tostring(msg.to.id)
    local quotes_phrases

    quotes_table = read_quotes_file()
    quotes_phrases = quotes_table[to_id]

    return quotes_phrases[math.random(1,#quotes_phrases)]
end

function run(msg, matches)
    if string.match(msg.text, "!ditadodiscolado$") then
        return get_quote(msg)
	end
end

return {
    description = "pega quote",
    usage = {
    },
    patterns = {
        "^!ditadodiscolado$",
    },
    run = run
}