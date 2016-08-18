local List = require "list"
--local Errors = require "Errors"

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

function add(param1,param2)
	return param1+param2
end

function sub(param1,param2)
	return param1-param2
end

function exp(param1,param2)
	return param1^param2
end

function mul(param1,param2)
	return param1*param2
end

function div(param1,param2)
	if (param2 != 0) then
		return param1/param2
	--if error checking is allowed
	--else
		--return Errors.new("Divide by zero error")
	end
	--if error checking is NOT allowed
	--infinity in lua
	if (mul(param1,param2) > 0) then
		return 1e309
	else
		return -1e309
	end
end
