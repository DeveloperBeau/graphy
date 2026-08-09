module CrcLiteKeys

# Key material helpers for the crclite cipher.

export crclite_default_key, crclite_validate_key

function crclite_default_key()
    return 4294967295
end

function crclite_validate_key(key)
    return key isa Integer && key >= 0
end

function crclite_key_id()
    return string("crclite:", crclite_default_key())
end

end
