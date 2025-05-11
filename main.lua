print("Hello world")
-- semicolumns are not necessary like js

local name = "vinit kumar" -- by default variables in lua are global for local variables you have to specify local keyword

function SayHello() -- {} are not used in lua
	return "Hello " .. name -- .. is concentation operator
end
print(SayHello())

-- everything in lua is table like everything in js is objects, table have parent called metatable like prototypes in js
local numbers = {
	10,
	20,
	30,
	40,
} -- array of numbers, also arrays in lua are 1 indexed

for index, number in pairs(numbers) do -- pairs returns a pair of index and value of an array
	print("Index: " .. index)
	print("Value: " .. number)
end

local person = {
	name = "Vinit",
	age = 20,
	address = "Dobra, Jhunjhunu, Rajasthan, India",
} -- key valu pairs in lua uses = instead of : like js

print(person.name, person.age, person.address)

local Person = {
	status = "alive",
} -- classes in lua doesn't exists but you can achieve calsses using metatables and tables

Person.__index = Person -- Set up the metatable for method lookups

function Person.new(name, age)
	local newPerson = {
		name = name,
		age = age,
	}

	setmetatable(newPerson, Person)

	return newPerson
end

function Person:getname() -- here we used : instead of . befause : gives us a additional self by passing Person as an argument by default, you can use . but then you have to pass Person as parameter and also you can't use self you have to do return Person.name also while using the vinti.getname you will have to pass vinit as first argument
	return self.name
end

function Person:getage()
	return self.age
end

local vinit = Person.new("Vinit", 20)

print(vinit:getname(), vinit:getage(), Person.status)

local people = { vinit }

local deepak = Person.new("Deepak", 20)

table.insert(people, deepak) -- insert is used to insert items to an array, if you pass two arguments then the first argument should be table (which is array) and second should be the value but if you are passing three arguments then the firts will be table second will be position and the third will be the value
table.remove(people, 1) -- removes the first element of the table (which is vinit here)

for _, prsn in pairs(people) do
	print(prsn:getname() .. " is " .. prsn:getage() .. " years old and " .. Person.status)
end
