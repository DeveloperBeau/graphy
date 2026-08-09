module XorRollKeys

# Key material helpers for the xorroll cipher.

export xorroll_default_key, xorroll_validate_key

function xorroll_default_key()
    return 193
end

function xorroll_validate_key(key)
    return key isa Integer && key >= 0
end

function xorroll_key_id()
    return string("xorroll:", xorroll_default_key())
end

end
