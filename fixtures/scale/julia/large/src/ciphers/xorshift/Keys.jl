module XorShiftKeys

# Key material helpers for the xorshift cipher.

export xorshift_default_key, xorshift_validate_key

function xorshift_default_key()
    return 911
end

function xorshift_validate_key(key)
    return key isa Integer && key >= 0
end

function xorshift_key_id()
    return string("xorshift:", xorshift_default_key())
end

end
