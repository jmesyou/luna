math = require "math"
list = require "list"
symbol = require "symbol"
local Env = {}
Env.mt = {}

function Env.standard_env()
    local env = {}
    setmetable(env, Env.mt)
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
        ["symbol?"] = function(obj) return getmetatable(obj) == symbol.mt end,
        ["print"] = function(obj) lprint(obj) end,
        ["begin"] = nil,
        ["list"] = function(...) return list.new({...}) end,
        ["list?"] = function(obj) return getmetatable(obj) == list.mt end,
        ["car"] = list.head,
        ["cdr"] = list.tail,
    }
    for name, obj in pairs(math) do env.dispatch[name] = obj end
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
            return "ERRRRROOOOR"
        end
        return self.outer:find(key)
    end
    return value
end

local function lprint(obj)
    if obj == nil then
        return nil
    else
        print(obj)
    end
end

return Env