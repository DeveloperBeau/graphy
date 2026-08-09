module Rc4LiteKeys

# Key material helpers for the rc4lite cipher.

export rc4lite_default_key, rc4lite_validate_key

function rc4lite_default_key()
    return 17
end

function rc4lite_validate_key(key)
    return key isa Integer && key >= 0
end

function rc4lite_key_id()
    return string("rc4lite:", rc4lite_default_key())
end

end
