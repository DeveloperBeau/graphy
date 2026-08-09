module Tokens

export Token, Cursor, peek_token, next_token

struct Token
    type::Symbol
    value::String
end

mutable struct Cursor
    tokens::Vector{Token}
    pos::Int
end

Cursor(tokens::Vector{Token}) = Cursor(tokens, 1)

function peek_token(cursor::Cursor)
    return cursor.pos > length(cursor.tokens) ? nothing : cursor.tokens[cursor.pos]
end

function next_token(cursor::Cursor)
    token = peek_token(cursor)
    cursor.pos += 1
    return token
end

end
