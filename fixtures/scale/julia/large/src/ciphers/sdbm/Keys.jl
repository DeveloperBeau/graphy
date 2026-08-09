module SdbmKeys

# Key material helpers for the sdbm cipher.

export sdbm_default_key, sdbm_validate_key

function sdbm_default_key()
    return 0
end

function sdbm_validate_key(key)
    return key isa Integer && key >= 0
end

function sdbm_key_id()
    return string("sdbm:", sdbm_default_key())
end

end
