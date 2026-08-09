module PortaCheck

# Round-trip verification for the porta cipher.

using ..PortaCipher

export porta_verify

function porta_verify(sample::Vector{UInt8})
    enc = PortaCipher.porta_encrypt(sample)
    dec = PortaCipher.porta_decrypt(enc)
    return dec == sample
end

end
