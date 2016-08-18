

Symbol = {}
Symbol.mt = {field = ""}

function Symbol.new(field)
    local symbol = {}
    setmetatable(symbol, Symbol.mt)
    symbol.field = field
    return symbol
end

function Symbol.mt:__tostring()
    return symbol.field
end

function Symbol.mt:__call()
    return symbol.field
end
