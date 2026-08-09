module CtrXorKeys

# Key material helpers for the ctrxor cipher.

export ctrxor_default_key, ctrxor_validate_key

function ctrxor_default_key()
    return 7
end

function ctrxor_validate_key(key)
    return key isa Integer && key >= 0
end

function ctrxor_key_id()
    return string("ctrxor:", ctrxor_default_key())
end

end
