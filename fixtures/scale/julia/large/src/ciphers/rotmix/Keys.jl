module RotmixKeys

# Key material helpers for the rotmix cipher.

export rotmix_default_key, rotmix_validate_key

function rotmix_default_key()
    return 3
end

function rotmix_validate_key(key)
    return key isa Integer && key >= 0
end

function rotmix_key_id()
    return string("rotmix:", rotmix_default_key())
end

end
