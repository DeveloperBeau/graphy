module BeaufortKeys

# Key material helpers for the beaufort cipher.

export beaufort_default_key, beaufort_validate_key

function beaufort_default_key()
    return "FORTRESS"
end

function beaufort_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function beaufort_key_id()
    return string("beaufort:", beaufort_default_key())
end

end
