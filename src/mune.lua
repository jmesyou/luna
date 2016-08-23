local env = require "env"
local ioreader = require "iomodule"

function repl(string)
    if (string == nil) then
        while true do
            print(env.evaluate(io.read()))
        end
    elseif (type(string) == "string") then
        print(env.evaluate(string))
    end

end


if #arg == 0 then
    repl(nil)
else
    --TODO implement multiple line reads && support for partial expressions
    for i = 1, #arg do
        repl(ioreader.readFile(arg[i]))
    end
end


stringarr = {}
stringarr[1] = "hello"
stringarr[2] = "world"

print(type(stringarr))
print(type({"hello, world"}))
