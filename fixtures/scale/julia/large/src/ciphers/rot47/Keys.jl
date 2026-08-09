module Rot47Keys

# Key material helpers for the rot47 cipher.

export rot47_default_key, rot47_validate_key

function rot47_default_key()
    return 47
end

function rot47_validate_key(key)
    return key isa Integer && key >= 0
end

function rot47_key_id()
    return string("rot47:", rot47_default_key())
end

end
