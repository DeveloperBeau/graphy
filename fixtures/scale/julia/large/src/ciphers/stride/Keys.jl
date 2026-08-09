module StrideKeys

# Key material helpers for the stride cipher.

export stride_default_key, stride_validate_key

function stride_default_key()
    return 9
end

function stride_validate_key(key)
    return key isa Integer && key >= 0
end

function stride_key_id()
    return string("stride:", stride_default_key())
end

end
