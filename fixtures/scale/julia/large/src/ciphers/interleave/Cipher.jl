module InterleaveCipher

# Interleave cipher: block transposition with period 8.

export interleave_encrypt, interleave_decrypt

const INTERLEAVE_PERM = [1, 3, 5, 7, 2, 4, 6, 8]
const INTERLEAVE_INV = [1, 5, 2, 6, 3, 7, 4, 8]

function interleave_apply(data::Vector{UInt8}, order::Vector{Int})
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

function interleave_encrypt(data::Vector{UInt8})
    return interleave_apply(data, INTERLEAVE_PERM)
end

function interleave_decrypt(data::Vector{UInt8})
    return interleave_apply(data, INTERLEAVE_INV)
end

end
