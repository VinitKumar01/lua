--Tables are the only data structure in Lua, and they are extremely flexible — they can be used as arrays, dictionaries (maps), objects, sets, records, etc.
--Array

local list = { "apple", "banana", "cherry" }
print(list[1]) -- "apple" (Lua arrays start at index 1)

--Dictionary (Key-Value Map)

local dict = {
	name = "Alice",
	age = 30,
	isStudent = false,
}
print(dict["name"]) -- "Alice"

-- Set

local set = {
	apple = true,
	banana = true,
}

if set["banana"] then
	print("banana is in the set")
end

-- Object/Class

local Person = {
	name = "",
	greet = function(self)
		print("Hello, my name is " .. self.name)
	end,
}

local p1 = { name = "Bob" }
setmetatable(p1, { __index = Person }) -- Inherit methods
p1:greet() -- "Hello, my name is Bob"
