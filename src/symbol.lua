

Symbol = {}
Symbol.mt = {field = ""}

function Symbol.new(field)
    local symbol = {}
    symbol.field = field
    setmetatable(symbol, Symbol.mt)
    return symbol
end

function Symbol.mt:__tostring()
    return self.field
end

function Symbol.mt:__call()
    return self.field
end

return Symbol