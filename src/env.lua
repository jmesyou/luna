Math = require "math"
List = require "list"
Parser = require "parser"
Symbol = require "symbol"
local Env = {}
Env.mt = {}

function Env.standard_env()
    local env = {}
    env.outer = nil
    env.dispatch = {
        ["+"] = function(x, y) return x + y end,
        ["-"] = function(x, y) return x - y end,
        ["*"] = function(x, y) return x * y end,
        ["/"] = function(x, y) return x / y end,
        ["<"] = function(x, y) return x < y end,
        [">"] = function(x, y) return x > y end,
        ["="] = function(x, y) return x == y end,
        [">="] = function(x, y) return x >= y end,
        ["<="] = function(x, y) return x <= y end,
        ["++"] = function(x, y) return x .. y end,
        ["not"] = function(x) return not x end,
        ["null?"] = function(obj) return obj == nil or #obj == 0 end,
        ["number?"] = function(obj) return type(obj) == "number" end,
        ["symbol?"] = function(obj) return getmetatable(obj) == Symbol.mt end,
        ["procedure?"] = function(obj) return getmetable(obj) == Proc.mt end,
        ["print"] = function(obj) lprint(obj) end,
        ["begin"] = nil,
        ["list?"] = function(obj) return getmetatable(obj) == List.mt end,
    }
    for name, fn in pairs(Math) do env.dispatch[name] = fn end
    for name, fn in pairs(List) do env.dispatch[name] = fn end
    setmetatable(env, Env.mt)
    return env
end

function Env.new(params, args, outer)
    assert(#params == #args)
    local env = {}
    setmetatable(env, Env.mt)
    env.dispatch = {}
    env.outer = outer
    for i = 1, #params do
        env.dispatch[params[i]] = args[i]
    end
    return env
end

function Env.mt:find(key)
    local value = self.dispatch[key]
    if value == nil then
        if self.outer == nil then
            error(string.format("%q is not defined", key))
        end
        return self.outer:find(key)
    end
    return self
end

Env.global_env = Env.standard_env()

function eval(expr, env)
    if type(expr) == "number" then
        return expr
    elseif getmetatable(expr) == symbol.mt then
        return env.dispatch[tostring(expr)]
    elseif getmetatable(expr[1]) == symbol.mt then
        local keyword = tostring(expr[1])
        if keyword == "if" then
            local _, test, conseq, alt = table.unpack(expr)
            local exp
            if eval(test, env) then exp = conseq else exp = alt end
            return eval(exp, env)
        elseif keyword == "define" then
            local _, var, exp = table.unpack(expr)
            env.dispatch[tostring(var)] = eval(exp, env)
        elseif keyword == "set!" then
            local _, var, exp = table.unpack(expr)
            env.find(tostring(var)).dispatch[tostring(var)] = eval(exp, env)
        elseif keyword == "lambda" then
            local _, params, body = table.unpack(expr)
            return Proc.new(params, body, env)
        else
            local proc = eval(expr[1], env)
            local args = {}
            for index = 2, #expr do
                args[#args+1] = (eval(expr[index], env))
            end
            return proc(table.unpack(args))
        end
    else
        error("unexpected error encountered")
    end
end

function debug_table(tbl)
    local out = "( "
    for i,j in ipairs(tbl) do
        if type(j) == "table" then
            out = out .. debug_table(j)
        else
            out = out .. j .. " "
        end
    end
    out = out .. ") "
    return out
end

function Env.evaluate(str)
    print(str)
    return eval(parser.parse(str), Env.global_env)
end

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

return Env