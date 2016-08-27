local env = require "env"
local ioreader = require "iomodule"

function repl()
	if(string == nil) then
		while true do
			local ok, ret = pcall(env.evaluate, io.read())
			print(ret)
		end
	elseif (type(string) == "string") then
        print ok, ret = pcall(env.evaluate, io.read())
		print(env.evaluate(string))
	end
end

function compile()
    --TODO
end


if #arg == 0 then
    repl(nil)
else
    for i = 1, #arg do
        repl(ioreader.readFile(arg[i]))
    end
end


stringarr = {}
stringarr[1] = "hello"
stringarr[2] = "world"

print(type(stringarr))
print(type({"hello, world"}))
