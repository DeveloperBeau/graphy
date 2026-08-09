module FeistelKeys

# Key material helpers for the feistel cipher.

export feistel_default_key, feistel_validate_key

function feistel_default_key()
    return 101
end

function feistel_validate_key(key)
    return key isa Integer && key >= 0
end

function feistel_key_id()
    return string("feistel:", feistel_default_key())
end

end
