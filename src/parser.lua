symbol = require "symbol"

local parser = {}

local START = {}
local STRING = {}
local ATOM = {}

function parser.tokenize(str)
  local state = START
  local tokens = {}
  local word = ""
    for i = 1, #str do
      local char = str:sub(i,i)
      if state == START then
        if      char == "("  then tokens[#tokens+1] = "("
        elseif  char == ")"  then tokens[#tokens+1] = ")"
        elseif  char == "\"" then state = STRING; word = ""
        elseif  char == " "  then --nothing
        else    state = ATOM; word = char
        end
      elseif state == STRING then
        if      char == "\"" then tokens[#tokens+1] = "\"" .. word .. "\""; state = START
        else    word = word .. char
        end
      elseif state == ATOM then
        if      char == " " then tokens[#tokens+1] = word; state = START
        elseif  char == ")" then tokens[#tokens+1] = word; tokens[#tokens+1] = ")";  state = START
        else    word = word .. char
        end
      else
        print("ERRROOOOR")
        return
      end
    end
    return tokens
end

function parser.read_tokens(tokens)
  local ast = {}
  while #tokens > 0 do
    local token = table.remove(tokens, 1)
    if token == "(" then
      ast[#ast+1] = parser.read_tokens(tokens)
    elseif token == ")" then
      return ast
    else
      ast[#ast+1] = parser.atomize(token)
    end
  end
  return ast
end

local function debug_table(tbl)
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

function parser.atomize(str)
  local atom = tonumber(str)
  if atom == nil then
    return str
  else
    return atom
  end
end

function parser.parse(str)
  return parser.read_tokens(parser.tokenize(str))
end

return parser
