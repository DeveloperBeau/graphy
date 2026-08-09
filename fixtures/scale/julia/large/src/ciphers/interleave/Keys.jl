module InterleaveKeys

# Key material helpers for the interleave cipher.

export interleave_default_key, interleave_validate_key

function interleave_default_key()
    return 8
end

function interleave_validate_key(key)
    return key isa Integer && key >= 0
end

function interleave_key_id()
    return string("interleave:", interleave_default_key())
end

end
