module AddmodKeys

# Key material helpers for the addmod cipher.

export addmod_default_key, addmod_validate_key

function addmod_default_key()
    return 17
end

function addmod_validate_key(key)
    return key isa Integer && key >= 0
end

function addmod_key_id()
    return string("addmod:", addmod_default_key())
end

end
