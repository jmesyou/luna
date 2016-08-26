null = require "null"

List = {}
List.__index = List

function List.list(table)
	local list
	if #table == 0 then list = null else list = table end
	setmetatable(list, List)
	return list
end

function List.append(list, key)
	assert(getmetatable(list) == List)
	table.insert(list, key)
	return list
end

function List.cons(head, tail)
	assert(getmetatable(tail) == List)
	table.insert(tail, head, 1)
	return tail
end

function List.head(list)
	assert(getmetatable(list) == List)
	local obj = list[1]
	return obj
end

function List.tail(list)
	assert(getmetatable(list) == List)
	local tail = List.new()
	for i = 2, #list do
		tail[i-1] = list[i]
	end
	return tail
end

function List.concat(lst1, lst2)
	assert(getmetatable(lst1) == List and getmetatable(lst2) == List)
	for i = 1, #lst2 do
		List.append(lst1,  lst2[i])
	end
	return lst1
end

function List:__tostring()
	local str = "["
	for i = 1, #self-1 do
		str = str .. self[i] .. ", "
	end
	return str .. self[#self] .. "]"
end

-- fold s.t. 1+2+3 -> 1+(2+3)
function List.foldr(list, fn)
	local accumulator = list[#list]
	return foldrhelper(list, #list-1, fn, accumulator)
end

-- essentially do a foldl starting at end instead of beginning
function foldrhelper(list, headindex, fn, accumulator)
	if(headindex == 1) then
		return fn(list[headindex], accumulator)
	end
	accumulator = fn(list[headindex], accumulator)
	headindex = headindex - 1
	return foldrhelper(list, headindex, fn, accumulator)
end

-- fold s.t. 1+2+3 -> (1+2)+3
-- folding only works if #list > 1
function List.foldl(list, fn)
	local accumulator = list[1]
	return foldlhelper(list, 2, fn, accumulator)
end

-- tail recursion optimized & reduced table creation
function foldlhelper(list, headindex, fn, accumulator)
	if (#list - headindex == 0) then
		return fn(accumulator, list[headindex])
	end
	accumulator = fn(accumulator, list[headindex])
	headindex = headindex + 1
	return foldlhelper(list, headindex, fn, accumulator)
end

-- filter values from the list that comply with the function provided
function List.filter(list, fn)
	local result = List.new()
	for i=1, #list do
		if (fn(list[i])) then
			List.append(result, list[i])
		end
	end
	return result
end

-- apply a given function to all the elements in the list
function List.map(list, fn)
	local mappedlist = List.new()
	for i=1, #list do
		List.append(mappedlist, fn(list[i]))
	end
	return mappedlist
end

return List
