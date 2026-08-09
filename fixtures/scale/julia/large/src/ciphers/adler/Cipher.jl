module AdlerCipher

# Adler: two-accumulator checksum.

export adler_digest, adler_hex

function adler_digest(data::Vector{UInt8})
    a, s = UInt32(1), UInt32(0)
    for b in data
        a = (a + b) % UInt32(65521)
        s = (s + a) % UInt32(65521)
    end
    return (s << 16) | a
end

function adler_hex(data::Vector{UInt8})
    return string(adler_digest(data), base = 16, pad = 8)
end

end
