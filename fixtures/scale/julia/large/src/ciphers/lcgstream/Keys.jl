module LcgStreamKeys

# Key material helpers for the lcgstream cipher.

export lcgstream_default_key, lcgstream_validate_key

function lcgstream_default_key()
    return 42
end

function lcgstream_validate_key(key)
    return key isa Integer && key >= 0
end

function lcgstream_key_id()
    return string("lcgstream:", lcgstream_default_key())
end

end
