module TrithemiusKeys

# Key material helpers for the trithemius cipher.

export trithemius_default_key, trithemius_validate_key

function trithemius_default_key()
    return "ABC"
end

function trithemius_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function trithemius_key_id()
    return string("trithemius:", trithemius_default_key())
end

end
