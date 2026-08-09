module XorDigestKeys

# Key material helpers for the xordigest cipher.

export xordigest_default_key, xordigest_validate_key

function xordigest_default_key()
    return 0
end

function xordigest_validate_key(key)
    return key isa Integer && key >= 0
end

function xordigest_key_id()
    return string("xordigest:", xordigest_default_key())
end

end
