module DecimationKeys

# Key material helpers for the decimation cipher.

export decimation_default_key, decimation_validate_key

function decimation_default_key()
    return 0
end

function decimation_validate_key(key)
    return key isa Integer && key >= 0
end

function decimation_key_id()
    return string("decimation:", decimation_default_key())
end

end
