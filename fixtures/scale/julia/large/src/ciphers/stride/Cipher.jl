module StrideCipher

# Stride cipher: block transposition with period 9.

export stride_encrypt, stride_decrypt

const STRIDE_PERM = [1, 4, 7, 2, 5, 8, 3, 6, 9]
const STRIDE_INV = [1, 4, 7, 2, 5, 8, 3, 6, 9]

function stride_apply(data::Vector{UInt8}, order::Vector{Int})
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

function stride_encrypt(data::Vector{UInt8})
    return stride_apply(data, STRIDE_PERM)
end

function stride_decrypt(data::Vector{UInt8})
    return stride_apply(data, STRIDE_INV)
end

end
