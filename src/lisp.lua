local parser = require "parser"
local env = require "env"

global_env = env.standard_env()

Proc = {}
Proc.mt = {}

function Proc.new(param, body, env)
    local proc = {}
    setmetatable(proc, Proc.mt)
    proc.param = param
    proc.body = body
    proc.env = env
end

function Proc.mt:__call(...)
    return eval(body, env.new(self.param, {...}, self.env))
end

local function eval(expr, env)
    if type(expr) == "string" then
        return env.dispatch[expr]
    elseif type(expr) == "number" then
        return expr
    elseif expr[1] == "if" then
        local _, test, conseq, alt = table.unpack(expr)
        local exp
        if eval(test, env) then exp = conseq else exp = alt end
        return eval(exp, env)
    else
        local proc = eval(expr[1], env)
        local args = {}
        for index = 2, #expr do
            args[#args+1] = (eval(expr[index], env))
        end
        return proc(table.unpack(args))
    end
end

local function evaluate(str)
    return eval(parser.parse(str))
end
