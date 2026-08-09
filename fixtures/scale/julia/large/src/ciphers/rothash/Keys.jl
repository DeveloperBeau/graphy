module RotHashKeys

# Key material helpers for the rothash cipher.

export rothash_default_key, rothash_validate_key

function rothash_default_key()
    return 99991
end

function rothash_validate_key(key)
    return key isa Integer && key >= 0
end

function rothash_key_id()
    return string("rothash:", rothash_default_key())
end

end
