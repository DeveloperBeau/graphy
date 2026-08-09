module ColumnarKeys

# Key material helpers for the columnar cipher.

export columnar_default_key, columnar_validate_key

function columnar_default_key()
    return 4
end

function columnar_validate_key(key)
    return key isa Integer && key >= 0
end

function columnar_key_id()
    return string("columnar:", columnar_default_key())
end

end
