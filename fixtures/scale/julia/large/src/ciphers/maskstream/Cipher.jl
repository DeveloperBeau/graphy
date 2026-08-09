module MaskStreamCipher

# MaskStream cipher: xor against a fixed 4-byte mask.

export maskstream_encrypt, maskstream_decrypt

const MASKSTREAM_MASK = UInt8[0x17, 0x69, 0xbb, 0x07]

function maskstream_keystream(n::Int)
    mask = MASKSTREAM_MASK
    return UInt8[mask[mod(i - 1, length(mask)) + 1] for i in 1:n]
end

function maskstream_encrypt(data::Vector{UInt8})
    return data .⊻ maskstream_keystream(length(data))
end

function maskstream_decrypt(data::Vector{UInt8})
    # Xor stream ciphers are symmetric.
    return maskstream_encrypt(data)
end

end
