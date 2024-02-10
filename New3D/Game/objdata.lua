--[[
------------------------------------------------------------------------------
Wavefront Object Loader is licensed under the MIT Open Source License.
(http://www.opensource.org/licenses/mit-license.html)
------------------------------------------------------------------------------

Copyright (c) 2014 Landon Manning - LManning17@gmail.com - LandonManning.com

Permission is hereby granted--- blah blah shut the fuck up law boy
gayass


]]--

local path = ... .. "."
local loader = {}

loader.version = "0.0.2"

function loader.load(file)
	assert(file_exists(file), "File not found: " .. file)

	local get_lines

	if love then
		get_lines = love.filesystem.lines
	else
		get_lines = io.lines
	end

	local lines = {}

	for line in get_lines(file) do 
		table.insert(lines, line)
	end

	return loader.parse(lines)
end

function loader.parse(object)
	local verts = {}

	for _, line in ipairs(object) do
		local l = string_split(line, "%s+")
		
		if l[1] == "v" then
			local v = {
				x = tonumber(l[2]),
				y = tonumber(l[3]),
				z = tonumber(l[4]),
			}
			table.insert(verts, v)
		end
	end

	return verts
end

function file_exists(file)
	if love then return love.filesystem.getInfo(file) ~= nil end

	local f = io.open(file, "r")
	if f then f:close() end
	return f ~= nil
end

-- http://wiki.interfaceware.com/534.html
function string_split(s, d)
	local t = {}
	local i = 0
	local f
	local match = '(.-)' .. d .. '()'
	
	if string.find(s, d) == nil then
		return {s}
	end
	
	for sub, j in string.gmatch(s, match) do
		i = i + 1
		t[i] = sub
		f = j
	end
	
	if i ~= 0 then
		t[i+1] = string.sub(s, f)
	end
	
	return t
end

return loader
