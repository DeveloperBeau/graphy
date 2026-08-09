module CaesarKeys

# Key material helpers for the caesar cipher.

export caesar_default_key, caesar_validate_key

function caesar_default_key()
    return 3
end

function caesar_validate_key(key)
    return key isa Integer && key >= 0
end

function caesar_key_id()
    return string("caesar:", caesar_default_key())
end

end
