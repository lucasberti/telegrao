local isEnabled = false
local forWho = 0

local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    print(result)
    cmd:close()
    return result
end

local function ask(txt)
    return run_bash('/home/bot/.linuxbrew/bin/node /root/node_modules/cleverbot.io/test.js' .. ' ' .. txt)
end

local function run(msg, matches)
    if string.lower(matches[1]) == "clever" or string.lower(matches[1]) == "cleverbot" then
        forWho = msg.from.id
        isEnabled = true
        return ask("hello")

    elseif string.find(string.lower(matches[1]), "goodbye") or string.find(string.lower(matches[1]), "bye") or string.find(string.lower(matches[1]), "cya") then
        if msg.from.id == forWho then
            isEnabled = false 
            forWho = 0
            return ask("goodbye")
        end

    elseif isEnabled == true and msg.from.id == forWho then
        return ask(matches[1]:gsub("'", ""))

    elseif string.match(matches[1], "^[C|c]lever,? (.*)$") or string.match(matches[1], "^(.*) [C|c]lever[?]?$") then 
        return ask(matches[1]:gsub("'", ""))
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
