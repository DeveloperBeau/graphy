module RailFenceCipher

# RailFence cipher: block transposition with period 6.

export railfence_encrypt, railfence_decrypt

const RAILFENCE_PERM = [1, 3, 5, 2, 4, 6]
const RAILFENCE_INV = [1, 4, 2, 5, 3, 6]

function railfence_apply(data::Vector{UInt8}, order::Vector{Int})
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

function railfence_encrypt(data::Vector{UInt8})
    return railfence_apply(data, RAILFENCE_PERM)
end

function railfence_decrypt(data::Vector{UInt8})
    return railfence_apply(data, RAILFENCE_INV)
end

end
