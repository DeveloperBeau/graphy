module ScytaleKeys

# Key material helpers for the scytale cipher.

export scytale_default_key, scytale_validate_key

function scytale_default_key()
    return 6
end

function scytale_validate_key(key)
    return key isa Integer && key >= 0
end

function scytale_key_id()
    return string("scytale:", scytale_default_key())
end

end
