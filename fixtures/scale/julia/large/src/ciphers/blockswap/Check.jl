module BlockSwapCheck

# Round-trip verification for the blockswap cipher.

using ..BlockSwapCipher

export blockswap_verify

function blockswap_verify(sample::Vector{UInt8})
    enc = BlockSwapCipher.blockswap_encrypt(sample)
    dec = BlockSwapCipher.blockswap_decrypt(enc)
    return dec == sample
end

end
