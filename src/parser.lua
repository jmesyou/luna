symbol = require "symbol"

local Parser = {}

local START = {}
local STRING = {}
local ATOM = {}

function Parser.tokenize(str)
  local state = START
  local tokens = {}
  local word = ""
    for i = 1, #str do
      local char = str:sub(i,i)
      if state == START then
        if      char == "("  then tokens[#tokens+1] = "("
        elseif  char == ")"  then tokens[#tokens+1] = ")"
        elseif  char == "\"" then state = STRING; word = ""
        elseif  wspace(char) then --nothing
        else    state = ATOM; word = char
        end
      elseif state == STRING then
        if      char == "\"" then tokens[#tokens+1] = word; state = START
        else    word = word .. char
        end
      elseif state == ATOM then
        if      wspace(char) then tokens[#tokens+1] = parser.atomize(word); state = START
        elseif  char == ")"  then tokens[#tokens+1] = parser.atomize(word); tokens[#tokens+1] = ")";  state = START
        else    word = word .. char
        end
      else
        error("unexpected parsing state")
      end
    end
    return tokens
end

function Parser.read_tokens(tokens)
  local ast = {}
  while #tokens > 0 do
    local token = table.remove(tokens, 1)
    if token == "(" then
      ast[#ast+1] = parser.read_tokens(tokens)
    elseif token == ")" then
      return ast
    else
      ast[#ast+1] = token
    end
  end
  return ast[1]
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

function Parser.atomize(str)
  local atom = tonumber(str)
  if atom == nil then
    return symbol.new(str)
  else
    return atom
  end
end

function wspace(char)
  return string.byte(char) == 9  or  --tab
         string.byte(char) == 10 or -- nl
         string.byte(char) == 13 or  --cr
         string.byte(char) == 32     --whitespace
end

function Parser.parse(str)
  return parser.read_tokens(parser.tokenize(str))
end

return Parser
