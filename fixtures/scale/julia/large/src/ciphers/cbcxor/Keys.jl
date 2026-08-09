module CbcXorKeys

# Key material helpers for the cbcxor cipher.

export cbcxor_default_key, cbcxor_validate_key

function cbcxor_default_key()
    return 113
end

function cbcxor_validate_key(key)
    return key isa Integer && key >= 0
end

function cbcxor_key_id()
    return string("cbcxor:", cbcxor_default_key())
end

end
