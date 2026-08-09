module RotBlocksKeys

# Key material helpers for the rotblocks cipher.

export rotblocks_default_key, rotblocks_validate_key

function rotblocks_default_key()
    return 6
end

function rotblocks_validate_key(key)
    return key isa Integer && key >= 0
end

function rotblocks_key_id()
    return string("rotblocks:", rotblocks_default_key())
end

end
