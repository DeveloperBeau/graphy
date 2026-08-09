module PortaKeys

# Key material helpers for the porta cipher.

export porta_default_key, porta_validate_key

function porta_default_key()
    return "GLACIER"
end

function porta_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function porta_key_id()
    return string("porta:", porta_default_key())
end

end
