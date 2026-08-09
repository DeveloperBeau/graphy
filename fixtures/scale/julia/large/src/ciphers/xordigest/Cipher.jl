module XorDigestCipher

# XorDigest: position-spread xor digest.

export xordigest_digest, xordigest_hex

function xordigest_digest(data::Vector{UInt8})
    h = UInt32(0)
    for (i, b) in enumerate(data)
        h = h ⊻ (UInt32(b) << (mod(i - 1, 4) * 8))
    end
    return h
end

function xordigest_hex(data::Vector{UInt8})
    return string(xordigest_digest(data), base = 16, pad = 8)
end

end
