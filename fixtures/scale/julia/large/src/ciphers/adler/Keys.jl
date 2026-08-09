module AdlerKeys

# Key material helpers for the adler cipher.

export adler_default_key, adler_validate_key

function adler_default_key()
    return 0
end

function adler_validate_key(key)
    return key isa Integer && key >= 0
end

function adler_key_id()
    return string("adler:", adler_default_key())
end

end
