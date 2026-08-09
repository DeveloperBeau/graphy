module GronsfeldKeys

# Key material helpers for the gronsfeld cipher.

export gronsfeld_default_key, gronsfeld_validate_key

function gronsfeld_default_key()
    return "31415"
end

function gronsfeld_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function gronsfeld_key_id()
    return string("gronsfeld:", gronsfeld_default_key())
end

end
