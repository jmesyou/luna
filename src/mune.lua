local env = require "env"

function repl()
    while true do
        print(env.evaluate(env))
    end

end

if #args == 0 then
    repl()
end