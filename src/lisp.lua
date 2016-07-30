

local math_lib = require "math"
local math_lib = require "math"
local parser = require "parser"
local parse = parser.parse

env = {
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
  ["number?"] = function(x) return type(x) == "number" end,
  ["print"] = function(x) lprint(obj) end
}
for name, obj in pairs(math_lib) do env[name] = obj end

function lprint(obj)
  if obj == nil then
    return nil
  else
    print(obj)
  end
end

--TODO implement procedures and variables

local function eval(expr, env)
  if type(expr) == "string" then
    return env[expr]
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
