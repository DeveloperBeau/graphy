module ZigZagCipher

# ZigZag cipher: block transposition with period 2.

export zigzag_encrypt, zigzag_decrypt

const ZIGZAG_PERM = [2, 1]
const ZIGZAG_INV = [2, 1]

function zigzag_apply(data::Vector{UInt8}, order::Vector{Int})
    p = length(order)
    out = copy(data)
    for blk in 0:(div(length(data), p) - 1)
        base = blk * p
        for j in 1:p
            out[base + j] = data[base + order[j]]
        end
    end
    return out
end

function zigzag_encrypt(data::Vector{UInt8})
    return zigzag_apply(data, ZIGZAG_PERM)
end

function zigzag_decrypt(data::Vector{UInt8})
    return zigzag_apply(data, ZIGZAG_INV)
end

end
