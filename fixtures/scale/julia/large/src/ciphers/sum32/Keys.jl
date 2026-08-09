module Sum32Keys

# Key material helpers for the sum32 cipher.

export sum32_default_key, sum32_validate_key

function sum32_default_key()
    return 0
end

function sum32_validate_key(key)
    return key isa Integer && key >= 0
end

function sum32_key_id()
    return string("sum32:", sum32_default_key())
end

end
