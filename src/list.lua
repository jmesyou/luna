
List = {}
List.__index = List

function List.new(table)
	local list = {}
	setmetatable(list, List)
	list.array = table or {}
	return list
end

function List:length()
	return #self.array
end

function List:append(data)
	if (type(data) ~= "table" and getmetatable(data) ~= "List") then
		table.insert(self.array, data)
	else
		self:concat(data)
	end
	return self
end

function List:cons(data)
	if (type(data) ~= "table" and getmetatable(data) ~= "List") then
		table.insert(self.array, data, 1)
		return self
	end
	if (getmetatable(data) ~= "List") then
		newList = List.new(data)
		newList:concat(self)
		return newList
	else
		data:concat(self)
		return data
	end
end

function List:head()
	local obj = self.array[1]
	return obj
end

function List:tail()
	local tailOfList = List.new()
	for i = 2, #self.array do
		tailOfList:append(self.array[i])
	end
	return tailOfList
end

function List:concat(list)
	for i = 1, #list.array do
		self:append(list.array[i])
	end
	return self
end

function List:print()
	for key, value in pairs (self.array) do
		io.write(value, " ")
	end
	io.write("\n")
end

function test_cases()
	lista = List.new({2,3,4,5})
	lista:print()

	lista:cons(1)
	lista:print()

	lista:append(6)
	lista:print()

	listb = List.new({7,8,8.9999,"ten"})
	listb:print()

	lista:append(listb)
	lista:print()

	listatail = lista:tail()
	listatail:print()

	print(listatail:head())

	listc = lista:cons({-1,0})
	listc:print()
end

test_cases()
