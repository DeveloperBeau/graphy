module AffineKeys

# Key material helpers for the affine cipher.

export affine_default_key, affine_validate_key

function affine_default_key()
    return 8
end

function affine_validate_key(key)
    return key isa Integer && key >= 0
end

function affine_key_id()
    return string("affine:", affine_default_key())
end

end
