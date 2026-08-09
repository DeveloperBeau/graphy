module KeymixKeys

# Key material helpers for the keymix cipher.

export keymix_default_key, keymix_validate_key

function keymix_default_key()
    return "ZEBRA"
end

function keymix_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function keymix_key_id()
    return string("keymix:", keymix_default_key())
end

end
