local env = require "env"

function repl()
    while true do
        local ok, ret = pcall(env.evaluate, io.read())
        print(ret)
    end
end

function compile()
    --TODO
end

if #arg == 0 then
    repl()
end