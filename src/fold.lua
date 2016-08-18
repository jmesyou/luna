List = require "list"

-- fold s.t. 1+2+3 -> 1+(2+3)
function foldr(list, fn)
	local head = List.head(list)
	local tail = List.tail(list)
	if (#list == 2) then
		return fn(head, tail[1])
	end
	
	return fn(head, foldr(tail, fn))
end

-- fold s.t. 1+2+3 -> (1+2)+3
function foldl(list, fn)
	local head = List.head(list)
	local tail = List.tail(list)
	if (#list == 2) then
		return fn(tail[1], head)
	end
	
	return fn(foldl(tail, fn), head)
end