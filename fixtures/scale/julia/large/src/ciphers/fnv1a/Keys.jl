module Fnv1aKeys

# Key material helpers for the fnv1a cipher.

export fnv1a_default_key, fnv1a_validate_key

function fnv1a_default_key()
    return 2166136261
end

function fnv1a_validate_key(key)
    return key isa Integer && key >= 0
end

function fnv1a_key_id()
    return string("fnv1a:", fnv1a_default_key())
end

end
