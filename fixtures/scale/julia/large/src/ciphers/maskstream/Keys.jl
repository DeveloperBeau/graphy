module MaskStreamKeys

# Key material helpers for the maskstream cipher.

export maskstream_default_key, maskstream_validate_key

function maskstream_default_key()
    return 90
end

function maskstream_validate_key(key)
    return key isa Integer && key >= 0
end

function maskstream_key_id()
    return string("maskstream:", maskstream_default_key())
end

end
