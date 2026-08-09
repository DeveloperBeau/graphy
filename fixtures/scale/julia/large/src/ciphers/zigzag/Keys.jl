module ZigZagKeys

# Key material helpers for the zigzag cipher.

export zigzag_default_key, zigzag_validate_key

function zigzag_default_key()
    return 2
end

function zigzag_validate_key(key)
    return key isa Integer && key >= 0
end

function zigzag_key_id()
    return string("zigzag:", zigzag_default_key())
end

end
