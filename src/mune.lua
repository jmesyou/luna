local env = require "env"

function repl()
    while true do
        print(env.evaluate(io.read()))
    end

end

if #arg == 0 then
    repl()
else
    for i = 1, #arg do
        print(env.evaluate(iomodule.readFile(arg[i])))
    end
end
