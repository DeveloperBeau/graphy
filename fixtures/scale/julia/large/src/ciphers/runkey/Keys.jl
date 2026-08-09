module RunkeyKeys

# Key material helpers for the runkey cipher.

export runkey_default_key, runkey_validate_key

function runkey_default_key()
    return "THEQUICKBROWNFOX"
end

function runkey_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function runkey_key_id()
    return string("runkey:", runkey_default_key())
end

end
