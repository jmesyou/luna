--TODO implemented fully featured parser with support for strings/comments
--[[
this is the actual parse function but
we just want to have a functioning program right now

function parse(str)
  local expr = {}
  local word = ""
  local in_str = false
  for index, char in str do
    if char == "(" and not in_str then
      expr[#expr+1] = {}
    elseif char == ")" and not in_str then
      if #word > 0 then
        expr[#expr].insert(word)
        word = ""
      end
end
]]--

local parser = {}



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

local function string_to_char_array(str)
  local arr = {}
  for i = 1, #str do
    arr[#arr+1] = str:sub(i,i)
  end
  return arr
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
  out = out .. " ) "
  return out
end

function parser.tokenize(str)
  local stream = str:gsub("%s*[(]%s*", " ( "):gsub("%s*[)]%s*", " ) ")
  stream = stream:gsub("^%s+", ""):gsub("%s+$", "")
  fields = {}
  stream:gsub("([^".."%s".."]*)".."%s", function(c) table.insert(fields, c) end)
  return fields
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
