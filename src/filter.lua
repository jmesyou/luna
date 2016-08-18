local List = require "list"

--filter s.t. 1,2,3,4 for even numbers -> 2,4
function filter(list, fn)
	result = List.new()
	for i=1, #list do
		if (fn(list[i])) then
			List.append(result, list[i])
		end
	end
	return result	
end

function even(param1)
	return param1 % 2 == 0
end

function odd(param1)
	return param1 % 2 == 1
end

function not(fn, param)
	return ~fn(param)
end

function and(fn1, param1, fn2, param2)
	return fn1(param1) && fn2(param2)
end

function or(fn1, param1, fn2, param2)
	return fn1(param1) || fn2(param2)
end

function xor(fn1, param1, fn2, param2)
	return or(fn1,param1,fn2,param2) && ~and(fn1,param1,fn2,param2)
end
