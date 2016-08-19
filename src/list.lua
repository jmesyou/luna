
-- TODO Fold

-- DEPRECATED FUNCTIONS
-- Length -> default to #


List = {}
List.mt = {}

function List.new(table)
	local list = table
	setmetatable(list, List.mt)
	return list
end

function List.append(list, obj)
	table.insert(list, obj)
	return list
end

function List.cons(head, tail)
    table.insert(tail, head, 1)
    return tail
end

function List.head(list)
	local obj = list[1]
	return obj
end

function List.tail(list)
	local tail = List.new({})
    for i = 2, #list do
        tail[i] = list[i]
    end
	return tail
end

function List.concat(lst1, lst2)
	for i = 1, #lst2 do
		List.append(lst1,  lst2[i])
	end
	return lst1
end

function List.mt:__tostring()
    local str = "["
	for i = 1, #self-1 do
		str = str .. tostring(self[i]) .. ", "
	end
	return str .. self[#self] .. "]"
end

list = List.new({})
print(getmetatable(list) == List.mt)

--[[
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

]]--
