-- -*- coding: utf-8 -*-
--
local M = {}

function M.readfile(file)
    local conf = {}
     
    local fp = io.open(file, "r")

    if fp == nil then
        return "File doesn't exists"
    end

    for line in fp:lines() do
        line = line:match("%s*(.+)")
        if line and line:sub(1, 1) ~= "#" and line:sub(1, 1) ~= ";" then
     	option = line:match("%S+"):lower()
    	value  = line:match("=%S*%s*(.*)" ):gsub('["\']', '')
     
    	if not value then
     	    conf[option] = true
    	else
    	    if not value:find(",") then
    		conf[option] = value
    	    else
    		value = value .. ","
    		conf[option] = {}
    		for entry in value:gmatch("%s*(.-),") do
    		    conf[option][#conf[option]+1] = entry
    		end
    	    end
    	end
     
        end
    end
    fp:close()
    return conf     
end

function M.tostring(tbl)
    local function val_to_str(v)
        if "string" == type(v) then
            v = string.gsub(v, "\n", "\\n")
            if string.match(string.gsub(v,"[^'\"]",""), '^"+$') then
                return "'" .. v .. "'"
            end
            return '"' .. string.gsub(v,'"', '\\"') .. '"'
        else
            return "table" == type(v) and M.tostring(v) or tostring(v)
        end
    end
    
    local function key_to_str(k)
        if "string" == type(k) and string.match(k, "^[_%a][_%a%d]*$") then
            return k
        else
            return "[" .. val_to_str(k) .. "]"
        end
    end

    local result, done = {}, {}
    for k, v in ipairs(tbl) do
        table.insert(result, val_to_str(v))
        done[k] = true
    end
    for k, v in pairs(tbl) do
        if not done[k] then
            table.insert(result, key_to_str(k) .. "=" .. val_to_str(v))
        end
    end
    return "{" .. table.concat(result, ",") .. "}"
end

function M.encode_table(tbl)
    local str = ""

    local function char2hexcode(c)
        return string.format("%%%02X", string.byte(c))
    end

    local function escape(str)
        str = string.gsub(str, "\n", "\r\n")
        str = string.gsub(str, "([^0-9a-zA-Z_. -])", char2hexcode)
        str = string.gsub(str, " ", "+")
        return str
    end

    for key, vals in pairs(tbl) do
        if type(vals) ~= "table" then
            vals = {vals}
        end
        for k, val in pairs(vals) do
            str = str .. "&" .. escape(key) .. "=" ..escape(val)
        end
    end
    return string.sub(str,2)
end

return M
