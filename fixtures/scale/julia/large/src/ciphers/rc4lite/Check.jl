module Rc4LiteCheck

# Round-trip verification for the rc4lite cipher.

using ..Rc4LiteCipher

export rc4lite_verify

function rc4lite_verify(sample::Vector{UInt8})
    enc = Rc4LiteCipher.rc4lite_encrypt(sample)
    dec = Rc4LiteCipher.rc4lite_decrypt(enc)
    return dec == sample
end

end
