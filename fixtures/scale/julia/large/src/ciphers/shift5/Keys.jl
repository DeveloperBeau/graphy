module Shift5Keys

# Key material helpers for the shift5 cipher.

export shift5_default_key, shift5_validate_key

function shift5_default_key()
    return 5
end

function shift5_validate_key(key)
    return key isa Integer && key >= 0
end

function shift5_key_id()
    return string("shift5:", shift5_default_key())
end

end
