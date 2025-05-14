--Metatables allow you to change the behavior of tables — e.g., how they respond to operators, how they're indexed, etc.

--They're like "meta-behavior" that defines how tables act under special conditions.

--Metatables and metamethods

-- __index => Used for inheritance or default behavior.

local fallback = { a = 1 }

local t = {}
setmetatable(t, { __index = fallback })

print(t.a) --> 1 (found in fallback)
print(t.b) --> nil

-- Can also be a function:

setmetatable(t, {
	__index = function(tbl, key)
		return "default"
	end,
})
print(t.anything) --> "default"

-- __newindex => Custom behavior when assigning new keys

local t = {}

setmetatable(t, {
	__newindex = function(tbl, key, value)
		print("Setting " .. key .. " to " .. value)
		rawset(tbl, key, value) -- avoid infinite loop
	end,
})

t.x = 10 --> prints: Setting x to 10

-- Operator Overloading

-- __add – Overload +

local mt = {
	__add = function(a, b)
		return { x = a.x + b.x, y = a.y + b.y }
	end,
}

local v1 = { x = 1, y = 2 }
local v2 = { x = 3, y = 4 }

setmetatable(v1, mt)

local sum = v1 + v2
print(sum.x, sum.y) --> 4 6

-- __sub – Overload -

local mt = {
	__sub = function(a, b)
		return { x = a.x - b.x, y = a.y - b.y }
	end,
}

setmetatable(v1, mt)
local diff = v1 - v2
print(diff.x, diff.y) --> -2 -2

-- __mul – Overload *

local mt = {
	__mul = function(a, b)
		return a.value * b.value
	end,
}

local a = { value = 5 }
local b = { value = 3 }

setmetatable(a, mt)
print(a * b) --> 15

-- __div – Overload /

local mt = {
	__div = function(a, b)
		return a.val / b.val
	end,
}

local a = { val = 10 }
local b = { val = 2 }

setmetatable(a, mt)
print(a / b) --> 5

-- __mod, __pow – % and ^

-- % (modulo)
setmetatable(a, {
	__mod = function(a, b)
		return a.val % b.val
	end,
})
print(a % b) --> 0

-- ^ (power)
setmetatable(a, {
	__pow = function(a, b)
		return a.val ^ b.val
	end,
})
print(a ^ b) --> 100

-- __eq, __lt, __le – Comparison (==, <, <=)

local mt = {
	__eq = function(a, b)
		return a.id == b.id
	end,
	__lt = function(a, b)
		return a.value < b.value
	end,
}

local a = { id = 1, value = 10 }
local b = { id = 1, value = 20 }

setmetatable(a, mt)
setmetatable(b, mt)

print(a == b) --> true (same id)
print(a < b) --> true (value comparison)

-- __tostring – Custom string conversion

local t = { x = 5, y = 6 }

setmetatable(t, {
	__tostring = function(tbl)
		return "(" .. tbl.x .. ", " .. tbl.y .. ")"
	end,
})

print(t) --> (5, 6)

-- __call – Make table callable like a function

local t = {}

setmetatable(t, {
	__call = function(tbl, a, b)
		return a + b
	end,
})

print(t(3, 4)) --> 7
