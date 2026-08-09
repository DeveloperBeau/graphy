module Djb2Keys

# Key material helpers for the djb2 cipher.

export djb2_default_key, djb2_validate_key

function djb2_default_key()
    return 5381
end

function djb2_validate_key(key)
    return key isa Integer && key >= 0
end

function djb2_key_id()
    return string("djb2:", djb2_default_key())
end

end
