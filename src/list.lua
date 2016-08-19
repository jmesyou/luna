
-- TODO Fold

-- DEPRECATED FUNCTIONS
-- Length -> default to #


List = {}
List.mt = {}
List.mt.__index = List.mt

function List.new(table)
	local list = {}
	list = table or {}
	setmetatable(list, List.mt)
	return list
end

function List.append(list, obj)
    assert(getmetatable(list) == List.mt)
	table.insert(list, obj)
	return list
end

function List.cons(head, tail)
    assert(getmetatable(tail) == List.mt)
    table.insert(tail, head, 1)
    return tail
end

function List.head(list)
    assert(getmetatable(list) == List.mt)
	local obj = list[1]
	return obj
end

function List.tail(list)
    assert(getmetatable(list) == List.mt)
	local tail = List.new()
    for i = 2, #list do
        tail[i-1] = list[i]
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

-- fold s.t. 1+2+3 -> 1+(2+3)
function List.foldr(list, fn)
	local head = List.head(list)
	local tail = List.tail(list)
	if (#list == 2) then
		return fn(head, tail[1])
	end
	return fn(head, List.foldr(tail, fn))
end

-- fold s.t. 1+2+3 -> (1+2)+3
function List.foldl(list, fn)
	local head = List.head(list)
	local tail = List.tail(list)
	if (#list == 2) then
		return fn(tail[1], head)
	end
	return fn(List.foldl(tail, fn), head)
end

function List.filter(list, fn)
	result = List.new()
	for i=1, #list do
		if (fn(list[i])) then
			List.append(result, list[i])
		end
	end
	return result
end

function List.map(list, fn)
	local mappedlist = List.new()
	for i=1, #list do
		List.append(mappedlist, fn(list[i]))
	end
	return mappedlist
end

function add(x,y)
	return x+y
end

function even(x)
	return x % 2 == 0
end

function square(x)
	return x*x
end

function test_cases()
	local list = List.new({1,2,3,4,5,6,7,8,9,10})
	print(List.foldl(list,add))
	print(List.filter(list,even))
	print(List.map(list,square))
end

test_cases()

return List
