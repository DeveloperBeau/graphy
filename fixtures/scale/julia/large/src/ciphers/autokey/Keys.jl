module AutokeyKeys

# Key material helpers for the autokey cipher.

export autokey_default_key, autokey_validate_key

function autokey_default_key()
    return "QUEEN"
end

function autokey_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function autokey_key_id()
    return string("autokey:", autokey_default_key())
end

end
