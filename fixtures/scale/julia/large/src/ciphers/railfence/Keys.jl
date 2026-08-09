module RailFenceKeys

# Key material helpers for the railfence cipher.

export railfence_default_key, railfence_validate_key

function railfence_default_key()
    return 6
end

function railfence_validate_key(key)
    return key isa Integer && key >= 0
end

function railfence_key_id()
    return string("railfence:", railfence_default_key())
end

end
