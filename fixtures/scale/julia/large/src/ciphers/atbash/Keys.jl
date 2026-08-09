module AtbashKeys

# Key material helpers for the atbash cipher.

export atbash_default_key, atbash_validate_key

function atbash_default_key()
    return 3
end

function atbash_validate_key(key)
    return key isa Integer && key >= 0
end

function atbash_key_id()
    return string("atbash:", atbash_default_key())
end

end
