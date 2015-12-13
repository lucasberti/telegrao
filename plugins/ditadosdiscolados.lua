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

function save_quote(msg)
    local to_id = tostring(msg.to.id)
	local name = get_name(msg)

    if msg.text:sub(11):isempty() then
        return "pora eh pra usa !addditado [ditado]"
    end

    if quotes_table == nil then
        quotes_table = {}
    end

    if quotes_table[to_id] == nil then
        quotes_table[to_id] = {}
    end

    local quotes = quotes_table[to_id]
    quotes[#quotes+1] = msg.text:sub(12)

    serialize_to_file(quotes_table, quotes_file)

    return "pora sauvei aki o ditado mun massa mun brigado eu cresci como 1 bot so de le isso ai"
end

function run(msg, matches)
	if string.match(msg.text, "!addditado (.+)$") then
        quotes_table = read_quotes_file()
        return save_quote(msg)
    end
end

return {
    description = "salva quote",
    usage = {
        "!addditado [msg]",
    },
    patterns = {
        "^!addditado (.+)$",
    },
    run = run,
	privileged = true
}