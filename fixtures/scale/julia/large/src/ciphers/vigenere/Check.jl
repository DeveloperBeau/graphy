module VigenereCheck

# Round-trip verification for the vigenere cipher.

using ..VigenereCipher

export vigenere_verify

function vigenere_verify(sample::Vector{UInt8})
    enc = VigenereCipher.vigenere_encrypt(sample)
    dec = VigenereCipher.vigenere_decrypt(enc)
    return dec == sample
end

end
