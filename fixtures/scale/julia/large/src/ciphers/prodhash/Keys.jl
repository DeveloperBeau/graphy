module ProdHashKeys

# Key material helpers for the prodhash cipher.

export prodhash_default_key, prodhash_validate_key

function prodhash_default_key()
    return 7
end

function prodhash_validate_key(key)
    return key isa Integer && key >= 0
end

function prodhash_key_id()
    return string("prodhash:", prodhash_default_key())
end

end
