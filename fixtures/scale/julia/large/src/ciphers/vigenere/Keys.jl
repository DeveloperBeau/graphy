module VigenereKeys

# Key material helpers for the vigenere cipher.

export vigenere_default_key, vigenere_validate_key

function vigenere_default_key()
    return "LEMON"
end

function vigenere_validate_key(key)
    return key isa AbstractString && length(key) >= 3
end

function vigenere_key_id()
    return string("vigenere:", vigenere_default_key())
end

end
