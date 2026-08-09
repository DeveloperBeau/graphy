module XorBasicKeys

# Key material helpers for the xorbasic cipher.

export xorbasic_default_key, xorbasic_validate_key

function xorbasic_default_key()
    return 90
end

function xorbasic_validate_key(key)
    return key isa Integer && key >= 0
end

function xorbasic_key_id()
    return string("xorbasic:", xorbasic_default_key())
end

end
