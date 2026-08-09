module RevBlocksKeys

# Key material helpers for the revblocks cipher.

export revblocks_default_key, revblocks_validate_key

function revblocks_default_key()
    return 4
end

function revblocks_validate_key(key)
    return key isa Integer && key >= 0
end

function revblocks_key_id()
    return string("revblocks:", revblocks_default_key())
end

end
