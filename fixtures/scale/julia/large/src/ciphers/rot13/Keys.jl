module Rot13Keys

# Key material helpers for the rot13 cipher.

export rot13_default_key, rot13_validate_key

function rot13_default_key()
    return 13
end

function rot13_validate_key(key)
    return key isa Integer && key >= 0
end

function rot13_key_id()
    return string("rot13:", rot13_default_key())
end

end
