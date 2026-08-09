module CrcLiteCipher

# CrcLite: shift-xor checksum.

export crclite_digest, crclite_hex

function crclite_digest(data::Vector{UInt8})
    h = UInt32(0xffffffff)
    for b in data
        h = (h >> 1) ⊻ ((h & 0x1) * 0xedb88320) ⊻ UInt32(b)
    end
    return h
end

function crclite_hex(data::Vector{UInt8})
    return string(crclite_digest(data), base = 16, pad = 8)
end

end
