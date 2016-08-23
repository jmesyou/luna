local env = require "env"

function repl()
    while true do
        print(env.evaluate(io.read()))
    end

end

if #arg == 0 then
    repl()
end