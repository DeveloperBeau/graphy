module BlockSwapKeys

# Key material helpers for the blockswap cipher.

export blockswap_default_key, blockswap_validate_key

function blockswap_default_key()
    return 8
end

function blockswap_validate_key(key)
    return key isa Integer && key >= 0
end

function blockswap_key_id()
    return string("blockswap:", blockswap_default_key())
end

end
