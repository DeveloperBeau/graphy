module QuagmireKeys

# Key material helpers for the quagmire cipher.

export quagmire_default_key, quagmire_validate_key

function quagmire_default_key()
    return "OCEAN"
end

function quagmire_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function quagmire_key_id()
    return string("quagmire:", quagmire_default_key())
end

end
